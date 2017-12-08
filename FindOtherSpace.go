// FindOtherSpace
package main

import (
	"encoding/json"
	"fmt"
	. "myfunc"
	"net/http"
	"strconv"
	"strings"
)

type Tmp_WaveDetailSpaceFloat struct {
	Wavedetailspace_code string  `db:"wavedetailspace_code"`
	Wavedetail_code      string  `db:"wavedetail_code"`
	Wave_code            string  `db:"wave_code"`
	Wavedetail_count     int64   `db:"wavedetail_count"`
	Wavedetail_excount   int64   `db:"wavedetail_excount"`
	Product_code         string  `db:"product_code"`
	Product_name         string  `db:"product_name"`
	Product_enname       string  `db:"product_enname"`
	Product_barcode      string  `db:"product_barcode"`
	Product_sku          string  `db:"product_sku"`
	Product_unit         string  `db:"product_unit"`
	Product_weight       float64 `db:"product_weight"`
	Product_length       int64   `db:"product_length"`
	Product_width        int64   `db:"product_width"`
	Product_heigth       int64   `db:"product_heigth"`
	Product_length_sort  int64   `db:"product_length_sort"`
	Product_width_sort   int64   `db:"product_width_sort"`
	Product_heigth_sort  int64   `db:"product_heigth_sort"`
	Product_bulk         int64   `db:"product_bulk"`
	Product_imgurl       string  `db:"product_imgurl"`
	Product_state        int     `db:"product_state"`
	Product_groupstate   int     `db:"product_groupstate"`
	Product_batterystate int     `db:"product_batterystate"`
	Space_code           string  `db:"space_code"`
	Space_number         string  `db:"space_number"`
	Space_linenumber     string  `db:"space_linenumber"`
	Addtime              string  `db:"addtime"`
}
type Tmp_WaveDetail struct {
	Wavedetail_code string `db:"wavedetail_code"`
	Wave_code       string `db:"wave_code"`
	Wave_type       int    `db:"wave_type"`
	Wave_count      int64  `db:"wave_count"`
	Outorder_code   string `db:"outorder_code"`
	Product_code    string `db:"product_code"`
	Product_name    string `db:"product_name"`
	Addtime         string `db:"addtime"`
}
type Tmp_Warning struct {
	Warning_code   string
	Warning_name   string
	Warning_state  int
	Warning_count  string
	Wave_code      string
	Task_code      string
	Product_code   string
	Product_name   string
	Space_code     string
	Space_number   string
	Space_halftype int
	User_code      string
	User_name      string
	User_logourl   string
}
type Out_OtherSpace struct {
	Code    int
	Message string
	Data    []Out_CarBatchDetailOne
}

