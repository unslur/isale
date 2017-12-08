// FindTaskDetail
package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"
)

type Out_Task struct {
	Code    int
	Message string
	Data    Out_TaskList
}
type Out_TaskList struct {
	Task Out_TaskOne

	List []Out_TaskListOne
}
type Out_TaskOne struct {
	Product_imgurl  string
	User_name       string
	User_code       string
	Product_name    string
	Product_unit    string
	Product_bulk    string
	Product_barcode string
	Product_code    string
	Product_sku     string
	Product_enname  string
	Task_count      string
	Task_type       string
	Task_code       string
	Task_othercode  string
	Count           int
}
type Out_TaskListOne struct {
	Task_code        string
	Task_type        string
	Task_content     string
	Task_state       string
	Task_count       string
	Task_othercode   string
	Area_name        string
	Space_code       string
	Space_number     string
	Space_linenumber string
	Space_usedbulk   string
	Space_leftbulk   string
	Space_upbulk     string
	Addtime          string
}

func FindTaskDetail(w http.ResponseWriter, r *http.Request) {

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
	InfoLog.Println("==========================查询任务明细开始：", r.URL)
	defer InfoLog.Println("==========================查询任务明细结束")
	r.ParseForm()
	task_code, found1 := r.Form["task_code"]
	if !found1 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}
	var rtn Out_Task
	sqlcmd := ""
	sqlcmd = fmt.Sprintf(`SELECT
		product_imgurl,
		user_name,
		user_code,
		product_name,
		product_unit,
		product_bulk,
		ifnull(product_barcode,"" ) product_barcode         ,
		product_code,
		product_sku,
		product_enname,
		task_count,
		task_type,
		task_code,
		task_othercode
	FROM
		isale_task
	where  task_code='%s' `, task_code[0])
	DebugLog.Println(sqlcmd)
	err = tx.QueryRow(sqlcmd).Scan(&rtn.Data.Task.Product_imgurl,
		&rtn.Data.Task.User_name,
		&rtn.Data.Task.User_code,
		&rtn.Data.Task.Product_name,
		&rtn.Data.Task.Product_unit,
		&rtn.Data.Task.Product_bulk,
		&rtn.Data.Task.Product_barcode,
		&rtn.Data.Task.Product_code,
		&rtn.Data.Task.Product_sku,
		&rtn.Data.Task.Product_enname,
		&rtn.Data.Task.Task_count,
		&rtn.Data.Task.Task_type,
		&rtn.Data.Task.Task_code,
		&rtn.Data.Task.Task_othercode)
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

	sqlcmd = fmt.Sprintf(`update isale_task set task_state=2 
	where task_code='%s' and task_state=1`, task_code[0])
	DebugLog.Println(sqlcmd)
	stmts, err := tx.Prepare(sqlcmd)

	if err != nil {
		InfoLog.Println(err)
		rtn.Code = 2
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到任务信息"
		} else {
			rtn.Message = "更新失败"
		}
		DebugLog.Println(rtn)
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	defer stmts.Close()
	results, err := stmts.Exec()
	if err != nil {
		InfoLog.Println(err)
		rtn.Code = 4
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到任务信息"
		} else {
			rtn.Message = "更新失败"
		}

		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	affect, err := results.RowsAffected()
	if err != nil {
		InfoLog.Println(err)
		rtn.Code = 3
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到任务信息"
		} else {
			rtn.Message = "查询异常"
		}
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	DebugLog.Printf("受影响的条数：%d", affect)
	sqlcmd = fmt.Sprintf(`select ios_t.task_code,ios_t.count task_count,a.area_name,
	s.space_code,s.space_number,s.space_linenumber
	,s.space_usedbulk,s.space_leftbulk,s.space_upbulk
			from isale_inorderspace_tmp ios_t
			inner join isale_space s on s.space_code = ios_t.space_code
			inner join isale_area a on s.area_code = a.area_code 
			 and ios_t.task_code  = %s
				order by s.space_number desc  `, task_code[0])
	DebugLog.Println(sqlcmd)
	result, err := tx.Query(sqlcmd)
	if err != nil {
		InfoLog.Println(err)
		rtn.Code = 3
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到任务信息"
		} else {
			rtn.Message = "查询异常"
		}
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	defer result.Close()
	for result.Next() {
		var one Out_TaskListOne
		result.Scan(&one.Task_code,
			&one.Task_count,
			&one.Area_name, &one.Space_code, &one.Space_number, &one.Space_linenumber,
			&one.Space_usedbulk, &one.Space_leftbulk, &one.Space_upbulk)
		rtn.Data.List = append(rtn.Data.List, one)
	}
	sqlcmd = fmt.Sprintf(`select sum(sd.space_count) task_count_up
		from isale_spacedetaillog sd
		where sd.task_code = '%s' group by sd.task_code`, task_code[0])
	DebugLog.Println(sqlcmd)
	err = tx.QueryRow(sqlcmd).Scan(&rtn.Data.Task.Count)
	if err != nil {
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Data.Task.Count = 0
		} else {
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到任务信息"
			} else {
				rtn.Message = "查询异常"
			}
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}

	}
	if rtn.Data.List == nil {
		rtn.Data.List = make([]Out_TaskListOne, 0)
	}
	rtn.Code = 1
	rtn.Message = "成功"
	DebugLog.Println(rtn)
	bytes, _ := json.Marshal(rtn)
	fmt.Fprint(w, string(bytes))

}
