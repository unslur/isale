// FindTaskList
package main

import (
	"encoding/json"
	"fmt"
	"strings"
	//. "myfunc"
	"net/http"

	"github.com/cihub/seelog"
)

func FindTaskList(w http.ResponseWriter, r *http.Request) {

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
	InfoLog.Println("==========================查询任务开始：", r.URL)
	defer InfoLog.Println("==========================查询任务结束")
	r.ParseForm()
	pager_offset, found1 := r.Form["pager_offset"]
	user_code, found2 := r.Form["user_code"]
	DebugLog.Println(user_code[0])
	task_state, found3 := r.Form["task_state"]
	task_type, found4 := r.Form["task_type"]
	if !found1 || !found2 || !found3 || !found4 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}
	sqlcmd := ""
	task_type_condi := ""
	if found4 {
		task_type_condi = fmt.Sprintf(" and task_type=%s ", task_type[0])
	}
	var rtn Out_TaskType
	sqlcmd = fmt.Sprintf(`select task_code      ,
	task_type      ,
	task_othercode ,
	task_count     ,
	task_content   ,
	task_state,addtime      from isale_task
	 where user_code='%s' and task_state=%s %s limit %s,20`,
		user_code[0],
		task_state[0], task_type_condi, pager_offset[0])
	DebugLog.Println(sqlcmd)
	result, err := dborm.Query(sqlcmd)
	if err != nil {
		rtn.Code = 2
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到任务信息"
		} else {
			rtn.Message = "查询异常"
		}
		DebugLog.Println(rtn)
		seelog.Debug(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	defer result.Close()
	for result.Next() {

		var one Out_TaskTypeOne
		result.Scan(&one.Task_code, &one.Task_type, &one.Task_othercode,
			&one.Task_count, &one.Task_content, &one.Task_state, &one.Addtime)

		DebugLog.Println(one)
		rtn.Data = append(rtn.Data, one)
	}
	if rtn.Data == nil {
		rtn.Data = make([]Out_TaskTypeOne, 0)
	}
	rtn.Code = 1
	seelog.Debug(rtn)
	bytes, _ := json.Marshal(rtn)
	fmt.Fprint(w, string(bytes))
	return

}
