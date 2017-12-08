// FindOutTaskList
package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
	"strings"
)

type Out_OutTask struct {
	Code    int
	Message string
	Data    []Out_OutTaskOne
}

type Out_OutTaskOne struct {
	Task_code      string
	Task_type      int
	Task_content   string
	Task_state     int64
	Task_count     string
	Task_othercode string
	Wave_code      string
	Addtime        string
}

func FindOutTaskList(w http.ResponseWriter, r *http.Request) {

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
	InfoLog.Println("==========================查询出库任务开始：", r.URL)
	defer InfoLog.Println("==========================查询出库任务结束")
	r.ParseForm()
	pager_offset, found1 := r.Form["pager_offset"]
	user_code, found2 := r.Form["user_code"]
	//DebugLog.Println(user_code[0])
	task_state, found3 := r.Form["task_state"]

	if !found1 || !found2 || !found3 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}
	var rtn Out_OutTask
	var pager_offsetint int64
	if pager_offsetint, err = strconv.ParseInt(pager_offset[0], 0, 64); err != nil {
		rtn.Code = 7
		rtn.Message = "重量原始量字符串为非数字:" + err.Error()
		InfoLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return

	}
	sqlcmd := ""
	sqlcmd = fmt.Sprintf(`SELECT	
	count(t.task_code),	
	GROUP_CONCAT(DISTINCT ifnull(t.task_content,"")) task_content,	
	wds.wave_code,
	wds.addtime
FROM
	isale_task t
left JOIN isale_wavedetailspace wds ON t.task_othercode = wds.wavedetailspace_code
WHERE
	t.task_state = %s
	AND t.task_type = 3
AND t.user_code = '%s'
GROUP BY
	wds.wave_code
`, task_state[0], user_code[0])
	DebugLog.Println(sqlcmd)
	result, err := db.Query(sqlcmd)
	if err != nil {
		rtn.Code = 0
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到任务信息"
		} else {
			InfoLog.Println(err.Error())
			rtn.Message = "查询异常"
		}
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)

		fmt.Fprint(w, string(bytes))

		return
	}
	var count int64
	defer result.Close()
	for result.Next() {
		count++
	}
	sqlcmd = fmt.Sprintf(`SELECT	
	count(t.task_code),	
	GROUP_CONCAT(DISTINCT ifnull(t.task_content,"")) task_content,	
	wds.wave_code,
	wds.addtime
FROM
	isale_task t
left JOIN isale_wavedetailspace wds ON t.task_othercode = wds.wavedetailspace_code
WHERE
	t.task_state = %s
	AND t.task_type = 3
AND t.user_code = '%s'
GROUP BY
	wds.wave_code
LIMIT %s, 20`, task_state[0], user_code[0], pager_offset[0])
	DebugLog.Println(sqlcmd)
	results, err := db.Query(sqlcmd)
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
	defer results.Close()
	for results.Next() {
		var one Out_OutTaskOne
		results.Scan(&one.Task_count,
			&one.Task_content,
			&one.Wave_code, &one.Addtime)
		if one.Task_state, err = strconv.ParseInt(task_state[0], 0, 64); err != nil {
			rtn.Code = 7
			rtn.Message = "重量原始量字符串为非数字:" + err.Error()
			InfoLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			return

		}

		rtn.Data = append(rtn.Data, one)

	}

	length := int64(len(rtn.Data))

	if length < 20 {

		var start_a int64
		var start_b int64
		if pager_offsetint-count < 0 {
			start_a = 0
		} else {
			start_a = pager_offsetint - count
		} //取整

		start_b = 20 - length //取余

		sqlcmd = fmt.Sprintf(`SELECT	
	count(t.task_code),	
	GROUP_CONCAT(DISTINCT ifnull(t.task_content,"")) task_content,	
	pds.process_code,
	pds.addtime
FROM
	isale_task t
left JOIN isale_processdetailspace pds ON t.task_othercode = pds.processdetailspace_code
WHERE
	t.task_state = %s
	AND t.task_type = 9
AND t.user_code = '%s'
GROUP BY
	pds.process_code
LIMIT %d, %d`, task_state[0], user_code[0], start_a, start_b)
		DebugLog.Println(sqlcmd)
		resultss, err := db.Query(sqlcmd)
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
		defer resultss.Close()
		for resultss.Next() {
			var one Out_OutTaskOne
			resultss.Scan(&one.Task_count,
				&one.Task_content,
				&one.Wave_code, &one.Addtime)
			if one.Task_state, err = strconv.ParseInt(task_state[0], 0, 64); err != nil {
				rtn.Code = 7
				rtn.Message = "重量原始量字符串为非数字:" + err.Error()
				InfoLog.Println(rtn)
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				return

			}

			rtn.Data = append(rtn.Data, one)

		}
		length = int64(len(rtn.Data))
		if length < 20 {
			var start_a1 int64
			var start_b1 int64
			if pager_offsetint-count < 0 {
				start_a1 = 0
			} else {
				start_a1 = pager_offsetint - count
			} //取整

			start_b1 = 20 - length //取余

			sqlcmd = fmt.Sprintf(`SELECT	
	count(t.task_code),	
	GROUP_CONCAT(DISTINCT ifnull(t.task_content,"")) task_content,	
	pds.storagetransfer_code	,
	pds.addtime
FROM
	isale_task t
left JOIN isale_storage_transfer_space pds ON t.task_othercode = pds.storagetransferspace_code
WHERE
	t.task_state = %s
	AND t.task_type = 10
AND t.user_code = '%s'
GROUP BY
	pds.storagetransfer_code	
LIMIT %d, %d`, task_state[0], user_code[0], start_a1, start_b1)
			DebugLog.Println(sqlcmd)
			resultsss, err := db.Query(sqlcmd)
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
			defer resultsss.Close()
			for resultsss.Next() {
				var one Out_OutTaskOne
				resultsss.Scan(&one.Task_count,
					&one.Task_content,
					&one.Wave_code, &one.Addtime)
				if one.Task_state, err = strconv.ParseInt(task_state[0], 0, 64); err != nil {
					rtn.Code = 7
					rtn.Message = "重量原始量字符串为非数字:" + err.Error()
					InfoLog.Println(rtn)
					bytes, _ := json.Marshal(rtn)
					fmt.Fprint(w, string(bytes))
					return

				}

				rtn.Data = append(rtn.Data, one)

			}
		}
	}
	if rtn.Data == nil {
		rtn.Data = make([]Out_OutTaskOne, 0)
	}
	rtn.Code = 1
	rtn.Message = "成功"
	DebugLog.Println(rtn)
	bytes, _ := json.Marshal(rtn)

	fmt.Fprint(w, string(bytes))

	return
}
func FindOutTaskList1(w http.ResponseWriter, r *http.Request) {

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
	InfoLog.Println("==========================查询出库任务开始：", r.URL)
	defer InfoLog.Println("==========================查询出库任务结束")
	r.ParseForm()
	pager_offset, found1 := r.Form["pager_offset"]
	user_code, found2 := r.Form["user_code"]
	//DebugLog.Println(user_code[0])
	task_state, found3 := r.Form["task_state"]

	if !found1 || !found2 || !found3 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}
	var rtn Out_OutTask
	sqlcmd := ""
	sqlcmd = fmt.Sprintf(`SELECT
	t.task_code,
	t.task_type,
	t.task_othercode,
	t.task_count,
	t.task_content,
	t.task_state,
	wds.wave_code,
	wds.addtime
FROM
	isale_task t
inner JOIN isale_wavedetailspace wds ON t.task_othercode = wds.wavedetailspace_code
WHERE
	t.task_state = %s
AND t.user_code = '%s'
GROUP BY
	wds.wave_code
LIMIT %s, 20`, task_state[0], user_code[0], pager_offset[0])
	DebugLog.Println(sqlcmd)
	result, err := db.Query(sqlcmd)
	if err != nil {
		rtn.Code = 0
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
	defer result.Close()
	for result.Next() {
		var one Out_OutTaskOne
		result.Scan(&one.Task_code, &one.Task_type,
			&one.Task_othercode, &one.Task_count,
			&one.Task_content, &one.Task_state,
			&one.Wave_code, &one.Addtime)
		rtn.Data = append(rtn.Data, one)

	}
	if rtn.Data == nil {
		rtn.Data = make([]Out_OutTaskOne, 0)
	}
	rtn.Code = 1
	rtn.Message = "成功"
	DebugLog.Println(rtn)
	bytes, _ := json.Marshal(rtn)

	fmt.Fprint(w, string(bytes))

	return
}
