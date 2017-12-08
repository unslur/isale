// UpdateTaskState
package main

import (
	"encoding/json"
	"fmt"
	"net/http"
)

func UpdateTaskState(w http.ResponseWriter, r *http.Request) {

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
	InfoLog.Println("==========================更新任务开始：", r.URL)
	defer InfoLog.Println("==========================更新任务结束")
	r.ParseForm()
	task_code, found1 := r.Form["task_code"]
	task_type, found1 := r.Form["task_type"]
	task_state, found1 := r.Form["task_state"]
	task_othercode, found1 := r.Form["task_othercode"]
	if !found1 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}
	var rtn Out_OutOrderUnBatch
	sqlcmd := ""
	sqlcmd = fmt.Sprintf(`update isale_task set task_state=%s where task_code='%s'`,
		task_state[0], task_code[0])
	DebugLog.Println(sqlcmd)
	stmts, err := tx.Prepare(sqlcmd)

	if err != nil {
		InfoLog.Println(err)
		rtn.Code = 2
		rtn.Message = "更新失败"
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
		rtn.Message = "更新失败"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	_, err = results.RowsAffected()
	if err != nil {
		InfoLog.Println(err)
		rtn.Code = 3
		rtn.Message = "更新失败"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	sqlcmd = fmt.Sprintf(`call proc_inorder_d('%s')`, task_code[0])
	DebugLog.Println(sqlcmd)
	stmtsd, err := db.Prepare(sqlcmd)
	DebugLog.Println(1)
	if err != nil {
		InfoLog.Println(err)
		rtn.Code = 2
		rtn.Message = "更新失败"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	defer stmtsd.Close()
	DebugLog.Println(2)
	resultsd, err := stmtsd.Exec()
	if err != nil {
		InfoLog.Println(err)
		rtn.Code = 4
		rtn.Message = "更新失败"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	DebugLog.Println(3)
	_, err = resultsd.RowsAffected()
	if err != nil {
		InfoLog.Println(err)
		rtn.Code = 3
		rtn.Message = "更新失败"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	DebugLog.Println(4)

	sqlcmd = fmt.Sprintf(`select count(1) from isale_task 
	where task_othercode = '%s' and (task_state=2 or task_state=1)`,
		task_othercode[0], task_type[0])
	count := 0
	DebugLog.Println(sqlcmd)
	err = tx.QueryRow(sqlcmd).Scan(&count)
	if err != nil {
		InfoLog.Println(err)
		rtn.Code = 3
		rtn.Message = "更新失败"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	if count < 2 {
		sqlcmd = fmt.Sprintf(`update isale_inorderdetail set  inorderdetail_state=4
		where inorderdetail_code='%s'`, task_othercode[0])
		DebugLog.Println(sqlcmd)
		stmtsd, err := tx.Prepare(sqlcmd)

		if err != nil {
			InfoLog.Println(err)
			rtn.Code = 2
			rtn.Message = "更新失败"
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		defer stmtsd.Close()
		resultsd, err := stmtsd.Exec()
		if err != nil {
			InfoLog.Println(err)
			rtn.Code = 4
			rtn.Message = "更新失败"
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		_, err = resultsd.RowsAffected()
		if err != nil {
			InfoLog.Println(err)
			rtn.Code = 3
			rtn.Message = "更新失败"
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		sqlcmd = fmt.Sprintf(`select count(1) from isale_inorderdetail iod where iod.inorder_code = (
			select iod.inorder_code from isale_inorderdetail iod where iod.inorderdetail_code='%s'
			) and (iod.inorderdetail_state = 1 or iod.inorderdetail_state =2)`, task_othercode[0])
		err = tx.QueryRow(sqlcmd).Scan(&count)
		if err != nil {
			InfoLog.Println(err)
			rtn.Code = 2
			rtn.Message = err.Error()
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		if count < 2 {
			sqlcmd = fmt.Sprintf(`update isale_inorder set inorder_state=2 where inorder_code=(
				select DISTINCT inorder_code 
				from isale_inorderdetail 
				where inorderdetail_code='%s') `, task_othercode[0])
			DebugLog.Println(sqlcmd)
			stmtsd, err := tx.Prepare(sqlcmd)

			if err != nil {
				InfoLog.Println(err)
				rtn.Code = 2
				rtn.Message = "更新失败"
				DebugLog.Println(rtn)
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}
			defer stmtsd.Close()
			resultsd, err := stmtsd.Exec()
			if err != nil {
				InfoLog.Println(err)
				rtn.Code = 4
				rtn.Message = "更新失败"
				DebugLog.Println(rtn)
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}
			_, err = resultsd.RowsAffected()
			if err != nil {
				InfoLog.Println(err)
				rtn.Code = 3
				rtn.Message = "更新失败"
				DebugLog.Println(rtn)
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}
		}

	}
	rtn.Code = 1
	rtn.Message = "成功"
	DebugLog.Println(rtn)
	bytes, _ := json.Marshal(rtn)
	fmt.Fprint(w, string(bytes))

}
