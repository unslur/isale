// FindOutOrderList
package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"
)

type Out_OutOrderUnBatch struct {
	Code    int
	Message string
	Data    []Out_OutOrderUnBatchListOne
}

type Out_OutOrderUnBatchListOne struct {
	Outorder_code  string
	Outorder_count int
	Express_name   string
}

func FindOutOrderUnBatchList(w http.ResponseWriter, r *http.Request) {

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
	InfoLog.Println("==========================获取出库非批间列表开始：", r.URL)
	defer InfoLog.Println("==========================获取出库非批间列表结束")
	r.ParseForm()
	DebugLog.Println(r.Form)
	user_code, found1 := r.Form["user_code"]
	wave_code, found2 := r.Form["wave_code"]
	task_state, found3 := r.Form["task_state"]

	if !found1 || !found2 || !found3 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}

	sqlcmd := ""

	var rtn Out_OutOrderUnBatch
	isWave := 0
	sqlcmd = fmt.Sprintf(`select count(*) from isale_process where process_code='%s'`, wave_code[0])
	if err = dborm.QueryRowx(sqlcmd).Scan(&isWave); err != nil {
		rtn.Code = 2
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到货位信息"
		} else {
			rtn.Message = "查询异常"
		}
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	if isWave > 0 {
		InfoLog.Println("加工订单")
		sqlcmd = fmt.Sprintf(`UPDATE isale_task
	SET task_state = 2
	WHERE
		task_othercode IN (
			SELECT
				wds.processdetailspace_code
			FROM
				isale_processdetailspace wds
			WHERE
				wds.process_code = '%s'
		)
	AND user_code = '%s'
	AND task_state = 1`,
			wave_code[0], user_code[0])
		DebugLog.Println(sqlcmd)
		_, err = db.Exec(sqlcmd)
		if err != nil {
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到货位信息"
			} else {
				rtn.Message = "更新失败"
			}
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			return
		}
	} else {
		InfoLog.Println("普通订单")

		sqlcmd = fmt.Sprintf(`UPDATE isale_task
	SET task_state = 2
	WHERE
		task_othercode IN (
			SELECT
				wds.wavedetailspace_code
			FROM
				isale_wavedetailspace wds
			WHERE
				wds.wave_code = '%s'
		)
	AND user_code = '%s'
	AND task_state = 1`,
			wave_code[0], user_code[0])
		DebugLog.Println(sqlcmd)
		_, err = db.Exec(sqlcmd)
		if err != nil {
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到货位信息"
			} else {
				rtn.Message = "更新失败"
			}
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			return
		}
		if task_state[0] == "3" {
			sqlcmd = fmt.Sprintf(`SELECT
		outorder_code,
		ifnull(express_name,""),
		outorder_count,
		ifnull(outorder_way,0),
		outorder_count
	FROM
		isale_outorder
	WHERE
		wave_code = '%s'
	AND task_user_code = '%s' and outorder_count>1
	and outorder_downstate=3 `, wave_code[0], user_code[0])
		} else {
			sqlcmd = fmt.Sprintf(`SELECT
		outorder_code,
		ifnull(express_name,""),
		outorder_type,
		ifnull(outorder_way,0),
		outorder_count

	FROM
		isale_outorder
	WHERE
		wave_code = '%s'
	AND task_user_code = '%s' and outorder_count>1
	and (outorder_downstate=1 or outorder_downstate=2)`, wave_code[0], user_code[0])
		}

		DebugLog.Println(sqlcmd)
		result, err := db.Query(sqlcmd)
		if err != nil {
			rtn.Code = 0
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到货位信息"
			} else {
				rtn.Message = "查询异常"
			}
			bytes, _ := json.Marshal(rtn)

			fmt.Fprint(w, string(bytes))

			return
		}
		defer result.Close()
		for result.Next() {
			var one Out_OutOrderUnBatchListOne
			outorder_type := 0
			outorder_way := 0
			err = result.Scan(&one.Outorder_code,
				&one.Express_name,
				&outorder_type,
				&outorder_way,
				&one.Outorder_count)
			if err != nil {
				DebugLog.Println(err)
			}
			if outorder_type == 2 {
				if outorder_way == 1 {
					one.Express_name = "空运"
				} else {
					one.Express_name = "海运"
				}
			}
			sqlcmd = fmt.Sprintf(`SELECT	
	count(space_number)
FROM
	isale_wavedetailspace a
LEFT JOIN isale_waveoutorder b ON a.wavedetail_code = b.wavedetail_code
WHERE
	b.outorder_code = '%s'
AND b.wave_code = '%s' `, one.Outorder_code, wave_code[0])
			tmp := 0
			if err = tx.QueryRowx(sqlcmd).Scan(&tmp); err != nil {
				rtn.Code = 0
				if strings.Contains(err.Error(), "sql: no rows in result set") {
					rtn.Message = "没有查询到波次信息"
				} else {
					rtn.Message = "查询异常"
				}
				bytes, _ := json.Marshal(rtn)

				fmt.Fprint(w, string(bytes))

				return
			}
			if tmp > 0 {
				rtn.Data = append(rtn.Data, one)
			}

		}
	}
	if rtn.Data == nil {
		rtn.Data = make([]Out_OutOrderUnBatchListOne, 0)
	}
	rtn.Code = 1
	rtn.Message = "成功"
	DebugLog.Println(rtn)
	bytes, _ := json.Marshal(rtn)
	fmt.Fprint(w, string(bytes))
	return
}
