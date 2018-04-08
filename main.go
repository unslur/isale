// isaleAPI project main.go
package main

import (
	"database/sql"
	"errors"
	"fmt"
	"log"
	. "myfunc"
	"net/http"
	"os"
	"runtime"
	"time"

	"github.com/jmoiron/sqlx"
)

var Server_port string = ":"
var db_ip string = ""
var db_user string = ""
var db_passwd string = ""
var db_name string = ""
var db_port string = ""
var Db_type string = ""

var Halftype string = ""

func InitConfigs() {
	myConfig := new(Config)
	myConfig.InitConfig("config.ini")
	db_ip = myConfig.Read("db", "ip")
	db_port = myConfig.Read("db", "port")
	db_user = myConfig.Read("db", "user")
	db_passwd = myConfig.Read("db", "passwd")
	db_name = myConfig.Read("db", "name")
	Server_port += myConfig.Read("server", "port")

	Db_type = myConfig.Read("db", "type")

	if Db_type == "" {
		Db_type = "mysql"
	}
	InfoLog.Println("=======监听本地端口", Server_port)
	InfoLog.Println("=======数据库地址:", db_ip)
	InfoLog.Println("=======数据库用户:", db_user)
	InfoLog.Println("=======数据库密码:", db_passwd)
	InfoLog.Println("=======数据库名称:", db_name)
	InfoLog.Println("=======数据库类型:", Db_type)
	Halftype = myConfig.Read("server", "halftype")
	InfoLog.Println("=======库类型:", Halftype)
	if Halftype == "1" {
		InfoLog.Println("=======库类型:始发仓")
	} else if Halftype == "2" {
		InfoLog.Println("=======库类型:中转仓")
	} else {
		Halftype = "3"
		InfoLog.Println("=======库类型:未定义")
	}

}
func GetHalfType() string {
	DebugLog.Println(Halftype)
	return Halftype
}
func main() {

	var err error

	DebugLog = log.New(os.Stdout, "[Debug]", log.LstdFlags)

	InfoLog = log.New(os.Stderr, "[Info]", log.LstdFlags)
	InitConfigs()
	mysqlinfo := fmt.Sprintf(`%s:%s@tcp(%s:%s)/%s?charset=utf8`, db_user, db_passwd, db_ip, db_port, db_name)
	//dborm = sqlx.MustConnect("mysql", "root:123123@tcp(127.0.0.1:3306)/isaledb?charset=utf8")
	dborm = sqlx.MustConnect("mysql", mysqlinfo)
	dborm.DB.SetMaxIdleConns(5)
	dborm.DB.SetMaxOpenConns(20)
	dborm.DB.SetConnMaxLifetime(300 * time.Second)

	db, err = ConnectMysql(db_user, db_passwd, db_ip, db_port, db_name)
	if db == nil {
		InfoLog.Println("连接数据库失败", err.Error())
		return
	}
	if err != nil {
		InfoLog.Println("数据库连接失败：", err.Error())
		return
	}

	InfoLog.Println("=======开始监听端口", Server_port)
	//DebugLog.Println(Halftype)
	RunServer()
}
func ConnectMysql(user string, passwd string, ip string, port string, dbname string) (*sql.DB, error) {
	//mysqlinfo := "root:123123@tcp(127.0.0.1:3306)/cheng"
	mysqlinfo := user + ":" + passwd + "@tcp(" + ip + ":" + port + ")/" + dbname
	db, err := sql.Open("mysql", mysqlinfo)
	if err != nil {
		pc, file, line, _ := runtime.Caller(0)

		log.Printf("%s,%d,%s\n", runtime.FuncForPC(pc).Name(), line, file)
		s := fmt.Sprintf("can't connect db:%s\n", err.Error())

		return nil, errors.New(s)
	}
	db.SetMaxOpenConns(30)
	db.SetMaxIdleConns(5)
	db.SetConnMaxLifetime(300 * time.Second)
	err = db.Ping()
	if err != nil {
		pc, file, line, _ := runtime.Caller(0)

		log.Printf("%s,%d,%s\n", runtime.FuncForPC(pc).Name(), line, file)

		s := fmt.Sprintf("can't connect db:%s\n", err.Error())
		db.Close()
		return nil, errors.New(s)
	}
	return db, nil

}

