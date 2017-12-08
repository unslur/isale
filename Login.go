// Login
package main

import (
	"encoding/json"
	"fmt"

	"net/http"
)

type Out_User struct {
	Code    int
	Message string
	Data    Out_UserListOne
}

type Out_UserListOne struct {
	User_code            string
	User_loginname       string
	User_loginpass       string
	User_type            string
	User_name            string
	User_mobilephone     string
	User_logourl         string
	User_state           int
	User_rent_price      string
	User_arrearage_price string
	Company_code         string
}

func Login(w http.ResponseWriter, r *http.Request) {

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
	InfoLog.Println("==========================登录开始：", r.URL)
	defer InfoLog.Println("==========================登录结束")
	r.ParseForm()
	user_loginname, found1 := r.Form["user_loginname"]
	user_loginpass, found2 := r.Form["user_loginpass"]
	if !found1 || !found2 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}

	sqlcmd := fmt.Sprintf(`select user_code,
	user_loginname,  user_type,
	user_name, user_mobilephone,user_logourl ,user_state, user_rent_price,ifnull( user_arrearage_price,""),company_code
	from isale_user where user_loginname='%s' and user_loginpass='%s'`, user_loginname[0], user_loginpass[0])
	var user Out_UserListOne
	var rtn Out_User

	DebugLog.Println(sqlcmd)
	err = tx.QueryRow(sqlcmd).Scan(&user.User_code, &user.User_loginname, &user.User_type,
		&user.User_name, &user.User_mobilephone, &user.User_logourl, &user.User_state, &user.User_rent_price,
		&user.User_arrearage_price, &user.Company_code)

	if err != nil {
		rtn.Code = 2
		rtn.Message = "失败"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
	} else {
		rtn.Code = 1
		rtn.Message = "成功"
		rtn.Data = user
		//rtn.Data.List = append(rtn.Data.List, user)
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
	}
}
