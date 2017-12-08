// CheckStorageInfo
package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"

	"github.com/cihub/seelog"
)

type Out_CheckDetail struct {
	Code    int
	Message string
	Data    []Tmp_checkDetail
}

func CheckStorageInfo(w http.ResponseWriter, r *http.Request) {
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
	//task_state, _ := r.Form["taskState"]
	check_code, found4 := r.Form["check_code"]
	space_code, found2 := r.Form["space_code"]
	//DebugLog.Println(task_state[0])
	if !found3 || !found4 || !found2 {
		fmt.Fprint(w, "请勿非法访问")
		return
	}
	var rtn Out_CheckDetail
	sqlcmd := ""
	DebugLog.Println("输入的货位：", space_code[0])
	if !IsSpaceCode(space_code[0]) {
		space_code[0] = GetSpaceCodeFrom(space_code[0])
	}
	DebugLog.Println("转换的货位：", space_code[0])
	oneSpace := Tmp_Space{}
	if IsTaskDoing(space_code[0], []string{"1", "2"}) > 0 {
		rtn.Code = 2

		rtn.Message = "当前货位号有上下架任务"
		seelog.Debug(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	sqlcmd = fmt.Sprintf(`SELECT
space_code,
space_state,
space_usestate,
space_lockstate,
ifnull(user_code,"") user_code
FROM
	isale_space
WHERE	
 space_code='%s'
`, space_code[0])
	DebugLog.Println(sqlcmd)
	if err = tx.Get(&oneSpace, sqlcmd); err != nil {
		rtn.Code = 2
		DebugLog.Println(err)
		rtn.Message = "当前货位号不存在"
		seelog.Debug(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	if oneSpace.Space_state == 2 {
		rtn.Code = 2
		rtn.Message = "当前货位号已失效"
		seelog.Debug(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	if oneSpace.Space_usestate == 1 {
		rtn.Code = 2
		rtn.Message = "当前货位号未使用"
		seelog.Debug(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	oneUser := Tmp_UserSimple{}
	sqlcmd = fmt.Sprintf(`select task_user_code as user_code from 
	isale_check where check_code='%s'`, check_code[0])
	DebugLog.Println(sqlcmd)

	if err = tx.Get(&oneUser, sqlcmd); err != nil {
		rtn.Code = 2
		DebugLog.Println(err.Error())
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到任务"
		} else {
			rtn.Message = "查询异常"
		}
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	if oneSpace.Space_lockstate == 2 {

		if oneUser.User_code != oneSpace.User_code {
			rtn.Code = 2
			rtn.Message = "当前货位号已被使用"
			seelog.Debug(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			return
		}

	}
	sqlcmd = fmt.Sprintf(`SELECT
	a.checkdetail_code,
	a.check_code,
	a.product_code,
	a.product_sku,
	a.product_name,
	a.space_code,
	a.space_number,
	a.space_linenumber,
	a.space_count,
	a.user_code,
	a.user_name
	
	
FROM
	isale_checkdetail a LEFT JOIN
isale_task b ON a.checkdetail_code=b.task_othercode
WHERE
	check_code = '%s'
	and space_code='%s'
and b.task_state!=3
order by Space_linenumber
Limit %s ,20	`, check_code[0], space_code[0], pager_offset[0])

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
	//	sqlCondition := ""
	//	for indexs, ele := range rtn.Data {

	//		if indexs != len(rtn.Data)-1 {
	//			sqlCondition += fmt.Sprintf(" '%s', ", ele.Checkdetail_code)
	//		} else {
	//			sqlCondition += fmt.Sprintf(" '%s' ", ele.Checkdetail_code)
	//		}
	//	}
	if len(rtn.Data) > 0 {
		if len(oneSpace.User_code) > 0 {
			DebugLog.Println(oneSpace.User_code)
			DebugLog.Println(oneUser.User_code)
			if oneSpace.User_code != oneUser.User_code {
				//DebugLog.Println(oneSpace.User_code)
				rtn.Code = 2
				rtn.Message = "该货位已被其他人锁定"
				seelog.Debug(rtn)
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				return
			} else {

			}

		} else {
			sqlcmd = fmt.Sprintf(`update isale_space set space_lockstate=2 
			,user_code='%s' where space_code='%s'`, oneUser.User_code, space_code[0])
			InfoLog.Println("用户：", oneUser.User_code, "锁定了货位：", space_code[0])
			DebugLog.Println(sqlcmd)
			if _, err = tx.Exec(sqlcmd); err != nil {
				rtn.Code = 2
				rtn.Message = "插入打印信息发生错误:" + err.Error()
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}
		}
	}

	if rtn.Data == nil {
		rtn.Data = make([]Tmp_checkDetail, 0)
	}

	rtn.Code = 1
	rtn.Message = "成功"
	seelog.Debug(rtn)
	bytes, _ := json.Marshal(rtn)
	fmt.Fprint(w, string(bytes))
	return
}
