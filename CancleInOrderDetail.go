// CancleInOrderDetail
package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"
)

func CancleInOrderDetail(w http.ResponseWriter, r *http.Request) {
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
	InfoLog.Println("==========================审查取消订单开始：", r.URL)
	defer InfoLog.Println("==========================审查取消订单结束")
	r.ParseForm()
	inorderdetail_code, found1 := r.Form["inorderdetail_code"]

	user_code, found2 := r.Form["user_code"]

	if !found1 || !found2 {
		fmt.Fprint(w, "请勿非法访问")
		return
	}
	DebugLog.Println(user_code[0])
	rtn := Rtn{}
	sqlcmd := ""
	oneDetail := Tmp_InorderdetailCode{}
	sqlcmd = fmt.Sprintf(`select inorder_code,product_code , inorderdetail_state from isale_inorderdetail where inorderdetail_code='%s'`, inorderdetail_code[0])
	if err = tx.Get(&oneDetail, sqlcmd); err != nil {
		rtn.Code = 2
		DebugLog.Println(err.Error())
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到入库单"
		} else {
			rtn.Message = "查询异常"
		}
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	if oneDetail.Inorderdetail_state != 1 {
		rtn.Code = 2
		rtn.Message = "该订单已被处理"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	Count := 0
	sqlcmd = fmt.Sprintf(`SELECT ifnull(SUM(product_count),0) from isale_inorderdetail_batch WHERE inorderdetail_code='%s'`, inorderdetail_code[0])
	if err = tx.QueryRowx(sqlcmd).Scan(&Count); err != nil {
		rtn.Code = 2
		rtn.Message = "错误发生" + err.Error()
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return

	}
	if Count > 0 {
		rtn.Code = 2
		rtn.Message = "已经审核过，无法取消订单"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}

	sqlcmd = fmt.Sprintf(`update isale_inorderdetail set inorderdetail_state=3 ,product_state=4 where inorderdetail_code='%s'`, inorderdetail_code[0])
	if _, err = tx.Exec(sqlcmd); err != nil {
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

	sqlcmd = fmt.Sprintf(`update isale_product set product_state=4 where product_code='%s' and product_state!=3`, oneDetail.Product_code)
	DebugLog.Println(sqlcmd)
	if _, err = tx.Exec(sqlcmd); err != nil {
		rtn.Code = 2
		DebugLog.Println(err.Error())
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到入库单"
		} else {
			rtn.Message = "查询异常"
		}
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	sqlcmd = fmt.Sprintf(`select count(inorderdetail_code) from isale_inorderdetail where inorder_code='%s'
	and inorderdetail_state=1`, oneDetail.Inorder_code)
	count := 0
	if err = tx.QueryRowx(sqlcmd).Scan(&count); err != nil {
		rtn.Code = 2
		DebugLog.Println(err.Error())
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询入库子单，或者已经录入部分"
		} else {
			rtn.Message = "查询异常"
		}
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	if count == 0 {
		sqlcmd = fmt.Sprintf(`update isale_inorder set inorder_verify_state=2 where inorder_code='%s'`, oneDetail.Inorder_code)
		if _, err = tx.Exec(sqlcmd); err != nil {
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
	}
	rtn.Code = 1
	rtn.Message = "成功"
	DebugLog.Println(rtn)
	bytes, _ := json.Marshal(rtn)
	fmt.Fprint(w, string(bytes))
}
