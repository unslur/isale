// updateCheckStorag
package main

import (
	"encoding/json"
	"fmt"
	"strings"

	. "myfunc"
	"net/http"
	"strconv"

	"github.com/cihub/seelog"
)

func UpdateCheckStorage(w http.ResponseWriter, r *http.Request) {
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
	InfoLog.Println("==========================更新盘点详细开始：", r.URL)
	defer InfoLog.Println("==========================更新盘点详细结束")
	r.ParseForm()
	//	user_code, found4 := r.Form["user_code"]
	//	DebugLog.Println(user_code)
	_, found1 := r.Form["flag"] //1 数量正确,2 数量异常

	count, found3 := r.Form["count"]
	DebugLog.Println(r.Form)

	Checkdetail_code, found2 := r.Form["checkdetail_code"]
	DebugLog.Println(Checkdetail_code)
	if !found1 || !found3 || !found2 {
		fmt.Fprint(w, "请勿非法访问")
		return
	}
	var rtn Rtn
	sqlcmd := ""
	oneCheckDetail := Tmp_checkDetail{}
	sqlcmd = fmt.Sprintf(`SELECT
	checkdetail_code,
	check_code,
	product_code,
	product_sku,
	product_name,
	space_code,
	space_number,
	space_linenumber,
	space_count,
	user_code,
	user_name	
FROM
	isale_checkdetail
WHERE
	checkdetail_code = '%s'`, Checkdetail_code[0])
	DebugLog.Println(sqlcmd)
	if err = tx.Get(&oneCheckDetail, sqlcmd); err != nil {
		rtn.Code = 2
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到任务信息"
		} else {
			rtn.Message = "查询异常"
		}
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	oneSpaceDetaillog := Tmp_SpaceDetaillog{}
	sqlcmd = fmt.Sprintf(`SELECT
	space_code,
	space_halftype,
	space_count,
	product_code,
	product_name,
	product_enname,
	ifnull(product_barcode,"" ) product_barcode         ,
	product_sku,
	product_unit,
	product_weight,
	product_length,
	product_width,
	product_heigth,
	product_length_sort,
	product_width_sort,
	product_heigth_sort,
	product_bulk,
	product_imgurl,
	product_state,
	product_groupstate,
	product_batterystate
FROM
	isale_spacedetail
WHERE
	space_code = '%s'
AND product_code = '%s'`, oneCheckDetail.Space_code, oneCheckDetail.Product_code)
	DebugLog.Println(sqlcmd)
	if err = tx.Get(&oneSpaceDetaillog, sqlcmd); err != nil {
		rtn.Code = 2
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到货位信息"
		} else {
			rtn.Message = "查询异常"
		}
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	oneTask := Tmp_Task{}
	sqlcmd = fmt.Sprintf(`select task_code,task_type,task_othercode from isale_task where task_othercode='%s'`, Checkdetail_code[0])
	DebugLog.Println(sqlcmd)
	if err = tx.Get(&oneTask, sqlcmd); err != nil {
		rtn.Code = 2
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到任务信息"
		} else {
			rtn.Message = "查询异常"
		}
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	if oneTask.Task_state == 3 {
		rtn.Code = 2
		rtn.Message = "任务已完成，请重新刷新"
		DebugLog.Println(sqlcmd)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	oneUser := Tmp_UserSimple{}
	sqlcmd = fmt.Sprintf(`select user_code,user_name,user_mobilephone from isale_user where user_code='%s'`, oneCheckDetail.User_code)
	DebugLog.Println(sqlcmd)
	if err = tx.Get(&oneUser, sqlcmd); err != nil {
		rtn.Code = 2
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到人员信息"
		} else {
			rtn.Message = "查询异常"
		}
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	sqlcmd = fmt.Sprintf(`insert into isale_spacedetaillog(
		
		space_code           ,
space_halftype       ,
space_count          ,
product_code         ,
product_name         ,
product_enname       ,
product_barcode      ,
product_sku          ,
product_unit         ,
product_weight       ,
product_length       ,
product_width        ,
product_heigth       ,
product_length_sort  ,
product_width_sort   ,
product_heigth_sort  ,
product_bulk         ,
product_imgurl       ,
product_state        ,
product_groupstate   ,
product_batterystate ,
user_code            ,
user_name            ,
user_mobilephone     ,
task_code            ,
task_type            ,
task_othercode       
	) select space_code,
space_halftype       ,
'%s'          ,
product_code         ,
product_name         ,
product_enname       ,
ifnull(product_barcode,"" ) product_barcode         ,
product_sku          ,
product_unit         ,
product_weight       ,
product_length       ,
product_width        ,
product_heigth       ,
product_length_sort  ,
product_width_sort   ,
product_heigth_sort  ,
product_bulk         ,
product_imgurl       ,
product_state        ,
product_groupstate   ,
product_batterystate ,
'%s'       		    ,
'%s'         		  ,
'%s'    		,
'%s'            ,
%d          	  ,
'%s'       from isale_spacedetail where space_code ='%s' and product_code='%s'`, count[0], oneCheckDetail.User_code,
		oneUser.User_name, oneUser.User_mobilephone, oneTask.Task_code,
		oneTask.Task_type, oneTask.Task_othercode, oneCheckDetail.Space_code, oneCheckDetail.Product_code)
	DebugLog.Println(sqlcmd)
	if _, err = tx.Exec(sqlcmd); err != nil {
		rtn.Code = 2
		rtn.Message = "更新失败"
		DebugLog.Println(sqlcmd)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	Flag := false
	if oneSpaceDetaillog.Space_count != count[0] {
		InfoLog.Println("货位上数量：", oneSpaceDetaillog.Space_count)
		InfoLog.Println("盘点数据：", count[0])
		Flag = true
	}
	ExceptionCondi := ""
	if !Flag { //数量正确处理

	} else if Flag { //数量异常处理
		InfoLog.Println("盘点数据异常", count[0])
		curr_count, err := strconv.ParseInt(oneCheckDetail.Space_count, 0, 64)
		if err != nil {
			rtn.Code = 2
			rtn.Message = "当前应数量:" + err.Error()
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		rel_count, err := strconv.ParseInt(count[0], 0, 64)
		if err != nil {
			rtn.Code = 2
			rtn.Message = "当前真实数量:" + err.Error()
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		oneStorage := Tmp_Storage{}
		sqlcmd = fmt.Sprintf(`select 
		storage_code, storage_count
		from isale_storage where product_code='%s' and user_code='%s'`, oneCheckDetail.Product_code, oneCheckDetail.User_code)
		DebugLog.Println(sqlcmd)
		if err = tx.Get(&oneStorage, sqlcmd); err != nil {
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到库存信息"
			} else {
				rtn.Message = "查询异常"
			}
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		sto_count, err := strconv.ParseInt(oneStorage.Storage_count, 0, 64)
		if err != nil {
			rtn.Code = 2
			rtn.Message = "库存数量:" + err.Error()
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		InfoLog.Println("盘点数量：", rel_count)
		InfoLog.Println("原库存数量：", curr_count)
		InfoLog.Println("库存数量：", sto_count)
		InfoLog.Println("扣減數量：", rel_count-curr_count)

		sto_count = sto_count + (rel_count - curr_count)
		InfoLog.Println("计算后库存数量：", sto_count)

		sqlcmd = fmt.Sprintf(`update isale_storage set storage_count='%d' where storage_code='%s'`, sto_count, oneStorage.Storage_code)
		DebugLog.Println(sqlcmd)
		if _, err = tx.Exec(sqlcmd); err != nil {
			rtn.Code = 2
			rtn.Message = "更新失败"
			DebugLog.Println(sqlcmd)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		if rel_count == 0 {
			sqlcmd = fmt.Sprintf(`delete from isale_spacedetail  where space_code='%s' and product_code='%s'`,
				oneSpaceDetaillog.Space_code, oneSpaceDetaillog.Product_code)
		} else {
			sqlcmd = fmt.Sprintf(`update isale_spacedetail set space_count='%d' where space_code='%s' and product_code='%s'`,
				rel_count, oneSpaceDetaillog.Space_code, oneSpaceDetaillog.Product_code)
		}
		DebugLog.Println(sqlcmd)
		if _, err = tx.Exec(sqlcmd); err != nil {
			rtn.Code = 2
			rtn.Message = "更新失败"
			DebugLog.Println(sqlcmd)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		sqlcmd = fmt.Sprintf(`select space_bulk ,space_usedbulk from isale_space where space_code='%s'`, oneSpaceDetaillog.Space_code)
		oneSpace := Tmp_Space{}
		if err = tx.Get(&oneSpace, sqlcmd); err != nil {
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到货位信息"
			} else {
				rtn.Message = "查询异常"
			}
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		//		ALLProductBulk, err := strconv.ParseFloat(oneSpace.Space_usedbulk, 64)
		//		if err != nil {
		//			rtn.Code = 2
		//			rtn.Message = "库存数量:" + err.Error()
		//			bytes, _ := json.Marshal(rtn)
		//			fmt.Fprint(w, string(bytes))
		//			panic("cysql")
		//		}
		InfoLog.Println("当前货位总体积:", oneSpace.Space_bulk)
		InfoLog.Println("当前货位已使用体积:", oneSpace.Space_usedbulk)
		InfoLog.Println("当前货位未使用体积:", oneSpace.Space_leftbulk)
		oneProductBulk, err := strconv.ParseInt(oneSpaceDetaillog.Product_bulk, 0, 64)
		if err != nil {
			rtn.Code = 2
			rtn.Message = "库存数量:" + err.Error()
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		InfoLog.Println("单个商品体积：", oneProductBulk)
		ShouldSubBulk := oneProductBulk * (rel_count - curr_count)
		oneSpace.Space_usedbulk, err = SubIntString(oneSpace.Space_usedbulk, fmt.Sprintf(`%d`, ShouldSubBulk))
		if err != nil {
			rtn.Code = 2
			rtn.Message = "库存数量:" + err.Error()
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		InfoLog.Println("扣除货位使用体积后已使用体积：", oneSpace.Space_usedbulk)
		oneSpace.Space_leftbulk, err = SubIntString(oneSpace.Space_bulk, oneSpace.Space_usedbulk)
		if err != nil {
			rtn.Code = 2
			rtn.Message = "库存数量:" + err.Error()
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		InfoLog.Println("扣除货位使用体积后未使用体积：", oneSpace.Space_leftbulk)
		ExceptionCondi = fmt.Sprintf(`, space_usedbulk='%s' ,space_leftbulk='%s' `, oneSpace.Space_usedbulk, oneSpace.Space_leftbulk)

	}

	check_code := ""
	check_count := 0
	sqlcmd = fmt.Sprintf(`SELECT
	check_code
FROM
	isale_checkdetail a
LEFT JOIN isale_task b ON a.checkdetail_code=b.task_othercode
WHERE

 a.checkdetail_code='%s'
and 	b.task_type=5 and b.task_state!=3 `, Checkdetail_code[0])
	DebugLog.Println(sqlcmd)
	if err = tx.QueryRowx(sqlcmd).Scan(&check_code); err != nil {
		rtn.Code = 2
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到任务信息"
		} else {
			rtn.Message = "查询异常"
		}
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	sqlcmd = fmt.Sprintf(`
SELECT
count(*)
FROM
	isale_checkdetail cd
INNER JOIN isale_task t ON cd.checkdetail_code = t.task_othercode
WHERE
	t.task_type = 5
AND t.task_state != 3
and cd.check_code='%s' `, check_code)

	DebugLog.Println(sqlcmd)
	if err = tx.QueryRowx(sqlcmd).Scan(&check_count); err != nil {
		rtn.Code = 2
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到任务信息"
		} else {
			rtn.Message = "查询异常"
		}
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	if check_count == 1 {
		sqlcmd = fmt.Sprintf(`update isale_check set check_state=3 where check_code='%s'`, check_code)
		DebugLog.Println(sqlcmd)
		if _, err = tx.Exec(sqlcmd); err != nil {
			rtn.Code = 2
			rtn.Message = "更新失败"
			DebugLog.Println(sqlcmd)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
	}
	sqlcmd = fmt.Sprintf(`update isale_task set task_state=3 where task_othercode='%s' and task_type=5`, oneCheckDetail.Checkdetail_code)
	DebugLog.Println(sqlcmd)
	if _, err = tx.Exec(sqlcmd); err != nil {
		rtn.Code = 2
		rtn.Message = "更新失败"
		DebugLog.Println(sqlcmd)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	//	sqlcmd = fmt.Sprintf(`select task_user_code from isale_check where check_code='%s'`, check_code)
	//	DebugLog.Println(sqlcmd)
	//	if err = tx.Get(&oneUser, sqlcmd); err != nil {
	//		rtn.Code = 2
	//		rtn.Message = err.Error()
	//		seelog.Debug(rtn)
	//		bytes, _ := json.Marshal(rtn)
	//		fmt.Fprint(w, string(bytes))
	//		return
	//	}
	sqlcmd = fmt.Sprintf(`update isale_space set space_lockstate=1 , user_code='' %s where space_code='%s' `, ExceptionCondi, oneCheckDetail.Space_code)
	DebugLog.Println(sqlcmd)
	if _, err = tx.Exec(sqlcmd); err != nil {
		rtn.Code = 2
		rtn.Message = "更新失败"
		seelog.Debug(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	rtn.Code = 1
	rtn.Message = "成功"
	seelog.Debug(rtn)
	bytes, _ := json.Marshal(rtn)
	fmt.Fprint(w, string(bytes))
	return
}
