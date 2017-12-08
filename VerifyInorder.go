// VerifyInorder
package main

import (
	"encoding/json"
	"fmt"
	. "myfunc"
	"net/http"
	"strconv"
)

type Tmp_InorderdetailCodeFloat struct {
	Inorderdetail_code            string
	Inorderdetail_state           int
	Inorderdetail_halftype        int
	Inorderdetail_selectuserstate int
	Inorderdetail_printstate      int
	Inorder_code                  string
	Inorder_mode                  int
	Operate_user_code             string
	User_code                     string
	User_name                     string
	User_mobilephone              string
	Product_code                  string
	Product_name                  string
	Product_enname                string
	Product_barcode               string
	Product_sku                   string
	Product_unit                  string
	Product_weight                float64
	Product_length                float64
	Product_width                 float64
	Product_heigth                float64
	Product_length_sort           float64
	Product_width_sort            float64
	Product_heigth_sort           float64
	Product_bulk                  float64
	Product_imgurl                string
	Product_state                 int
	Product_groupstate            int
	Product_batterystate          int
	Product_usercount             float64
	Product_count                 float64
	Product_totalweight           float64
	Product_totalbulk             float64
	Product_count_batch           float64
	Addtime                       string
}
type Tmp_InorderdetailCode_Batch struct {
	Inorderdetailbactch_code string
	Inorderdetail_code       string
	User_code                string
	User_name                string
	User_mobilephone         string
	Product_code             string
	Product_name             string
	Product_enname           string
	Product_barcode          string
	Product_sku              string
	Product_unit             string
	Product_weight           string
	Product_length           string
	Product_width            string
	Product_heigth           string
	Product_length_sort      string
	Product_width_sort       string
	Product_heigth_sort      string
	Product_bulk             string
	Product_imgurl           string
	Product_groupstate       int
	Product_batterystate     int
	Product_count            string
	Product_totalweight      string
	Product_totalbulk        string
	Operate_user_code        string
	Operate_user_name        string
	Task_user_code           string
	Task_user_name           string
	Task_user_logourl        string
}

