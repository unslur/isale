// TestApi
package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"
)

type Testrtn struct {
	Code    int
	Message string
	Data    []TestApi1Orm
}

type TestApi1Orm struct {
	SalverCarcode        string `db:"salvercar_code"`
	SalverCarnumber      string `db:"salvercar_number"`
	SalverCartype        int    `db:"salvercar_type"`
	SalverCarweight      string `db:"salvercar_weight"`
	SalverCarlength      string `db:"salvercar_length"`
	SalverCarwidth       string `db:"salvercar_width"`
	SalverCarheigth      string `db:"salvercar_heigth"`
	SalverCarbulk        string `db:"salvercar_bulk"`
	SalverShelfcol       string `db:"salvershelf_col"`
	SalverShelfros       string `db:"salvershelf_ros"`
	SalverShelftotalbulk string `db:"salvershelf_totalbulk"`
	SalverShelfusestate  int    `db:"salvershelf_usestate"`
	Addtime              string `db:"addtime"`
}

func IsaleTestApi1(w http.ResponseWriter, r *http.Request) {

	defer func() { // 必须要先声明defer，否则不能捕获到panic异常

		err := recover()
		if err != nil {

			InfoLog.Println(err) // 这里的err其实就是panic传入的内容，55
		}

	}()

	InfoLog.Println("==========================测试1开始：", r.URL)
	defer InfoLog.Println("==========================测试1结束")
	r.ParseForm()
	car_code, found1 := r.Form["car_code"]

	if !found1 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}
	var rtn Testrtn
	sqlcmd := ""
	sqlcmd = fmt.Sprintf(`select salvercar_code,salvercar_number,addtime from isale_salvercar where salvercar_type =%s`, car_code[0])
	oneorm := []TestApi1Orm{}
	err := dborm.Select(&oneorm, sqlcmd)

	if err != nil {
		InfoLog.Println(err)
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到任务信息"
		} else {
			rtn.Message = "查询异常"
		}
		bytes, _ := json.Marshal(rtn)

		fmt.Fprint(w, string(bytes))

		return
	}
	rtn.Data = oneorm

	rtn.Code = 1
	rtn.Message = ""
	DebugLog.Println(rtn)
	bytes, _ := json.Marshal(rtn)

	fmt.Fprint(w, string(bytes))

	return
}
func IsaleTestApi2(w http.ResponseWriter, r *http.Request) {

	defer func() { // 必须要先声明defer，否则不能捕获到panic异常

		err := recover()
		if err != nil {

			InfoLog.Println(err) // 这里的err其实就是panic传入的内容，55
		}

	}()

	InfoLog.Println("==========================测试2开始：", r.URL)
	defer InfoLog.Println("==========================测试2结束")
	r.ParseForm()
	car_code, found1 := r.Form["car_code"]

	if !found1 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}
	var rtn Testrtn
	var err error
	sqlcmd := ""
	DebugLog.Println(Halftype)
	resultorm := []TestApi1Orm{}
	one := TestApi1Orm{}
	one.SalverCartype = 2
	one.SalverCarlength = "150"
	one.SalverCarcode = "009"
	product_imgurl := ""
	sqlcmd = fmt.Sprintf(`select product_imgurl from isale_inorderdetail where inorderdetail_code='3011503893060465589239200'`)
	if err = db.QueryRow(sqlcmd).Scan(&product_imgurl); err != nil {
		DebugLog.Println(err.Error())
	}
	DebugLog.Println(product_imgurl)
	sqlcmd = fmt.Sprintf(`select '%s'`, product_imgurl)
	DebugLog.Println(sqlcmd)
	return
	sqlcmd = fmt.Sprintf(`select salvercar_code,salvercar_number,addtime,
		 salvercar_type,salvercar_length
		from isale_salvercar
		where salvercar_type =:salvercar_type
		and salvercar_length=:salvercar_length
		`)
	DebugLog.Println(sqlcmd)
	rows, err := dborm.NamedQuery(sqlcmd, one)

	CheckError(err)
	defer rows.Close()
	for rows.Next() {
		one := TestApi1Orm{}
		err := rows.StructScan(&one)
		CheckError(err)
		resultorm = append(resultorm, one)

	}

	sqlcmd = fmt.Sprintf(`select 
	a.salvercar_code,a.salvercar_number,a.salvercar_length,a.addtime 
	from isale_salvercar a where a.salvercar_type =%s`, car_code[0])
	DebugLog.Println(sqlcmd)
	err = dborm.Select(&resultorm, sqlcmd)

	CheckError(err)
	rtn.Data = resultorm

	rtn.Code = 1
	rtn.Message = ""
	DebugLog.Println(rtn)
	bytes, _ := json.Marshal(rtn)

	fmt.Fprint(w, string(bytes))

	return
}
func CheckError(err error) {
	if err != nil {
		panic(err.Error())
	}
}
func IsaleTestApi3(w http.ResponseWriter, r *http.Request) {

	defer func() { // 必须要先声明defer，否则不能捕获到panic异常

		err := recover()
		if err != nil {
			var rtn Testrtn
			InfoLog.Println(err)
			rtn.Message = fmt.Sprintf("%v", err)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
		}

	}()

	InfoLog.Println("==========================测试2开始：", r.URL)
	defer InfoLog.Println("==========================测试2结束")
	r.ParseForm()
	_, found1 := r.Form["car_code"]

	if !found1 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}
	var rtn Testrtn
	var err error
	sqlcmd := ""

	one := TestApi1Orm{}
	one.SalverCartype = 2
	one.SalverCarlength = "150"
	one.SalverCarcode = "009"

	sqlcmd = fmt.Sprintf(`insert into isale_salvercar(salvercar_code,
	salvercar_type,salvercar_length
	) values(:salvercar_code,:salvercar_type,:salvercar_length)	`)
	DebugLog.Println(sqlcmd)
	rows, err := dborm.NamedExec(sqlcmd, one)

	CheckError(err)
	s, err := rows.RowsAffected()
	CheckError(err)
	DebugLog.Printf("受影响条数%d", s)

	rtn.Code = 1
	rtn.Message = ""
	DebugLog.Println(rtn)
	bytes, _ := json.Marshal(rtn)

	fmt.Fprint(w, string(bytes))

	return
}
func IsaleTestApi4(w http.ResponseWriter, r *http.Request) {

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

	InfoLog.Println("==========================测试4开始：", r.URL)
	defer InfoLog.Println("==========================测试4结束")
	r.ParseForm()
	var rtn Rtn
	sqlcmd := ""
	sqlcmd = fmt.Sprintf(`update isale_user set user_name='cy' where user_code='1011488808454162812000000'`)
	DebugLog.Println(sqlcmd)
	if _, err = tx.Exec(sqlcmd); err != nil {
		rtn.Code = 2
		rtn.Message = err.Error()
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	oneUser := Tmp_UserSimple{}
	sqlcmd = fmt.Sprintf(`select user_name from isale_user where user_code='1011488808454162812000000'`)
	if err = tx.Get(&oneUser, sqlcmd); err != nil {
		rtn.Code = 2
		rtn.Message = err.Error()
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	DebugLog.Println(oneUser)
	panic("cysql")
	rtn.Code = 1

	rtn.Message = ""
	DebugLog.Println(rtn)
	bytes, _ := json.Marshal(rtn)

	fmt.Fprint(w, string(bytes))

	return
}
