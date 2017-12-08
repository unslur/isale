// CheckStorage
package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"

	"github.com/cihub/seelog"
)

type Out_Check struct {
	Code    int
	Message string
	Data    []Tmp_check
}

func CheckStorage(w http.ResponseWriter, r *http.Request) {
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
	InfoLog.Println("==========================盘点开始：", r.URL)
	defer InfoLog.Println("==========================盘点结束")
	r.ParseForm()
	task_state, found1 := r.Form["task_state"]
	pager_offset, found3 := r.Form["pager_offset"]
	user_code, found2 := r.Form["user_code"]

	if !found1 || !found2 || !found3 {
		fmt.Fprint(w, "请勿非法访问")
		return
	}
	var rtn Out_Check
	sqlcmd := ""
	sqlcmd = fmt.Sprintf(`SELECT
	b.check_code,
	ifnull(b.product_names,"") product_names,
	ifnull(b.product_codes,"")product_codes,
	ifnull(b.user_code,"")user_code,
	ifnull(b.user_name,"")user_name,
	b.check_state,
	b.check_allocatstate,
	ifnull(b.space_codes,"") space_codes,
	ifnull(b.space_numbers,"") space_numbers,
	b.space_halftype,
	b.task_user_code,
	b.task_user_name,
	b.task_user_logourl
FROM
	isale_check b
WHERE
	b.check_state = %s
AND b.task_user_code = '%s'
Limit %s,20`, task_state[0], user_code[0], pager_offset[0])

	//CheckTaskList := []Tmp_check{}
	DebugLog.Println(sqlcmd)
	if err = tx.Select(&rtn.Data, sqlcmd); err != nil {
		rtn.Code = 2
		DebugLog.Println(err.Error())
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到盘点单"
		} else {
			rtn.Message = "查询异常"
		}
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	if rtn.Data == nil {
		rtn.Data = make([]Tmp_check, 0)
	}
	rtn.Code = 1
	rtn.Message = "成功"
	seelog.Debug(rtn)
	bytes, _ := json.Marshal(rtn)
	fmt.Fprint(w, string(bytes))
	return
}
