// DownStorage
package main

import (
	"encoding/json"
	"fmt"

	"net/http"
	"strconv"
	"strings"
)

type Tmp_outorder struct {
	Outordercode string `db:"code"`
	Count        int64  `db:"count"`
	Excount      int64  `db:"excount"`
}

func DownStorage(w http.ResponseWriter, r *http.Request) {
	tx, err := dborm.Beginx()
	if err != nil {
		InfoLog.Println(err)
		return
	}
	defer func() { // 必须要先声明defer，否则不能捕获到panic异常

		err := recover()
		if err != nil {
			errStr := fmt.Sprintf("%s", err)
			if strings.Contains(errStr, "cysql") {
				tx.Rollback()
				InfoLog.Println("有错误发生，正在回滚")
			}

			InfoLog.Println(err) // 这里的err其实就是panic传入的内容，55
		} else {
			tx.Commit()

		}

	}()
	InfoLog.Println("==========================下架开始：", r.URL)
	defer InfoLog.Println("==========================下架结束")
	r.ParseForm()
	Wavedetailspace_code, found1 := r.Form["Wavedetailspace_code"]
	Space_code, found2 := r.Form["Space_code"]
	countStr, found3 := r.Form["Count"]
	if !found1 || !found2 || !found3 {
		fmt.Fprint(w, "请勿非法访问")
		return
	}
	sqlcmd := ""
	var rtn Rtn
	if countStr[0] == "0" {
		rtn.Code = 2
		rtn.Message = "下架数量必须大于0"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	DebugLog.Println("输入的货位：", Space_code[0])
	if !IsSpaceCode(Space_code[0]) {
		Space_code[0] = GetSpaceCodeFrom(Space_code[0])
	}
	DebugLog.Println("转换的货位：", Space_code[0])
	onetask := Tmp_Task{}
	sqlcmd = fmt.Sprintf(`select task_code,task_type,task_othercode,user_code ,product_code from isale_task 
		where task_othercode='%s'`, Wavedetailspace_code[0])
	DebugLog.Println(sqlcmd)
	if err = tx.Get(&onetask, sqlcmd); err != nil {
		DebugLog.Println(err.Error())
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到process单"
		} else {
			rtn.Message = "查询异常"
		}
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	if onetask.Task_type == 10 {
		InfoLog.Println("分销订单")
	} else if onetask.Task_type == 9 {
		InfoLog.Println("加工订单")
	} else {
		InfoLog.Println("普通订单")
	}
	userCode := ""
	userType := 1
	userMoblie := ""
	usrtName := ""
	userCode = onetask.User_code
	sqlcmd = fmt.Sprintf(`select user_name,user_type,user_mobilephone from isale_user where user_code='%s'`,
		userCode)
	DebugLog.Println(sqlcmd)
	if err = tx.QueryRowx(sqlcmd).Scan(&usrtName, &userType, &userMoblie); err != nil {
		rtn.Code = 2
		DebugLog.Println(err.Error())
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到用户"
		} else {
			rtn.Message = "查询异常"
		}
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	isWave := 0
	sqlcmd = fmt.Sprintf(`select count(*) from isale_processdetailspace where processdetailspace_code='%s'`, Wavedetailspace_code[0])
	if err = dborm.QueryRowx(sqlcmd).Scan(&isWave); err != nil {
		rtn.Code = 2
		DebugLog.Println(err.Error())
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到process单"
		} else {
			rtn.Message = "查询异常"
		}
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	var spaceCount int64
	var spaceExCount int64
	var product_bulk int64
	var count int64 //填写的下架任务
	if count, err = strconv.ParseInt(countStr[0], 0, 64); err != nil {
		rtn.Code = 7
		rtn.Message = "重量原始量字符串为非数字:" + err.Error()
		InfoLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}

	sqlcmd = fmt.Sprintf(`select space_count+0 ,space_excount+0,product_bulk+0 from isale_spacedetail 
	where space_code ='%s' and product_code='%s'`, Space_code[0], onetask.Product_code)
	DebugLog.Println(sqlcmd)
	if err = tx.QueryRow(sqlcmd).Scan(&spaceCount, &spaceExCount, &product_bulk); err != nil {
		rtn.Code = 2
		DebugLog.Println(err.Error())
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到货位信息"
		} else {
			rtn.Message = "查询异常"
		}
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	if spaceCount-count < 1 { //执行delete
		sqlcmd = fmt.Sprintf(`delete from isale_spacedetail 
		where space_code='%s' and product_code='%s'`, Space_code[0], onetask.Product_code)
	} else {
		sqlcmd = fmt.Sprintf(`update isale_spacedetail set space_count='%d',
		space_excount='%d' where space_code='%s' and product_code='%s'`,
			spaceCount-count, spaceExCount-count, Space_code[0], onetask.Product_code)
	}
	DebugLog.Println(sqlcmd)
	_, err = tx.Exec(sqlcmd)
	if err != nil {
		rtn.Code = 2
		rtn.Message = "插入打印信息发生错误:" + err.Error()
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	oneSpace := Tmp_Space{}
	sqlcmd = fmt.Sprintf(`select 
	space_code          ,
	space_bulk			,
	space_usedbulk      ,
	space_leftbulk      ,
	ifnull(space_upbulk,"0")     space_upbulk   ,	
	space_type          ,
	space_state         ,
	space_usestate      
  
	from isale_space where space_code='%s'`, Space_code[0])
	DebugLog.Println(sqlcmd)
	if err = tx.Get(&oneSpace, sqlcmd); err != nil {
		rtn.Code = 2
		DebugLog.Println(err.Error())
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到货位"
		} else {
			rtn.Message = "查询异常"
		}
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	space_usedbulkInt, err := strconv.ParseInt(oneSpace.Space_usedbulk, 0, 64)
	if err != nil {
		rtn.Code = 2
		rtn.Message = "货位已使用体积:" + err.Error()
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	space_leftbulkInt, err := strconv.ParseInt(oneSpace.Space_leftbulk, 0, 64)
	if err != nil {
		rtn.Code = 2
		rtn.Message = "货位剩余使用体积:" + err.Error()
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	space_bulkInt, err := strconv.ParseInt(oneSpace.Space_bulk, 0, 64)
	if err != nil {
		rtn.Code = 2
		rtn.Message = "货位总体积:" + err.Error()
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	DebugLog.Println(product_bulk * count)
	DebugLog.Println(space_usedbulkInt)

	if count*product_bulk < space_usedbulkInt {
		space_usedbulkInt -= (count * product_bulk)
		space_leftbulkInt += (count * product_bulk)
		oneSpace.Space_usedbulk = fmt.Sprintf("%d", space_usedbulkInt)
		oneSpace.Space_leftbulk = fmt.Sprintf("%d", space_leftbulkInt)
	} else {
		space_usedbulkInt = 0
		space_leftbulkInt = space_bulkInt
		oneSpace.Space_usedbulk = "0"
		oneSpace.Space_leftbulk = oneSpace.Space_bulk
		oneSpace.Space_usestate = 1
	}
	sqlcmd = fmt.Sprintf(`update isale_space set 
	space_leftbulk=:space_leftbulk,space_usedbulk=:space_usedbulk,
	space_usestate=:space_usestate where space_code=:space_code	`)
	DebugLog.Println(sqlcmd)
	_, err = tx.NamedExec(sqlcmd, oneSpace)
	if err != nil {
		rtn.Code = 2
		rtn.Message = "更新货位体积:" + err.Error()
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}

	if onetask.Task_type == 9 || onetask.Task_type == 10 {
		//InfoLog.Println("加工订单")
		sqlcmd = fmt.Sprintf(`update isale_task 
		set task_state=3 where task_code='%s'
		 and task_state!=3`, onetask.Task_code)
		DebugLog.Println(sqlcmd)
		_, err = tx.Exec(sqlcmd)
		if err != nil {
			rtn.Code = 2
			DebugLog.Println(err.Error())
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到入库单"
			} else {
				rtn.Message = "更新失败"
			}
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		oneSpaceDetaillog := Tmp_SpaceDetaillog{}
		sqlcmd = fmt.Sprintf(`select 
		space_code                ,
		space_halftype            ,		
		product_code              ,
		product_name              ,
		product_enname            ,
		ifnull(product_barcode,"" ) product_barcode         ,
		product_sku               ,
		product_unit              ,
		product_weight            ,
		product_length            ,
		product_width             ,
		product_heigth            ,
		product_length_sort       ,
		product_width_sort        ,
		product_heigth_sort       ,
		product_bulk              ,
		product_imgurl            ,
		product_state             ,
		product_groupstate        ,
		product_batterystate      
	from isale_spacedetail where space_code ='%s' and product_code='%s'`, Space_code[0], onetask.Product_code)
		DebugLog.Println(sqlcmd)
		if err = tx.Get(&oneSpaceDetaillog, sqlcmd); err != nil {
			rtn.Code = 2
			DebugLog.Println(err.Error())
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到货位信息"
			} else {
				rtn.Message = "查询异常"
			}
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		oneSpaceDetaillog.Space_count = countStr[0]
		sqlcmd = fmt.Sprintf(`select task_code,task_type,task_othercode,user_code from isale_task 
	where task_othercode='%s'`, Wavedetailspace_code[0])
		DebugLog.Println(sqlcmd)

		if err = tx.QueryRowx(sqlcmd).Scan(&oneSpaceDetaillog.Task_code,
			&oneSpaceDetaillog.Task_type, &oneSpaceDetaillog.Task_othercode, &userCode); err != nil {
			rtn.Code = 2
			DebugLog.Println(err.Error())
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到任务"
			} else {
				rtn.Message = "查询异常"
			}
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}

		sqlcmd = fmt.Sprintf(`insert into isale_spacedetaillog(	
		space_code           ,
		space_halftype       ,
		space_count          ,
		product_code         ,
		product_name         ,
		product_enname       ,
		product_barcode         ,
		product_sku          ,
		product_unit         ,
		product_weight       ,
		product_length       ,
		product_width        ,
		product_heigth       ,
		product_length_sort  ,
		product_width_sort   ,
		product_heigth_sort  ,
		product_bulk         ,
		product_imgurl       ,
		product_state        ,
		product_groupstate   ,
		product_batterystate ,
		user_code            ,
		user_name            ,
		user_mobilephone     ,
		task_code            ,
		task_type            ,
		task_othercode       
			) select space_code,
		space_halftype       ,
		'%s'          ,
		product_code         ,
		product_name         ,
		product_enname       ,
		ifnull(product_barcode,"" ) product_barcode         ,
		product_sku          ,
		product_unit         ,
		product_weight       ,
		product_length       ,
		product_width        ,
		product_heigth       ,
		product_length_sort  ,
		product_width_sort   ,
		product_heigth_sort  ,
		product_bulk         ,
		product_imgurl       ,
		product_state        ,
		product_groupstate   ,
		product_batterystate ,
		'%s'           ,
		'%s'          ,
		'%s'     ,
		'%s'            ,
		%d            ,
		'%s'       from isale_spacedetail 
		where space_code ='%s' and product_code='%s'`, oneSpaceDetaillog.Space_count, userCode, usrtName, userMoblie,
			oneSpaceDetaillog.Task_code,
			oneSpaceDetaillog.Task_type, oneSpaceDetaillog.Task_othercode, Space_code[0], oneSpaceDetaillog.Product_code)
		DebugLog.Println(sqlcmd)
		_, err = tx.Exec(sqlcmd)
		if err != nil {
			rtn.Code = 2
			rtn.Message = "插入打印信息发生错误:" + err.Error()
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		if onetask.Task_type == 9 {

			oneWaveDetailSpace := Tmp_Processdetailspace{}
			sqlcmd = fmt.Sprintf(`select 
processdetailspace_code,
processdetail_code,
processdetailspace_count,
ifnull(processdetailspace_excount,"0") processdetailspace_excount,
product_code,
product_bulk,
space_code,
process_code
from isale_processdetailspace where processdetailspace_code='%s'`, Wavedetailspace_code[0])
			DebugLog.Println(sqlcmd)
			if err = tx.Get(&oneWaveDetailSpace, sqlcmd); err != nil {
				rtn.Code = 2
				DebugLog.Println(err.Error())
				if strings.Contains(err.Error(), "sql: no rows in result set") {
					rtn.Message = "没有查询到process单"
				} else {
					rtn.Message = "查询异常"
				}
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}
			if Space_code[0] != oneWaveDetailSpace.Space_code {
				rtn.Code = 2
				rtn.Message = "货位编码不一致，请重新验证"
				DebugLog.Println(rtn)
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}
			excountInt, err := strconv.ParseInt(oneWaveDetailSpace.Processdetailspace_excount, 0, 64)
			if err != nil {
				rtn.Code = 2
				rtn.Message = "转换已下架数量错误" + err.Error()
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}
			sqlcmd = fmt.Sprintf(`update isale_processdetailspace 
set processdetailspace_excount='%d'
where processdetailspace_code='%s'`, count+excountInt, oneWaveDetailSpace.Processdetailspace_code)
			DebugLog.Println(sqlcmd)
			_, err = tx.Exec(sqlcmd)
			if err != nil {
				rtn.Code = 2
				DebugLog.Println(err.Error())
				if strings.Contains(err.Error(), "sql: no rows in result set") {
					rtn.Message = "没有查询到入库单"
				} else {
					rtn.Message = "更新失败"
				}
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}
			count_tmp := 0
			sqlcmd = fmt.Sprintf(`select count(*) from isale_processdetailspace 
		where process_code='%s' and processdetailspace_count+0 >ifnull(processdetailspace_excount,"")+0`, oneWaveDetailSpace.Process_code)
			DebugLog.Println(sqlcmd)
			if err = tx.QueryRowx(sqlcmd).Scan(&count_tmp); err != nil {
				rtn.Code = 2
				DebugLog.Println(err.Error())
				if strings.Contains(err.Error(), "sql: no rows in result set") {
					rtn.Message = "没有查询到process单"
				} else {
					rtn.Message = "查询异常"
				}
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}
			if count_tmp == 0 {
				sqlcmd = fmt.Sprintf(`update isale_process set process_state=3
			 where process_code='%s'`, oneWaveDetailSpace.Process_code)
				DebugLog.Println(sqlcmd)
				_, err = tx.Exec(sqlcmd)
				if err != nil {
					rtn.Code = 2
					if strings.Contains(err.Error(), "sql: no rows in result set") {
						rtn.Message = "没有查询到process单"
					} else {
						rtn.Message = "更新失败"
					}
					bytes, _ := json.Marshal(rtn)
					fmt.Fprint(w, string(bytes))
					panic("cysql")
				}
			}
		} else if onetask.Task_type == 10 {
			oneWaveDetailSpace := Tmp_transfer{}
			sqlcmd = fmt.Sprintf(`select 
storagetransferspace_code,
storagetransfer_code,
storagetransferspace_count,
ifnull(storagetransferspace_excount,"0") storagetransferspace_excount,
product_code,
product_bulk,
space_code
from isale_storage_transfer_space where storagetransferspace_code='%s'`, Wavedetailspace_code[0])
			DebugLog.Println(sqlcmd)
			if err = tx.Get(&oneWaveDetailSpace, sqlcmd); err != nil {
				rtn.Code = 2
				DebugLog.Println(err.Error())
				if strings.Contains(err.Error(), "sql: no rows in result set") {
					rtn.Message = "没有查询到process单"
				} else {
					rtn.Message = "查询异常"
				}
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}
			if Space_code[0] != oneWaveDetailSpace.Space_code {
				rtn.Code = 2
				rtn.Message = "货位编码不一致，请重新验证"
				DebugLog.Println(rtn)
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}

			sqlcmd = fmt.Sprintf(`update isale_storage_transfer_space 
set storagetransferspace_excount=%s
where storagetransferspace_code='%s'`, countStr[0], oneWaveDetailSpace.Storagetransferspace_code)
			DebugLog.Println(sqlcmd)
			_, err = tx.Exec(sqlcmd)
			if err != nil {
				rtn.Code = 2
				DebugLog.Println(err.Error())
				if strings.Contains(err.Error(), "sql: no rows in result set") {
					rtn.Message = "没有查询到入库单"
				} else {
					rtn.Message = "更新失败"
				}
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}
			count_tmp := 0
			sqlcmd = fmt.Sprintf(`select count(*) from isale_storage_transfer_space 
		where storagetransfer_code='%s' and storagetransferspace_count+0 >ifnull(storagetransferspace_excount,"")+0`, oneWaveDetailSpace.Storagetransfer_code)
			DebugLog.Println(sqlcmd)
			if err = tx.QueryRowx(sqlcmd).Scan(&count_tmp); err != nil {
				rtn.Code = 2
				DebugLog.Println(err.Error())
				if strings.Contains(err.Error(), "sql: no rows in result set") {
					rtn.Message = "没有查询到process单"
				} else {
					rtn.Message = "查询异常"
				}
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}
			if count_tmp == 0 {
				sqlcmd = fmt.Sprintf(`update isale_storage_transfer set storagetransfer_type=3
			 where storagetransfer_code='%s'`, oneWaveDetailSpace.Storagetransfer_code)
				DebugLog.Println(sqlcmd)
				_, err = tx.Exec(sqlcmd)
				if err != nil {
					rtn.Code = 2
					if strings.Contains(err.Error(), "sql: no rows in result set") {
						rtn.Message = "没有查询到process单"
					} else {
						rtn.Message = "更新失败"
					}
					bytes, _ := json.Marshal(rtn)
					fmt.Fprint(w, string(bytes))
					panic("cysql")
				}
			}

		}
	} else {
		oneWaveDetailSpace := Tmp_WaveDetailSpace{}
		InfoLog.Println("普通订单")

		sqlcmd = fmt.Sprintf(`select 
wavedetailspace_code,
wavedetail_code,
wavedetail_count,
ifnull(wavedetail_excount,"0") wavedetail_excount,
product_code,
product_bulk,
space_code,
wave_code
from isale_wavedetailspace where wavedetailspace_code='%s'`, Wavedetailspace_code[0])
		DebugLog.Println(sqlcmd)
		if err = tx.Get(&oneWaveDetailSpace, sqlcmd); err != nil {
			rtn.Code = 2
			DebugLog.Println(err.Error())
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到货位信息"
			} else {
				rtn.Message = "查询异常"
			}
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		if Space_code[0] != oneWaveDetailSpace.Space_code {
			rtn.Code = 2
			rtn.Message = "货位编码不一致，请重新验证"
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		oneSpaceDetaillog := Tmp_SpaceDetaillog{}
		sqlcmd = fmt.Sprintf(`select 
		space_code                ,
		space_halftype            ,		
		product_code              ,
		product_name              ,
		product_enname            ,
		ifnull(product_barcode,"" ) product_barcode         ,
		product_sku               ,
		product_unit              ,
		product_weight            ,
		product_length            ,
		product_width             ,
		product_heigth            ,
		product_length_sort       ,
		product_width_sort        ,
		product_heigth_sort       ,
		product_bulk              ,
		product_imgurl            ,
		product_state             ,
		product_groupstate        ,
		product_batterystate      
	from isale_spacedetail where space_code ='%s' and product_code='%s'`, Space_code[0], oneWaveDetailSpace.Product_code)
		DebugLog.Println(sqlcmd)
		if err = tx.Get(&oneSpaceDetaillog, sqlcmd); err != nil {
			rtn.Code = 2
			DebugLog.Println(err.Error())
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到货位信息"
			} else {
				rtn.Message = "查询异常"
			}
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		oneSpaceDetaillog.Space_count = countStr[0]
		sqlcmd = fmt.Sprintf(`select task_code,task_type,task_othercode,user_code from isale_task 
	where task_othercode='%s'`, Wavedetailspace_code[0])
		DebugLog.Println(sqlcmd)
		userCode := ""
		userType := 1
		userMoblie := ""
		usrtName := ""
		if err = tx.QueryRowx(sqlcmd).Scan(&oneSpaceDetaillog.Task_code,
			&oneSpaceDetaillog.Task_type, &oneSpaceDetaillog.Task_othercode, &userCode); err != nil {
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到任务"
			} else {
				rtn.Message = "查询异常"
			}
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		sqlcmd = fmt.Sprintf(`select user_name,user_type,user_mobilephone from isale_user where user_code='%s'`,
			userCode)
		DebugLog.Println(sqlcmd)
		if err = tx.QueryRowx(sqlcmd).Scan(&usrtName, &userType, &userMoblie); err != nil {
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到人员"
			} else {
				rtn.Message = "查询异常"
			}
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		sqlcmd = fmt.Sprintf(`insert into isale_spacedetaillog(	
		space_code           ,
		space_halftype       ,
		space_count          ,
		product_code         ,
		product_name         ,
		product_enname       ,
		product_barcode         ,
		product_sku          ,
		product_unit         ,
		product_weight       ,
		product_length       ,
		product_width        ,
		product_heigth       ,
		product_length_sort  ,
		product_width_sort   ,
		product_heigth_sort  ,
		product_bulk         ,
		product_imgurl       ,
		product_state        ,
		product_groupstate   ,
		product_batterystate ,
		user_code            ,
		user_name            ,
		user_mobilephone     ,
		task_code            ,
		task_type            ,
		task_othercode       
			) select space_code,
		space_halftype       ,
		'%s'          ,
		product_code         ,
		product_name         ,
		product_enname       ,
		ifnull(product_barcode,"" ) product_barcode         ,
		product_sku          ,
		product_unit         ,
		product_weight       ,
		product_length       ,
		product_width        ,
		product_heigth       ,
		product_length_sort  ,
		product_width_sort   ,
		product_heigth_sort  ,
		product_bulk         ,
		product_imgurl       ,
		product_state        ,
		product_groupstate   ,
		product_batterystate ,
		'%s'           ,
		'%s'          ,
		'%s'     ,
		'%s'            ,
		%d            ,
		'%s'       from isale_spacedetail 
		where space_code ='%s' and product_code='%s'`, oneSpaceDetaillog.Space_count, userCode, usrtName, userMoblie,
			oneSpaceDetaillog.Task_code,
			oneSpaceDetaillog.Task_type, oneSpaceDetaillog.Task_othercode, Space_code[0], oneSpaceDetaillog.Product_code)
		DebugLog.Println(sqlcmd)
		_, err = tx.Exec(sqlcmd)
		if err != nil {
			rtn.Code = 2
			rtn.Message = "插入打印信息发生错误:" + err.Error()
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}

		//		var spaceCount int64
		//		var spaceExCount int64
		//		var product_bulk int64
		//		var count int64 //填写的下架任务
		//		if count, err = strconv.ParseInt(countStr[0], 0, 64); err != nil {
		//			rtn.Code = 7
		//			rtn.Message = "重量原始量字符串为非数字:" + err.Error()
		//			InfoLog.Println(rtn)
		//			bytes, _ := json.Marshal(rtn)
		//			fmt.Fprint(w, string(bytes))
		//			return
		//		}

		//		sqlcmd = fmt.Sprintf(`select space_count+0 ,space_excount+0,product_bulk+0 from isale_spacedetail
		//	where space_code ='%s' and product_code='%s'`, Space_code[0], oneWaveDetailSpace.Product_code)
		//		DebugLog.Println(sqlcmd)
		//		if err = tx.QueryRow(sqlcmd).Scan(&spaceCount, &spaceExCount, &product_bulk); err != nil {
		//			rtn.Code = 2
		//			if strings.Contains(err.Error(), "sql: no rows in result set") {
		//				rtn.Message = "没有查询到货位信息"
		//			} else {
		//				rtn.Message = "查询异常"
		//			}
		//			bytes, _ := json.Marshal(rtn)
		//			fmt.Fprint(w, string(bytes))
		//			return
		//		}
		//		if spaceCount-count < 1 { //执行delete
		//			sqlcmd = fmt.Sprintf(`delete from isale_spacedetail
		//		where space_code='%s' and product_code='%s'`, Space_code[0], oneWaveDetailSpace.Product_code)
		//		} else {
		//			sqlcmd = fmt.Sprintf(`update isale_spacedetail set space_count='%d',
		//		space_excount='%d' where space_code='%s' and product_code='%s'`,
		//				spaceCount-count, spaceExCount-count, Space_code[0], oneWaveDetailSpace.Product_code)
		//		}
		//		DebugLog.Println(sqlcmd)
		//		_, err = tx.Exec(sqlcmd)
		//		if err != nil {
		//			rtn.Code = 2
		//			rtn.Message = "插入打印信息发生错误:" + err.Error()
		//			bytes, _ := json.Marshal(rtn)
		//			fmt.Fprint(w, string(bytes))
		//			panic("cysql")
		//		}
		//		oneSpace := Tmp_Space{}
		//		sqlcmd = fmt.Sprintf(`select
		//	space_code          ,
		//	space_bulk			,
		//	space_usedbulk      ,
		//	space_leftbulk      ,
		//	ifnull(space_upbulk,"0")     space_upbulk   ,
		//	space_type          ,
		//	space_state         ,
		//	space_usestate

		//	from isale_space where space_code='%s'`, Space_code[0])
		//		DebugLog.Println(sqlcmd)
		//		if err = tx.Get(&oneSpace, sqlcmd); err != nil {
		//			rtn.Code = 2
		//			if strings.Contains(err.Error(), "sql: no rows in result set") {
		//				rtn.Message = "没有查询到货位信息"
		//			} else {
		//				rtn.Message = "查询异常"
		//			}
		//			bytes, _ := json.Marshal(rtn)
		//			fmt.Fprint(w, string(bytes))
		//			panic("cysql")
		//		}
		//		space_usedbulkInt, err := strconv.ParseInt(oneSpace.Space_usedbulk, 0, 64)
		//		if err != nil {
		//			rtn.Code = 2
		//			rtn.Message = "货位已使用体积:" + err.Error()
		//			bytes, _ := json.Marshal(rtn)
		//			fmt.Fprint(w, string(bytes))
		//			panic("cysql")
		//		}
		//		space_leftbulkInt, err := strconv.ParseInt(oneSpace.Space_leftbulk, 0, 64)
		//		if err != nil {
		//			rtn.Code = 2
		//			rtn.Message = "货位剩余使用体积:" + err.Error()
		//			bytes, _ := json.Marshal(rtn)
		//			fmt.Fprint(w, string(bytes))
		//			panic("cysql")
		//		}
		//		space_bulkInt, err := strconv.ParseInt(oneSpace.Space_bulk, 0, 64)
		//		if err != nil {
		//			rtn.Code = 2
		//			rtn.Message = "货位总体积:" + err.Error()
		//			bytes, _ := json.Marshal(rtn)
		//			fmt.Fprint(w, string(bytes))
		//			panic("cysql")
		//		}
		//		DebugLog.Println(product_bulk * count)
		//		DebugLog.Println(space_usedbulkInt)

		//		if count*product_bulk < space_usedbulkInt {
		//			space_usedbulkInt -= (count * product_bulk)
		//			space_leftbulkInt += (count * product_bulk)
		//			oneSpace.Space_usedbulk = fmt.Sprintf("%d", space_usedbulkInt)
		//			oneSpace.Space_leftbulk = fmt.Sprintf("%d", space_leftbulkInt)
		//		} else {
		//			space_usedbulkInt = 0
		//			space_leftbulkInt = space_bulkInt
		//			oneSpace.Space_usedbulk = "0"
		//			oneSpace.Space_leftbulk = oneSpace.Space_bulk
		//			oneSpace.Space_usestate = 1
		//		}
		//		sqlcmd = fmt.Sprintf(`update isale_space set
		//	space_leftbulk=:space_leftbulk,space_usedbulk=:space_usedbulk,
		//	space_usestate=:space_usestate where space_code=:space_code	`)
		//		DebugLog.Println(sqlcmd)
		//		_, err = tx.NamedExec(sqlcmd, oneSpace)
		//		if err != nil {
		//			rtn.Code = 2
		//			rtn.Message = "更新货位体积:" + err.Error()
		//			bytes, _ := json.Marshal(rtn)
		//			fmt.Fprint(w, string(bytes))
		//			panic("cysql")
		//		}
		excountInt, err := strconv.ParseInt(oneWaveDetailSpace.Wavedetail_excount, 0, 64)
		if err != nil {
			rtn.Code = 2
			rtn.Message = "转换已下架数量错误" + err.Error()
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		countIntDone, err := strconv.ParseInt(oneWaveDetailSpace.Wavedetail_count, 0, 64)
		if err != nil {
			rtn.Code = 2
			rtn.Message = "转换总下架数量错误" + err.Error()
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}

		excountInt += count
		sqlcmd = fmt.Sprintf(`update isale_wavedetailspace set wavedetail_excount='%d' where
	wavedetailspace_code='%s'`, excountInt, Wavedetailspace_code[0])
		_, err = tx.Exec(sqlcmd)
		if err != nil {
			rtn.Code = 2
			rtn.Message = "更新下架数量:" + err.Error()
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}

		if excountInt >= countIntDone {
			wave_type := 0
			sqlcmd = fmt.Sprintf(`select  wave_type from isale_wavedetail where wavedetail_code ='%s'`, oneWaveDetailSpace.Wavedetail_code)
			if err = tx.QueryRowx(sqlcmd).Scan(&wave_type); err != nil {
				rtn.Code = 2
				if strings.Contains(err.Error(), "sql: no rows in result set") {
					rtn.Message = "没有查询到货位信息"
				} else {
					rtn.Message = "查询异常"
				}
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}
			sqlcmd = fmt.Sprintf(`update isale_task set task_state=3 where task_code='%s' and task_state!=3`, oneSpaceDetaillog.Task_code)
			DebugLog.Println(sqlcmd)
			_, err = tx.Exec(sqlcmd)
			if err != nil {
				rtn.Code = 2
				if strings.Contains(err.Error(), "sql: no rows in result set") {
					rtn.Message = "没有查询到货位信息"
				} else {
					rtn.Message = "更新失败"
				}
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}
			if wave_type == 1 {
				sqlcmd = fmt.Sprintf(`SELECT 

	wo.outorder_code code,
	wds.wavedetail_count + 0 count,
	wds.wavedetail_excount + 0 excount
FROM
	isale_task t
LEFT JOIN isale_wavedetailspace wds ON t.task_othercode = wds.wavedetailspace_code
LEFT JOIN isale_wavedetail wd ON wd.wavedetail_code = wds.wavedetail_code
LEFT JOIN isale_waveoutorder wo ON wd.wavedetail_code = wo.wavedetail_code
WHERE
	wds.wavedetailspace_code = '%s'

AND wds.wave_code = '%s'
AND t.user_code = '%s'
AND wd.wave_type = 1
AND wds.product_code = '%s'`, oneWaveDetailSpace.Wavedetailspace_code,
					oneWaveDetailSpace.Wave_code, userCode, oneWaveDetailSpace.Product_code)
				result := []Tmp_outorder{}
				DebugLog.Println(sqlcmd)
				if err = tx.Select(&result, sqlcmd); err != nil {
					rtn.Code = 2
					if strings.Contains(err.Error(), "sql: no rows in result set") {
						rtn.Message = "没有查询到货位信息"
					} else {
						rtn.Message = "查询异常"
					}
					bytes, _ := json.Marshal(rtn)
					fmt.Fprint(w, string(bytes))
					panic("cysql")
				}
				if len(result) > 0 {

					if result[0].Count <= result[0].Excount {
						for _, ele := range result {
							sqlcmd = fmt.Sprintf(`update isale_outorder set outorder_downstate=3 where
				outorder_code='%s'`, ele.Outordercode)
							DebugLog.Println(sqlcmd)
							_, err = tx.Exec(sqlcmd)
							if err != nil {
								rtn.Code = 2
								rtn.Message = "更新订单状态:" + err.Error()
								bytes, _ := json.Marshal(rtn)
								fmt.Fprint(w, string(bytes))
								panic("cysql")
							}
						}

					} else {
						for _, ele := range result {
							sqlcmd = fmt.Sprintf(`update isale_outorder set outorder_downstate=2 where
				outorder_code='%s' and outorder_downstate=1`, ele.Outordercode)
							DebugLog.Println(sqlcmd)
							_, err = tx.Exec(sqlcmd)
							if err != nil {
								rtn.Code = 2
								rtn.Message = "更新订单状态:" + err.Error()
								bytes, _ := json.Marshal(rtn)
								fmt.Fprint(w, string(bytes))
								panic("cysql")
							}
						}
					}
				}
			} else if wave_type == 2 {
				sqlcmd = fmt.Sprintf(`SELECT	
COUNT(c.task_code),
ifnull(b.outorder_code	,"")
FROM
	isale_wavedetailspace a
INNER JOIN isale_waveoutorder b ON a.wavedetail_code = b.wavedetail_code
LEFT JOIN isale_task c on c.task_othercode=a.wavedetailspace_code
WHERE
	b.outorder_code =(
SELECT
	b.outorder_code
FROM
 isale_waveoutorder b 
where	b.wavedetail_code ='%s' 
)`, oneWaveDetailSpace.Wavedetail_code)
				outordercodeALL := ""
				outordercode1 := ""
				countTmpAll := 0
				countTmp := 0
				DebugLog.Println(sqlcmd)
				if err = tx.QueryRowx(sqlcmd).Scan(&countTmpAll, &outordercodeALL); err != nil {
					rtn.Code = 2
					rtn.Message = "查询剩余订单号状态:" + err.Error()
					bytes, _ := json.Marshal(rtn)
					fmt.Fprint(w, string(bytes))
					panic("cysql")
				}
				sqlcmd = fmt.Sprintf(`SELECT	
COUNT(c.task_code),
ifnull(b.outorder_code	,"")
FROM
	isale_wavedetailspace a
INNER JOIN isale_waveoutorder b ON a.wavedetail_code = b.wavedetail_code
LEFT JOIN isale_task c on c.task_othercode=a.wavedetailspace_code
WHERE
	b.outorder_code =(
SELECT
	b.outorder_code
FROM
 isale_waveoutorder b 
where	b.wavedetail_code ='%s' 
) and 
c.task_state=3`, oneWaveDetailSpace.Wavedetail_code)
				DebugLog.Println(sqlcmd)
				if err = tx.QueryRowx(sqlcmd).Scan(&countTmp, &outordercode1); err != nil {
					rtn.Code = 2
					rtn.Message = "查询已完成订单号状态:" + err.Error()
					bytes, _ := json.Marshal(rtn)
					fmt.Fprint(w, string(bytes))
					panic("cysql")
				}
				DebugLog.Printf("订单已完成数量：%d\n", countTmp)
				DebugLog.Printf("订单号：%s\n", outordercodeALL)
				if countTmp >= countTmpAll {

					if len(outordercode1) > 10 {
						DebugLog.Printf("订单号：%s\n", outordercodeALL)
						sqlcmd = fmt.Sprintf(`update isale_outorder set outorder_downstate=3 where
				outorder_code='%s'`, outordercodeALL)
						DebugLog.Println(sqlcmd)
						_, err = tx.Exec(sqlcmd)
						if err != nil {
							rtn.Code = 2
							rtn.Message = "更新订单状态:" + err.Error()
							bytes, _ := json.Marshal(rtn)
							fmt.Fprint(w, string(bytes))
							panic("cysql")
						}
					}

				} else {
					if len(outordercode1) > 10 {
						DebugLog.Printf("订单号：%s\n", outordercodeALL)
						sqlcmd = fmt.Sprintf(`update isale_outorder set outorder_downstate=2 where
				outorder_code='%s' and outorder_downstate=1`, outordercodeALL)
						DebugLog.Println(sqlcmd)
						_, err = tx.Exec(sqlcmd)
						if err != nil {
							rtn.Code = 2
							rtn.Message = "更新订单状态:" + err.Error()
							bytes, _ := json.Marshal(rtn)
							fmt.Fprint(w, string(bytes))
							panic("cysql")
						}
					}
				}

			}

		} else {
			//sqlcmd = fmt.Sprintf(`update isale_task set task_state=2 where task_code='%s' and task_state=1`, oneSpaceDetaillog.Task_code)
		}

	}
	rtn.Code = 1
	rtn.Message = ""
	bytes, _ := json.Marshal(rtn)
	fmt.Fprint(w, string(bytes))
}
