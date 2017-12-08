// CheckStorageSpace
package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"

	"github.com/cihub/seelog"
)

type Out_CheckDetailSpace struct {
	Code    int
	Message string
	Data    []Tmp_checkDetailsimple
}

func CheckStorageSpace(w http.ResponseWriter, r *http.Request) {
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
	InfoLog.Println("==========================盘点货位详细开始：", r.URL)
	defer InfoLog.Println("==========================盘点货位详细结束")
	r.ParseForm()
	//	user_code, found1 := r.Form["user_code"]
	//	DebugLog.Println(user_code)
	pager_offset, found3 := r.Form["pager_offset"]
	task_state, _ := r.Form["taskState"]
	check_code, found4 := r.Form["check_code"]
	DebugLog.Println(task_state[0])
	if !found3 || !found4 {
		fmt.Fprint(w, "请勿非法访问")
		return
	}
	var rtn Out_CheckDetailSpace
	sqlcmd := ""
	sqlcmdCondition := ""
	if task_state[0] != "3" {
		sqlcmdCondition = " and b.task_state!=3"
	} else {
		sqlcmdCondition = " and b.task_state=3"
	}
	sqlcmd = fmt.Sprintf(`SELECT
DISTINCT	space_code,
	space_number,
	space_linenumber	
FROM
	isale_checkdetail
WHERE
	space_code  IN (
		SELECT			
 DISTINCT space_code
		FROM
			isale_checkdetail a
		LEFT JOIN isale_task b ON a.checkdetail_code = b.task_othercode
WHERE b.task_type=5 
and a.check_code='%s' %s
	) and check_code='%s'
group by space_code
ORDER BY space_linenumber
limit %s,20	`, check_code[0], sqlcmdCondition, check_code[0], pager_offset[0])

	DebugLog.Println(sqlcmd)
	if err = tx.Select(&rtn.Data, sqlcmd); err != nil {
		rtn.Code = 2
		DebugLog.Println(err.Error())
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到货位号"
		} else {
			rtn.Message = "查询异常"
		}
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	sqlcmd = fmt.Sprintf(`update isale_check set check_state=2 where check_code='%s' and check_state=1`, check_code[0])
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
		return
	}

	if rtn.Data == nil {
		rtn.Data = make([]Tmp_checkDetailsimple, 0)
	}
	rtn.Code = 1
	rtn.Message = "成功"
	seelog.Debug(rtn)
	bytes, _ := json.Marshal(rtn)
	fmt.Fprint(w, string(bytes))
	return
}
