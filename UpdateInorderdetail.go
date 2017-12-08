// UpdateInorderdetail
package main

import (
	"encoding/json"
	"fmt"
	. "myfunc"
	"net/http"
	"sort"

	"github.com/cihub/seelog"
)

type In_Detail struct {
	Inorderdetail_code   string
	User_code            string
	Product_code         string
	Product_name         string
	Product_enname       string
	Product_barcode      string
	Product_sku          string
	Product_unit         string
	Product_weight       float64
	Product_length       float64
	Product_width        float64
	Product_heigth       float64
	Product_bulk         float64
	Product_batterystate int64
	Product_usercount    float64
	Product_count        float64
	Flag                 int64
}

func UpdateInorderdetail(w http.ResponseWriter, r *http.Request) {

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
	InfoLog.Println("==========================更新确认子订单开始：", r.URL)
	defer InfoLog.Println("==========================更新确认子订单结束")
	r.ParseForm()

	Info, found1 := r.Form["info"]
	flag, found2 := r.Form["flag"]
	if !found1 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}
	DebugLog.Println(Info)
	sqlcmd := ""
	rtn := Rtn{}
	info := In_Detail{}
	if err := json.Unmarshal([]byte(Info[0]), &info); err != nil {

		rtn.Code = 2
		DebugLog.Println(err.Error())
		rtn.Message = "解析失败"
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return

	}
	DebugLog.Printf("%+v\n", info)

	var product_length_sort float64
	var product_width_sort float64
	var product_heigth_sort float64
	var product_totalweight float64
	var product_totalbulk float64
	product_list := make([]float64, 3)
	product_list[0] = info.Product_length
	product_list[1] = info.Product_width
	product_list[2] = info.Product_heigth

	sort.Float64s(product_list)

	product_length_sort = product_list[2]
	product_width_sort = product_list[1]
	product_heigth_sort = product_list[0]

	product_totalweight = info.Product_usercount * info.Product_weight
	product_totalbulk = info.Product_usercount * info.Product_bulk

	oneDetail := Tmp_InorderdetailCodeFloat{}
	sqlcmd = fmt.Sprintf(`select 
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
		
		from isale_inorderdetail where inorderdetail_code='%s' `,
		info.Inorderdetail_code)
	if err = tx.Get(&oneDetail, sqlcmd); err != nil {
		rtn.Code = 2
		rtn.Message = ""
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	if oneDetail.Product_state != 3 {
		if info.Product_count == 0 {
			rtn.Code = 2
			rtn.Message = "入库数量需要大于零"
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			return
		}
		if info.Product_weight == 0 {
			rtn.Code = 2
			rtn.Message = "入库重量需要大于零"
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			return
		}
		if info.Product_length == 0 {
			rtn.Code = 2
			rtn.Message = "入库长度需要大于零"
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			return
		}
		if info.Product_width == 0 {
			rtn.Code = 2
			rtn.Message = "入库宽度需要大于零"
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			return
		}
		if info.Product_heigth == 0 {
			rtn.Code = 2
			rtn.Message = "入库高度需要大于零"
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			return
		}
		if info.Product_bulk == 0 {
			rtn.Code = 2
			rtn.Message = "入库体积需要大于零"
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			return
		}
		if info.Product_batterystate < 0 {
			rtn.Code = 2
			rtn.Message = "是否选择电池需要大于零"
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			return
		}
	}
	if info.Product_count == 0 {
		rtn.Code = 2
		rtn.Message = "数量必须大于零"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	var count float64
	count = info.Product_count
	if oneDetail.Inorderdetail_state > 1 {
		rtn.Code = 2
		rtn.Message = "该订单已被处理"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	if oneDetail.Operate_user_code == "" || oneDetail.Operate_user_code == info.User_code {
		if oneDetail.Product_state > 2 {
			sqlcmd = fmt.Sprintf(`update isale_inorderdetail set operate_user_code='%s',		
	product_totalweight ='%.2f',
	product_totalbulk ='%d'
 where inorderdetail_code='%s'`, info.User_code,
				product_totalweight, int(product_totalbulk), info.Inorderdetail_code)
		} else {
			sqlcmd = fmt.Sprintf(`update isale_inorderdetail set operate_user_code='%s',
		product_name='%s',
	product_enname       ='%s',
	product_barcode      ='%s',
	product_sku          ='%s',
	product_unit         ='%s',
	product_weight       ='%.2f',
	product_length       ='%d',
	product_width        ='%d',
	product_heigth       ='%d',
	product_bulk         ='%d',
	
	product_batterystate =%d,
	product_length_sort ='%d',
	product_width_sort ='%d',
	product_heigth_sort ='%d',
	product_totalweight ='%.2f',
	product_totalbulk ='%d'
 where inorderdetail_code='%s'`, info.User_code, info.Product_name, info.Product_enname,
				info.Product_barcode, info.Product_sku, info.Product_unit, info.Product_weight, int(info.Product_length),
				int(info.Product_width), int(info.Product_heigth), int(info.Product_bulk),
				info.Product_batterystate, int(product_length_sort), int(product_width_sort), int(product_heigth_sort),
				product_totalweight, int(product_totalbulk), info.Inorderdetail_code)
		}

		DebugLog.Println(sqlcmd)
		if _, err = tx.Exec(sqlcmd); err != nil {
			rtn.Code = 2
			rtn.Message = "更新失败"
			seelog.Debug(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		sqlcondition := ""
		if count+oneDetail.Product_count == oneDetail.Product_usercount {
			sqlcondition = fmt.Sprintf(`,inorderdetail_state=2`)
		}
		if found2 {
			if flag[0] == "2" {
				sqlcondition = fmt.Sprintf(`,inorderdetail_state=2`)
			}
		}
		oneOperateUser := Tmp_UserSimple{}
		sqlcmd = fmt.Sprintf(`select user_code,user_name,user_logourl,user_mobilephone from isale_user where user_code='%s'`,
			info.User_code)
		DebugLog.Println(sqlcmd)
		if err = tx.Get(&oneOperateUser, sqlcmd); err != nil {
			rtn.Code = 2
			rtn.Message = err.Error()
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
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
		OneDetailBatch.Product_count = fmt.Sprintf(`%d`, int(info.Product_count))
		OneDetailBatch.Product_totalweight = fmt.Sprintf(`%.2f`, oneDetail.Product_weight*count)
		OneDetailBatch.Product_totalbulk = fmt.Sprintf(`%d`, int(oneDetail.Product_bulk*count))
		OneDetailBatch.Operate_user_code = oneOperateUser.User_code
		OneDetailBatch.Operate_user_name = oneOperateUser.User_name
		oneDetail.Product_totalbulk = oneDetail.Product_bulk * count
		oneDetail.Product_totalweight = oneDetail.Product_weight * count
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
		sqlcmd = fmt.Sprintf(`update isale_inorderdetail set product_count='%d',
		product_totalweight='%d', product_totalbulk='%d' ,product_state=3
		%s where inorderdetail_code='%s'`, int(count), int(oneDetail.Product_totalweight),
			int(oneDetail.Product_totalbulk), sqlcondition, oneDetail.Inorderdetail_code)
		DebugLog.Println(sqlcmd)
		if _, err = tx.Exec(sqlcmd); err != nil {
			rtn.Code = 2
			rtn.Message = "更新失败"
			seelog.Debug(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		sqlcmd = fmt.Sprintf(`select count(*) from isale_inorderdetail where inorder_code='%s' and inorderdetail_state=1`, oneDetail.Inorder_code)
		DebugLog.Println(sqlcmd)
		inordercount := 0
		if err = tx.QueryRowx(sqlcmd).Scan(&inordercount); err != nil {
			rtn.Code = 2
			rtn.Message = err.Error()
			seelog.Debug(rtn)
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
				seelog.Debug(rtn)
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}
		}
		sqlcmd = fmt.Sprintf(`update isale_product set product_state=3 where product_code='%s'`, info.Product_code)
		DebugLog.Println(sqlcmd)
		if _, err = tx.Exec(sqlcmd); err != nil {
			rtn.Code = 2
			rtn.Message = "更新失败"
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		rtn.Code = 1
		rtn.Message = "成功"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		DebugLog.Println("完成")
		return
	} else {
		rtn.Code = 2
		rtn.Message = "该操作已被人处理"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}

}
