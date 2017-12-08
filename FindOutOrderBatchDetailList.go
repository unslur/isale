// FindOutOrderBatchDetailList
package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"
)

func FindOutOrderBatchDetailList(w http.ResponseWriter, r *http.Request) {

	defer func() { // 必须要先声明defer，否则不能捕获到panic异常

		err := recover()
		if err != nil {

			InfoLog.Println(err) // 这里的err其实就是panic传入的内容，55
		}

	}()
	InfoLog.Println("==========================获取出库批间详细列表开始：", r.URL)
	defer InfoLog.Println("==========================获取出库批间详细列表结束")
	r.ParseForm()
	wave_code, found1 := r.Form["wave_code"]
	product_code, found2 := r.Form["product_code"]
	DebugLog.Println(r.Form)
	if !found1 || !found2 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}

	sqlcmd := ""
	var rtn Out_OutOrderDetail
	types, err := querytype(wave_code[0])
	if err != nil {
		rtn.Code = 0
		rtn.Message = "查询异常"
		bytes, _ := json.Marshal(rtn)

		fmt.Fprint(w, string(bytes))

		return
	}
	if types == 1 {
		//普通订单
		InfoLog.Println("普通订单")
		sqlcmd = fmt.Sprintf(`SELECT
	DISTINCT
	product_code,
	product_name,
	product_sku,
	space_number,
	space_linenumber,
	wavedetail_count
FROM
	isale_wavedetailspace a
LEFT JOIN isale_waveoutorder b ON a.wavedetail_code = b.wavedetail_code
WHERE
	a.product_code = '%s'
AND b.wave_code = '%s'
and b.wave_type=1 `, product_code[0], wave_code[0])

		DebugLog.Println(sqlcmd)
		result, err := db.Query(sqlcmd)
		if err != nil {
			rtn.Code = 0
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到波次信息"
			} else {
				rtn.Message = "查询异常"
			}
			bytes, _ := json.Marshal(rtn)

			fmt.Fprint(w, string(bytes))

			return
		}
		defer result.Close()
		for result.Next() {
			var one Out_OutOrderDetailListOne
			err = result.Scan(&one.Product_code,
				&one.Product_name,
				&one.Product_sku,
				&one.Space_number,
				&one.Space_linenumber,
				&one.Wavedetail_count)
			if err != nil {
				DebugLog.Println(err)
			}
			rtn.Data = append(rtn.Data, one)
		}
	} else if types == 2 {

		InfoLog.Println("加工订单")
		sqlcmd = fmt.Sprintf(`SELECT
			DISTINCT
			product_code,
			product_name,
			product_sku,
			space_number,
			space_linenumber,
			processdetailspace_count,
			ifnull(processdetailspace_excount,"0")
		FROM
		isale_processdetailspace a
		
		WHERE
			a.product_code = '%s'
		AND a.process_code = '%s'
		`, product_code[0], wave_code[0])

		DebugLog.Println(sqlcmd)
		result, err := db.Query(sqlcmd)
		if err != nil {
			rtn.Code = 0
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到波次信息"
			} else {
				rtn.Message = "查询异常"
			}
			bytes, _ := json.Marshal(rtn)

			fmt.Fprint(w, string(bytes))

			return
		}
		defer result.Close()
		for result.Next() {
			var one Out_OutOrderDetailListOne
			err = result.Scan(&one.Product_code,
				&one.Product_name,
				&one.Product_sku,
				&one.Space_number,
				&one.Space_linenumber,
				&one.Wavedetail_count,&one.Wavedetail_excount)
			if err != nil {
				DebugLog.Println(err)
			}
			rtn.Data = append(rtn.Data, one)
		}
	} else if types == 3 {
		InfoLog.Println("分销订单")
		sqlcmd = fmt.Sprintf(`SELECT
			DISTINCT
			product_code,
			product_name,
			product_sku,
			space_number,
			space_linenumber,
			storagetransferspace_count,ifnull(storagetransferspace_excount,"0")
		FROM
		
		isale_storage_transfer_space b 
		WHERE
			b.product_code = '%s'
		AND b.storagetransfer_code = '%s'
		 `, product_code[0], wave_code[0])

		DebugLog.Println(sqlcmd)
		result, err := db.Query(sqlcmd)
		if err != nil {
			rtn.Code = 0
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到波次信息"
			} else {
				DebugLog.Println(err.Error())
				rtn.Message = "查询异常"
			}
			bytes, _ := json.Marshal(rtn)

			fmt.Fprint(w, string(bytes))

			return
		}
		defer result.Close()
		for result.Next() {
			var one Out_OutOrderDetailListOne
			err = result.Scan(&one.Product_code,
				&one.Product_name,
				&one.Product_sku,
				&one.Space_number,
				&one.Space_linenumber,
				&one.Wavedetail_count,&one.Wavedetail_excount)
			if err != nil {
				DebugLog.Println(err)
			}
			rtn.Data = append(rtn.Data, one)
		}
	}
	if rtn.Data == nil {
		rtn.Data = make([]Out_OutOrderDetailListOne, 0)
	}
	rtn.Code = 1
	rtn.Message = "成功"
	DebugLog.Println(rtn)
	bytes, _ := json.Marshal(rtn)
	fmt.Fprint(w, string(bytes))
	return
}
