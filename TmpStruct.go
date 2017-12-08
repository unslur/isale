// TmpStruct
package main

type Tmp_SpaceDetail struct {
	Space_code           string `db:"space_code"`
	Space_halftype       int    `db:"space_halftype"`
	Space_count          string `db:"space_count"`
	Space_excount        string `db:"space_excount"`
	Product_code         string `db:"product_code"`
	Product_name         string `db:"product_name"`
	Product_enname       string `db:"product_enname"`
	Product_barcode      string `db:"product_barcode"`
	Product_sku          string `db:"product_sku"`
	Product_unit         string `db:"product_unit"`
	Product_weight       string `db:"product_weight"`
	Product_length       string `db:"product_length"`
	Product_width        string `db:"product_width"`
	Product_heigth       string `db:"product_heigth"`
	Product_length_sort  string `db:"product_length_sort"`
	Product_width_sort   string `db:"product_width_sort"`
	Product_heigth_sort  string `db:"product_heigth_sort"`
	Product_bulk         string `db:"product_bulk"`
	Product_imgurl       string `db:"product_imgurl"`
	Product_state        int    `db:"product_state"`
	Product_groupstate   int    `db:"product_groupstate"`
	Product_batterystate int    `db:"product_batterystate"`
	User_code            string
	User_name            string
	User_mobilephone     string
	Addtime              string `db:"addtime"`
}
type Tmp_SpaceDetailMore struct {
	Space_code       string `db:"space_code"`
	Space_halftype   int    `db:"space_halftype"`
	Space_count      int64  `db:"space_count"`
	Space_excount    int64  `db:"space_excount"`
	Product_code     string `db:"product_code"`
	Product_name     string `db:"product_name"`
	Product_enname   string `db:"product_enname"`
	Product_barcode  string `db:"product_barcode"`
	Product_sku      string `db:"product_sku"`
	Product_unit     string `db:"product_unit"`
	Product_imgurl   string `db:"product_imgurl"`
	Space_number     string `db:"space_number"`
	Space_linenumber string `db:"space_linenumber"`
	Number           int64  `db:"number"`
}
type Tmp_SpaceDetaillog struct {
	Space_code           string `db:"space_code"`
	Space_halftype       int    `db:"space_halftype"`
	Space_count          string `db:"space_count"`
	Product_code         string `db:"product_code"`
	Product_name         string `db:"product_name"`
	Product_enname       string `db:"product_enname"`
	Product_barcode      string `db:"product_barcode"`
	Product_sku          string `db:"product_sku"`
	Product_unit         string `db:"product_unit"`
	Product_weight       string `db:"product_weight"`
	Product_length       string `db:"product_length"`
	Product_width        string `db:"product_width"`
	Product_heigth       string `db:"product_heigth"`
	Product_length_sort  string `db:"product_length_sort"`
	Product_width_sort   string `db:"product_width_sort"`
	Product_heigth_sort  string `db:"product_heigth_sort"`
	Product_bulk         string `db:"product_bulk"`
	Product_imgurl       string `db:"product_imgurl"`
	Product_state        int    `db:"product_state"`
	Product_groupstate   int    `db:"product_groupstate"`
	Product_batterystate int    `db:"product_batterystate"`
	Task_code            string `db:"task_code"`
	Task_type            int    `db:"task_type"`
	Task_othercode       string `db:"task_othercode"`
	Addtime              string `db:"addtime"`
}
type Tmp_SpaceDetaillogFloat struct {
	Space_code           string `db:"space_code"`
	Space_halftype       int    `db:"space_halftype"`
	Space_countint       int64  `db:"space_countint"`
	Space_count          string `db:"space_count"`
	Product_code         string `db:"product_code"`
	Product_name         string `db:"product_name"`
	Product_enname       string `db:"product_enname"`
	Product_barcode      string `db:"product_barcode"`
	Product_sku          string `db:"product_sku"`
	Product_unit         string `db:"product_unit"`
	Product_weight       string `db:"product_weight"`
	Product_length       string `db:"product_length"`
	Product_width        string `db:"product_width"`
	Product_heigth       string `db:"product_heigth"`
	Product_length_sort  string `db:"product_length_sort"`
	Product_width_sort   string `db:"product_width_sort"`
	Product_heigth_sort  string `db:"product_heigth_sort"`
	Product_bulk         string `db:"product_bulk"`
	Product_bulkint      int64  `db:"product_bulkint"`
	Product_imgurl       string `db:"product_imgurl"`
	Product_state        int    `db:"product_state"`
	Product_groupstate   int    `db:"product_groupstate"`
	Product_batterystate int    `db:"product_batterystate"`
	User_code            string
	User_name            string
	User_mobilephone     string
	Task_code            string `db:"task_code"`
	Task_type            int    `db:"task_type"`
	Task_othercode       string `db:"task_othercode"`
	Addtime              string `db:"addtime"`
}

