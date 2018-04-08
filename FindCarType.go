// FindCarType
package main

import (
	"encoding/json"
	"fmt"
	. "myfunc"
	"net/http"
	"strings"
)

type Out_Car struct {
	Code    int
	Message string
	Data    Out_CarList
}
type Out_CarOne struct {
	Type  int
	Count int
}

type Out_CarBatchOne struct {
	Product_name string
	Product_code string
	Product_sku  string
	Number       int64
}
type Out_CarList struct {
	PackAddr string
	List     []Out_CarBatchDetailOne
}
type Out_CarBatchDetailOne struct {
	ID                   string
	Product_name         string
	Product_code         string
	Product_sku          string
	Wavedetail_count     int64
	Wavedetail_excount   int64
	Space_number         string
	Space_linenumber     string
	Number               int64
	Space_code           string
	Wavedetailspace_code string
}

func FindCarOrder(w http.ResponseWriter, r *http.Request) {
	tx, err := dborm.Beginx()
	if err != nil {
		InfoLog.Println(err)
		return
	}
	defer func() { // 必须要先声明defer，否则不能捕获到panic异常

		err := recover()
		if err != nil {
			tx.Rollback()
			InfoLog.Println("有错误发生，正在回滚")
			InfoLog.Println(err) // 这里的err其实就是panic传入的内容，55
		} else {
			tx.Commit()
		}

	}()
	InfoLog.Println("==========================根据车类型下发开始：", r.URL)
	defer InfoLog.Println("==========================根据车类型下发结束")
	r.ParseForm()
	car_code, found1 := r.Form["car_code"]
	wave_code, found2 := r.Form["wave_code"]
	user_code, found3 := r.Form["user_code"]

	flag, found4 := r.Form["flag"]
	pager_offset, found5 := r.Form["pager_offset"]
	task_state, found6 := r.Form["task_state"]

	if !found1 || !found2 || !found3 || !found4 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}
	if !found5 {
		pager_offset = []string{"0"}

	}
	if !found6 {
		task_state = []string{"2"}
	}
	if task_state[0] == "1" {
		task_state[0] = "2"
	}
	var rtn Out_Car
	sqlcmd := ""
	sqlcmd = fmt.Sprintf(`SELECT
	salvercar_type,

IF (
	salvercar_type = 2,
	(salvershelf_col + 0) * (salvershelf_ros + 0),
	0
)
FROM
	isale_salvercar
WHERE
	salvercar_code = '%s'`, car_code[0])
	carCount := 0
	Type := 0
	DebugLog.Println(sqlcmd)
	err = db.QueryRow(sqlcmd).Scan(&Type, &carCount)
	if err != nil {
		rtn.Code = 0
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到篮/板车信息"
		} else {
			rtn.Message = "查询异常"
		}
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	limitCondi := ""
	if carCount == 0 {
		limitCondi = fmt.Sprintf("limit 0,100 ")
	} else {
		limitCondi = fmt.Sprintf("limit 0,%d ", carCount)
	}
	if flag[0] == "1" { //非批间扫码
		var list []Out_CarBatchOne
		sqlcmd = fmt.Sprintf(`SELECT
	outorder_code,
	
	(@rownum:=@rownum+1) as mynumber	
FROM
	isale_outorder
	,(SELECT @rownum:=0) b
WHERE
	wave_code = '%s'
AND task_user_code = '%s' and outorder_count>1
and outorder_downstate=1  
%s`, wave_code[0], user_code[0], limitCondi)
		DebugLog.Println(sqlcmd)
		result, err := db.Query(sqlcmd)
		if err != nil {
			rtn.Code = 0
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到出库单"
			} else {
				rtn.Message = "查询异常"
			}
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			return
		}
		defer result.Close()
		for result.Next() {
			var one Out_CarBatchOne
			result.Scan(&one.Product_code, &one.Number)
			list = append(list, one)
		}
		outorderCodeCondition := ""
		for indexs, ele := range list {
			if indexs != len(list)-1 {
				outorderCodeCondition += fmt.Sprintf(" '%s', ", ele.Product_code)
			} else {
				outorderCodeCondition += fmt.Sprintf(" '%s' ", ele.Product_code)
			}
		}
		if len(list) > 0 {
			sqlcmd = fmt.Sprintf(`SELECT
	
	product_name,
	product_code,
	product_sku,
	wavedetail_count,
	ifnull(wavedetail_excount,0),
	space_number,
	space_linenumber,
	b.outorder_code,
	a.wavedetailspace_code,
	a.space_code
	
FROM
	isale_wavedetailspace a
LEFT JOIN isale_waveoutorder b ON a.wavedetail_code = b.wavedetail_code
WHERE
	b.outorder_code in (%s)
AND b.wave_code = '%s'
ORDER BY
	a.space_linenumber,a.space_code
limit %s,20	`, outorderCodeCondition, wave_code[0], pager_offset[0])
			DebugLog.Println(sqlcmd)
			result1, err := db.Query(sqlcmd)
			if err != nil {
				rtn.Code = 0
				if strings.Contains(err.Error(), "sql: no rows in result set") {
					rtn.Message = "没有查询到货位信息"
				} else {
					rtn.Message = "查询异常"
				}
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				return
			}
			defer result1.Close()
			var listDetail []Out_CarBatchDetailOne
			var outorderOrProductCode []string
			for result1.Next() {

				var one Out_CarBatchDetailOne
				var outOrderCode string
				result1.Scan(&one.Product_name, &one.Product_code, &one.Product_sku,
					&one.Wavedetail_count,
					&one.Wavedetail_excount,
					&one.Space_number, &one.Space_linenumber, &outOrderCode, &one.Wavedetailspace_code,
					&one.Space_code)
				one.ID = GenerateCode("222")

				for _, ele := range list {
					if ele.Product_code == outOrderCode {
						one.Number = ele.Number
						break
					}
				}

				listDetail = append(listDetail, one)
				outorderOrProductCode = append(outorderOrProductCode, outOrderCode)

			}
			if len(listDetail) > 0 {
				s := Tmp_WaveDetailSpace{}
				s.Wave_code = wave_code[0]

				sqlcmd = fmt.Sprintf(`select wave_halftype from isale_wave where wave_code='%s'`, wave_code[0])
				housetype := 1
				if err = db.QueryRow(sqlcmd).Scan(&housetype); err != nil {
					rtn.Code = 4
					if strings.Contains(err.Error(), "sql: no rows in result set") {
						rtn.Message = "没有查询到货位信息"
					} else {
						rtn.Message = "查询异常"
					}
					bytes, _ := json.Marshal(rtn)
					fmt.Fprint(w, string(bytes))
					return
				}
				if Type == 1 { //非批间板车
					sqlcmd = fmt.Sprintf(`call proc_packtable_bc('%s',%d,2,@result)`,
						wave_code[0], housetype)
				} else { //非批间篮车
					condition := ""
					for indexs, ele := range outorderOrProductCode {

						if indexs != len(outorderOrProductCode)-1 {
							condition += fmt.Sprintf("%s,", ele)
						} else {
							condition += fmt.Sprintf("%s", ele)
						}
					}
					DebugLog.Println(condition)
					sqlcmd = fmt.Sprintf(`call proc_packtable_lc('%s',%d,2,'%s',@result)`,
						wave_code[0], housetype, condition)
				}

				resultStr := ""
				DebugLog.Println(sqlcmd)
				if err = db.QueryRow(sqlcmd).Scan(&resultStr); err != nil {
					rtn.Code = 4
					if strings.Contains(err.Error(), "sql: no rows in result set") {
						rtn.Message = "没有查询到货位信息"
					} else {
						rtn.Message = "查询异常"
					}
					bytes, _ := json.Marshal(rtn)
					fmt.Fprint(w, string(bytes))
					return
				}

				rtn.Data.PackAddr = resultStr
			}
			rtn.Data.List = listDetail

		}

	} else { //批间扫码

		var list []Out_CarBatchOne
		isWave := 0
		sqlcmd = fmt.Sprintf(`select count(*) from isale_process where process_code='%s'`, wave_code[0])
		if err = dborm.QueryRowx(sqlcmd).Scan(&isWave); err != nil {
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到process信息"
			} else {
				rtn.Message = "查询异常"
			}
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			return
		}
		if isWave > 0 { //加工订单
			InfoLog.Println("加工订单")
			sqlcmd = fmt.Sprintf(` SELECT
	wds.product_name,
	wds.product_code,	
	wds.product_sku,
	(@rownum:=@rownum+1) as mynumber
FROM
	isale_task t
LEFT JOIN isale_processdetailspace wds ON t.task_othercode = wds.processdetailspace_code
LEFT JOIN isale_processdetail wd ON wd.processdetail_code = wds.processdetail_code
,(SELECT @rownum:=0) b
WHERE
	t.task_state = '%s' 
AND wds.process_code = '%s'
AND t.user_code = '%s'

GROUP BY
	wds.product_code
%s`, task_state[0], wave_code[0], user_code[0], limitCondi)
			DebugLog.Println(sqlcmd)
			result, err := db.Query(sqlcmd)
			if err != nil {
				rtn.Code = 0
				if strings.Contains(err.Error(), "sql: no rows in result set") {
					rtn.Message = "没有查询到任务"
				} else {
					rtn.Message = "查询异常"
				}
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				return
			}
			defer result.Close()
			for result.Next() {
				var one Out_CarBatchOne
				result.Scan(&one.Product_name, &one.Product_code, &one.Product_sku, &one.Number)
				list = append(list, one)
			}

			product_condi := ""
			for indexs, ele := range list {
				if indexs != len(list)-1 {
					product_condi += fmt.Sprintf(" '%s', ", ele.Product_code)
				} else {
					product_condi += fmt.Sprintf(" '%s' ", ele.Product_code)
				}
			}
			if len(list) > 0 {
				sqlcmd = fmt.Sprintf(`SELECT
	wds.product_name,
	wds.product_code,
	wds.product_sku,
	wds.processdetailspace_count + 0 processdetail_count,
	ifnull(wds.processdetailspace_excount,"0")+0 processdetail_excount,
	wds.space_code,
	wds.space_number,
	wds.space_linenumber,
	wds.processdetailspace_code
FROM
	isale_task a
LEFT JOIN isale_processdetailspace wds ON a.task_othercode = wds.processdetailspace_code
LEFT JOIN isale_processdetail wd ON wd.processdetail_code = wds.processdetail_code
WHERE
	 wds.process_code = '%s'
AND a.user_code = '%s'

AND wds.product_code IN (
	%s
)

ORDER BY
	wds.space_linenumber,wds.space_code
	limit %s,20`, wave_code[0], user_code[0], product_condi, pager_offset[0])
				DebugLog.Println(sqlcmd)
				result1, err := db.Query(sqlcmd)
				if err != nil {
					rtn.Code = 0
					if strings.Contains(err.Error(), "sql: no rows in result set") {
						rtn.Message = "没有查询到任务信息"
					} else {
						rtn.Message = "查询异常"
					}
					bytes, _ := json.Marshal(rtn)
					fmt.Fprint(w, string(bytes))
					return
				}
				defer result1.Close()
				var listDetail []Out_CarBatchDetailOne
				var outorderOrProductCode []string
				for result1.Next() {

					var one Out_CarBatchDetailOne
					result1.Scan(&one.Product_name, &one.Product_code, &one.Product_sku, &one.Wavedetail_count,
						&one.Wavedetail_excount,
						&one.Space_code, &one.Space_number, &one.Space_linenumber, &one.Wavedetailspace_code)
					one.ID = GenerateCode("222")
					for _, ele := range list {
						if ele.Product_code == one.Product_code {
							one.Number = ele.Number
							break
						}
					}
					DebugLog.Println(one)
					listDetail = append(listDetail, one)
					outorderOrProductCode = append(outorderOrProductCode, one.Product_code)

				}
				if len(listDetail) > 0 {
					sqlcmd = fmt.Sprintf(`select packtable_name from isale_packtable where packtable_type=2 limit 0,1`)

					resultStr := ""
					if err = db.QueryRow(sqlcmd).Scan(&resultStr); err != nil {
						rtn.Code = 0
						if strings.Contains(err.Error(), "sql: no rows in result set") {
							rtn.Message = "没有查询到包装台,请移到包装点"
						} else {
							rtn.Message = "查询异常"
						}
						bytes, _ := json.Marshal(rtn)
						fmt.Fprint(w, string(bytes))
						return
					}
					rtn.Data.PackAddr = resultStr
				}
				rtn.Data.List = listDetail
			} else {
				DebugLog.Println("没有批间")
			}

		} else {
			isTransfer := 0
			sqlcmd = fmt.Sprintf(`select count(*) from isale_storage_transfer where storagetransfer_code='%s'`, wave_code[0])
			if err = dborm.QueryRowx(sqlcmd).Scan(&isTransfer); err != nil {
				rtn.Code = 2
				if strings.Contains(err.Error(), "sql: no rows in result set") {
					rtn.Message = "没有查询到process信息"
				} else {
					rtn.Message = "查询异常"
				}
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				return
			}
			if isTransfer > 0 {
				//分销订单
				sqlcmd = fmt.Sprintf(` SELECT
					wds.product_name,
					wds.product_code,	
					wds.product_sku,
					(@rownum:=@rownum+1) as mynumber
				FROM
					isale_task t
				LEFT JOIN isale_storage_transfer_space wds ON t.task_othercode = wds.storagetransferspace_code				
				LEFT JOIN isale_storage_transfer wd ON wd.storagetransfer_code = wds.storagetransferspace_code				
				,(SELECT @rownum:=0) b
				WHERE
					t.task_state = '%s' 
				AND wds.storagetransfer_code = '%s'
				AND t.user_code = '%s'
				
				GROUP BY
					wds.product_code
				%s`, task_state[0], wave_code[0], user_code[0], limitCondi)
				DebugLog.Println(sqlcmd)
				result, err := db.Query(sqlcmd)
				if err != nil {
					rtn.Code = 0
					if strings.Contains(err.Error(), "sql: no rows in result set") {
						rtn.Message = "没有查询到任务"
					} else {
						rtn.Message = "查询异常"
					}
					bytes, _ := json.Marshal(rtn)
					fmt.Fprint(w, string(bytes))
					return
				}
				defer result.Close()
				for result.Next() {
					var one Out_CarBatchOne
					result.Scan(&one.Product_name, &one.Product_code, &one.Product_sku, &one.Number)
					list = append(list, one)
				}

				product_condi := ""
				for indexs, ele := range list {
					if indexs != len(list)-1 {
						product_condi += fmt.Sprintf(" '%s', ", ele.Product_code)
					} else {
						product_condi += fmt.Sprintf(" '%s' ", ele.Product_code)
					}
				}
				if len(list) > 0 {
					sqlcmd = fmt.Sprintf(`SELECT
					wds.product_name,
					wds.product_code,
					wds.product_sku,
					wds.storagetransferspace_count+ 0 processdetail_count,
					ifnull(wds.storagetransferspace_excount	,"0")+0 processdetail_excount,
					wds.space_code,
					wds.space_number,
					wds.space_linenumber,
					wds.storagetransferspace_code
				FROM
					isale_task a
				LEFT JOIN isale_storage_transfer_space wds ON a.task_othercode = wds.storagetransferspace_code
				LEFT JOIN isale_storage_transfer wd ON wd.storagetransfer_code= wds.storagetransfer_code				
				WHERE
					 wds.storagetransfer_code = '%s'
				AND a.user_code = '%s'
				
				AND wds.product_code IN (
					%s
				)
				
				ORDER BY
					wds.space_linenumber,wds.space_code
					limit %s,20`, wave_code[0], user_code[0], product_condi, pager_offset[0])
					DebugLog.Println(sqlcmd)
					result1, err := db.Query(sqlcmd)
					if err != nil {
						rtn.Code = 0
						if strings.Contains(err.Error(), "sql: no rows in result set") {
							rtn.Message = "没有查询到任务信息"
						} else {
							rtn.Message = "查询异常"
						}
						bytes, _ := json.Marshal(rtn)
						fmt.Fprint(w, string(bytes))
						return
					}
					defer result1.Close()
					var listDetail []Out_CarBatchDetailOne
					var outorderOrProductCode []string
					for result1.Next() {

						var one Out_CarBatchDetailOne
						result1.Scan(&one.Product_name, &one.Product_code, &one.Product_sku, &one.Wavedetail_count,
							&one.Wavedetail_excount,
							&one.Space_code, &one.Space_number, &one.Space_linenumber, &one.Wavedetailspace_code)
						one.ID = GenerateCode("222")
						for _, ele := range list {
							if ele.Product_code == one.Product_code {
								one.Number = ele.Number
								break
							}
						}
						DebugLog.Println(one)
						listDetail = append(listDetail, one)
						outorderOrProductCode = append(outorderOrProductCode, one.Product_code)

					}
					if len(listDetail) > 0 {
						// sqlcmd = fmt.Sprintf(`select packtable_name from isale_packtable where packtable_type=2 limit 0,1`)

						// resultStr := ""
						// if err = db.QueryRow(sqlcmd).Scan(&resultStr); err != nil {
						// 	rtn.Code = 0
						// 	if strings.Contains(err.Error(), "sql: no rows in result set") {
						// 		rtn.Message = "没有查询到包装台"
						// 	} else {
						// 		rtn.Message = "查询异常"
						// 	}
						// 	bytes, _ := json.Marshal(rtn)
						// 	fmt.Fprint(w, string(bytes))
						// 	return
						// }
						rtn.Data.PackAddr = "分销换标签任务，请放到待上架区域等待重新上架"
					}
					rtn.Data.List = listDetail
				} else {
					DebugLog.Println("没有批间")
				}
			} else {
				InfoLog.Println("普通订单")
				sqlcmd = fmt.Sprintf(` SELECT
	wds.product_name,
	wds.product_code,	
	wds.product_sku,
	(@rownum:=@rownum+1) as mynumber
FROM
	isale_task t
LEFT JOIN isale_wavedetailspace wds ON t.task_othercode = wds.wavedetailspace_code
LEFT JOIN isale_wavedetail wd ON wd.wavedetail_code = wds.wavedetail_code
,(SELECT @rownum:=0) b
WHERE
	t.task_state = '%s' 
AND wds.wave_code = '%s'
AND t.user_code = '%s'
AND wd.wave_type = 1
GROUP BY
	wds.product_code
%s`, task_state[0], wave_code[0], user_code[0], limitCondi)
				DebugLog.Println(sqlcmd)
				result, err := db.Query(sqlcmd)
				if err != nil {
					rtn.Code = 0
					if strings.Contains(err.Error(), "sql: no rows in result set") {
						rtn.Message = "没有查询到任务"
					} else {
						rtn.Message = "查询异常"
					}
					bytes, _ := json.Marshal(rtn)
					fmt.Fprint(w, string(bytes))
					return
				}
				defer result.Close()
				for result.Next() {
					var one Out_CarBatchOne
					result.Scan(&one.Product_name, &one.Product_code, &one.Product_sku, &one.Number)
					list = append(list, one)
				}

				product_condi := ""
				for indexs, ele := range list {
					if indexs != len(list)-1 {
						product_condi += fmt.Sprintf(" '%s', ", ele.Product_code)
					} else {
						product_condi += fmt.Sprintf(" '%s' ", ele.Product_code)
					}
				}
				if len(list) > 0 {
					sqlcmd = fmt.Sprintf(`SELECT
	wds.product_name,
	wds.product_code,
	wds.product_sku,
	wds.wavedetail_count + 0 wavedetail_count,
	ifnull(wds.wavedetail_excount,"0")+0 wavedetail_excount,
	wds.space_code,
	wds.space_number,
	wds.space_linenumber,
	wds.wavedetailspace_code
FROM
	isale_task a
LEFT JOIN isale_wavedetailspace wds ON a.task_othercode = wds.wavedetailspace_code
LEFT JOIN isale_wavedetail wd ON wd.wavedetail_code = wds.wavedetail_code
WHERE
	 wds.wave_code = '%s'
AND a.user_code = '%s'
AND wd.wave_type = 1
and a.task_state = '%s'
AND wds.product_code IN (
	%s
)

ORDER BY
	wds.space_linenumber,wds.space_code
	limit %s,20`, wave_code[0], user_code[0], task_state[0], product_condi, pager_offset[0])
					DebugLog.Println(sqlcmd)
					result1, err := db.Query(sqlcmd)
					if err != nil {
						rtn.Code = 0
						if strings.Contains(err.Error(), "sql: no rows in result set") {
							rtn.Message = "没有查询到货位信息"
						} else {
							rtn.Message = "查询异常"
						}
						bytes, _ := json.Marshal(rtn)
						fmt.Fprint(w, string(bytes))
						return
					}
					defer result1.Close()
					var listDetail []Out_CarBatchDetailOne
					var outorderOrProductCode []string
					for result1.Next() {

						var one Out_CarBatchDetailOne
						result1.Scan(&one.Product_name, &one.Product_code, &one.Product_sku, &one.Wavedetail_count,
							&one.Wavedetail_excount,
							&one.Space_code, &one.Space_number, &one.Space_linenumber, &one.Wavedetailspace_code)
						one.ID = GenerateCode("222")
						for _, ele := range list {
							if ele.Product_code == one.Product_code {
								one.Number = ele.Number
								break
							}
						}
						DebugLog.Println(one)
						listDetail = append(listDetail, one)
						outorderOrProductCode = append(outorderOrProductCode, one.Product_code)

					}
					if len(listDetail) > 0 {
						sqlcmd = fmt.Sprintf(`select wave_halftype from isale_wave where wave_code='%s'`, wave_code[0])
						housetype := 1
						if err = db.QueryRow(sqlcmd).Scan(&housetype); err != nil {
							rtn.Code = 4
							if strings.Contains(err.Error(), "sql: no rows in result set") {
								rtn.Message = "没有查询到波次信息"
							} else {
								rtn.Message = "查询异常"
							}
							bytes, _ := json.Marshal(rtn)
							fmt.Fprint(w, string(bytes))
							return
						}
						if Type == 1 { //批间板车
							sqlcmd = fmt.Sprintf(`call proc_packtable_bc('%s',%d,1,@result)`,
								wave_code[0], housetype)
						} else { //批间篮车

							condition := ""
							for indexs, ele := range outorderOrProductCode {

								if indexs != len(outorderOrProductCode)-1 {
									condition += fmt.Sprintf("%s,", ele)
								} else {
									condition += fmt.Sprintf("%s", ele)
								}
							}
							sqlcmd = fmt.Sprintf(`call proc_packtable_lc('%s',%d,1,'%s',@result)`,
								wave_code[0], housetype, condition)
						}

						resultStr := ""
						if err = db.QueryRow(sqlcmd).Scan(&resultStr); err != nil {
							rtn.Code = 0
							if strings.Contains(err.Error(), "sql: no rows in result set") {
								rtn.Message = "没有查询到货位信息"
							} else {
								rtn.Message = "查询异常"
							}
							bytes, _ := json.Marshal(rtn)
							fmt.Fprint(w, string(bytes))
							return
						}
						rtn.Data.PackAddr = resultStr
					}
					rtn.Data.List = listDetail
				} else {
					DebugLog.Println("没有批间")
				}
			}
		}

	}
	if rtn.Data.List == nil {
		rtn.Data.List = make([]Out_CarBatchDetailOne, 0)
	}
	rtn.Code = 1
	rtn.Message = "成功"
	bytes, _ := json.Marshal(rtn)
	fmt.Fprint(w, string(bytes))
	return

}