func VerifyInorder(w http.ResponseWriter, r *http.Request) {

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
	InfoLog.Println("==========================审核通过子订单开始：", r.URL)
	defer InfoLog.Println("==========================审核通过子子订单结束")
	r.ParseForm()
	Inorderdetail_code, found1 := r.Form["inorderdetail_code"]
	user_code, found2 := r.Form["user_code"]

	flag, found3 := r.Form["flag"]
	product_count, found4 := r.Form["product_count"]
	if !found1 || !found2 || !found4 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}
	DebugLog.Println(user_code[0])
	sqlcmd := ""
	rtn := Rtn{}
	oneDetail := Tmp_InorderdetailCodeFloat{}
	sqlcmd = fmt.Sprintf(`SELECT
	inorderdetail_code,
	inorderdetail_state,
	inorder_code,
	user_code,
	user_name,
	product_enname,
	
	user_mobilephone,
	product_code,
	product_name,
	ifnull(product_barcode, "") product_barcode,
	product_sku,
	product_unit,
	product_weight + 0 product_weight,
	product_length + 0 product_length,
	product_width + 0 product_width,
	product_heigth + 0 product_heigth,
	product_bulk + 0 product_bulk,
	product_length_sort,product_width_sort,product_heigth_sort,
	product_imgurl,
	product_groupstate,
	product_batterystate,
	product_state,
	product_usercount,
	ifnull(product_count, "0") + 0 product_count,
	ifnull(product_count_batch, "0") + 0 product_count_batch,
	ifnull(operate_user_code, "") operate_user_code
FROM
	isale_inorderdetail
WHERE
	inorderdetail_code = '%s' `,
		Inorderdetail_code[0])
	DebugLog.Println(sqlcmd)
	if err = tx.Get(&oneDetail, sqlcmd); err != nil {
		rtn.Code = 2
		rtn.Message = err.Error()
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	//	if product_count[0] == "0" {
	//		rtn.Code = 2
	//		rtn.Message = "数量必须大于零"
	//		DebugLog.Println(rtn)
	//		bytes, _ := json.Marshal(rtn)
	//		fmt.Fprint(w, string(bytes))
	//		return
	//	}
	sqlcmd = fmt.Sprintf(`update isale_product set product_state=3 where product_code='%s' and product_state!=3`, oneDetail.Product_code)
	DebugLog.Println(sqlcmd)
	if _, err = tx.Exec(sqlcmd); err != nil {
		rtn.Code = 2
		rtn.Message = "更新失败"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	var count float64
	count, err = strconv.ParseFloat(product_count[0], 64)
	if err != nil {
		rtn.Code = 2
		rtn.Message = "库存数量:" + err.Error()
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	if oneDetail.Inorderdetail_state != 1 {
		rtn.Code = 2
		rtn.Message = "该订单已被处理"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	//	if oneDetail.Product_usercount < count+oneDetail.Product_count {
	//		rtn.Code = 2
	//		rtn.Message = fmt.Sprintf(`该次审核数量已大于需要审核数量,剩余审核数量为%d`, int(oneDetail.Product_usercount-oneDetail.Product_count))
	//		DebugLog.Println(rtn)
	//		bytes, _ := json.Marshal(rtn)
	//		fmt.Fprint(w, string(bytes))
	//		panic("cysql")
	//	}

	oneOperateUser := Tmp_UserSimple{}
	sqlcmd = fmt.Sprintf(`select user_code,user_name,user_logourl,user_mobilephone from isale_user where user_code='%s'`,
		user_code[0])
	DebugLog.Println(sqlcmd)
	if err = tx.Get(&oneOperateUser, sqlcmd); err != nil {
		rtn.Code = 2
		rtn.Message = err.Error()
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	sqlconditon := ""
	//	if count+oneDetail.Product_count == oneDetail.Product_usercount {
	//		sqlconditon = fmt.Sprintf(`,inorderdetail_state=2`)
	//	}
	if found3 {
		if flag[0] == "2" {
			sqlconditon = fmt.Sprintf(`,inorderdetail_state=2`)
		}
	}
	if count > 0 {
		OneDetailBatch := Tmp_InorderdetailCode_Batch{}
		OneDetailBatch.Inorderdetailbactch_code = GenerateCode("435")
		OneDetailBatch.Inorderdetail_code = oneDetail.Inorderdetail_code
		OneDetailBatch.User_code = oneDetail.User_code
		OneDetailBatch.User_name = oneDetail.User_name
		OneDetailBatch.User_mobilephone = oneDetail.User_mobilephone
		OneDetailBatch.Product_code = oneDetail.Product_code
		OneDetailBatch.Product_name = oneDetail.Product_name
		OneDetailBatch.Product_enname = oneDetail.Product_enname
		OneDetailBatch.Product_barcode = oneDetail.Product_barcode
		OneDetailBatch.Product_sku = oneDetail.Product_sku
		OneDetailBatch.Product_unit = oneDetail.Product_unit
		OneDetailBatch.Product_weight = fmt.Sprintf(`%.2f`, oneDetail.Product_weight)
		OneDetailBatch.Product_length = fmt.Sprintf(`%d`, int(oneDetail.Product_length))
		OneDetailBatch.Product_width = fmt.Sprintf(`%d`, int(oneDetail.Product_width))
		OneDetailBatch.Product_heigth = fmt.Sprintf(`%d`, int(oneDetail.Product_heigth))
		OneDetailBatch.Product_length_sort = fmt.Sprintf(`%d`, int(oneDetail.Product_length_sort))
		OneDetailBatch.Product_width_sort = fmt.Sprintf(`%d`, int(oneDetail.Product_width_sort))
		OneDetailBatch.Product_heigth_sort = fmt.Sprintf(`%d`, int(oneDetail.Product_heigth_sort))
		OneDetailBatch.Product_bulk = fmt.Sprintf(`%d`, int(oneDetail.Product_bulk))
		OneDetailBatch.Product_imgurl = oneDetail.Product_imgurl
		OneDetailBatch.Product_groupstate = oneDetail.Product_groupstate
		OneDetailBatch.Product_batterystate = oneDetail.Product_batterystate
		OneDetailBatch.Product_count = product_count[0]
		OneDetailBatch.Product_totalweight = fmt.Sprintf(`%.2f`, oneDetail.Product_weight*count)
		OneDetailBatch.Product_totalbulk = fmt.Sprintf(`%d`, int(oneDetail.Product_bulk*count))
		OneDetailBatch.Operate_user_code = oneOperateUser.User_code
		OneDetailBatch.Operate_user_name = oneOperateUser.User_name
		sqlcmd = fmt.Sprintf(`insert into isale_inorderdetail_batch(
		inorderdetailbactch_code  ,
inorderdetail_code        ,
user_code                 ,
user_name                 ,
user_mobilephone          ,
product_code              ,
product_name              ,
product_enname            ,
product_barcode           ,
product_sku               ,
product_unit              ,
product_weight            ,
product_length            ,
product_width             ,
product_heigth            ,
product_length_sort       ,
product_width_sort        ,
product_heigth_sort       ,
product_bulk              ,
product_imgurl            ,
product_groupstate        ,
product_batterystate      ,
product_count             ,
product_totalweight       ,
product_totalbulk         ,
operate_user_code         ,
operate_user_name
	) values(
		:inorderdetailbactch_code  ,
:inorderdetail_code        ,
:user_code                 ,
:user_name                 ,
:user_mobilephone          ,
:product_code              ,
:product_name              ,
:product_enname            ,
:product_barcode           ,
:product_sku               ,
:product_unit              ,
:product_weight            ,
:product_length            ,
:product_width             ,
:product_heigth            ,
:product_length_sort       ,
:product_width_sort        ,
:product_heigth_sort       ,
:product_bulk              ,
:product_imgurl            ,
:product_groupstate        ,
:product_batterystate      ,
:product_count             ,
:product_totalweight       ,
:product_totalbulk         ,
:operate_user_code         ,
:operate_user_name
	)`)
		if _, err = tx.NamedExec(sqlcmd, OneDetailBatch); err != nil {
			rtn.Code = 2
			rtn.Message = "更新失败"
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}

		//if oneDetail.Operate_user_code == "" || oneDetail.Operate_user_code == user_code[0] {
		oneDetail.Product_count_batch += count
		count += oneDetail.Product_count

		oneDetail.Product_totalbulk = oneDetail.Product_bulk * count
		oneDetail.Product_totalweight = oneDetail.Product_weight * count
		sqlcmd = fmt.Sprintf(`update isale_inorderdetail set product_count='%d',
	product_count_batch='%d',
		task_user_code=:user_code,task_user_name=:user_name,task_user_logourl=:user_logourl,
		operate_user_code='%s',product_state=3,
		product_totalweight='%d', product_totalbulk='%d' %s where inorderdetail_code='%s'`,
			int(count), int(oneDetail.Product_count_batch), user_code[0],
			int(oneDetail.Product_totalweight),
			int(oneDetail.Product_totalbulk), sqlconditon, oneDetail.Inorderdetail_code)
		DebugLog.Println(sqlcmd)
		if _, err = tx.NamedExec(sqlcmd, oneOperateUser); err != nil {
			rtn.Code = 2
			rtn.Message = "更新失败"
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
	} else {
		if oneDetail.Product_count < 1 {
			rtn.Code = 2
			rtn.Message = "该任务还未上架过一次，无法取消"
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		sqlcmd = fmt.Sprintf(`update isale_inorderdetail set inorderdetail_state=2 where inorderdetail_code='%s'`,
			oneDetail.Inorderdetail_code)
		DebugLog.Println(sqlcmd)
		if _, err = tx.NamedExec(sqlcmd, oneOperateUser); err != nil {
			rtn.Code = 2
			rtn.Message = "更新失败"
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
	}
	sqlcmd = fmt.Sprintf(`select count(*) from isale_inorderdetail where inorder_code='%s' and inorderdetail_state=1`, oneDetail.Inorder_code)
	DebugLog.Println(sqlcmd)
	inordercount := 0
	if err = tx.QueryRowx(sqlcmd).Scan(&inordercount); err != nil {
		rtn.Code = 2
		rtn.Message = err.Error()
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	if inordercount < 1 {
		sqlcmd = fmt.Sprintf(`update isale_inorder set inorder_verify_state=2 where inorder_code='%s'`, oneDetail.Inorder_code)
		DebugLog.Println(sqlcmd)
		if _, err = tx.Exec(sqlcmd); err != nil {
			rtn.Code = 2
			rtn.Message = "更新失败"
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
	}

	rtn.Code = 1
	rtn.Message = "成功"
	DebugLog.Println(rtn)
	bytes, _ := json.Marshal(rtn)
	fmt.Fprint(w, string(bytes))
	return
	//	} else {
	//		rtn.Code = 2
	//		rtn.Message = "该操作已被人处理"
	//		DebugLog.Println(rtn)
	//		bytes, _ := json.Marshal(rtn)
	//		fmt.Fprint(w, string(bytes))
	//		return
	//	}
}