func IsSpace_halftype(space_code string) int {
	sqlcmd := fmt.Sprintf(`select space_halftype from isale_space where space_code='%s'`, space_code)
	spacetype := 0
	if err := dborm.QueryRowx(sqlcmd).Scan(&spacetype); err != nil {
		spacetype = 0
	}
	return spacetype
}
func FindOtherSpace(w http.ResponseWriter, r *http.Request) {
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
			}

			InfoLog.Println(err) // 这里的err其实就是panic传入的内容，55
		} else {
			tx.Commit()

		}

	}()
	InfoLog.Println("==========================查询其他货位开始：", r.URL)
	defer InfoLog.Println("==========================查询其他货位结束")
	r.ParseForm()
	Wavedetailspace_code, found1 := r.Form["Wavedetailspace_code"]
	Number, found2 := r.Form["Number"]
	User_code, found3 := r.Form["User_code"]
	Remainnumber, found4 := r.Form["Remainnumber"]
	if !found1 || !found2 || !found3 {
		fmt.Fprint(w, "请勿非法访问")
		return
	}
	rtn := Out_OtherSpace{}
	var RemainnumberInt int64
	if !found4 {
		RemainnumberInt = 0
	} else {
		RemainnumberInt, err = strconv.ParseInt(Remainnumber[0], 0, 64)
		if err != nil {
			rtn.Code = 2
			rtn.Message = "" + err.Error()
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}
	}
	sqlcmd := ""
	//	rtn.Code = 11
	//	sqlcmd += fmt.Sprintf("4080485\n")
	//	sqlcmd += fmt.Sprintf("rrete")
	//	rtn.Message = fmt.Sprintf("58450\n")
	//	rtn.Message += fmt.Sprintf("54ereg\n%s", sqlcmd)
	//	InfoLog.Printf("%+v\n", rtn)
	//	bytes, _ := json.Marshal(rtn)
	//	fmt.Fprint(w, string(bytes))
	//	return
	NumberInt64, err := strconv.ParseInt(Number[0], 0, 64)
	if err != nil {
		rtn.Code = 2
		rtn.Message = "" + err.Error()
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}

	oneWaveDetailSpace := Tmp_WaveDetailSpaceFloat{}
	oneWaveDetail := Tmp_WaveDetail{}
	oneTask := Tmp_Task{}
	sqlcmd = fmt.Sprintf(`select 
	task_code               ,
task_type               ,
task_othercode          ,
task_count              ,
task_content            ,
task_state              ,
product_code            ,
product_name            ,
product_enname          ,
ifnull(product_barcode,"" ) product_barcode         ,
product_sku             ,
product_unit            ,
product_weight          ,
product_length          ,
product_width           ,
product_heigth          ,
product_length_sort     ,
product_width_sort      ,
product_heigth_sort     ,
product_bulk            ,
product_imgurl          ,
product_state           ,
product_groupstate      ,
product_batterystate    ,
user_code               ,
user_name               ,
user_logourl            
	from isale_task where task_othercode='%s'`, Wavedetailspace_code[0])

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
	if oneTask.Task_type == 9 {
		rtn.Code = 2
		rtn.Message = "该任务为加工任务，不存在缺货情况"
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	if oneTask.Task_type == 10 {
		rtn.Code = 2
		rtn.Message = "该任务为分销任务，不存在缺货情况"
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	sqlcmd = fmt.Sprintf(`select 
	wavedetailspace_code,
	wavedetail_code,
	wave_code,
	ifnull(wavedetail_count,"0")+0 wavedetail_count,
	ifnull(wavedetail_excount,"0")+0 wavedetail_excount,
	product_code,
	product_name,
	product_enname,
	ifnull(product_barcode,"" ) product_barcode         ,
	product_sku,
	product_unit,
	product_weight+0.0 product_weight,
	product_length+0 product_length,
	product_width+0 product_width,
	product_heigth+0 product_heigth,
	product_length_sort+0 product_length_sort,
	product_width_sort+0 product_width_sort,	
	product_heigth_sort+0 product_heigth_sort,
	product_bulk+0 product_bulk,
	product_imgurl,
	product_batterystate,
	product_groupstate,
	space_code,
	space_number,
	space_linenumber
	from isale_wavedetailspace where wavedetailspace_code='%s'`, Wavedetailspace_code[0])

	if err = tx.Get(&oneWaveDetailSpace, sqlcmd); err != nil {
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
	oneWaveDetailSpace.Product_imgurl = strings.Replace(oneWaveDetailSpace.Product_imgurl, `\`, `/`, -1)
	oneOperateUser := Tmp_UserSimple{}
	sqlcmd = fmt.Sprintf(`select user_code,user_name,user_logourl,user_mobilephone from isale_user where user_code='%s'`,
		User_code[0])

	if err = tx.Get(&oneOperateUser, sqlcmd); err != nil {
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

	sqlcmd = fmt.Sprintf(`select 
	wavedetail_code   ,
	wave_code         ,
	wave_type         ,
	wave_count+0     wave_count   ,
	ifnull(outorder_code,"" )  outorder_code  ,
	ifnull(product_code,"")   product_code  ,
	ifnull(product_name,"" )   product_name  ,
	addtime
	from isale_wavedetail where wavedetail_code='%s'`, oneWaveDetailSpace.Wavedetail_code)
	DebugLog.Println(sqlcmd)
	if err = tx.Get(&oneWaveDetail, sqlcmd); err != nil {
		rtn.Code = 2
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到波次信息"
		} else {
			rtn.Message = "查询异常"
		}
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return
	}
	spacetype := IsSpace_halftype(oneWaveDetailSpace.Space_code)

	spaceDetailList := []Tmp_SpaceDetailMore{}
	sqlcmd = fmt.Sprintf(`select 
	distinct
		sd.space_code,
		sd.space_count+0 space_count,
		ifnull(sd.space_excount,"0")+0 space_excount,
		sd.product_code,sd.product_name,sd.product_sku,s.space_number,s.space_linenumber		
		from isale_spacedetail sd inner join isale_space s on sd.space_code=s.space_code
		where sd.product_code='%s' and sd.space_halftype=%d and 
		(sd.space_count+0)-(ifnull(sd.space_excount,"0")+0)>0 and
		s.space_type<3 and s.space_state=1 and s.space_lockstate=1 and s.space_usestate=2 
		and s.space_code!='%s' order by s.space_linenumber`, oneWaveDetailSpace.Product_code, spacetype, oneWaveDetailSpace.Space_code)
	DebugLog.Println(sqlcmd)
	if err = tx.Select(&spaceDetailList, sqlcmd); err != nil {
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
	var UsableCount int64
	//	var NeedRecoverCount int64
	var ss int64
	InfoLog.Println("=======遍历货架上商品开始")
	for _, ele_tmp := range spaceDetailList {
		InfoLog.Println("货位号", ele_tmp.Space_number, "货架", ele_tmp.Space_code, "上商品数", ele_tmp.Space_count, ",预扣数量", ele_tmp.Space_excount, ",可用数量", ele_tmp.Space_count-ele_tmp.Space_excount)
		ss = ss + (ele_tmp.Space_count - ele_tmp.Space_excount)
	}
	InfoLog.Println("=======遍历货架上商品结束")
	for _, ele := range spaceDetailList {
		UsableCount = UsableCount + (ele.Space_count - ele.Space_excount)
	}

	NeedOutCount := oneWaveDetailSpace.Wavedetail_count - oneWaveDetailSpace.Wavedetail_excount
	InfoLog.Println("还需要下架的商品数量:", NeedOutCount)
	InfoLog.Println("已下架的商品数量:", oneWaveDetailSpace.Wavedetail_excount)
	InfoLog.Println("当前货架上剩余商品数量:", RemainnumberInt)
	InfoLog.Println("货架上总可以商品数量（除了当前货架）:", UsableCount)
	oneWarning := Tmp_Warning{}
	oneWarning.Warning_code = GenerateCode("453")
	oneWarning.Warning_name = fmt.Sprintf(`%s上%s异常`, oneWaveDetailSpace.Space_number, oneWaveDetailSpace.Product_name)
	oneWarning.Warning_count = fmt.Sprintf(`%d`, NeedOutCount)
	oneWarning.Wave_code = oneWaveDetailSpace.Wave_code
	oneWarning.Task_code = oneTask.Task_code
	oneWarning.Product_code = oneWaveDetailSpace.Product_code
	oneWarning.Product_name = oneWaveDetailSpace.Product_name
	oneWarning.Space_code = oneWaveDetailSpace.Space_code
	oneWarning.Space_number = oneWaveDetailSpace.Space_number
	oneWarning.Space_halftype = spacetype
	oneWarning.User_code = oneOperateUser.User_code
	oneWarning.User_logourl = oneOperateUser.User_logourl
	oneWarning.User_name = oneOperateUser.User_name
	sqlcmd = fmt.Sprintf(`insert into isale_warning (
	warning_code    ,
warning_name    ,
warning_count   ,
wave_code       ,
task_code       ,
product_code    ,
product_name    ,
space_code      ,
space_number    ,
space_halftype  ,
user_code       ,
user_name       ,
user_logourl    
) values(:warning_code    ,
:warning_name    ,
:warning_count   ,
:wave_code       ,
:task_code       ,
:product_code    ,
:product_name    ,
:space_code      ,
:space_number    ,
:space_halftype  ,
:user_code       ,
:user_name       ,
:user_logourl    )`)
	if _, err = tx.NamedExec(sqlcmd, oneWarning); err != nil {
		rtn.Code = 2
		if strings.Contains(err.Error(), "sql: no rows in result set") {
			rtn.Message = "没有查询到任务信息"
		} else {
			rtn.Message = "更新失败"
		}
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		panic("cysql")
	}
	sqlcmd_task := fmt.Sprintf(`insert into isale_task(
			task_code               ,
task_type               ,
task_othercode          ,
task_count              ,
task_content            ,
task_state              ,
product_code            ,
product_name            ,
product_enname          ,
product_barcode         ,
product_sku             ,
product_unit            ,
product_weight          ,
product_length          ,
product_width           ,
product_heigth          ,
product_length_sort     ,
product_width_sort      ,
product_heigth_sort     ,
product_bulk            ,
product_imgurl          ,
product_state           ,
product_groupstate      ,
product_batterystate    ,
user_code               ,
user_name               ,
user_logourl            
		) values(
			:task_code               ,
:task_type               ,
:task_othercode          ,
:task_count              ,
:task_content            ,
:task_state              ,
:product_code            ,
:product_name            ,
:product_enname          ,
:product_barcode         ,
:product_sku             ,
:product_unit            ,
:product_weight          ,
:product_length          ,
:product_width           ,
:product_heigth          ,
:product_length_sort     ,
:product_width_sort      ,
:product_heigth_sort     ,
:product_bulk            ,
:product_imgurl          ,
:product_state           ,
:product_groupstate      ,
:product_batterystate    ,
:user_code               ,
:user_name               ,
:user_logourl           

		)`)
	sqlcmd_wds := fmt.Sprintf(`insert into isale_wavedetailspace(
			wavedetailspace_code    ,
wavedetail_code         ,
wave_code               ,
wavedetail_count        ,
wavedetail_excount      ,
product_code            ,
product_name            ,
product_enname          ,
product_barcode         ,
product_sku             ,
product_unit            ,
product_weight          ,
product_length          ,
product_width           ,
product_heigth          ,
product_length_sort     ,
product_width_sort      ,
product_heigth_sort     ,
product_bulk            ,
product_imgurl          ,
product_state           ,
product_groupstate      ,
product_batterystate    ,
space_code              ,
space_number            ,
space_linenumber

		) values(
			:wavedetailspace_code    ,
:wavedetail_code         ,
:wave_code               ,
:wavedetail_count        ,
:wavedetail_excount      ,
:product_code            ,
:product_name            ,
:product_enname          ,
:product_barcode         ,
:product_sku             ,
:product_unit            ,
:product_weight          ,
:product_length          ,
:product_width           ,
:product_heigth          ,
:product_length_sort     ,
:product_width_sort      ,
:product_heigth_sort     ,
:product_bulk            ,
:product_imgurl          ,
:product_state           ,
:product_groupstate      ,
:product_batterystate    ,
:space_code              ,
:space_number            ,
:space_linenumber
		)`)
	if UsableCount+RemainnumberInt < NeedOutCount {
		//数量不够的时候

		DebugLog.Println("《《《《《《《《《《《《《《数量不够")

		if oneWaveDetail.Wave_type == 1 { //批间
			InfoLog.Println("当前任务为批间任务，任务号", oneWaveDetailSpace.Wavedetail_code)
			rtn.Code = 11
			waveDetailList := []Tmp_WaveDetail{}
			//var OtherTaskExcount int64     //已下架数量
			var OtherTaskCount int64       //总下架数量
			var OldLessOtheTaskCount int64 //以前缺货的任务下架数量
			//			sqlcmd = fmt.Sprintf(`SELECT
			//sum(ifnull(wds.wavedetail_excount,"")+0)
			//FROM
			//	isale_wavedetailspace wds
			//INNER JOIN isale_task t ON wds.wavedetailspace_code = t.task_othercode
			//where  wds.wavedetail_code='%s' and wds.product_code='%s'`,
			//				oneWaveDetailSpace.Wavedetail_code, oneWaveDetailSpace.Product_code)
			//			DebugLog.Println(sqlcmd)
			//			if err = tx.QueryRowx(sqlcmd).Scan(&OtherTaskExcount); err != nil {
			//				rtn.Code = 2
			//				rtn.Message = err.Error()
			//				bytes, _ := json.Marshal(rtn)
			//				fmt.Fprint(w, string(bytes))
			//				panic("cysql")
			//			}
			//			OtherTaskExcount -= oneWaveDetailSpace.Wavedetail_excount

			sqlcmd = fmt.Sprintf(`SELECT
ifnull(sum(ifnull(wds.wavedetail_count,"")+0),0)
FROM
	isale_wavedetailspace wds
INNER JOIN isale_task t ON wds.wavedetailspace_code = t.task_othercode
where  wds.wavedetail_code='%s' and wds.product_code='%s' and (task_state_less=0 or  isnull(task_state_less))`,
				oneWaveDetailSpace.Wavedetail_code, oneWaveDetailSpace.Product_code)
			DebugLog.Println(sqlcmd)
			if err = tx.QueryRowx(sqlcmd).Scan(&OtherTaskCount); err != nil {
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

			OtherTaskCount -= oneWaveDetailSpace.Wavedetail_count
			InfoLog.Println("其他下架正常任务数量:", OtherTaskCount)
			sqlcmd = fmt.Sprintf(`SELECT
ifnull(sum(ifnull(wds.wavedetail_excount,"")+0),0)
FROM
	isale_wavedetailspace wds
INNER JOIN isale_task t ON wds.wavedetailspace_code = t.task_othercode
where  wds.wavedetail_code='%s' and wds.product_code='%s' and task_state_less=2 `,
				oneWaveDetailSpace.Wavedetail_code, oneWaveDetailSpace.Product_code)
			DebugLog.Println(sqlcmd)
			if err = tx.QueryRowx(sqlcmd).Scan(&OldLessOtheTaskCount); err != nil {
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
			InfoLog.Println("其他下架时进行了缺货操作的任务已下架数量:", OldLessOtheTaskCount)
			OtherTaskCount += OldLessOtheTaskCount
			/////根据波次信息查询到波次详细信息，以及出库单,按照出库单等级顺序排列
			sqlcmd = fmt.Sprintf(`SELECT
	wd.wavedetail_code,
	wd.wave_code,
	product_count+ 0 wave_count,
	oo.outorder_code,
	wd.product_code
FROM
	isale_wavedetail wd
INNER JOIN isale_outorder oo ON wd.wave_code = oo.wave_code
inner join isale_outorderdetail od on oo.outorder_code=od.outorder_code
			where wd.wave_code='%s' and wd.wave_type=1 and wd.product_code='%s' 
			order by oo.outorder_level desc,oo.outorder_sendtime,oo.outorder_downtime,oo.addtime`,
				oneWaveDetail.Wave_code, oneWaveDetail.Product_code)
			DebugLog.Println(sqlcmd)
			if err = tx.Select(&waveDetailList, sqlcmd); err != nil {
				rtn.Code = 2
				if strings.Contains(err.Error(), "sql: no rows in result set") {
					rtn.Message = "没有查询到波次信息"
				} else {
					rtn.Message = "查询异常"
				}
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}

			ALLUsableCount := RemainnumberInt + oneWaveDetailSpace.Wavedetail_excount + OtherTaskCount
			InfoLog.Println("当前货位已下架数量和同一个波次下的其他任务总下架数量", ALLUsableCount)
			//InfoLog.Println("当前货位已下架数量和同一个波次下的其他总下架数量", RemainnumberInt+oneWaveDetailSpace.Wavedetail_excount+OtherTaskCount)
			ALLUsableCount_tmp := ALLUsableCount //当前整个波次循环后的数量
			////把能出的出库单出了，并且把等级改为3

			var PushCount int64
			for _, ele := range waveDetailList {
				InfoLog.Printf("同一个波次下可用数量%d\n", ALLUsableCount_tmp)
				InfoLog.Printf("%s订单的商品数 %d\n", ele.Outorder_code, ele.Wave_count)
				if ALLUsableCount_tmp >= ele.Wave_count {
					ALLUsableCount_tmp -= ele.Wave_count
					sqlcmd = fmt.Sprintf(`update isale_outorder set 
					outorder_downstate=3 and outorder_level=3 
					where  outorder_code='%s'`, ele.Outorder_code)
					DebugLog.Println(sqlcmd)
					if _, err = tx.Exec(sqlcmd); err != nil {
						rtn.Code = 2
						if strings.Contains(err.Error(), "sql: no rows in result set") {
							rtn.Message = "没有查询到任务信息"
						} else {
							rtn.Message = "更新失败"
						}
						bytes, _ := json.Marshal(rtn)
						fmt.Fprint(w, string(bytes))
						panic("cysql")
					}
				} else {
					InfoLog.Println("===========查找库存匹配订单并推荐任务", UsableCount)
					if ele.Wave_count <= UsableCount+ALLUsableCount_tmp { //库存可用数量大于订单数量
						rtn.Code = 1
						rtn.Message = ""
						var PushCountTmp int64
						InfoLog.Println("查找库存匹配订单满足推荐数量,额外可用数量", UsableCount)

						InfoLog.Println("ele.Wave_count", ele.Wave_count)
						//InfoLog.Println("OtherTaskCount ", OtherTaskCount)
						InfoLog.Println("ALLUsableCount_tmp", ALLUsableCount_tmp)
						//						if ele.Wave_count <= ALLUsableCount_tmp {
						//							OtherTaskCount += ALLUsableCount_tmp
						//							ALLUsableCount_tmp = 0
						//							InfoLog.Printf("当前订单%s数量%d小于等于同一波次下的可用预扣数量（OtherTaskExcount）不推荐", ele.Outorder_code, ele.Wave_count)
						//							OtherTaskCount -= ele.Wave_count
						//							continue
						//						}
						UsableCount += ALLUsableCount_tmp

						PushCountTmp = ele.Wave_count - ALLUsableCount_tmp
						ALLUsableCount_tmp = 0
						UsableCount -= PushCountTmp
						//////遍历货位，直到满足
						InfoLog.Println("当前订单出库商品数量：", PushCountTmp)

						PushCount += PushCountTmp
						InfoLog.Println("库存数量能满足当前订单，向其推荐商品数量：", PushCountTmp)
					} else {
						InfoLog.Println("货位能用的数量小于订单数量，且当前货位数量：", UsableCount)
						sqlcmd = fmt.Sprintf(`update isale_outorder set  
						outorder_level=3,wave_code = null,
						wave_user_code = null,task_user_code = null,
						task_user_name = null,packtable_code = null where outorder_code='%s'`, ele.Outorder_code)
						if _, err = tx.Exec(sqlcmd); err != nil {
							rtn.Code = 2
							if strings.Contains(err.Error(), "sql: no rows in result set") {
								rtn.Message = "没有查询到任务信息"
							} else {
								rtn.Message = "更新失败"
							}
							bytes, _ := json.Marshal(rtn)
							fmt.Fprint(w, string(bytes))
							panic("cysql")
						}

					}
					sqlcmd = fmt.Sprintf(`update isale_outorder set 
					outorder_downstate=1
					where  outorder_code='%s'`, ele.Outorder_code)
					DebugLog.Println(sqlcmd)
					if _, err = tx.Exec(sqlcmd); err != nil {
						rtn.Code = 2
						if strings.Contains(err.Error(), "sql: no rows in result set") {
							rtn.Message = "没有查询到任务信息"
						} else {
							rtn.Message = "更新失败"
						}
						bytes, _ := json.Marshal(rtn)
						fmt.Fprint(w, string(bytes))
						panic("cysql")
					}
				}
			}
			SuggestStr := ""
			if PushCount > 0 {
				oneRtn := Out_CarBatchDetailOne{}

				oneRtn.Number = NumberInt64
				oneRtn.Product_code = oneWaveDetailSpace.Product_code
				oneRtn.Product_name = oneWaveDetailSpace.Product_name
				oneRtn.Product_sku = oneWaveDetailSpace.Product_sku
				oneRtn.Wavedetail_excount = 0
				rtn.Code = 1
				for _, ele := range spaceDetailList {
					var SubCount int64
					if ele.Space_count-ele.Space_excount >= PushCount {

						SubCount = PushCount
						InfoLog.Printf("部分货位%s(%s)推荐%d个", ele.Space_number, ele.Space_code, SubCount)

						PushCount = 0
					} else {
						PushCount -= (ele.Space_count - ele.Space_excount)
						SubCount = ele.Space_count - ele.Space_excount
						InfoLog.Printf("全部货位%s(%s)推荐%d个", ele.Space_number, ele.Space_code, SubCount)

					}
					SuggestStr += fmt.Sprintf("\n货位:%s,数量%d", ele.Space_number, SubCount)
					oneRtn.ID = GenerateCode("222")
					oneRtn.Wavedetailspace_code = GenerateCode("602")
					oneRtn.Space_code = ele.Space_code
					oneRtn.Space_linenumber = ele.Space_linenumber
					oneRtn.Space_number = ele.Space_number
					oneRtn.Wavedetail_count = SubCount
					rtn.Data = append(rtn.Data, oneRtn)

					////添加task开始
					oneTask_Copy := oneTask
					oneTask_Copy.Task_code = GenerateCode("700")
					oneTask_Copy.Task_othercode = oneRtn.Wavedetailspace_code
					oneTask_Copy.Task_count = fmt.Sprintf(`%d`, oneRtn.Wavedetail_count)
					oneTask_Copy.Task_content = fmt.Sprintf(`%s出库%d%s`, oneRtn.Product_name, oneRtn.Wavedetail_count, oneWaveDetailSpace.Product_unit)
					oneTask_Copy.Task_state = 2
					if _, err = tx.NamedExec(sqlcmd_task, oneTask_Copy); err != nil {
						rtn.Code = 2
						if strings.Contains(err.Error(), "sql: no rows in result set") {
							rtn.Message = "没有查询到货位信息"
						} else {
							rtn.Message = "更新失败"
						}
						DebugLog.Println(err.Error())

						bytes, _ := json.Marshal(rtn)
						fmt.Fprint(w, string(bytes))
						panic("cysql")
					}
					////添加task结束
					////添加wavedetailspace开始
					oneWaveDetailSpace_Copy := Tmp_WaveDetailSpace{}

					oneWaveDetailSpace_Copy.Wavedetailspace_code = oneRtn.Wavedetailspace_code
					oneWaveDetailSpace_Copy.Wavedetail_code = oneWaveDetailSpace.Wavedetail_code
					oneWaveDetailSpace_Copy.Wave_code = oneWaveDetailSpace.Wave_code
					oneWaveDetailSpace_Copy.Wavedetail_excount = "0"
					oneWaveDetailSpace_Copy.Product_code = oneWaveDetailSpace.Product_code
					oneWaveDetailSpace_Copy.Product_name = oneWaveDetailSpace.Product_name
					oneWaveDetailSpace_Copy.Product_enname = oneWaveDetailSpace.Product_enname
					oneWaveDetailSpace_Copy.Product_barcode = oneWaveDetailSpace.Product_barcode
					oneWaveDetailSpace_Copy.Product_sku = oneWaveDetailSpace.Product_sku
					oneWaveDetailSpace_Copy.Product_unit = oneWaveDetailSpace.Product_unit
					oneWaveDetailSpace_Copy.Product_weight = fmt.Sprintf(`%.2f`, oneWaveDetailSpace.Product_weight)
					oneWaveDetailSpace_Copy.Product_length = fmt.Sprintf(`%d`, oneWaveDetailSpace.Product_length)
					oneWaveDetailSpace_Copy.Product_width = fmt.Sprintf(`%d`, oneWaveDetailSpace.Product_width)
					oneWaveDetailSpace_Copy.Product_heigth = fmt.Sprintf(`%d`, oneWaveDetailSpace.Product_heigth)
					oneWaveDetailSpace_Copy.Product_length_sort = fmt.Sprintf(`%d`, oneWaveDetailSpace.Product_length_sort)
					oneWaveDetailSpace_Copy.Product_width_sort = fmt.Sprintf(`%d`, oneWaveDetailSpace.Product_width_sort)
					oneWaveDetailSpace_Copy.Product_heigth_sort = fmt.Sprintf(`%d`, oneWaveDetailSpace.Product_heigth_sort)
					oneWaveDetailSpace_Copy.Product_bulk = fmt.Sprintf(`%d`, oneWaveDetailSpace.Product_bulk)
					oneWaveDetailSpace_Copy.Product_imgurl = oneWaveDetailSpace.Product_imgurl
					oneWaveDetailSpace_Copy.Product_state = oneWaveDetailSpace.Product_state
					oneWaveDetailSpace_Copy.Product_groupstate = oneWaveDetailSpace.Product_groupstate
					oneWaveDetailSpace_Copy.Product_batterystate = oneWaveDetailSpace.Product_batterystate
					oneWaveDetailSpace_Copy.Space_code = ele.Space_code
					oneWaveDetailSpace_Copy.Space_number = ele.Space_number
					oneWaveDetailSpace_Copy.Space_linenumber = ele.Space_linenumber
					oneWaveDetailSpace_Copy.Wavedetail_count = fmt.Sprintf(`%d`, oneRtn.Wavedetail_count)
					if _, err = tx.NamedExec(sqlcmd_wds, oneWaveDetailSpace_Copy); err != nil {
						rtn.Code = 2
						if strings.Contains(err.Error(), "sql: no rows in result set") {
							rtn.Message = "没有查询到任务信息"
						} else {
							rtn.Message = "更新"
						}

						bytes, _ := json.Marshal(rtn)
						fmt.Fprint(w, string(bytes))
						panic("cysql")
					}
					////添加wavedetailspace结束

					////更新spacedetail开始
					sqlcmd = fmt.Sprintf(`update isale_spacedetail set space_excount=(ifnull(space_excount,"")+0+%d)
				where space_code='%s' and product_code='%s'`, SubCount, ele.Space_code, ele.Product_code)
					if _, err = tx.Exec(sqlcmd); err != nil {
						rtn.Code = 2
						if strings.Contains(err.Error(), "sql: no rows in result set") {
							rtn.Message = "没有查询到任务信息"
						} else {
							rtn.Message = "更新失败"
						}

						DebugLog.Println(err.Error())

						bytes, _ := json.Marshal(rtn)
						fmt.Fprint(w, string(bytes))
						panic("cysql")
					}
					////更新spacedetail结束
					if PushCount == 0 {
						break
					}
				}
			}

			////更新当前任务状态为已完成
			sqlcmd = fmt.Sprintf(`update isale_task set task_state=3 , task_state_less=2 
			where user_code='%s' and task_othercode ='%s'
			  `, oneOperateUser.User_code, oneWaveDetailSpace.Wavedetailspace_code)
			DebugLog.Println(sqlcmd)
			if _, err = tx.Exec(sqlcmd); err != nil {
				rtn.Code = 2
				if strings.Contains(err.Error(), "sql: no rows in result set") {
					rtn.Message = "没有查询到任务信息"
				} else {
					rtn.Message = "更新失败"
				}
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}
			//查询之前下架的日志，还原货架数量
			spaceDetailLogList := []Tmp_SpaceDetaillogFloat{}
			sqlcmd = fmt.Sprintf(`select space_code, space_halftype,space_count+0 space_countint,
			 space_count,product_code,product_name,product_enname,ifnull(product_barcode,"" ) product_barcode,product_sku,
			product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,
			product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,
			product_batterystate,user_code,user_name,user_mobilephone,
		 product_bulk+0 product_bulkint,task_code,task_othercode,addtime
			from isale_spacedetaillog sdl  where task_othercode in( select task_othercode from isale_wavedetailspace where wavedetail_code='%s' )
			 and sdl.user_code='%s' order by space_count desc,addtime desc`, oneWaveDetailSpace.Wavedetail_code, oneTask.User_code)
			DebugLog.Println(sqlcmd)
			if err = tx.Select(&spaceDetailLogList, sqlcmd); err != nil {
				rtn.Code = 2
				if strings.Contains(err.Error(), "sql: no rows in result set") {
					rtn.Message = "没有查询到任务信息"
				} else {
					rtn.Message = "更新失败"
				}
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}

			//前面是满足了outorder的单子，剩下不满足的就还原货架上去
			NeedRecoverTotalCount := ALLUsableCount_tmp /////总共需要恢复的数量
			InfoLog.Println("恢复的数量(包括未下架的任务)", NeedRecoverTotalCount)

			NeedRecoverTotalCount_tmp := NeedRecoverTotalCount
			resultMessage := ""
			BreakFlag := false
			for _, ele := range spaceDetailLogList {
				if NeedRecoverTotalCount_tmp == 0 {
					break
				}
				if BreakFlag == true {
					break
				}
				var OneRecoverCount int64 /////日志中单次需要恢复的数量
				if NeedRecoverTotalCount_tmp >= ele.Space_countint {
					///如果当前删除日志的商品数量大于等于当前日志的数量，则删除
					sqlcmd = fmt.Sprintf(`delete from isale_spacedetaillog 
						where space_code='%s' and task_code='%s' and addtime='%s' `,
						ele.Space_code, ele.Task_code, ele.Addtime)
					DebugLog.Println(sqlcmd)
					if _, err = tx.Exec(sqlcmd); err != nil {
						rtn.Code = 2
						if strings.Contains(err.Error(), "sql: no rows in result set") {
							rtn.Message = "没有查询到任务信息"
						} else {
							rtn.Message = "更新失败"
						}
						bytes, _ := json.Marshal(rtn)
						fmt.Fprint(w, string(bytes))
						panic("cysql")
					}

					NeedRecoverTotalCount_tmp -= ele.Space_countint
					OneRecoverCount = ele.Space_countint
				} else if NeedRecoverTotalCount_tmp < ele.Space_countint {
					///如果当前删除日志的商品数量下于当前日志的数量，则更新
					OneRecoverCount = NeedRecoverTotalCount_tmp
					//RecoverCount = ele.Space_countint

					/////当前货位上的数量够，且需要下架的数量大于0
					sqlcmd = fmt.Sprintf(`update isale_spacedetaillog 
						set space_count=(space_count+0-%d)
						where space_code='%s' and task_code='%s' and addtime='%s' `,
						OneRecoverCount, ele.Space_code, ele.Task_code, ele.Addtime)
					DebugLog.Println(sqlcmd)
					if _, err = tx.Exec(sqlcmd); err != nil {
						rtn.Code = 2
						if strings.Contains(err.Error(), "sql: no rows in result set") {
							rtn.Message = "没有查询到任务信息"
						} else {
							rtn.Message = "更新失败"
						}
						bytes, _ := json.Marshal(rtn)
						fmt.Fprint(w, string(bytes))
						panic("cysql")
					}

					NeedRecoverTotalCount_tmp = 0
					BreakFlag = true
				}
				resultMessage += fmt.Sprintf("\n货位%s,数量:%d ", GetSpaceNameFrom(ele.Space_code), OneRecoverCount)
				//查询货位详细信息
				sqlcmd = fmt.Sprintf(`select count(*) from isale_spacedetail 
					where space_code='%s' and product_code='%s'`, ele.Space_code, ele.Product_code)
				count := 0
				DebugLog.Println(sqlcmd)
				if err = tx.QueryRowx(sqlcmd).Scan(&count); err != nil {
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
				if count == 0 {
					//查询货位详细信息，如果没有了就新建
					sqlcmd = fmt.Sprintf(`insert into isale_spacedetail(
	space_code             ,
space_halftype         ,
space_count            ,
space_excount          ,
product_code           ,
product_name           ,
product_enname         ,
product_barcode        ,
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
product_batterystate  ,
user_code,
user_name,
user_mobilephone
) values(:space_code    ,
:space_halftype         ,
:space_count            ,
'0',
:product_code           ,
:product_name           ,
:product_enname         ,
:product_barcode        ,
:product_sku            ,
:product_unit           ,
:product_weight         ,
:product_length         ,
:product_width          ,
:product_heigth         ,
:product_length_sort    ,
:product_width_sort     ,
:product_heigth_sort    ,
:product_bulk           ,
:product_imgurl         ,
:product_state          ,
:product_groupstate     ,
:product_batterystate ,
:user_code,
:user_name,
:user_mobilephone )`)
					DebugLog.Println(sqlcmd)
					if _, err = tx.NamedExec(sqlcmd, ele); err != nil {
						rtn.Code = 2
						if strings.Contains(err.Error(), "sql: no rows in result set") {
							rtn.Message = "没有查询到任务信息"
						} else {
							rtn.Message = "更新失败"
						}
						bytes, _ := json.Marshal(rtn)
						fmt.Fprint(w, string(bytes))
						panic("cysql")
					}
				} else {
					//查询货位详细信息，如果还有就更新
					sqlcmd = fmt.Sprintf(`UPDATE isale_spacedetail
						SET space_count = (
							CONVERT (
								(space_count + 0 + % d),
								DECIMAL (11, 0)
							)
						)
						WHERE
							space_code = '%s'
						AND product_code = '%s'`, OneRecoverCount, ele.Space_code, ele.Product_code)
					DebugLog.Println(sqlcmd)
					if _, err = tx.Exec(sqlcmd); err != nil {
						rtn.Code = 2
						if strings.Contains(err.Error(), "sql: no rows in result set") {
							rtn.Message = "没有查询到任务信息"
						} else {
							rtn.Message = "更新失败"
						}
						bytes, _ := json.Marshal(rtn)
						fmt.Fprint(w, string(bytes))
						panic("cysql")
					}
				}
				oneSpace := Tmp_Space{}
				//查询货位详细信息，如果更新货位体积
				sqlcmd = fmt.Sprintf(`select 
	space_code          ,
	space_bulk			,
	space_usedbulk      ,
	space_leftbulk      ,
	ifnull(space_upbulk,"0")     space_upbulk   ,	
	space_type          ,
	space_state         ,
	space_usestate      
  
	from isale_space where space_code='%s'`, ele.Space_code)
				DebugLog.Println(sqlcmd)
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
				space_usedbulkInt, err := strconv.ParseInt(oneSpace.Space_usedbulk, 0, 64)
				if err != nil {
					rtn.Code = 2
					rtn.Message = "货位已使用体积:" + err.Error()
					bytes, _ := json.Marshal(rtn)
					fmt.Fprint(w, string(bytes))
					panic("cysql")
				}
				space_leftbulkInt, err := strconv.ParseInt(oneSpace.Space_leftbulk, 0, 64)
				if err != nil {
					rtn.Code = 2
					rtn.Message = "货位剩余使用体积:" + err.Error()
					bytes, _ := json.Marshal(rtn)
					fmt.Fprint(w, string(bytes))
					panic("cysql")
				}
				space_bulkInt, err := strconv.ParseInt(oneSpace.Space_bulk, 0, 64)
				if err != nil {
					rtn.Code = 2
					rtn.Message = "货位总体积:" + err.Error()
					bytes, _ := json.Marshal(rtn)
					fmt.Fprint(w, string(bytes))
					panic("cysql")
				}
				DebugLog.Println(ele.Product_bulkint * OneRecoverCount)
				DebugLog.Println(space_usedbulkInt)

				if OneRecoverCount*ele.Product_bulkint+space_usedbulkInt > space_bulkInt {
					space_usedbulkInt += (OneRecoverCount * ele.Product_bulkint)
					space_leftbulkInt = 0
					oneSpace.Space_usedbulk = fmt.Sprintf("%d", space_usedbulkInt)
					oneSpace.Space_leftbulk = fmt.Sprintf("%d", space_leftbulkInt)
				} else {
					space_usedbulkInt += (OneRecoverCount * ele.Product_bulkint)
					space_leftbulkInt -= (OneRecoverCount * ele.Product_bulkint)
					oneSpace.Space_usedbulk = fmt.Sprintf("%d", space_usedbulkInt)
					oneSpace.Space_leftbulk = fmt.Sprintf("%d", space_leftbulkInt)

				}
				oneSpace.Space_usestate = 2
				sqlcmd = fmt.Sprintf(`update isale_space set 
	space_leftbulk=:space_leftbulk,space_usedbulk=:space_usedbulk,
	space_usestate=:space_usestate where space_code=:space_code	`)
				DebugLog.Println(sqlcmd)
				_, err = tx.NamedExec(sqlcmd, oneSpace)
				if err != nil {
					rtn.Code = 2
					rtn.Message = "更新货位体积:" + err.Error()
					bytes, _ := json.Marshal(rtn)
					fmt.Fprint(w, string(bytes))
					panic("cysql")
				}
				sqlcmd = fmt.Sprintf(`update isale_wavedetailspace set 
	wavedetail_excount=(wavedetail_excount+0-%d) where wavedetailspace_code='%s'	`, OneRecoverCount, ele.Task_othercode)
				DebugLog.Println(sqlcmd)
				_, err = tx.Exec(sqlcmd)
				if err != nil {
					rtn.Code = 2
					rtn.Message = "还原wavedetailspace错误:" + err.Error()
					bytes, _ := json.Marshal(rtn)
					fmt.Fprint(w, string(bytes))
					panic("cysql")
				}
			}

			NeedRecoverTotalCount -= NeedRecoverTotalCount_tmp
			InfoLog.Println("实际还原数量:", NeedRecoverTotalCount)
			if len(rtn.Data) > 0 {
				rtn.Code = 11
			} else {
				rtn.Code = 11
			}
			if NeedRecoverTotalCount == 0 {

				if len(SuggestStr) > 3 {
					//SuggestStr = strings.Replace(SuggestStr, "\n", "\\n", -1)
					rtn.Message += fmt.Sprintf("已为您找到新的货位,列表如下:" + SuggestStr)
				} else {
					rtn.Message += fmt.Sprintf("当前库存不足")
				}
			} else {
				rtn.Message += fmt.Sprintf("当前库存不足,请还原已拿取的货品数量%d%s\n列表如下:", NeedRecoverTotalCount, oneWaveDetailSpace.Product_unit)
				rtn.Message += resultMessage
			}

			//rtn.Message = fmt.Sprintf(`当前库存能满足的订单总数量：%d,\n请将还原的数量(%d)放回原货位,列表如下：\n%s`,
			//	ALLUsableCount-ALLUsableCount_tmp, NeedRecoverTotalCount, resultMessage)
			InfoLog.Printf("%+v\n", rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			return
		} else { //非批间

			///////查询当前波次明细下的具体拣货任务
			wavedetailspaceList := []Tmp_WaveDetailSpaceFloat{}
			sqlcmd = fmt.Sprintf(`select wds.wavedetailspace_code ,
			ifnull(wds.wavedetail_excount,"0")+0 wavedetail_excount,
			wds.wavedetail_count+0 wavedetail_count,wds.product_code ,
			wds.space_code,wds.product_bulk,wds.space_number,wds.product_name
			from isale_wavedetailspace wds inner join isale_task t on wds.wavedetailspace_code=t.task_othercode 
			where wds.wavedetail_code='%s' and t.user_code='%s' and ifnull(wds.wavedetail_excount,"0")+0>0`, oneWaveDetailSpace.Wavedetail_code, User_code[0])
			DebugLog.Println(sqlcmd)
			if err = tx.Select(&wavedetailspaceList, sqlcmd); err != nil {
				rtn.Code = 2
				if strings.Contains(err.Error(), "sql: no rows in result set") {
					rtn.Message = "没有查询到波次信息"
				} else {
					rtn.Message = "查询异常"
				}
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}

			///////当前波次明细下的具体拣货任务全部变成已完成状态，比把拣货任务变为0
			rtn.Message += fmt.Sprintf("该订单已无法满足当日发货条件，\n请将该订单已拿取的商品还原到原货位。\n还原列表：")
			for _, ele := range wavedetailspaceList {
				rtn.Message += fmt.Sprintf("\n货位:%s,货品:%s,数量:%d", ele.Space_number, ele.Product_name, ele.Wavedetail_excount)
				sqlcmd = fmt.Sprintf(`update isale_task set task_state=3 where task_othercode='%s' `, ele.Wavedetailspace_code)
				DebugLog.Println(sqlcmd)
				if _, err = tx.Exec(sqlcmd); err != nil {
					rtn.Code = 2
					if strings.Contains(err.Error(), "sql: no rows in result set") {
						rtn.Message = "没有查询到货位信息"
					} else {
						rtn.Message = "更新失败"
					}
					bytes, _ := json.Marshal(rtn)
					fmt.Fprint(w, string(bytes))
					panic("cysql")
				}
				sqlcmd = fmt.Sprintf(`update isale_wavedetailspace set wavedetail_excount='0' where wavedetailspace_code='%s' `, ele.Wavedetailspace_code)
				DebugLog.Println(sqlcmd)
				if _, err = tx.Exec(sqlcmd); err != nil {
					rtn.Code = 2
					if strings.Contains(err.Error(), "sql: no rows in result set") {
						rtn.Message = "没有查询到货位信息"
					} else {
						rtn.Message = "更新失败"
					}
					bytes, _ := json.Marshal(rtn)
					fmt.Fprint(w, string(bytes))
					panic("cysql")
				}
				///////当前波次明细下的具体拣货任务 执行过拣货操作，则把货位还原回货位上
				if ele.Wavedetail_excount > 0 {

					sqlcmd = fmt.Sprintf(`select count(*) from isale_spacedetail 
					where space_code='%s' and product_code='%s' `, ele.Space_code, ele.Product_code)
					count := 0
					DebugLog.Println(sqlcmd)
					if err = tx.QueryRowx(sqlcmd).Scan(&count); err != nil {
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
					//////如果之前货位上的商品全部取走，则新建insert
					if count == 0 {
						oneSpacedetaillog := Tmp_SpaceDetaillog{}
						sqlcmd = fmt.Sprintf(`select 
						space_code             ,
						space_halftype         ,
						space_count            ,
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
						product_batterystate  ,
						user_code,
						user_name,
						user_mobilephone
						from isale_spacedetaillog where task_othercode='%s'`, ele.Wavedetailspace_code)
						DebugLog.Println(sqlcmd)
						if err = tx.Get(&oneSpacedetaillog, sqlcmd); err != nil {
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

						sqlcmd = fmt.Sprintf(`insert into isale_spacedetail(
						space_code             ,
						space_halftype         ,
						space_count            ,
						space_excount          ,
						product_code           ,
						product_name           ,
						product_enname         ,
						product_barcode        ,
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
						product_batterystate  ,
						user_code,
						user_name,
						user_mobilephone
						) values(:space_code    ,
						:space_halftype         ,
						:space_count            ,
						'0',
						:product_code           ,
						:product_name           ,
						:product_enname         ,
						:product_barcode        ,
						:product_sku            ,
						:product_unit           ,
						:product_weight         ,
						:product_length         ,
						:product_width          ,
						:product_heigth         ,
						:product_length_sort    ,
						:product_width_sort     ,
						:product_heigth_sort    ,
						:product_bulk           ,
						:product_imgurl         ,
						:product_state          ,
						:product_groupstate     ,
						:product_batterystate ,
						:user_code,
						:user_name,
						:user_mobilephone )`)
						DebugLog.Println("添加货位详细信息")
						if _, err = tx.NamedExec(sqlcmd, oneSpacedetaillog); err != nil {
							rtn.Code = 2
							if strings.Contains(err.Error(), "sql: no rows in result set") {
								rtn.Message = "没有查询到货位信息"
							} else {
								rtn.Message = "更新失败"
							}
							bytes, _ := json.Marshal(rtn)
							fmt.Fprint(w, string(bytes))
							panic("cysql")
						}
					} else {
						//////如果之前货位上的商品全部取走，则添加对应数量update
						sqlcmd = fmt.Sprintf(`UPDATE isale_spacedetail
						SET space_count = (
							CONVERT (
								(space_count + 0 + % d),
								DECIMAL (11, 0)
							)
						)
						WHERE
							space_code = '%s'
						AND product_code = '%s'`, ele.Wavedetail_excount, ele.Space_code, ele.Product_code)
						DebugLog.Println(sqlcmd)
						if _, err = tx.Exec(sqlcmd); err != nil {
							rtn.Code = 2
							if strings.Contains(err.Error(), "sql: no rows in result set") {
								rtn.Message = "没有查询到货位信息"
							} else {
								rtn.Message = "更新失败"
							}
							bytes, _ := json.Marshal(rtn)
							fmt.Fprint(w, string(bytes))
							panic("cysql")
						}
					}
					oneSpace := Tmp_Space{}
					////同时更新货位的可用体积
					sqlcmd = fmt.Sprintf(`select 
	space_code          ,
	space_bulk			,
	space_usedbulk      ,
	space_leftbulk      ,
	ifnull(space_upbulk,"0")     space_upbulk   ,	
	space_type          ,
	space_state         ,
	space_usestate      
  
	from isale_space where space_code='%s'`, ele.Space_code)
					DebugLog.Println(sqlcmd)
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
					space_usedbulkInt, err := strconv.ParseInt(oneSpace.Space_usedbulk, 0, 64)
					if err != nil {
						rtn.Code = 2
						rtn.Message = "货位已使用体积:" + err.Error()
						bytes, _ := json.Marshal(rtn)
						fmt.Fprint(w, string(bytes))
						panic("cysql")
					}
					space_leftbulkInt, err := strconv.ParseInt(oneSpace.Space_leftbulk, 0, 64)
					if err != nil {
						rtn.Code = 2
						rtn.Message = "货位剩余使用体积:" + err.Error()
						bytes, _ := json.Marshal(rtn)
						fmt.Fprint(w, string(bytes))
						panic("cysql")
					}
					space_bulkInt, err := strconv.ParseInt(oneSpace.Space_bulk, 0, 64)
					if err != nil {
						rtn.Code = 2
						rtn.Message = "货位总体积:" + err.Error()
						bytes, _ := json.Marshal(rtn)
						fmt.Fprint(w, string(bytes))
						panic("cysql")
					}
					DebugLog.Println(ele.Product_bulk * ele.Wavedetail_excount)
					DebugLog.Println(space_usedbulkInt)

					if ele.Wavedetail_excount*ele.Product_bulk+space_usedbulkInt > space_bulkInt {
						space_usedbulkInt += (ele.Wavedetail_excount * ele.Product_bulk)
						space_leftbulkInt = 0
						oneSpace.Space_usedbulk = fmt.Sprintf("%d", space_usedbulkInt)
						oneSpace.Space_leftbulk = fmt.Sprintf("%d", space_leftbulkInt)
					} else {
						space_usedbulkInt += (ele.Wavedetail_excount * ele.Product_bulk)
						space_leftbulkInt -= (ele.Wavedetail_excount * ele.Product_bulk)
						oneSpace.Space_usedbulk = fmt.Sprintf("%d", space_usedbulkInt)
						oneSpace.Space_leftbulk = fmt.Sprintf("%d", space_leftbulkInt)

					}
					oneSpace.Space_usestate = 2
					sqlcmd = fmt.Sprintf(`update isale_space set 
	space_leftbulk=:space_leftbulk,space_usedbulk=:space_usedbulk,
	space_usestate=:space_usestate where space_code=:space_code	`)
					DebugLog.Println(sqlcmd)
					_, err = tx.NamedExec(sqlcmd, oneSpace)
					if err != nil {
						rtn.Code = 2
						rtn.Message = "更新货位体积:" + err.Error()
						DebugLog.Println(sqlcmd)
						bytes, _ := json.Marshal(rtn)
						fmt.Fprint(w, string(bytes))
						panic("cysql")
					}
					////删除掉操作的日志信息
					sqlcmd = fmt.Sprintf(`delete from  isale_spacedetaillog  where task_othercode='%s' `, ele.Wavedetailspace_code)
					DebugLog.Println(sqlcmd)
					if _, err = tx.Exec(sqlcmd); err != nil {
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
				}

			}
			outorder_code := ""
			sqlcmd = fmt.Sprintf(`SELECT  wo.outorder_code 
			from isale_waveoutorder wo  WHERE wo.wavedetail_code='%s'`, oneWaveDetailSpace.Wavedetail_code)
			if err = tx.QueryRowx(sqlcmd).Scan(&outorder_code); err != nil {
				rtn.Code = 2
				if strings.Contains(err.Error(), "sql: no rows in result set") {
					rtn.Message = "没有查询到波次信息"
				} else {
					rtn.Message = "查询异常"
				}
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}
			sqlcmd = fmt.Sprintf(`update  isale_outorder set  
			outorder_level=3,wave_code = null,wave_user_code = null,task_user_code = null,task_user_name = null,packtable_code = null
 WHERE outorder_code='%s'`, outorder_code)
			if _, err = tx.Exec(sqlcmd); err != nil {
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
			rtn.Code = 12
			//rtn.Message += "\n"
			InfoLog.Printf("%+v\n", rtn)
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			return
		}

	} else {
		//数量够的时候
		sqlcmd = fmt.Sprintf(`update isale_task set task_state=3  , task_state_less=2 where task_code='%s'`, oneTask.Task_code)
		if _, err = tx.NamedExec(sqlcmd, oneWarning); err != nil {
			rtn.Code = 2
			if strings.Contains(err.Error(), "sql: no rows in result set") {
				rtn.Message = "没有查询到货位信息"
			} else {
				rtn.Message = "更新失败"
			}
			bytes, _ := json.Marshal(rtn)
			fmt.Fprint(w, string(bytes))
			panic("cysql")
		}

		NeedOutCount -= RemainnumberInt
		rtn.Code = 11
		rtn.Message = "已推荐货位:\n"
		oneWaveDetailSpace_Copy := Tmp_WaveDetailSpace{}

		oneWaveDetailSpace_Copy.Wavedetail_code = oneWaveDetailSpace.Wavedetail_code
		oneWaveDetailSpace_Copy.Wave_code = oneWaveDetailSpace.Wave_code
		oneWaveDetailSpace_Copy.Wavedetail_count = "0"
		oneWaveDetailSpace_Copy.Wavedetail_excount = "0"
		oneWaveDetailSpace_Copy.Product_code = oneWaveDetailSpace.Product_code
		oneWaveDetailSpace_Copy.Product_name = oneWaveDetailSpace.Product_name
		oneWaveDetailSpace_Copy.Product_enname = oneWaveDetailSpace.Product_enname
		oneWaveDetailSpace_Copy.Product_barcode = oneWaveDetailSpace.Product_barcode
		oneWaveDetailSpace_Copy.Product_sku = oneWaveDetailSpace.Product_sku
		oneWaveDetailSpace_Copy.Product_unit = oneWaveDetailSpace.Product_unit
		oneWaveDetailSpace_Copy.Product_weight = fmt.Sprintf(`%.2f`, oneWaveDetailSpace.Product_weight)
		oneWaveDetailSpace_Copy.Product_length = fmt.Sprintf(`%d`, oneWaveDetailSpace.Product_length)
		oneWaveDetailSpace_Copy.Product_width = fmt.Sprintf(`%d`, oneWaveDetailSpace.Product_width)
		oneWaveDetailSpace_Copy.Product_heigth = fmt.Sprintf(`%d`, oneWaveDetailSpace.Product_heigth)
		oneWaveDetailSpace_Copy.Product_length_sort = fmt.Sprintf(`%d`, oneWaveDetailSpace.Product_length_sort)
		oneWaveDetailSpace_Copy.Product_width_sort = fmt.Sprintf(`%d`, oneWaveDetailSpace.Product_width_sort)
		oneWaveDetailSpace_Copy.Product_heigth_sort = fmt.Sprintf(`%d`, oneWaveDetailSpace.Product_heigth_sort)
		oneWaveDetailSpace_Copy.Product_bulk = fmt.Sprintf(`%d`, oneWaveDetailSpace.Product_bulk)
		oneWaveDetailSpace_Copy.Product_imgurl = oneWaveDetailSpace.Product_imgurl
		oneWaveDetailSpace_Copy.Product_state = oneWaveDetailSpace.Product_state
		oneWaveDetailSpace_Copy.Product_groupstate = oneWaveDetailSpace.Product_groupstate
		oneWaveDetailSpace_Copy.Product_batterystate = oneWaveDetailSpace.Product_batterystate

		oneTask_Copy := oneTask
		sqlcmd_sd := ""

		for _, ele := range spaceDetailList {
			oneRtn := Out_CarBatchDetailOne{}

			oneRtn.ID = GenerateCode("222")
			oneRtn.Number = NumberInt64
			oneRtn.Product_code = ele.Product_code
			oneRtn.Product_name = ele.Product_name
			oneRtn.Product_sku = ele.Product_sku
			oneRtn.Space_code = ele.Space_code
			oneRtn.Space_linenumber = ele.Space_linenumber
			oneRtn.Space_number = ele.Space_number
			oneRtn.Wavedetailspace_code = GenerateCode("602")
			flag := false
			if NeedOutCount >= ele.Space_count-ele.Space_excount {
				oneRtn.Wavedetail_count = ele.Space_count - ele.Space_excount
				sqlcmd_sd = fmt.Sprintf(`update isale_spacedetail set space_excount=space_count 
				where space_code='%s' and product_code='%s'`, ele.Space_code, ele.Product_code)
				DebugLog.Println(sqlcmd_sd)
				if _, err = tx.Exec(sqlcmd_sd); err != nil {
					rtn.Code = 2
					if strings.Contains(err.Error(), "sql: no rows in result set") {
						rtn.Message = "没有查询到货位信息"
					} else {
						rtn.Message = "更新失败"
					}
					bytes, _ := json.Marshal(rtn)
					fmt.Fprint(w, string(bytes))
					panic("cysql")
				}
				fmt.Printf("%+v\n", oneRtn)
				rtn.Data = append(rtn.Data, oneRtn)

			} else {
				oneRtn.Wavedetail_count = NeedOutCount
				sqlcmd_sd = fmt.Sprintf(`update isale_spacedetail set space_excount='%d' 
				where space_code='%s' and product_code='%s'`, ele.Space_excount+NeedOutCount, ele.Space_code, ele.Product_code)
				DebugLog.Println(sqlcmd_sd)
				if _, err = tx.Exec(sqlcmd_sd); err != nil {
					rtn.Code = 2
					if strings.Contains(err.Error(), "sql: no rows in result set") {
						rtn.Message = "没有查询到货位信息"
					} else {
						rtn.Message = "更新失败"
					}
					bytes, _ := json.Marshal(rtn)
					fmt.Fprint(w, string(bytes))
					panic("cysql")
				}
				fmt.Printf("%+v\n", oneRtn)
				rtn.Data = append(rtn.Data, oneRtn)
				NeedOutCount = 0
				flag = true
			}
			rtn.Message += fmt.Sprintf("货位:%s 数量:%d\n", ele.Space_number, oneRtn.Wavedetail_count)
			NeedOutCount = NeedOutCount - (ele.Space_count - ele.Space_excount)
			//oneWaveDetailSpace_Copy.Wavedetailspace_code = GenerateCode("602")
			oneWaveDetailSpace_Copy.Wavedetail_count = fmt.Sprintf(`%d`, oneRtn.Wavedetail_count)
			oneWaveDetailSpace_Copy.Wavedetailspace_code = oneRtn.Wavedetailspace_code
			DebugLog.Println(sqlcmd_wds)
			//添加wavedetailspace信息
			InfoLog.Println("添加wavedetailspace信息")
			oneWaveDetailSpace_Copy.Space_code = ele.Space_code
			oneWaveDetailSpace_Copy.Space_number = ele.Space_number
			oneWaveDetailSpace_Copy.Space_linenumber = ele.Space_linenumber
			if _, err = tx.NamedExec(sqlcmd_wds, oneWaveDetailSpace_Copy); err != nil {
				rtn.Code = 2
				if strings.Contains(err.Error(), "sql: no rows in result set") {
					rtn.Message = "没有查询到货位信息"
				} else {
					rtn.Message = "更新失败"
				}

				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}
			oneTask_Copy.Task_code = GenerateCode("700")
			oneTask_Copy.Task_othercode = oneWaveDetailSpace_Copy.Wavedetailspace_code
			oneTask_Copy.Task_count = fmt.Sprintf(`%d`, oneWaveDetailSpace_Copy.Wavedetail_count)
			oneTask_Copy.Task_content = fmt.Sprintf(`%s出库%d`, oneWaveDetailSpace.Product_name, oneWaveDetailSpace_Copy.Wavedetail_count)
			oneTask_Copy.Task_state = 2
			//DebugLog.Println(sqlcmd_task)
			//添加task信息
			InfoLog.Println("添加task信息")
			if _, err = tx.NamedExec(sqlcmd_task, oneTask_Copy); err != nil {
				rtn.Code = 2
				if strings.Contains(err.Error(), "sql: no rows in result set") {
					rtn.Message = "没有查询到货位信息"
				} else {
					rtn.Message = "更新失败"
				}
				bytes, _ := json.Marshal(rtn)
				fmt.Fprint(w, string(bytes))
				panic("cysql")
			}
			if flag {
				break
			}

		}
		InfoLog.Printf("%+v\n", rtn)
		bytes, _ := json.Marshal(rtn)
		fmt.Fprint(w, string(bytes))
		return

	}

}
