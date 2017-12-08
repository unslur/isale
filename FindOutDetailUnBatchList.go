// FindOutOrderDetailList
package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"
)

type Out_OutOrderDetail struct {
	Code    int
	Message string
	Data    []Out_OutOrderDetailListOne
}

type Out_OutOrderDetailListOne struct {
	Product_code       string
	Product_name       string
	Product_sku        string
	Space_number       string
	Space_linenumber   string
	Wavedetail_count   string
	Wavedetail_excount string
}

func FindOutOrderUnBatchDetailList(w http.ResponseWriter, r *http.Request) {

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
	InfoLog.Println("==========================获取出库非批拣详细列表开始：", r.URL)
	defer InfoLog.Println("==========================获取出库非批拣详细列表结束")
	r.ParseForm()
	wave_code, found1 := r.Form["wave_code"]
	outorder_code, found2 := r.Form["outorder_code"]

	if !found1 || !found2 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}

	sqlcmd := ""
	var rtn Out_OutOrderDetail

	sqlcmd = fmt.Sprintf(`SELECT
	a.product_code,
	a.product_name,
	a.product_sku,
	a.space_number,
	a.space_linenumber,
	a.wavedetail_count,
	ifnull(a.wavedetail_excount,"")
FROM
	isale_wavedetailspace a
LEFT JOIN isale_waveoutorder b ON a.wavedetail_code = b.wavedetail_code
WHERE
	b.outorder_code = '%s'
AND b.wave_code = '%s' `, outorder_code[0], wave_code[0])

	DebugLog.Println(sqlcmd)
	result, err := db.Query(sqlcmd)
	if err != nil {
		rtn.Code = 0
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到波次信息"
		} else {
			rtn.Message = "查询异常"
		}
		DebugLog.Println(rtn)
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
			&one.Wavedetail_count,
			&one.Wavedetail_excount)
		if err != nil {
			DebugLog.Println(err)
		}
		rtn.Data = append(rtn.Data, one)
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


/*
1,普通订单
2，加工订单
3，分销订单
0，错误
*/
func querytype(wave_code string) (int, error) {
	sqlcmd := ""
	types := 0
	sqlcmd = fmt.Sprintf(`select count(*) from isale_process where process_code='%s' `, wave_code)
	if err := dborm.QueryRowx(sqlcmd).Scan(&types); err != nil {
		DebugLog.Println(err)
		return 0, err
	}
	if types > 0 {
		return 2, nil
	}
	sqlcmd = fmt.Sprintf(`select count(*) from isale_storage_transfer where storagetransfer_code='%s'`, wave_code)
	if err := dborm.QueryRowx(sqlcmd).Scan(&types); err != nil {
		DebugLog.Println(err)
		return 0, err
	}
	if types > 0 {
		return 3, nil
	}
	return 1, nil
}
func querytypebydetail(task_code string) (int, error) {
	sqlcmd := ""
	types := 0
	sqlcmd = fmt.Sprintf(`select count(*) from isale_process where process_code='%s' `, task_code)
	if err := dborm.QueryRowx(sqlcmd).Scan(&types); err != nil {
		DebugLog.Println(err)
		return 0, err
	}
	if types > 0 {
		return 2, nil
	}
	sqlcmd = fmt.Sprintf(`select count(*) from isale_storage_transfer where storagetransfer_code='%s'`, task_code)
	if err := dborm.QueryRowx(sqlcmd).Scan(&types); err != nil {
		DebugLog.Println(err)
		return 0, err
	}
	if types > 0 {
		return 3, nil
	}
	return 1, nil
}