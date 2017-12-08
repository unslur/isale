// FindSpaceProduct
package main

import (
	"encoding/json"
	"fmt"
	. "myfunc"
	"net/http"
	"strings"
)

type Out_Product struct {
	Code    int
	Message string
	Data    Out_ProductOne
}
type Out_ProductOne struct {
	ID            string
	Space_code    string `db:"space_code"`
	Space_number  string
	Product_code  string `db:"product_code"`
	Product_name  string `db:"product_name"`
	Product_sku   string `db:"product_sku"`
	Space_count   string `db:"space_count"`
	Space_excount string
}

func FindSpaceProduct(w http.ResponseWriter, r *http.Request) {

	tx, err := dborm.Beginx()
	if err != nil {
		InfoLog.Println(err)
		return
	}
	defer func() {

		err := recover()
		if err != nil {
			tx.Rollback()
			InfoLog.Println("有错误发生，正在回滚")
			InfoLog.Println(err)
		} else {
			tx.Commit()
		}

	}()
	InfoLog.Println("==========================获取货位上产品信息开始：", r.URL)
	defer InfoLog.Println("==========================获取货位上产品信息结束")
	r.ParseForm()
	//user_code, found1 := r.Form["user_code"]
	space_code, found2 := r.Form["space_code"]
	product_code, found1 := r.Form["product_code"]
	if !found1 || !found2 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}

	sqlcmd := ""
	var rtn Out_Product
	DebugLog.Println("输入的货位：", space_code[0])
	if !IsSpaceCode(space_code[0]) {
		space_code[0] = GetSpaceCodeFrom(space_code[0])
	}
	DebugLog.Println("转换的货位：", space_code[0])
	sqlcmd = fmt.Sprintf(`select  
	space_code,product_code,product_sku,
	product_name,space_count
	from isale_spacedetail 
	where space_code='%s' and product_code='%s'`, space_code[0], product_code[0])
	DebugLog.Println(sqlcmd)
	if err = tx.Get(&rtn.Data, sqlcmd); err != nil {
		rtn.Code = 2
		rtn.Message = "该货位不存在该货品"
		DebugLog.Println(err.Error())
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	oneSpace := Tmp_Space{}
	sqlcmd = fmt.Sprintf(`select space_code,space_lockstate,space_number from isale_space where space_code='%s'`, space_code[0])
	DebugLog.Println(sqlcmd)
	if err = tx.Get(&oneSpace, sqlcmd); err != nil {
		rtn.Code = 2
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到货位信息"
		} else {
			rtn.Message = "查询异常"
		}
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	if oneSpace.Space_lockstate == 2 {
		rtn.Code = 2
		rtn.Message = "该货位被锁定"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	if IsTaskDoing(space_code[0], []string{"1", "2", "5"}) > 0 {
		rtn.Code = 2
		rtn.Message = "该货架有任务，请先完成任务"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	rtn.Data.Space_excount = rtn.Data.Space_count
	rtn.Data.ID = GenerateCode("104")
	rtn.Data.Space_number = oneSpace.Space_number
	rtn.Code = 1
	rtn.Message = "成功"
	DebugLog.Println(rtn)
	bytes, _ := json.Marshal(rtn)
	fmt.Fprint(w, string(bytes))
	return
}
