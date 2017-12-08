// FindSpaceDetailList
package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"
)

type Out_SpaceDetail struct {
	Code    int
	Message string
	Data    []Out_SpaceDetailListOne
}

type Out_SpaceDetailListOne struct {
	Space_code           string
	Space_number         string
	Space_halftype       int
	Space_count          string
	Product_code         string
	Product_name         string
	Product_enname       string
	Product_barcode      string
	Product_sku          string
	Product_unit         string
	Product_weight       string
	Product_length       string
	Product_width        string
	Product_heigth       string
	Product_length_sort  string
	Product_width_sort   string
	Product_heigth_sort  string
	Product_bulk         string
	Product_imgurl       string
	Product_state        int
	Product_groupstate   int
	Product_batterystate int
	User_code            string
	User_name            string
	User_mobilephone     string
	Task_code            string
	Task_type            int
	Task_othercode       string
	Addtime              string
}

func FindSpaceDetailList(w http.ResponseWriter, r *http.Request) {

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
	InfoLog.Println("==========================查询已完成上架详细列表开始：", r.URL)
	defer InfoLog.Println("==========================查询已完成上架详细列表结束")
	r.ParseForm()
	task_code, found1 := r.Form["task_code"]
	pager_offset, found2 := r.Form["pager_offset"]
	if !found1 || !found2 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}
	var rtn Out_SpaceDetail
	sqlcmd := ""
	sqlcmd = fmt.Sprintf(`select
	a.space_code           ,
	b.space_number         ,
	a.space_halftype       ,
	a.space_count          ,
	a.product_code         ,
	a.product_name         ,
	a.product_enname       ,
	ifnull(a.product_barcode,"" ) product_barcode         ,
	a.product_sku          ,
	a.product_unit         ,
	a.product_weight       ,
	a.product_length       ,
	a.product_width        ,
	a.product_heigth       ,
	a.product_length_sort  ,
	a.product_width_sort   ,
	a.product_heigth_sort  ,
	a.product_bulk         ,
	a.product_imgurl       ,
	a.product_state        ,
	a.product_groupstate   ,
	a.product_batterystate ,
	a.user_code            ,
	a.user_name            ,
	a.user_mobilephone     ,
	a.task_code            ,
	a.task_type            ,
	a.task_othercode       ,
	a.addtime  
		from isale_spacedetaillog a INNER JOIN isale_space b
		 on a.space_code=b.space_code where task_code='%s'   limit %s,10`, task_code[0], pager_offset[0])
	DebugLog.Println(sqlcmd)
	result, err := db.Query(sqlcmd)
	if err != nil {
		InfoLog.Println(err)
		rtn.Code = 2
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到货位信息"
		} else {
			rtn.Message = "查询异常"
		}

		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	defer result.Close()
	for result.Next() {
		var one Out_SpaceDetailListOne

		result.Scan(&one.Space_code,
			&one.Space_number,
			&one.Space_halftype,
			&one.Space_count,
			&one.Product_code,
			&one.Product_name,
			&one.Product_enname,
			&one.Product_barcode,
			&one.Product_sku,
			&one.Product_unit,
			&one.Product_weight,
			&one.Product_length,
			&one.Product_width,
			&one.Product_heigth,
			&one.Product_length_sort,
			&one.Product_width_sort,
			&one.Product_heigth_sort,
			&one.Product_bulk,
			&one.Product_imgurl,
			&one.Product_state,
			&one.Product_groupstate,
			&one.Product_batterystate,
			&one.User_code,
			&one.User_name,
			&one.User_mobilephone,
			&one.Task_code,
			&one.Task_type,
			&one.Task_othercode,
			&one.Addtime)
		rtn.Data = append(rtn.Data, one)
	}
	if rtn.Data == nil {
		rtn.Data = make([]Out_SpaceDetailListOne, 0)
	}
	rtn.Code = 1
	rtn.Message = "成功"
	DebugLog.Println(rtn)
	bytes, _ := json.Marshal(rtn)
	fmt.Fprint(w, string(bytes))
}
