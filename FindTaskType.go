// FindTaskType
package main

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/cihub/seelog"
)

type Out_TaskType struct {
	Code    int
	Message string
	Data    []Out_TaskTypeOne
}
type Out_TaskTypeList struct {
	List []Out_TaskTypeOne
}
type Out_TaskTypeOne struct {
	Task_code      string
	Task_type      int
	Task_content   string
	Task_state     int
	Task_count     string
	Task_othercode string
	Addtime        string
}

func FindTaskType(w http.ResponseWriter, r *http.Request) {

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
	InfoLog.Println("==========================获取任务类型开始：", r.URL)
	defer InfoLog.Println("==========================获取任务类型结束")
	r.ParseForm()
	var rtn Out_TaskType
	for i := 1; i <= 5; i++ {
		var one Out_TaskTypeOne
		one.Task_type = i
		rtn.Data = append(rtn.Data, one)
	}
	if rtn.Data == nil {
		rtn.Data = make([]Out_TaskTypeOne, 0)
	}
	rtn.Code = 1
	seelog.Debug(rtn)
	bytes, _ := json.Marshal(rtn)
	fmt.Fprint(w, string(bytes))
}