type Tmp_WaveDetailSpace struct {
	Wavedetailspace_code string `db:"wavedetailspace_code"`
	Wavedetail_code      string `db:"wavedetail_code"`
	Wave_code            string `db:"wave_code"`
	Wavedetail_count     string `db:"wavedetail_count"`
	Wavedetail_excount   string `db:"wavedetail_excount"`
	Product_code         string `db:"product_code"`
	Product_name         string `db:"product_name"`
	Product_enname       string `db:"product_enname"`
	Product_barcode      string `db:"product_barcode"`
	Product_sku          string `db:"product_sku"`
	Product_unit         string `db:"product_unit"`
	Product_weight       string `db:"product_weight"`
	Product_length       string `db:"product_length"`
	Product_width        string `db:"product_width"`
	Product_heigth       string `db:"product_heigth"`
	Product_length_sort  string `db:"product_length_sort"`
	Product_width_sort   string `db:"product_width_sort"`
	Product_heigth_sort  string `db:"product_heigth_sort"`
	Product_bulk         string `db:"product_bulk"`
	Product_imgurl       string `db:"product_imgurl"`
	Product_state        int    `db:"product_state"`
	Product_groupstate   int    `db:"product_groupstate"`
	Product_batterystate int    `db:"product_batterystate"`
	Space_code           string `db:"space_code"`
	Space_number         string `db:"space_number"`
	Space_linenumber     string `db:"space_linenumber"`
	Addtime              string `db:"addtime"`
}
type Rtn struct {
	Code    int64
	Message string
}
type Tmp_Process struct {
	Process_code         string
	Process_count        int64
	Process_realitycount int64
	Process_state        int64
	Process_time         string
	Process_remark       string
	Product_code         string
}
type Tmp_Processdetail struct {
	Processdetail_code         string
	Processdetail_count        int64
	Processdetail_realitycount int64
	Process_code               string
	Product_code               string
	Storage_code               string
}
type Tmp_Processdetailspace struct {
	Processdetailspace_code    string
	Processdetailspace_count   string
	Processdetailspace_excount string
	Process_code               string
	Processdetail_code         string
	Product_code               string
	Product_name               string
	Product_enname             string
	Product_barcode            string
	Product_sku                string
	Product_unit               string
	Product_weight             string
	Product_length             string
	Product_width              string
	Product_heigth             string
	Product_length_sort        string
	Product_width_sort         string
	Product_heigth_sort        string
	Product_bulk               string
	Product_imgurl             string
	Product_state              int64
	Product_groupstate         int64
	Product_batterystate       int64
	Space_code                 string
	Space_number               string
	Space_linenumber           string
}
type Tmp_transfer struct {
	Storagetransferspace_code    string
	Storagetransferspace_count   string
	Storagetransferspace_excount string
	Storagetransfer_code         string
	Product_code                 string
	Product_name                 string
	Product_enname               string
	Product_barcode              string
	Product_sku                  string
	Product_unit                 string
	Product_weight               string
	Product_length               string
	Product_width                string
	Product_heigth               string
	Product_length_sort          string
	Product_width_sort           string
	Product_heigth_sort          string
	Product_bulk                 string
	Product_imgurl               string
	Product_state                int
	Product_groupstate           int
	Product_batterystate         int
	Space_code                   string
	Space_number                 string
	Space_linenumber             string
}
type Tmp_Space struct {
	Space_code        string `db:"space_code"`
	Space_number      string `db:"space_number"`
	Space_linenumber  string `db:"space_linenumber"`
	Space_weight      string `db:"space_weight"`
	Space_length      string `db:"space_length"`
	Space_width       string `db:"space_width "`
	Space_heigth      string `db:"space_heigth"`
	Space_length_sort string `db:"space_length_sort"`
	Space_width_sort  string `db:"space_width_sort"`
	Space_heigth_sort string `db:"space_heigth_sort"`
	Space_bulk        string `db:"space_bulk"`
	Space_usedbulk    string `db:"space_usedbulk"`
	Space_leftbulk    string `db:"space_leftbulk"`
	Space_upbulk      string `db:"space_upbulk"`
	Space_remark      string `db:"space_remark"`
	Space_type        int    `db:"space_type"`
	Space_state       int    `db:"space_state"`
	Space_usestate    int    `db:"space_usestate"`
	Space_lockstate   int    `db:"space_lockstate"`
	Space_halftype    int    `db:"space_halftype"`
	Space_parentcode  string `db:"space_parentcode"`
	Area_code         string `db:"area_code"`
	User_code         string `db:"user_code"`
	Addtime           string `db:"addtime"`
}
type Tmp_check struct {
	Check_code         string `db:"check_code"`
	Product_names      string `db:"product_names"`
	Product_codes      string `db:"product_codes"`
	User_code          string `db:"user_code"`
	User_name          string `db:"user_name"`
	Check_state        int    `db:"check_state"`
	Check_allocatstate int    `db:"check_allocatstate"`
	Space_codes        string `db:"space_codes"`
	Space_numbers      string `db:"space_numbers"`
	Space_halftype     int    `db:"space_halftype"`
	Task_user_code     string `db:"task_user_code"`
	Task_user_name     string `db:"task_user_name"`
	Task_user_logourl  string `db:"task_user_logourl"`
}
type Tmp_checkDetail struct {
	Checkdetail_code string `db:"checkdetail_code"`
	Check_code       string `db:"check_code"`
	Product_code     string `db:"product_code"`
	Product_sku      string `db:"product_sku"`
	Product_name     string `db:"product_name"`
	Space_code       string `db:"space_code"`
	Space_number     string `db:"space_number"`
	Space_linenumber string `db:"space_linenumber"`
	Space_count      string `db:"space_count"`
	User_code        string `db:"user_code"`
	User_name        string `db:"user_name"`
}
type Tmp_checkDetailsimple struct {
	Space_code       string `db:"space_code"`
	Space_number     string `db:"space_number"`
	Space_linenumber string `db:"space_linenumber"`
}
type Tmp_Task struct {
	Task_code            string `db:"task_code"`
	Task_type            int    `db:"task_type"`
	Task_othercode       string `db:"task_othercode"`
	Task_count           string `db:"task_count"`
	Task_content         string `db:"task_content"`
	Task_state           int    `db:"task_state"`
	Product_code         string `db:"product_code"`
	Product_name         string `db:"product_name"`
	Product_enname       string `db:"product_enname"`
	Product_barcode      string `db:"product_barcode"`
	Product_sku          string `db:"product_sku"`
	Product_unit         string `db:"product_unit"`
	Product_weight       string `db:"product_weight"`
	Product_length       string `db:"product_length"`
	Product_width        string `db:"product_width"`
	Product_heigth       string `db:"product_heigth"`
	Product_length_sort  string `db:"product_length_sort"`
	Product_width_sort   string `db:"product_width_sort"`
	Product_heigth_sort  string `db:"product_heigth_sort"`
	Product_bulk         string `db:"product_bulk"`
	Product_imgurl       string `db:"product_imgurl"`
	Product_state        int    `db:"product_state"`
	Product_groupstate   int    `db:"product_groupstate"`
	Product_batterystate int    `db:"product_batterystate"`
	User_code            string `db:"user_code"`
	User_name            string `db:"user_name"`
	User_logourl         string `db:"user_logourl"`
}
type Tmp_Storage struct {
	Storage_code         string `db:"storage_code"`
	Storage_count        string `db:"storage_count"`
	Storage_excount      string `db:"storage_excount"`
	Storage_state        string `db:"storage_state"`
	Storage_halftype     string `db:"storage_halftype"`
	Product_code         string `db:"product_code"`
	Product_name         string `db:"product_name"`
	Product_enname       string `db:"product_enname"`
	Product_barcode      string `db:"product_barcode"`
	Product_sku          string `db:"product_sku"`
	Product_unit         string `db:"product_unit"`
	Product_weight       string `db:"product_weight"`
	Product_length       string `db:"product_length"`
	Product_width        string `db:"product_width"`
	Product_heigth       string `db:"product_heigth"`
	Product_length_sort  string `db:"product_length_sort"`
	Product_width_sort   string `db:"product_width_sort"`
	Product_heigth_sort  string `db:"product_heigth_sort"`
	Product_bulk         string `db:"product_bulk"`
	Product_imgurl       string `db:"product_imgurl"`
	Product_state        string `db:"product_state"`
	Product_groupstate   string `db:"product_groupstate"`
	Product_batterystate string `db:"product_batterystate"`
	User_code            string `db:"user_code"`
	User_name            string `db:"user_name"`
	User_mobilephone     string `db:"user_mobilephone"`
}
type Tmp_UserSimple struct {
	User_code        string `db:"user_code"`
	User_name        string `db:"user_name"`
	User_mobilephone string `db:"user_mobilephone"`
	User_logourl     string `db:"user_logourl"`
}
