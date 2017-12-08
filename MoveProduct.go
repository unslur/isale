// MoveProduct
package main

import (
	"encoding/json"
	"fmt"
	. "myfunc"
	"net/http"
	"strings"
)

func MoveProduct(w http.ResponseWriter, r *http.Request) {

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
	InfoLog.Println("==========================移库开始：", r.URL)
	defer InfoLog.Println("==========================移库结束")
	r.ParseForm()
	User_code, found1 := r.Form["User_code"]
	Fromspace_code_number, found2 := r.Form["Fromspacecode"]
	Tospace_code_number, found3 := r.Form["Tospacecode"]
	Product_code, found4 := r.Form["Product_code"]
	Count, found5 := r.Form["Count"]
	DebugLog.Println(Count)
	DebugLog.Println(User_code)
	if !found1 {
		DebugLog.Println(1)
	}
	if !found2 {
		DebugLog.Println(2)
	}
	if !found3 {
		DebugLog.Println(3)
	}
	if !found4 {
		DebugLog.Println(4)
	}
	if !found1 || !found2 || !found3 || !found4 || !found5 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}
	Fromspace_code := Fromspace_code_number
	Tospace_code := Tospace_code_number
	var rtn Rtn
	if !IsSpaceCode(Fromspace_code_number[0]) {
		Fromspace_code[0] = GetSpaceCodeFrom(Fromspace_code_number[0])
	}
	if !IsSpaceCode(Tospace_code_number[0]) {
		Tospace_code[0] = GetSpaceCodeFrom(Tospace_code_number[0])
	}
	if Fromspace_code[0] == Tospace_code[0] {
		rtn.Code = 2
		rtn.Message = "两个货位不能一样"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	sqlcmd := ""

	OneSpaceFrom := Tmp_Space{}
	OneSpaceTo := Tmp_Space{}
	OneUser := Tmp_UserSimple{}

	sqlcmd = fmt.Sprintf(`select 
	space_code,space_type,space_state,space_usestate,space_lockstate,space_halftype,space_number
	from isale_space where space_code='%s'`, Fromspace_code[0])
	DebugLog.Println(sqlcmd)
	if err = tx.Get(&OneSpaceFrom, sqlcmd); err != nil {
		rtn.Code = 2
		rtn.Message = fmt.Sprintf(`%s货架未使用出现异常`, Fromspace_code_number[0])
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}

	sqlcmd = fmt.Sprintf(`select 
	space_code,space_type,space_state,space_usestate,space_lockstate,space_halftype,space_number
	from isale_space where space_code='%s'`, Tospace_code[0])
	DebugLog.Println(sqlcmd)
	if err = tx.Get(&OneSpaceTo, sqlcmd); err != nil {
		rtn.Code = 2
		rtn.Message = Tospace_code_number[0] + "货架未使用出现异常"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	if OneSpaceFrom.Space_lockstate == 2 {
		rtn.Code = 2
		rtn.Message = Fromspace_code_number[0] + "货位被锁定"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	if OneSpaceTo.Space_lockstate == 2 {
		rtn.Code = 2
		rtn.Message = Tospace_code_number[0] + "货位被锁定"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}

	sqlcmd = fmt.Sprintf(`select user_code,user_name,user_mobilephone,user_logourl from isale_user where user_code='%s'`, User_code[0])
	DebugLog.Println(sqlcmd)
	if err = tx.Get(&OneUser, sqlcmd); err != nil {
		rtn.Code = 2
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到人员信息"
		} else {
			rtn.Message = "查询异常"
		}
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	execResult := 0
	DebugLog.Println(OneSpaceFrom.Space_code, OneSpaceFrom.Space_type)
	DebugLog.Println(OneSpaceTo.Space_code, OneSpaceTo.Space_type)
	if OneSpaceFrom.Space_halftype != OneSpaceTo.Space_halftype {
		rtn.Code = 2
		rtn.Message = "不同仓库不支持移动"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	if IsTaskDoing(OneSpaceFrom.Space_code, []string{"1", "2", "5"}) > 0 {
		rtn.Code = 2
		rtn.Message = "货位" + OneSpaceFrom.Space_number + "有任务进行操作，请先完成任务"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	if IsTaskDoing(OneSpaceTo.Space_code, []string{"1", "2", "5"}) > 0 {
		rtn.Code = 2
		rtn.Message = "货位" + OneSpaceTo.Space_number + "有任务进行操作，请先完成任务"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	if OneSpaceFrom.Space_type == 3 && OneSpaceTo.Space_type == 2 {
		//high To top

		sqlcmd = fmt.Sprintf(`call proc_move_highToTop('%s','%s','%s','%s',%d,'%s',%s,'%s','%s','%s',@result)`, OneSpaceFrom.Space_code,
			OneSpaceFrom.Space_number, OneSpaceTo.Space_code, OneSpaceTo.Space_number, OneSpaceFrom.Space_halftype, Product_code[0], Count[0],
			OneUser.User_code, OneUser.User_name, OneUser.User_logourl)
		DebugLog.Println(sqlcmd)
		if err = tx.QueryRowx(sqlcmd).Scan(&execResult); err != nil {
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到任务信息"
			} else {
				rtn.Message = "移库异常"
			}
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
	} else if OneSpaceFrom.Space_type == 2 && OneSpaceTo.Space_type == 1 {
		//top to normal

		sqlcmd = fmt.Sprintf(`call proc_move_topToNormal('%s','%s','%s','%s',%d,'%s',%s,'%s','%s','%s',@result)`, OneSpaceFrom.Space_code,
			OneSpaceFrom.Space_number, OneSpaceTo.Space_code, OneSpaceTo.Space_number, OneSpaceFrom.Space_halftype, Product_code[0], Count[0],
			OneUser.User_code, OneUser.User_name, OneUser.User_logourl)
		DebugLog.Println(sqlcmd)
		if err = tx.QueryRowx(sqlcmd).Scan(&execResult); err != nil {
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到任务信息"
			} else {
				rtn.Message = "移库异常"
			}
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
	} else if OneSpaceFrom.Space_type == 1 && OneSpaceTo.Space_type == 1 {
		//normal to normal

		sqlcmd = fmt.Sprintf(`call proc_move_normalToNormal('%s','%s','%s','%s',%d,'%s',%s,'%s','%s','%s',@result)`, OneSpaceFrom.Space_code,
			OneSpaceFrom.Space_number, OneSpaceTo.Space_code, OneSpaceTo.Space_number, OneSpaceFrom.Space_halftype, Product_code[0], Count[0],
			OneUser.User_code, OneUser.User_name, OneUser.User_logourl)
		DebugLog.Println(sqlcmd)
		if err = tx.QueryRowx(sqlcmd).Scan(&execResult); err != nil {
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到任务信息"
			} else {
				rtn.Message = "移库异常"
			}
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
	} else if OneSpaceFrom.Space_type == 3 && OneSpaceTo.Space_type == 1 {
		//high to normal

		sqlcmd = fmt.Sprintf(`call proc_move_highToNormal('%s','%s','%s','%s',%d,'%s',%s,'%s','%s','%s',@result)`, OneSpaceFrom.Space_code,
			OneSpaceFrom.Space_number, OneSpaceTo.Space_code, OneSpaceTo.Space_number, OneSpaceFrom.Space_halftype, Product_code[0], Count[0],
			OneUser.User_code, OneUser.User_name, OneUser.User_logourl)
		DebugLog.Println(sqlcmd)
		if err = tx.QueryRowx(sqlcmd).Scan(&execResult); err != nil {
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到任务信息"
			} else {
				rtn.Message = "移库异常"
			}
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
	} else if OneSpaceFrom.Space_type == 2 && OneSpaceTo.Space_type == 3 {
		//top to high

		sqlcmd = fmt.Sprintf(`call proc_move_topToHigh('%s','%s','%s','%s',%d,'%s',%s,'%s','%s','%s',@result)`, OneSpaceFrom.Space_code,
			OneSpaceFrom.Space_number, OneSpaceTo.Space_code, OneSpaceTo.Space_number, OneSpaceFrom.Space_halftype, Product_code[0], Count[0],
			OneUser.User_code, OneUser.User_name, OneUser.User_logourl)
		DebugLog.Println(sqlcmd)
		if err = tx.QueryRowx(sqlcmd).Scan(&execResult); err != nil {
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到任务信息"
			} else {
				rtn.Message = "移库异常"
			}
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
	} else if OneSpaceFrom.Space_type == 1 && OneSpaceTo.Space_type == 2 {
		//normal to top

		sqlcmd = fmt.Sprintf(`call proc_move_normalToTop('%s','%s','%s','%s',%d,'%s',%s,'%s','%s','%s',@result)`, OneSpaceFrom.Space_code,
			OneSpaceFrom.Space_number, OneSpaceTo.Space_code, OneSpaceTo.Space_number, OneSpaceFrom.Space_halftype, Product_code[0], Count[0],
			OneUser.User_code, OneUser.User_name, OneUser.User_logourl)
		DebugLog.Println(sqlcmd)
		if err = tx.QueryRowx(sqlcmd).Scan(&execResult); err != nil {
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到任务信息"
			} else {
				rtn.Message = "移库异常"
			}
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
	} else if OneSpaceFrom.Space_type == 1 && OneSpaceTo.Space_type == 3 {
		//normal to high

		sqlcmd = fmt.Sprintf(`call proc_move_normalToHigh('%s','%s','%s','%s',%d,'%s',%s,'%s','%s','%s',@result)`, OneSpaceFrom.Space_code,
			OneSpaceFrom.Space_number, OneSpaceTo.Space_code, OneSpaceTo.Space_number, OneSpaceFrom.Space_halftype, Product_code[0], Count[0],
			OneUser.User_code, OneUser.User_name, OneUser.User_logourl)
		DebugLog.Println(sqlcmd)
		if err = tx.QueryRowx(sqlcmd).Scan(&execResult); err != nil {
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到任务信息"
			} else {
				rtn.Message = "移库异常"
			}
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
	} else if OneSpaceFrom.Space_type == 4 && OneSpaceTo.Space_type != 4 {
		//normal to high

		sqlcmd = fmt.Sprintf(`call proc_move_specialToNTH('%s','%s','%s','%s',%d,'%s',%s,'%s','%s','%s',@result)`, OneSpaceFrom.Space_code,
			OneSpaceFrom.Space_number, OneSpaceTo.Space_code, OneSpaceTo.Space_number, OneSpaceFrom.Space_halftype, Product_code[0], Count[0],
			OneUser.User_code, OneUser.User_name, OneUser.User_logourl)
		DebugLog.Println(sqlcmd)
		if err = tx.QueryRowx(sqlcmd).Scan(&execResult); err != nil {
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到任务信息"
			} else {
				rtn.Message = "移库异常"
			}
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
	} else if OneSpaceTo.Space_type == 4 && OneSpaceFrom.Space_type != 4 {
		//normal to high

		sqlcmd = fmt.Sprintf(`call proc_move_NTHToSpecial('%s','%s','%s','%s',%d,'%s',%s,'%s','%s','%s',@result)`, OneSpaceFrom.Space_code,
			OneSpaceFrom.Space_number, OneSpaceTo.Space_code, OneSpaceTo.Space_number, OneSpaceFrom.Space_halftype, Product_code[0], Count[0],
			OneUser.User_code, OneUser.User_name, OneUser.User_logourl)
		DebugLog.Println(sqlcmd)
		if err = tx.QueryRowx(sqlcmd).Scan(&execResult); err != nil {
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到任务信息"
			} else {
				rtn.Message = "移库异常"
			}
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
	} else {
		rtn.Code = 2
		rtn.Message = "货位类型不支持当前操作，请确定货位类型"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}

	rtn.Code = 1
	rtn.Message = "成功"
	DebugLog.Println(rtn)
	bytes, _ := json.Marshal(rtn)
	fmt.Fprint(w, string(bytes))
	return
}
func IsTaskDoing(space_code string, condi []string) (result int64) {
	sqlcmd := ""
	sqlcmd = fmt.Sprintf(`SELECT
	count(task_state)
FROM
	isale_task
WHERE
	task_code IN (
		SELECT
		DISTINCT	task_code
		FROM
			isale_spacedetaillog
		WHERE
			space_code = '%s'
	)
and task_state!=3 `, space_code)
	if len(condi) > 0 {
		sqlCondition := ""
		for indexs, ele := range condi {
			if indexs != len(condi)-1 {
				sqlCondition += fmt.Sprintf(" %s, ", ele)
			} else {
				sqlCondition += fmt.Sprintf(" %s ", ele)
			}
		}

		sqlcmd += fmt.Sprintf(`and task_type in(%s)`, sqlCondition)
	}
	DebugLog.Println(sqlcmd)
	if err := dborm.QueryRowx(sqlcmd).Scan(&result); err != nil {
		return 0
	}
	if result == 0 && condi[1] == "2" {

		sqlcmd = fmt.Sprintf(`select count(*) from isale_wavedetailspace wds inner join isale_task t on wds.wavedetailspace_code=t.task_othercode 
			where wds.space_code = '%s' AND task_state != 3`, space_code)
		DebugLog.Println(sqlcmd)
		if err := dborm.QueryRowx(sqlcmd).Scan(&result); err != nil {
			return 0
		}
	}
	return result

}
func IsSpaceCode(space_code string) bool {
	if len(space_code) != 25 {
		return false
	}
	if strings.HasPrefix(space_code, "105") {
		return true
	}
	return false

}
func MoveProduct1(w http.ResponseWriter, r *http.Request) {

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
	InfoLog.Println("==========================移库开始：", r.URL)
	defer InfoLog.Println("==========================移库结束")
	r.ParseForm()
	User_code, found1 := r.Form["User_code"]
	Fromspace_code, found2 := r.Form["Fromspacecode"]
	Tospace_code, found3 := r.Form["Tospacecode"]
	Product_code, found4 := r.Form["Product_code"]
	Count, found5 := r.Form["Count"]
	DebugLog.Println(Count)
	DebugLog.Println(User_code)
	if !found1 {
		DebugLog.Println(1)
	}
	if !found2 {
		DebugLog.Println(2)
	}
	if !found3 {
		DebugLog.Println(3)
	}
	if !found4 {
		DebugLog.Println(4)
	}
	if !found1 || !found2 || !found3 || !found4 || !found5 {
		fmt.Fprint(w, "请勿非法访问")

		return
	}

	var rtn Rtn
	sqlcmd := ""
	OneSpaceDetailFrom := Tmp_SpaceDetail{}
	OneSpaceDetailTo := Tmp_SpaceDetail{}
	OneSpaceFrom := Tmp_Space{}
	OneSpaceTo := Tmp_Space{}
	ToIsExixt := true

	sqlcmd = fmt.Sprintf(`select 
	space_code,space_type,space_state,space_usestate,space_lockstate,space_halftype
	from isale_space where space_code='%s'`, Fromspace_code[0])
	DebugLog.Println(sqlcmd)
	if err = tx.Get(&OneSpaceFrom, sqlcmd); err != nil {
		rtn.Code = 2
		rtn.Message = "下货货架未使用出现异常"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}

	sqlcmd = fmt.Sprintf(`select 
	space_code,space_type,space_state,space_usestate,space_lockstate,space_halftype
	from isale_space where space_code='%s'`, Tospace_code[0])
	DebugLog.Println(sqlcmd)
	if err = tx.Get(&OneSpaceTo, sqlcmd); err != nil {
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
	if err = tx.Get(&OneSpaceFrom, sqlcmd); err != nil {
		rtn.Code = 2
		rtn.Message = "上货货架未使用出现异常"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	if OneSpaceFrom.Space_halftype != OneSpaceTo.Space_halftype {
		rtn.Code = 2
		rtn.Message = "不同仓库货位不允许移动"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	if OneSpaceFrom.Space_state == 3 && OneSpaceTo.Space_state == 1 {
		rtn.Code = 2
		rtn.Message = "不允许从高位货位移动到普通货位"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	sqlcmd = fmt.Sprintf(`select space_code             ,
space_halftype         ,
space_count            ,
ifnull(space_excount ,"0"     ) space_excount,
product_code           ,
product_name           ,
product_enname         ,
ifnull(product_barcode,"" ) product_barcode         ,
product_sku            ,
product_unit           ,
product_weight         ,
product_length         ,
product_width          ,
product_heigth         ,
product_length_sort    ,
product_width_sort     ,
product_heigth_sort    ,
product_bulk           ,
product_imgurl         ,
product_state          ,
product_groupstate     ,
product_batterystate,user_code,user_name,user_mobilephone
	from isale_spacedetail where space_code='%s' and product_code='%s' limit 0,1`, Fromspace_code[0], Product_code[0])
	DebugLog.Println(sqlcmd)
	if err = tx.Get(&OneSpaceDetailFrom, sqlcmd); err != nil {
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

	sqlcmd = fmt.Sprintf(`select space_code             ,
space_halftype         ,
space_count            ,
ifnull(space_excount ,"0"     ) space_excount   ,
product_code           ,
product_name           ,
product_enname         ,
ifnull(product_barcode,"" ) product_barcode         ,
product_sku            ,
product_unit           ,
product_weight         ,
product_length         ,
product_width          ,
product_heigth         ,
product_length_sort    ,
product_width_sort     ,
product_heigth_sort    ,
product_bulk           ,
product_imgurl         ,
product_state          ,
product_groupstate     ,
product_batterystate
	from isale_spacedetail where space_code='%s' and product_code='%s' limit 0,1`, Tospace_code[0], Product_code[0])
	DebugLog.Println(sqlcmd)
	if err = tx.Get(&OneSpaceDetailTo, sqlcmd); err != nil {
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			InfoLog.Println("沒有貨位")
			ToIsExixt = false
		} else {
			rtn.Code = 2
			rtn.Message = "查询异常"
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			return
		}

	}
	var value int64
	//	FromlogCode := GenerateCode("107")
	//	TologCode := GenerateCode("107")
	ToTaskCode := GenerateCode("700")
	FromTaskCode := GenerateCode("700")
	if value, err = SubInt(OneSpaceDetailFrom.Space_count, Count[0]); err != nil {
		rtn.Code = 2
		rtn.Message = "类型转换错误"
		DebugLog.Println(rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	DebugLog.Println("下貨數量", value)
	oneUser := Tmp_UserSimple{}
	sqlcmd = fmt.Sprintf(`select user_code,user_name,user_mobilephone from isale_user where user_code='%s'`, User_code[0])
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
		panic("cysql")
	}
	sqlcmd = fmt.Sprintf(`insert into isale_spacedetaillog(	
		space_code           ,
		space_halftype       ,		space_count          ,		product_code         ,
		product_name         ,		product_enname       ,	product_barcode      ,		product_sku          ,
		product_unit         ,		product_weight       ,		product_length       ,
		product_width        ,		product_heigth       ,		product_length_sort  ,
		product_width_sort   ,		product_heigth_sort  ,	product_bulk         ,
		product_imgurl       ,		product_state        ,		product_groupstate   ,
		product_batterystate ,		user_code            ,		user_name            ,		user_mobilephone  ,
		task_code,task_type,task_othercode   
	
	) value(:space_code,:space_halftype,'%s',:product_code,:product_name,:product_enname,:product_barcode,
:product_sku,:product_unit,:product_weight,:product_length,:product_width,:product_heigth,:product_length_sort,
:product_width_sort,:product_heigth_sort,:product_bulk,:product_imgurl,:product_state,:product_groupstate,
:product_batterystate,'%s','%s','%s','%s',7,'%s')`, Count[0], oneUser.User_code,
		oneUser.User_name, oneUser.User_mobilephone, FromTaskCode, ToTaskCode)
	DebugLog.Println(sqlcmd)
	if _, err = tx.NamedExec(sqlcmd, OneSpaceDetailFrom); err != nil {
		rtn.Code = 2
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到货位信息"
		} else {
			rtn.Message = "更新异常"
		}
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	sqlcmd = fmt.Sprintf(`insert into isale_spacedetaillog(	
		space_code           ,
		space_halftype       ,		space_count          ,		product_code         ,
		product_name         ,		product_enname       ,	product_barcode      ,		product_sku          ,
		product_unit         ,		product_weight       ,		product_length       ,
		product_width        ,		product_heigth       ,		product_length_sort  ,
		product_width_sort   ,		product_heigth_sort  ,	product_bulk         ,
		product_imgurl       ,		product_state        ,		product_groupstate   ,
		product_batterystate ,		user_code            ,		user_name            ,		user_mobilephone  ,
		task_code,task_type,task_othercode  	
	) value(:space_code,:space_halftype,'%s',:product_code,:product_name,:product_enname,:product_barcode,
:product_sku,:product_unit,:product_weight,:product_length,:product_width,:product_heigth,:product_length_sort,
:product_width_sort,:product_heigth_sort,:product_bulk,:product_imgurl,:product_state,:product_groupstate,
:product_batterystate,'%s','%s','%s','%s',7,'%s')`, Count[0], oneUser.User_code,
		oneUser.User_name, oneUser.User_mobilephone, ToTaskCode, FromTaskCode)
	DebugLog.Println(sqlcmd)
	if _, err = tx.NamedExec(sqlcmd, OneSpaceDetailFrom); err != nil {
		rtn.Code = 2
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到货位信息"
		} else {
			rtn.Message = "更新异常"
		}
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	if value == 0 {
		sqlcmd = fmt.Sprintf(`delete from isale_spacedetail 
			where space_code='%s' and product_code='%s'`, Fromspace_code[0], Product_code[0])
	} else {

		sqlcmd = fmt.Sprintf(`update isale_spacedetail set space_count='%d' 
				where space_code='%s' and product_code='%s'`,
			value, Fromspace_code[0], Product_code[0])
	}
	DebugLog.Println(sqlcmd)
	if _, err = tx.Exec(sqlcmd); err != nil {
		rtn.Code = 2
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到货位信息"
		} else {
			rtn.Message = "更新异常"
		}
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}

	if ToIsExixt {
		if value, err = AddInt(OneSpaceDetailTo.Space_count, Count[0]); err != nil {
			rtn.Code = 2
			rtn.Message = "类型转换失败"
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
		sqlcmd = fmt.Sprintf(`update isale_spacedetail set space_count='%d' 
				where space_code='%s' and product_code='%s' `, value, Tospace_code[0], Product_code[0])
		DebugLog.Println(sqlcmd)
		if _, err = tx.Exec(sqlcmd); err != nil {
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到货位信息"
			} else {
				rtn.Message = "更新异常"
			}
			DebugLog.Println(rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
	} else {
		OneSpaceDetailTo = OneSpaceDetailFrom
		OneSpaceDetailTo.Space_code = Tospace_code[0]
		OneSpaceDetailTo.Space_count = Count[0]
		OneSpaceDetailTo.Space_excount = "0"
		sqlcmd = fmt.Sprintf(`insert into isale_spacedetail(
			space_code           ,
		space_halftype       ,		space_count          ,space_excount,		product_code         ,
		product_name         ,		product_enname       ,	product_barcode      ,		product_sku          ,
		product_unit         ,		product_weight       ,		product_length       ,
		product_width        ,		product_heigth       ,		product_length_sort  ,
		product_width_sort   ,		product_heigth_sort  ,	product_bulk         ,
		product_imgurl       ,		product_state        ,		product_groupstate   ,
		product_batterystate,user_code,user_name,user_mobilephone	
	) value(:space_code,:space_halftype,:space_count,:space_excount,:product_code,:product_name,:product_enname,:product_barcode,
:product_sku,:product_unit,:product_weight,:product_length,:product_width,:product_heigth,:product_length_sort,
:product_width_sort,:product_heigth_sort,:product_bulk,:product_imgurl,:product_state,:product_groupstate,
:product_batterystate,:user_code,:user_name,:user_mobilephone)`)
		DebugLog.Println(sqlcmd)
		if _, err = tx.NamedExec(sqlcmd, OneSpaceDetailTo); err != nil {
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到货位信息"
			} else {
				rtn.Message = "更新异常"
			}
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
}
