// SaveStorage
package main

import (
	"encoding/json"
	"fmt"
	. "myfunc"
	"net/http"
	"strconv"
	"strings"
)

type Out_SaveStorage struct {
	Code    int
	Message string
}
type Tmp_Inorder struct {
	Inorder_code     string `db:"inorder_code"`
	Inorder_remark   string `db:"inorder_remark"`
	Inorder_state    int    `db:"inorder_state"`
	Inorder_mode     int    `db:"inorder_mode"`
	Inorder_type     int    `db:"inorder_type"`
	User_code        string `db:"user_code"`
	User_name        string `db:"user_name"`
	User_mobilephone string `db:"user_mobilephone"`
}
type Out_Inorder struct {
	Inorder_code     string `db:"inorder_code"`
	Inorder_remark   string `db:"inorder_remark"`
	Inorder_state    int    `db:"inorder_state"`
	Inorder_mode     int    `db:"inorder_mode"`
	Inorder_type     int    `db:"inorder_type"`
	User_code        string `db:"user_code"`
	User_name        string `db:"user_name"`
	User_mobilephone string `db:"user_mobilephone"`
	InorderDetail    []Tmp_InorderdetailCode
}
type Tmp_InorderdetailCode struct {
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
	Product_weight                string
	Product_length                string
	Product_width                 string
	Product_heigth                string
	Product_length_sort           string
	Product_width_sort            string
	Product_heigth_sort           string
	Product_bulk                  string
	Product_imgurl                string
	Product_state                 int
	Product_groupstate            int
	Product_batterystate          int
	Product_usercount             string
	Product_count                 int
	Product_totalweight           string
	Product_totalbulk             string
	Product_count_batch           int
	Addtime                       string
}
type Tmp_SpaceCode struct {
	Space_code        string
	Space_number      string
	Space_linenumber  string
	Space_weight      string
	Space_length      string
	Space_width       string
	Space_heigth      string
	Space_length_sort string
	Space_width_sort  string
	Space_heigth_sort string
	Space_bulk        string
	Space_usedbulk    string
	Space_leftbulk    string
	Space_upbulk      string
	Space_remark      string
	Space_type        int
	Space_state       int
	Space_usestate    int
	Space_lockstate   int
	Space_halftype    int
	Space_parentcode  string
	Area_code         string
	Addtime           string
}

//type Tmp_SpaceCodeOrm struct {
//	Space_code        string
//	Space_number      string
//	Space_linenumber  string
//	Space_weight      string
//	Space_length      string
//	Space_width       string
//	Space_heigth      string
//	Space_length_sort string
//	Space_width_sort  string
//	Space_heigth_sort string
//	Space_bulk        string
//	Space_usedbulk    string
//	Space_leftbulk    string
//	Space_upbulk      string
//	Space_remark      string
//	Space_type        int
//	Space_state       int
//	Space_usestate    int
//	Space_lockstate   int
//	Space_halftype    int
//	Space_parentcode  string
//	Area_code         string
//	Addtime           string
//}

