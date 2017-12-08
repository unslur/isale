// FindTaskMaxCount
package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"
)

type Out_MaxCount struct {
	Code    int
	Message string
	Data    Out_MaxCountOne
}
type Out_MaxCountOne struct {
	Count int
}

func FindTaskMaxCount(w http.ResponseWriter, r *http.Request) {

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
	InfoLog.Println("==========================获取订单数最大开始：", r.URL)
	defer InfoLog.Println("==========================获取订单数最大结束")
	r.ParseForm()
	task_othercode, found1 := r.Form["task_othercode"]
	if !found1 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}
	var rtn Out_MaxCount
	sqlcmd := ""
	sqlcmd = fmt.Sprintf(`SELECT product_count from 
	isale_inorderdetail where inorderdetail_code='%s'`, task_othercode[0])
	DebugLog.Println(sqlcmd)
	err = tx.QueryRow(sqlcmd).Scan(&rtn.Data.Count)
	if err != nil {
		rtn.Code = 2
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到任务信息"
		} else {
			rtn.Message = "查询异常"
		}
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	rtn.Code = 1
	rtn.Message = "成功"
	bytes, _ := json.Marshal(rtn)
	fmt.Fprint(w, string(bytes))
	return
}
