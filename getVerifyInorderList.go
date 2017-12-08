// getVerifyInorderList
package main

import (
	"encoding/json"
	"fmt"
	"net/http"
)

type Out_VerifyList struct {
	Code    int
	Message string
	Data    []Out_InorderList
}
type Out_InorderList struct {
	Inorder_code           string `db:"inorder_code"`
	Inorder_remark         string `db:"inorder_remark"`
	Inorder_state          int    `db:"inorder_state"`
	Inorder_mode           int    `db:"inorder_mode"`
	Inorder_type           int    `db:"inorder_type"`
	User_code              string `db:"user_code"`
	User_name              string `db:"user_name"`
	User_mobilephone       string `db:"user_mobilephone"`
	Inorderdetail_code     string
	Inorderdetail_state    int
	Inorderdetail_halftype int
	Product_code           string
	Product_name           string
	Product_enname         string
	Product_barcode        string
	Product_sku            string
	Product_unit           string
	Product_weight         string
	Product_length         string
	Product_width          string
	Product_heigth         string

	Product_bulk string

	Product_state        int
	Product_groupstate   int
	Product_batterystate int
	Product_usercount    string
	Product_count        int
	Product_totalweight  string
	Product_totalbulk    string
	Addtime              string
}

func getVerifyInorderList(w http.ResponseWriter, r *http.Request) {

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
	InfoLog.Println("==========================查询确认子订单列表开始：", r.URL)
	defer InfoLog.Println("==========================查询确认子订单列表结束")
	r.ParseForm()
	pager_offset, found1 := r.Form["pager_offset"]
	user_code, found2 := r.Form["user_code"]
	DebugLog.Println(user_code[0])

	if !found1 || !found2 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}
	sqlcmd := ""
	rtn := Out_VerifyList{}
	data := []Out_InorderList{}
	sqlCondition := ""
	//Halftype = GetHalfType()
	DebugLog.Println(Halftype)
	if Halftype == "3" {

	} else {
		sqlCondition = fmt.Sprintf(` AND inorder_type = %s `, Halftype)
	}
	sqlcmd = fmt.Sprintf(`SELECT
	i.inorder_code             ,
i.inorder_remark           ,
i.inorder_state            ,
i.inorder_mode             ,
i.inorder_type             ,
i.user_code                ,
i.user_name                ,
i.user_mobilephone         ,
id.inorderdetail_code      ,     
id.inorderdetail_state     ,     
id.inorderdetail_halftype  ,
id.product_code            ,     
id.product_name            ,     
id.product_enname          ,     
ifnull(id.product_barcode,"" ) product_barcode         ,
id.product_sku             ,     
id.product_unit            ,     
id.product_weight          ,     
id.product_length          ,     
id.product_width           ,     
id.product_heigth          ,              
id.product_bulk            ,                  
id.product_state           ,     
id.product_groupstate      ,     
id.product_batterystate    ,     
id.product_usercount       ,     
ifnull(id.product_count,"0"    )    product_count   ,     
id.product_totalweight     ,     
id.product_totalbulk       ,     
i.addtime
FROM
	isale_inorder i
INNER JOIN isale_inorderdetail id ON i.inorder_code = id.inorder_code
WHERE
	(
		i.inorder_verify_state = 1
		OR ISNULL(i.inorder_verify_state)
	)
AND i.inorder_state = 1
%s
		and id.inorderdetail_state=1
		and id.product_state=3
ORDER BY
	i.inorder_type
LIMIT %s,
 20`, sqlCondition, pager_offset[0])
	DebugLog.Println(sqlcmd)
	if err = tx.Select(&data, sqlcmd); err != nil {
		rtn.Code = 2
		rtn.Message = err.Error()
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	rtn.Data = data
	rtn.Code = 1
	rtn.Message = "成功"
	if rtn.Data == nil {
		rtn.Data = make([]Out_InorderList, 0)
	}
	DebugLog.Println(rtn)
	bytes, _ := json.Marshal(rtn)
	fmt.Fprint(w, string(bytes))
	return

}