func GetSpaceCodeFrom(space_number string) string {
	sqlcmd := fmt.Sprintf(`select space_code ,space_number from isale_space where space_number ='%s' limit 0 ,1`, space_number)
	oneSpace := Tmp_Space{}
	DebugLog.Println(sqlcmd)
	if err := dborm.Get(&oneSpace, sqlcmd); err != nil {
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			InfoLog.Println("不存在该货位：", space_number)
			return ""
		} else {
			InfoLog.Println(err.Error())
			return ""
		}
	}
	return oneSpace.Space_code
}
func GetSpaceNameFrom(space_code string) string {
	sqlcmd := fmt.Sprintf(`select space_code ,space_number from isale_space where space_code ='%s' limit 0 ,1`, space_code)
	oneSpace := Tmp_Space{}
	DebugLog.Println(sqlcmd)
	if err := dborm.Get(&oneSpace, sqlcmd); err != nil {
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			InfoLog.Println("不存在该货位：", space_code)
			return ""
		} else {
			InfoLog.Println(err.Error())
			return ""
		}
	}
	return oneSpace.Space_number
}
func SaveStorage(w http.ResponseWriter, r *http.Request) {

	tx, err := dborm.Beginx()

	if err != nil {
		InfoLog.Println(err)
		return
	}
	defer func() { // 必须要先声明defer，否则不能捕获到panic异常

		err := recover()
		if err != nil {
			errStr := fmt.Sprintf("%s", err)
			if strings.Contains(errStr, "cysql") {
				tx.Rollback()
				InfoLog.Println("有错误发生，正在回滚")
			} else {
				InfoLog.Println(err)
				tx.Rollback()
			}
		} else {
			tx.Commit()
		}

	}()

	InfoLog.Println("==========================货品上架实际货位，并写入库存开始：", r.URL)
	defer InfoLog.Println("==========================货品上架实际货位，并写入库存结束")
	r.ParseForm()
	task_type, found1 := r.Form["task_type"]
	task_code, found2 := r.Form["task_code"]
	task_othercode, found3 := r.Form["task_othercode"]
	product_code, found4 := r.Form["product_code"]
	product_bulk, found5 := r.Form["product_bulk"]
	task_count, found6 := r.Form["task_count"]
	space_code, found7 := r.Form["space_code"]
	if !found1 || !found2 || !found3 || !found4 || !found5 || !found6 || !found7 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}
	var rtn Out_SaveStorage
	if !IsSpaceCode(space_code[0]) {
		space_code[0] = GetSpaceCodeFrom(space_code[0])
	}

	product_bulk_num, err := strconv.Atoi(product_bulk[0])
	if err != nil {
		rtn.Code = 0
		rtn.Message = "类型转换失败"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)

		fmt.Fprint(w, string(bytes))

		return
	}
	task_count_int, err := strconv.Atoi(task_count[0])
	if err != nil {
		rtn.Code = 0
		rtn.Message = "类型转换失败"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)

		fmt.Fprint(w, string(bytes))

		return
	}
	sqlcmd := ""
	sqlcmd = fmt.Sprintf(`select sum(sd.space_count) task_count_up
		from isale_spacedetaillog sd
		where sd.task_code = '%s' group by sd.task_code`, task_code[0])
	DebugLog.Println(sqlcmd)
	task_count_up := 0
	err = tx.QueryRow(sqlcmd).Scan(&task_count_up)
	if err != nil {
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			task_count_up = 0
		} else {
			rtn.Code = 0
			rtn.Message = "查询异常"
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)

			fmt.Fprint(w, string(bytes))

			return
		}

	}
	sqlcmd = fmt.Sprintf(`select task_count+0 from isale_task where task_code ='%s' `, task_code[0])
	curr_task_count := 0
	err = tx.QueryRow(sqlcmd).Scan(&curr_task_count)
	if err != nil {
		rtn.Code = 0
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
	updateFlag := false
	addFlag := false
	if task_count_up >= curr_task_count {
		//更新任务状态
		sqlcmd = fmt.Sprintf(`update isale_task set task_state=3 where task_code='%s' and task_state!=3`,
			task_code[0])
		DebugLog.Println(sqlcmd)
		DebugLog.Println("任务处理为完成")
		_, err = tx.Exec(sqlcmd)

		if err != nil {
			InfoLog.Println(err)
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到任务信息"
			} else {
				rtn.Message = "更新异常"
			}
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}

		rtn.Code = 10
		rtn.Message = "任务已完成，请不要重复上架"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))

		return
	} else {
		DebugLog.Println("已上架数量:", task_count_up)
		DebugLog.Println("本次上架数量:", task_count_int)
		DebugLog.Println("任务需要上架数量:", curr_task_count)
		if task_count_up+task_count_int > curr_task_count {

			task_count_int = curr_task_count - task_count_up
			updateFlag = true
			addFlag = true
		} else if task_count_up+task_count_int == curr_task_count {
			updateFlag = true
		}
	}

	sqlcmd = fmt.Sprintf(`SELECT 
inorderdetail_code              ,
inorderdetail_state             ,
inorderdetail_halftype          ,
inorderdetail_selectuserstate   ,
inorderdetail_printstate        ,
inorder_code                    ,
inorder_mode                    ,
user_code                       ,
user_name                       ,
user_mobilephone                ,
product_code                    ,
product_name                    ,
product_enname                  ,
ifnull(product_barcode,"") product_barcode ,
product_sku                     ,
product_unit                    ,
product_weight                  ,
product_length                  ,
product_width                   ,
product_heigth                  ,
product_length_sort             ,
product_width_sort              ,
product_heigth_sort             ,
product_bulk                    ,
product_imgurl                  ,
product_state                   ,
product_groupstate              ,
product_batterystate            ,
product_usercount               ,
product_count                   ,
ifnull(product_count_batch,"")+0,
product_totalweight             ,
product_totalbulk               ,
addtime
from isale_inorderdetail 
WHERE inorderdetail_code='%s'
 
`, task_othercode[0])
	DebugLog.Println(sqlcmd)
	var one_detail Tmp_InorderdetailCode
	err = tx.QueryRow(sqlcmd).Scan(&one_detail.Inorderdetail_code,
		&one_detail.Inorderdetail_state,
		&one_detail.Inorderdetail_halftype,
		&one_detail.Inorderdetail_selectuserstate,
		&one_detail.Inorderdetail_printstate,
		&one_detail.Inorder_code,
		&one_detail.Inorder_mode,
		&one_detail.User_code,
		&one_detail.User_name,
		&one_detail.User_mobilephone,
		&one_detail.Product_code,
		&one_detail.Product_name,
		&one_detail.Product_enname,
		&one_detail.Product_barcode,
		&one_detail.Product_sku,
		&one_detail.Product_unit,
		&one_detail.Product_weight,
		&one_detail.Product_length,
		&one_detail.Product_width,
		&one_detail.Product_heigth,
		&one_detail.Product_length_sort,
		&one_detail.Product_width_sort,
		&one_detail.Product_heigth_sort,
		&one_detail.Product_bulk,
		&one_detail.Product_imgurl,
		&one_detail.Product_state,
		&one_detail.Product_groupstate,
		&one_detail.Product_batterystate,
		&one_detail.Product_usercount,
		&one_detail.Product_count,
		&one_detail.Product_count_batch,
		&one_detail.Product_totalweight,
		&one_detail.Product_totalbulk,
		&one_detail.Addtime)
	if err != nil {
		rtn.Code = 0
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到任务信息"
		} else {
			DebugLog.Println(err.Error())
			rtn.Message = "查询异常"
		}
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)

		fmt.Fprint(w, string(bytes))

		return
	}
	one_detail.Product_imgurl = strings.Replace(one_detail.Product_imgurl, `\`, `/`, -1)
	sqlcmd = fmt.Sprintf(`select 
	space_code         ,
space_number       ,
space_linenumber   ,
space_weight       ,
space_length       ,
space_width        ,
space_heigth       ,
space_length_sort  ,
space_width_sort   ,
space_heigth_sort  ,
space_bulk         ,
space_usedbulk     ,
space_leftbulk     ,
ifnull(space_upbulk,"0")  space_upbulk     ,
space_remark       ,
space_type         ,
space_state        ,
space_usestate     ,
space_lockstate    ,
space_halftype     ,
ifnull(space_parentcode,"")  ,
area_code          ,
addtime
       from isale_space where space_code='%s'`, space_code[0])
	DebugLog.Println(sqlcmd)
	var one_space Tmp_SpaceCode
	err = tx.QueryRow(sqlcmd).Scan(&one_space.Space_code,
		&one_space.Space_number,
		&one_space.Space_linenumber,
		&one_space.Space_weight,
		&one_space.Space_length,
		&one_space.Space_width,
		&one_space.Space_heigth,
		&one_space.Space_length_sort,
		&one_space.Space_width_sort,
		&one_space.Space_heigth_sort,
		&one_space.Space_bulk,
		&one_space.Space_usedbulk,
		&one_space.Space_leftbulk,
		&one_space.Space_upbulk,
		&one_space.Space_remark,
		&one_space.Space_type,
		&one_space.Space_state,
		&one_space.Space_usestate,
		&one_space.Space_lockstate,
		&one_space.Space_halftype,
		&one_space.Space_parentcode,
		&one_space.Area_code,
		&one_space.Addtime)

	if err != nil {
		rtn.Code = 0
		//rtn.Message = err.Error()
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
	DebugLog.Println("批次量：", one_detail.Product_count_batch)
	if one_space.Space_lockstate == 2 {
		rtn.Code = 2
		rtn.Message = "货位已锁定"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)

		fmt.Fprint(w, string(bytes))

		return
	}
	if one_space.Space_type == 4 {
		rtn.Code = 2
		rtn.Message = "该货位为借货货位，不能上架，请选择其他货位"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)

		fmt.Fprint(w, string(bytes))

		return
	}
	if one_detail.Inorderdetail_halftype != one_space.Space_halftype {
		rtn.Code = 0
		rtn.Message = "货位类型不一致"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)

		fmt.Fprint(w, string(bytes))

		return
	}
	sqlcmd = fmt.Sprintf(`insert into isale_spacedetaillog (		
	space_code,space_count,space_halftype,product_code,
	product_name,product_enname,product_barcode,product_sku,
	product_unit,product_weight,product_length,product_width,
	product_heigth,product_length_sort,product_width_sort,
	product_heigth_sort,product_bulk,product_imgurl,product_state,
	product_groupstate,product_batterystate,user_code,
	user_name,user_mobilephone,task_code,task_type,task_othercode,feetime) 
	values('%s','%s',%d,'%s','%s','%s','%s','%s','%s','%s',
	'%s','%s','%s','%s','%s','%s','%s','%s',%d,%d,
	%d,'%s','%s','%s','%s',%s,'%s',date_sub(curdate(),interval -1 day))`, space_code[0],
		task_count[0], one_space.Space_halftype, one_detail.Product_code,
		one_detail.Product_name, one_detail.Product_enname, one_detail.Product_barcode,
		one_detail.Product_sku, one_detail.Product_unit, one_detail.Product_weight,
		one_detail.Product_length, one_detail.Product_width, one_detail.Product_heigth,
		one_detail.Product_length_sort, one_detail.Product_width_sort, one_detail.Product_heigth_sort,
		one_detail.Product_bulk, one_detail.Product_imgurl, one_detail.Product_state,
		one_detail.Product_groupstate, one_detail.Product_batterystate, one_detail.User_code,
		one_detail.User_name, one_detail.User_mobilephone, task_code[0], task_type[0], task_othercode[0])
	DebugLog.Println(sqlcmd)
	stmts, err := tx.Prepare(sqlcmd)

	if err != nil {
		InfoLog.Println(err)
		rtn.Code = 2
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到任务信息"
		} else {
			rtn.Message = "更新异常"
		}
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	defer stmts.Close()
	results, err := stmts.Exec()
	if err != nil {
		InfoLog.Println(err)
		rtn.Code = 4
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到任务信息"
		} else {
			rtn.Message = "更新异常"
		}
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	_, err = results.RowsAffected()
	if err != nil {
		InfoLog.Println(err)
		rtn.Code = 3
		rtn.Message = "更新失败"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	sqlcmd = fmt.Sprintf(`select space_code ,space_count, 
	product_code from isale_spacedetail where space_code='%s' and product_code ='%s'`, space_code[0], product_code[0])
	oneSpace_tmp := Tmp_SpaceDetail{}
	DebugLog.Println(sqlcmd)
	if err = tx.Get(&oneSpace_tmp, sqlcmd); err != nil {
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			sqlcmd = fmt.Sprintf(`insert into isale_spacedetail (
	space_code,space_count,space_halftype,product_code,
	product_name,product_enname,product_barcode,product_sku,
	product_unit,product_weight,product_length,product_width,
	product_heigth,product_length_sort,product_width_sort,
	product_heigth_sort,product_bulk,product_imgurl,product_state,
	product_groupstate,product_batterystate,space_excount,user_code,user_name,user_mobilephone) 
	values('%s','%s',%d,'%s','%s','%s','%s','%s','%s','%s',
	'%s','%s','%s','%s','%s','%s','%s','%s',%d,%d,
	%d,'0','%s','%s','%s')`, space_code[0],
				task_count[0], one_space.Space_halftype, one_detail.Product_code,
				one_detail.Product_name, one_detail.Product_enname, one_detail.Product_barcode,
				one_detail.Product_sku, one_detail.Product_unit, one_detail.Product_weight,
				one_detail.Product_length, one_detail.Product_width, one_detail.Product_heigth,
				one_detail.Product_length_sort, one_detail.Product_width_sort, one_detail.Product_heigth_sort,
				one_detail.Product_bulk, one_detail.Product_imgurl, one_detail.Product_state,
				one_detail.Product_groupstate, one_detail.Product_batterystate, one_detail.User_code, one_detail.User_name, one_detail.User_mobilephone)
			DebugLog.Println(sqlcmd)
			_, err = tx.Exec(sqlcmd)

			if err != nil {
				InfoLog.Println(err)
				rtn.Code = 2
				rtn.Message = "更新失败"
				DebugLog.Println(rtn)
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}

		} else {
			InfoLog.Println(err)
			rtn.Code = 3
			rtn.Message = "查询异常"
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
	} else {
		DebugLog.Println("上架之前数量", oneSpace_tmp.Space_count)

		oneSpace_tmp.Space_count, err = AddIntString(oneSpace_tmp.Space_count, task_count[0])
		if err != nil {
			rtn.Code = 2
			rtn.Message = "类型转换失败"
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		DebugLog.Println("上架之后数量", oneSpace_tmp.Space_count)
		sqlcmd = fmt.Sprintf(`update isale_spacedetail set space_count ='%s' where space_code='%s' and product_code='%s'`,
			oneSpace_tmp.Space_count, space_code[0], product_code[0])
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

	bluk := product_bulk_num * task_count_int
	curr_userbulk, err := strconv.Atoi(one_space.Space_usedbulk)
	if err != nil {
		InfoLog.Println(err)
		rtn.Code = 3
		rtn.Message = "类型转换失败"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	curr_leftbulk, err := strconv.Atoi(one_space.Space_leftbulk)
	if err != nil {
		InfoLog.Println(err)
		rtn.Code = 3
		rtn.Message = "类型转换失败"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	space_usedbulk := curr_userbulk + bluk
	space_leftbulk := curr_leftbulk - bluk
	sqlcmd = fmt.Sprintf(`update isale_space set space_usedbulk='%d',
	space_usestate=2,
	space_leftbulk='%d'
	where space_code='%s'`, space_usedbulk, space_leftbulk, one_space.Space_code)
	DebugLog.Println(sqlcmd)
	_, err = tx.Exec(sqlcmd)

	if err != nil {
		InfoLog.Println(err)
		rtn.Code = 2
		rtn.Message = "更新失败"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}

	sqlcmd = fmt.Sprintf(`select storage_code ,storage_count from isale_storage where  product_code='%s'
	and storage_halftype='%d'`, product_code[0], one_detail.Inorderdetail_halftype)
	cur_storage_code := ""
	cur_storage_count := ""
	err = tx.QueryRow(sqlcmd).Scan(&cur_storage_code, &cur_storage_count)

	if err != nil {
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			storage_code := GenerateCode("402")
			sqlcmd = fmt.Sprintf(`insert into isale_storage (
		storage_code,storage_count,storage_halftype,
		product_code,product_name,product_enname,product_barcode,
		product_sku,product_unit,product_weight,product_length,
		product_width,product_heigth,product_length_sort,
		product_width_sort,product_heigth_sort,product_bulk,
		product_imgurl,product_state,product_groupstate,
		product_batterystate,user_code,user_name,user_mobilephone)
		values('%s','%d',%d,%s,'%s','%s','%s','%s','%s','%s',
		'%s','%s',%s,'%s','%s','%s','%s','%s',%d,%d,
		%d,'%s','%s','%s')`, storage_code, task_count_int, one_detail.Inorderdetail_halftype,
				one_detail.Product_code, one_detail.Product_name, one_detail.Product_enname,
				one_detail.Product_barcode, one_detail.Product_sku, one_detail.Product_unit,
				one_detail.Product_weight, one_detail.Product_length, one_detail.Product_width,
				one_detail.Product_heigth, one_detail.Product_length_sort,
				one_detail.Product_width_sort, one_detail.Product_heigth_sort,
				one_detail.Product_bulk, one_detail.Product_imgurl, one_detail.Product_state,
				one_detail.Product_groupstate, one_detail.Product_batterystate,
				one_detail.User_code, one_detail.User_name, one_detail.User_mobilephone)
		} else {

			rtn.Code = 2
			rtn.Message = "查询异常"
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}

	} else {
		cur_storage_count_int, err := strconv.Atoi(cur_storage_count)
		if err != nil {
			cur_storage_count_int = 0
		}
		sqlcmd = fmt.Sprintf(`update isale_storage set storage_count='%d' where storage_code='%s' `,
			cur_storage_count_int+task_count_int, cur_storage_code)
	}
	DebugLog.Println(sqlcmd)
	_, err = tx.Exec(sqlcmd)

	if err != nil {
		InfoLog.Println(err)
		rtn.Code = 2
		rtn.Message = "更新失败"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}

	rtn.Code = 1
	rtn.Message = "成功"
	if updateFlag {
		sqlcmd = fmt.Sprintf(`update isale_task set task_state=3 where task_code='%s'`,
			task_code[0])
		DebugLog.Println(sqlcmd)
		_, err = tx.Exec(sqlcmd)

		if err != nil {
			InfoLog.Println(err)
			rtn.Code = 2
			rtn.Message = "更新失败"
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		if one_detail.Inorderdetail_state > 1 {
			if one_detail.Product_count_batch == 0 {
				sqlcmd = fmt.Sprintf(`SELECT count(task_code) from isale_task WHERE task_othercode='%s' AND task_state!=3`, task_othercode[0])
				tmp_count := 0
				if err = tx.QueryRowx(sqlcmd).Scan(&tmp_count); err != nil {
					InfoLog.Println(err)
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
				DebugLog.Println("未完成的任务条数：", tmp_count)
				if tmp_count == 0 {
					sqlcmd = fmt.Sprintf(`update isale_inorderdetail set inorderdetail_state=4 where inorderdetail_code='%s'
		and inorderdetail_state!=4`, task_othercode[0])
					DebugLog.Println(sqlcmd)
					_, err = tx.Exec(sqlcmd)

					if err != nil {
						InfoLog.Println(err)
						rtn.Code = 2
						rtn.Message = "更新失败"
						DebugLog.Println(rtn)
						bytes, _ := json.Marshal(rtn)
						fmt.Fprint(w, string(bytes))
						panic("cysql")
					}
					sqlcmd = fmt.Sprintf(`SELECT
	count(inorderdetail_code)
FROM
	isale_inorderdetail
WHERE
	inorder_code = (
		SELECT DISTINCT
			inorder_code
		FROM
			isale_inorderdetail
		WHERE
			inorderdetail_code = '%s'
	)
and inorderdetail_state!=4`, task_othercode[0])
					tmp_count := 0
					if err = tx.QueryRowx(sqlcmd).Scan(&tmp_count); err != nil {

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

					if Halftype != "1" {
						sqlcmd = fmt.Sprintf(`SELECT
	ifnull(process_code,"") process_code
FROM
	isale_inorder
WHERE
	inorder_code = (
		SELECT DISTINCT
			inorder_code
		FROM
			isale_inorderdetail
		WHERE
			inorderdetail_code = '%s'
	)
`, task_othercode[0])
						process_code := ""
						if err = tx.QueryRowx(sqlcmd).Scan(&process_code); err != nil {

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
						if len(process_code) > 1 {

							sqlcmd = fmt.Sprintf(`update isale_process set process_state=5 
				where process_code='%s'`, process_code)
							_, err = tx.Exec(sqlcmd)
							if err != nil {
								InfoLog.Println(err)
								rtn.Code = 2
								rtn.Message = "更新失败"
								DebugLog.Println(rtn)
								bytes, _ := json.Marshal(rtn)
								fmt.Fprint(w, string(bytes))
								panic("cysql")
							}
						}
					}
					if tmp_count == 0 {
						sqlcmd = fmt.Sprintf(`UPDATE isale_inorder
SET inorder_state = 3
WHERE
	inorder_code = (
		SELECT DISTINCT
			inorder_code
		FROM
			isale_inorderdetail
		WHERE
			inorderdetail_code = '%s'
	)
AND inorder_state != 3`, task_othercode[0])
						DebugLog.Println(sqlcmd)
						_, err = tx.Exec(sqlcmd)
						if err != nil {
							InfoLog.Println(err)
							rtn.Code = 2
							rtn.Message = "更新失败"
							DebugLog.Println(rtn)
							bytes, _ := json.Marshal(rtn)
							fmt.Fprint(w, string(bytes))
							panic("cysql")
						}
					}
				}
			}
		}
		if addFlag {
			rtn.Code = 10
			rtn.Message = fmt.Sprintln("任务完成,上架数量大于任务数量，实际入库数量,", task_count_int)
		} else {
			rtn.Code = 1
			rtn.Message = "成功"
		}

	}

	DebugLog.Println(rtn)
	bytes, _ := json.Marshal(rtn)
	fmt.Fprint(w, string(bytes))

}
