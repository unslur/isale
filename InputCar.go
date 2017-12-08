// InputCar
package main

import (
	"fmt"
	"net/http"
)

func InputCar(w http.ResponseWriter, r *http.Request) {
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
	InfoLog.Println("==========================订单绑定车开始：", r.URL)
	defer InfoLog.Println("==========================订单绑定车结束")
	r.ParseForm()
	_, found1 := r.Form["task_othercode"]
	if !found1 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}
}
