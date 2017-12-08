// GetVerifyInorder
package main

import (
	"encoding/json"
	"fmt"
	"strings"
	//. "myfunc"
	"net/http"
)

type Out_Verify struct {
	Code    int
	Message string
	Data    []Out_Inorder
}

func GetVerifyInorder(w http.ResponseWriter, r *http.Request) {

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
	InfoLog.Println("==========================查询确认子订单开始：", r.URL)
	defer InfoLog.Println("==========================查询确认子订单结束")
	r.ParseForm()
	pager_offset, found1 := r.Form["pager_offset"]
	user_code, found2 := r.Form["user_code"]
	DebugLog.Println(user_code[0])

	if !found1 || !found2 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}
	sqlcmd := ""
	rtn := Out_Verify{}
	sqlCondition := ""
	if Halftype == "3" {

	} else {
		sqlCondition = fmt.Sprintf(` and id.inorder_type=%s `, Halftype)
	}
	sqlcmd = fmt.Sprintf(`select   
	inorder_code,
	ifnull(inorder_remark,"") inorder_remark,
	inorder_mode,
	user_code,
	user_name,
	user_mobilephone	
	from isale_inorder where (inorder_verify_state=1 or  ISNULL(inorder_verify_state)  ) 
	and inorder_state=1 %s
	order by inorder_type
	limit %s,20`, sqlCondition, pager_offset[0])
	DebugLog.Println(sqlcmd)
	rows, err := tx.Queryx(sqlcmd)
	if err != nil {
		rtn.Code = 2
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到任务信息"
		} else {
			rtn.Message = "查询异常"
		}
		DebugLog.Println(rtn)
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}

	defer rows.Close()
	orderList := []Out_Inorder{}
	for rows.Next() {
		one := Out_Inorder{}
		err = rows.StructScan(&one)
		if err != nil {
			rtn.Code = 2
			//rtn.Message = err.Error()
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			return
		}
		orderList = append(orderList, one)
	}

	for _, ele := range orderList {
		DetailList := []Tmp_InorderdetailCode{}
		sqlcmd = fmt.Sprintf(`select 
		inorderdetail_code,inorder_code,user_code,user_name,user_mobilephone,
		product_code,product_name,product_enname,ifnull(product_barcode,"") product_barcode,product_sku,product_unit,
		product_imgurl,
		product_weight,product_length,product_width,product_heigth,product_bulk,
		product_state,product_usercount,
		ifnull(product_count,"0") product_count,product_totalweight,product_totalbulk
		product_groupstate,product_batterystate,addtime
		
		from isale_inorderdetail where inorder_code='%s'
		and inorderdetail_state=1 `, ele.Inorder_code)
		DebugLog.Println(sqlcmd)
		err = tx.Select(&DetailList, sqlcmd)
		if err != nil {
			rtn.Code = 2
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

		if len(DetailList) > 0 {

			ele.InorderDetail = DetailList
			rtn.Data = append(rtn.Data, ele)
		}

	}
	rtn.Code = 1
	rtn.Message = "成功"
	if rtn.Data == nil {
		rtn.Data = make([]Out_Inorder, 0)
	}
	DebugLog.Println(rtn)
	bytes, _ := json.Marshal(rtn)
	fmt.Fprint(w, string(bytes))
	return

}
