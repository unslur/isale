// FindWaveList
package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"
)

type Out_Wave struct {
	Code    int
	Message string
	Data    []Out_WaveListOne
}
type Out_WaveList struct {
	List []Out_WaveListOne
}
type Out_WaveListOne struct {
	Wave_code string
}

func FindWaveList(w http.ResponseWriter, r *http.Request) {

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
	InfoLog.Println("==========================获取波次列表开始：", r.URL)
	defer InfoLog.Println("==========================获取波次列表结束")
	r.ParseForm()
	user_code, found1 := r.Form["user_code"]
	if !found1 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}

	sqlcmd := ""
	var rtn Out_Wave
	sqlcmd = fmt.Sprintf(`SELECT
	b.wave_code
FROM
	isale_task a
INNER JOIN isale_wavedetailspace b ON a.task_othercode=b.wavedetailspace_code
WHERE user_code='%s' and task_state!=3 GROUP BY wave_code `, user_code[0])
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
		var one Out_WaveListOne
		result.Scan(&one.Wave_code)
		rtn.Data = append(rtn.Data, one)
	}
	if rtn.Data == nil {
		rtn.Data = make([]Out_WaveListOne, 0)
	}
	rtn.Code = 1
	rtn.Message = "成功"
	DebugLog.Println(rtn)
	bytes, _ := json.Marshal(rtn)
	fmt.Fprint(w, string(bytes))
	return
}
