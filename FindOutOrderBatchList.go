// FindOutOrderBatchList
package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"
)

type Out_OutOrderBatch struct {
	Code    int
	Message string
	Data    []Out_OutOrderBatchListOne
}

type Out_OutOrderBatchListOne struct {
	Product_name       string
	Product_code       string
	Product_sku        string
	Wavedetail_count   int
	Wavedetail_excount int
}

func FindOutOrderBatchList(w http.ResponseWriter, r *http.Request) {

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
	InfoLog.Println("==========================获取出库批拣列表开始：", r.URL)
	defer InfoLog.Println("==========================获取出库批间列表结束")
	r.ParseForm()
	user_code, found1 := r.Form["user_code"]
	wave_code, found2 := r.Form["wave_code"]
	//task_code, found3 := r.Form["task_code"]
	task_state, found4 := r.Form["task_state"]
	//task_othercode, found5 := r.Form["task_othercode"]
	if !found1 || !found2 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}

	sqlcmd := ""
	var rtn Out_OutOrderBatch

	if !found4 {
		DebugLog.Println("没有找到状态标示")
		task_state[0] = "1"
	} else {

		DebugLog.Println("状态标示", task_state[0])
	}
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
	types, err := querytype(wave_code[0])
	if err != nil {
		rtn.Code = 2
		rtn.Message = "查询异常"

		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	if types == 2 {
		InfoLog.Println("加工订单")
		sqlcmd = fmt.Sprintf(`UPDATE isale_task
	SET task_state = 2
	WHERE
		task_othercode IN (
			SELECT
				wds.processdetailspace_code
			FROM
				isale_processdetailspace wds
			WHERE
				wds.process_code = '%s'
		)
	AND user_code = '%s'
	AND task_state = 1`,
			wave_code[0], user_code[0])
		DebugLog.Println(sqlcmd)
		_, err = db.Exec(sqlcmd)
		if err != nil {
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到货位信息"
			} else {
				rtn.Message = "更新失败"
			}
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			return
		}
		if task_state[0] == "1" {
			task_state[0] = "2"
		}
		sqlcmd = fmt.Sprintf(`SELECT
	pds.product_name,
	pds.product_code,
	pds.product_sku,
	sum(pds.processdetailspace_count + 0) processdetail_count,
	sum(ifnull(pds.processdetailspace_excount,"") + 0) processdetail_excount
FROM
	isale_task t
LEFT JOIN isale_processdetailspace pds ON t.task_othercode = pds.processdetailspace_code
LEFT JOIN isale_processdetail pd ON pd.processdetail_code = pds.processdetail_code
WHERE
	t.task_state = %s
AND pds.process_code = '%s'
AND t.user_code = '%s'

GROUP BY
	pds.product_code `, task_state[0], wave_code[0], user_code[0])

		DebugLog.Println(sqlcmd)
		result, err := db.Query(sqlcmd)
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
		defer result.Close()
		for result.Next() {
			var one Out_OutOrderBatchListOne
			err = result.Scan(&one.Product_name, &one.Product_code,
				&one.Product_sku,
				&one.Wavedetail_count, &one.Wavedetail_excount)
			if err != nil {
				DebugLog.Println(err)
			}
			rtn.Data = append(rtn.Data, one)
		}
	} else if types == 3 {
		InfoLog.Println("分销订单")
		sqlcmd = fmt.Sprintf(`UPDATE isale_task
	SET task_state = 2
	WHERE
		task_othercode IN (
			SELECT
				wds.storagetransferspace_code
			FROM
			isale_storage_transfer_space wds
			WHERE
				wds.storagetransfer_code = '%s'
		)
	AND user_code = '%s'
	AND task_state = 1`,
			wave_code[0], user_code[0])
		DebugLog.Println(sqlcmd)
		_, err = db.Exec(sqlcmd)
		if err != nil {
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到货位信息"
			} else {
				rtn.Message = "更新失败"
			}
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			return
		}
		if task_state[0] == "1" {
			task_state[0] = "2"
		}
		sqlcmd = fmt.Sprintf(`SELECT
	pds.product_name,
	pds.product_code,
	pds.product_sku,
	sum(pds.storagetransferspace_count + 0) storagetransferspace_count,
	sum(ifnull(pds.storagetransferspace_excount,"") + 0) storagetransferspace_excount
FROM
	isale_task t
LEFT JOIN isale_storage_transfer_space pds ON t.task_othercode = pds.storagetransferspace_code
LEFT JOIN isale_storage_transfer pd ON pd.storagetransfer_code = pds.storagetransfer_code
WHERE
	t.task_state = %s
AND pds.storagetransfer_code = '%s'
AND t.user_code = '%s'

GROUP BY
	pds.product_code `, task_state[0], wave_code[0], user_code[0])

		DebugLog.Println(sqlcmd)
		result, err := db.Query(sqlcmd)
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
		defer result.Close()
		for result.Next() {
			var one Out_OutOrderBatchListOne
			err = result.Scan(&one.Product_name, &one.Product_code,
				&one.Product_sku,
				&one.Wavedetail_count, &one.Wavedetail_excount)
			if err != nil {
				DebugLog.Println(err)
			}
			rtn.Data = append(rtn.Data, one)
		}
	} else {
		// isTransfer := 0
		// sqlcmd = fmt.Sprintf(`select count(*) from isale_storage_transfer where storagetransfer_code='%s'`, wave_code[0])
		// if err = dborm.QueryRowx(sqlcmd).Scan(&isTransfer); err != nil {
		// 	rtn.Code = 2
		// 	if strings.Contains(err.Error(), "sql: no rows in result set") {
		// 		rtn.Message = "没有查询到process信息"
		// 	} else {
		// 		rtn.Message = "查询异常"
		// 	}
		// 	bytes, _ := json.Marshal(rtn)
		// 	fmt.Fprint(w, string(bytes))
		// 	return
		// }
		// 	if isTransfer > 0 {
		// 		//分销订单
		// 		InfoLog.Println("分销订单")
		// 		sqlcmd = fmt.Sprintf(`UPDATE isale_task
		// 	SET task_state = 2
		// 	WHERE
		// 		task_othercode IN (
		// 			SELECT
		// 				wds.storagetransferspace_code
		// 			FROM
		// 			isale_storage_transfer_space wds
		// 			WHERE
		// 				wds.storagetransfer_code= '%s'
		// 		)
		// 	AND user_code = '%s'
		// 	AND task_state = 1`,
		// 			wave_code[0], user_code[0])
		// 		DebugLog.Println(sqlcmd)
		// 		_, err = db.Exec(sqlcmd)
		// 		if err != nil {
		// 			rtn.Code = 2
		// 			if strings.Contains(err.Error(), "sql: no rows in result set") {
		// 				rtn.Message = "没有查询到货位信息"
		// 			} else {
		// 				rtn.Message = "更新失败"
		// 			}
		// 			bytes, _ := json.Marshal(rtn)
		// 			fmt.Fprint(w, string(bytes))
		// 			return
		// 		}
		// 		if task_state[0] == "1" {
		// 			task_state[0] = "2"
		// 		}
		// 		sqlcmd = fmt.Sprintf(`SELECT
		// 	pds.product_name,
		// 	pds.product_code,
		// 	pds.product_sku,
		// 	sum(pds.storagetransferspace_count+ 0) processdetail_count
		// FROM
		// 	isale_task t
		// LEFT JOIN isale_storage_transfer_space pds ON t.task_othercode = pds.storagetransferspace_code
		// LEFT JOIN isale_storage_transfer pd ON pd.storagetransfer_code	= pds.storagetransfer_code
		// WHERE
		// 	t.task_state = %s
		// AND pds.storagetransfer_code= '%s'
		// AND t.user_code = '%s'

		// GROUP BY
		// 	pds.product_code `, task_state[0], wave_code[0], user_code[0])

		// 		DebugLog.Println(sqlcmd)
		// 		result, err := db.Query(sqlcmd)
		// 		if err != nil {
		// 			rtn.Code = 0
		// 			if strings.Contains(err.Error(), "sql: no rows in result set") {
		// 				rtn.Message = "没有查询到任务信息"
		// 			} else {
		// 				rtn.Message = "查询异常"
		// 			}
		// 			bytes, _ := json.Marshal(rtn)

		// 			fmt.Fprint(w, string(bytes))

		// 			return
		// 		}
		// 		defer result.Close()
		// 		for result.Next() {
		// 			var one Out_OutOrderBatchListOne
		// 			err = result.Scan(&one.Product_name, &one.Product_code,
		// 				&one.Product_sku,
		// 				&one.Wavedetail_count)
		// 			if err != nil {
		// 				DebugLog.Println(err)
		// 			}
		// 			rtn.Data = append(rtn.Data, one)
		// 		}
		// 	} else {
		InfoLog.Println("普通订单")
		sqlcmd = fmt.Sprintf(`UPDATE isale_task
SET task_state = 2
WHERE
	task_othercode IN (
		SELECT
			wds.wavedetailspace_code
		FROM
			isale_wavedetailspace wds
		WHERE
			wds.wave_code = '%s'
	)
AND user_code = '%s'
AND task_state = 1`,
			wave_code[0], user_code[0])
		DebugLog.Println(sqlcmd)
		_, err := db.Exec(sqlcmd)
		if err != nil {
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到货位信息"
			} else {
				rtn.Message = "更新失败"
			}
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			return
		}

		if task_state[0] == "1" {
			task_state[0] = "2"
		}
		sqlcmd = fmt.Sprintf(`SELECT
	wds.product_name,
	wds.product_code,
	wds.product_sku,
	sum(wds.wavedetail_count + 0) wavedetail_count,
	ifnull(sum(wds.wavedetail_excount+0),0) wavedetail_excount
FROM
	isale_task t
LEFT JOIN isale_wavedetailspace wds ON t.task_othercode = wds.wavedetailspace_code
LEFT JOIN isale_wavedetail wd ON wd.wavedetail_code = wds.wavedetail_code
WHERE
	t.task_state = %s
AND wds.wave_code = '%s'
AND t.user_code = '%s'
AND wd.wave_type = 1
GROUP BY
	wds.product_code `, task_state[0], wave_code[0], user_code[0])

		DebugLog.Println(sqlcmd)
		result, err := db.Query(sqlcmd)
		if err != nil {
			rtn.Code = 0
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到波次信息"
			} else {
				rtn.Message = "查询异常"
			}
			InfoLog.Println(err.Error())
			bytes, _ := json.Marshal(rtn)

			fmt.Fprint(w, string(bytes))

			return
		}
		defer result.Close()
		for result.Next() {
			var one Out_OutOrderBatchListOne
			err = result.Scan(&one.Product_name, &one.Product_code,
				&one.Product_sku,
				&one.Wavedetail_count, &one.Wavedetail_excount)
			if err != nil {
				DebugLog.Println(err)
			}
			rtn.Data = append(rtn.Data, one)
		}
	}

	if rtn.Data == nil {
		rtn.Data = make([]Out_OutOrderBatchListOne, 0)
	}
	rtn.Code = 1
	rtn.Message = "成功"
	DebugLog.Println(rtn)
	bytes, _ := json.Marshal(rtn)
	fmt.Fprint(w, string(bytes))
	return
}