var dborm *sqlx.DB
var db *sql.DB
var DebugLog *log.Logger
var InfoLog *log.Logger

func RunServer() {
	defer func() {

		if err := recover(); err != nil {
			InfoLog.Println(err)
		}

	}()
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path != "/" {
			w.WriteHeader(404)
			w.Write([]byte("<h1>404</h1>"))
		} else {
			w.Write([]byte("index"))
		}
	})
	prefix := "/isale/receiveHand"
	http.HandleFunc(prefix+"/login", Login)                             //手持机用户登录
	http.HandleFunc(prefix+"/findTaskType", FindTaskType)               //查询任务类型
	http.HandleFunc(prefix+"/findTaskList", FindTaskList)               //查询用户下所有任务
	http.HandleFunc(prefix+"/findMoveTask", FindMoveTask)               //查询用户下所有任务
	http.HandleFunc(prefix+"/findTaskDetail", FindTaskDetail)           //根据任务编码查询任务明细
	http.HandleFunc(prefix+"/saveStorage", SaveStorage)                 //货品上架实际货位,并写入库存
	http.HandleFunc(prefix+"/updateTaskState", UpdateTaskState)         //当单次任务待上架数量完毕时候,更新任务状态
	http.HandleFunc(prefix+"/findSpaceDetailList", FindSpaceDetailList) //根据任务编码查询已完成上架列表
	http.HandleFunc(prefix+"/findCarOrder", FindCarOrder)               //根据任务编码查询已完成上架列表

	http.HandleFunc(prefix+"/findOutTaskList", FindOutTaskList)                             //根据任务编码查询出库任务列表
	http.HandleFunc(prefix+"/findWaveList", FindWaveList)                                   //根据任务编码查询已完成上架列表
	http.HandleFunc(prefix+"/findOutOrderUnBatchList", FindOutOrderUnBatchList)             //根据任务编码查询已完成上架列表
	http.HandleFunc(prefix+"/findOutOrderBatchList", FindOutOrderBatchList)                 //根据任务编码查询已完成上架列表
	http.HandleFunc(prefix+"/findOutOrderUnBatchDetailList", FindOutOrderUnBatchDetailList) //根据任务编码查询已完成上架列表
	http.HandleFunc(prefix+"/findOutOrderBatchDetailList", FindOutOrderBatchDetailList)     //根据任务编码查询已完成上架列表
	http.HandleFunc(prefix+"/findTaskMaxCount", FindTaskMaxCount)                           //根据任务编码查询已完成上架列表
	http.HandleFunc(prefix+"/downStorage", DownStorage)

	http.HandleFunc(prefix+"/checkStorage", CheckStorage)
	http.HandleFunc(prefix+"/checkStorageInfo", CheckStorageInfo)
	http.HandleFunc(prefix+"/checkStorageSpace", CheckStorageSpace)
	http.HandleFunc(prefix+"/updateCheckStorage", UpdateCheckStorage)
	http.HandleFunc(prefix+"/findSpaceProduct", FindSpaceProduct)
	http.HandleFunc(prefix+"/moveProduct", MoveProduct)
	http.HandleFunc(prefix+"/getVerifyInorder", GetVerifyInorder)
	http.HandleFunc(prefix+"/getVerifyInorderList", getVerifyInorderList)
	http.HandleFunc(prefix+"/updateInorderdetail", UpdateInorderdetail)
	http.HandleFunc(prefix+"/cancleInOrderDetail", CancleInOrderDetail)
	http.HandleFunc(prefix+"/findOtherSpace", FindOtherSpace)
	http.HandleFunc(prefix+"/verifyInorder", VerifyInorder)

	http.HandleFunc(prefix+"/testapione", IsaleTestApi1)
	http.HandleFunc(prefix+"/testapione2", IsaleTestApi2)
	http.HandleFunc(prefix+"/testapione3", IsaleTestApi3)
	http.HandleFunc(prefix+"/testapione4", IsaleTestApi4)
	http.HandleFunc(prefix+"/checkExt", checkExt)

	server := &http.Server{
		Addr:         Server_port,
		Handler:      nil,
		ReadTimeout:  5 * time.Second,
		WriteTimeout: 7 * time.Second,
	}

	err := server.ListenAndServe()
	if err != nil {

		InfoLog.Println("listenAndServer:", err)
		return
	}
}
