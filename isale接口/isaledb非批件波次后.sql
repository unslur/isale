/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50611
Source Host           : 127.0.0.1:3306
Source Database       : isaledb

Target Server Type    : MYSQL
Target Server Version : 50611
File Encoding         : 65001

Date: 2017-09-06 15:26:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for isale_area
-- ----------------------------
DROP TABLE IF EXISTS `isale_area`;
CREATE TABLE `isale_area` (
  `area_code` varchar(500) NOT NULL COMMENT '货位区系统编码',
  `area_name` varchar(500) DEFAULT NULL COMMENT '货位区名称',
  `area_type` int(2) DEFAULT NULL COMMENT '货位区类型(1:始发仓、2:中转仓)',
  `area_usetype` int(2) DEFAULT NULL COMMENT '货位区使用类型(1：普通、2：退货【不参与推荐算法,可以通过移库到正常货区】)',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_area
-- ----------------------------
INSERT INTO `isale_area` VALUES ('1081503889962751336566972', '始发仓-普通', '1', '1', '2017-08-28 11:12:42');
INSERT INTO `isale_area` VALUES ('1081503890153513808101310', '中转仓-普通', '2', '1', '2017-08-28 11:15:53');

-- ----------------------------
-- Table structure for isale_basket
-- ----------------------------
DROP TABLE IF EXISTS `isale_basket`;
CREATE TABLE `isale_basket` (
  `basket_code` varchar(500) DEFAULT NULL COMMENT '笼子系统编码',
  `basket_name` varchar(500) DEFAULT NULL COMMENT '笼子名称',
  `basket_number` varchar(500) DEFAULT NULL COMMENT '笼子编号',
  `basket_length` varchar(500) DEFAULT NULL COMMENT '虚拟笼长度(单位:mm)',
  `basket_width` varchar(500) DEFAULT NULL COMMENT '虚拟笼宽度(单位:mm)',
  `basket_heigth` varchar(500) DEFAULT NULL COMMENT '虚拟笼高度(单位:mm)',
  `basket_bulk` varchar(500) DEFAULT NULL COMMENT '虚拟笼体积',
  `basket_type` int(2) DEFAULT NULL COMMENT '笼子类型(1：始发仓、2：中转仓)始发仓普通笼子、中转仓虚拟笼子',
  `basket_way` int(2) DEFAULT NULL COMMENT '笼子货运方式(1：空运、2：海运)',
  `basket_sendtime` varchar(500) DEFAULT NULL COMMENT '虚拟笼订柜发货时间',
  `basket_sendstate` int(2) DEFAULT '1' COMMENT '是否发运【1，未发运，2，已发运】',
  `basket_sendremark` varchar(255) DEFAULT NULL COMMENT '笼子的物流状态',
  `basket_usestate` int(2) DEFAULT NULL COMMENT '使用状态(1：未使用、2：已使用）',
  `packtable_code` varchar(500) DEFAULT NULL COMMENT '包装台系统编码',
  `logistics_code` varchar(500) DEFAULT NULL COMMENT '物流商系统编码',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_basket
-- ----------------------------
INSERT INTO `isale_basket` VALUES ('2021500971072893478156041', '包装1-笼子1', '01', null, null, null, null, '1', null, null, '1', null, '2', '2051500971008357695840481', '2081501744690212907875070', '2017-07-25 16:24:32');
INSERT INTO `isale_basket` VALUES ('2021500971109580380170518', '包装1-笼子2', '02', null, null, null, null, '1', null, null, '1', null, '2', '2051500971008357695840481', '2081501744690212907875070', '2017-07-25 16:25:09');
INSERT INTO `isale_basket` VALUES ('2021500971126557292242242', '包装2-笼子1', '01', null, null, null, null, '1', null, null, '1', null, '2', '2051500971050070822435283', '2081501744690212907875070', '2017-07-25 16:25:26');
INSERT INTO `isale_basket` VALUES ('2021500971139459215517827', '包装2-笼子2', '02', null, null, null, null, '1', null, null, '1', null, '2', '2051500971050070822435283', '2081501744690212907875070', '2017-07-25 16:25:39');
INSERT INTO `isale_basket` VALUES ('2021501465668820233745420', '测试', '11', null, null, null, null, '2', null, null, '1', null, '2', '', '2081501744690212907875070', '2017-07-31 09:49:34');
INSERT INTO `isale_basket` VALUES ('2021502072068470307440733', '测试笼子1', 'S1', null, null, null, null, '1', null, null, '1', null, '2', '2051500971050070822435283', '2081501744690212907875070', '2017-08-07 10:16:23');
INSERT INTO `isale_basket` VALUES ('2021502072093674497446864', '测试笼子2', 'S2', null, null, null, null, '1', null, null, '1', null, '2', '2051500971008357695840481', '2081501744690212907875070', '2017-08-07 10:16:48');
INSERT INTO `isale_basket` VALUES ('2021502091732463218886002', '空运20170807', '001', null, null, null, null, '2', '1', null, '1', null, '1', '', null, '2017-08-07 15:42:12');
INSERT INTO `isale_basket` VALUES ('2021502092217963720860039', '', '001', null, null, null, null, '2', '1', null, '2', null, '2', '2051502091864832203129306', null, '2017-08-07 15:50:17');
INSERT INTO `isale_basket` VALUES ('2021502092778883603137995', '海运-20170807-001', '002', null, null, null, null, '2', '2', null, '2', null, '2', '2051502091864832203129306', null, '2017-08-07 15:59:38');
INSERT INTO `isale_basket` VALUES ('2021502092805193811298871', '', '002', null, null, null, null, '2', '1', null, '1', null, '1', '', null, '2017-08-07 16:00:05');
INSERT INTO `isale_basket` VALUES ('2021502093237772421210588', '海运-20170807-002', '002', '', '', '', '', '2', '2', '', '2', null, '2', '2051502091864832203129306', null, '2017-08-07 16:07:17');
INSERT INTO `isale_basket` VALUES ('2021502247727966625477109', '澳邮-笼子', '001', null, null, null, null, '1', null, null, '1', null, '2', '2051500971008357695840481', '2081501744713102782834284', '2017-08-09 11:02:07');
INSERT INTO `isale_basket` VALUES ('2021502247739994654109005', '澳邮-笼子2', '002', null, null, null, null, '1', null, null, '1', null, '2', '2051500971050070822435283', '2081501744713102782834284', '2017-08-09 11:02:19');

-- ----------------------------
-- Table structure for isale_check
-- ----------------------------
DROP TABLE IF EXISTS `isale_check`;
CREATE TABLE `isale_check` (
  `check_code` varchar(500) NOT NULL COMMENT '盘点系统编码',
  `product_names` varchar(500) DEFAULT NULL COMMENT '盘点任务名称（多个货品名称逗号分隔）',
  `product_codes` varchar(500) DEFAULT NULL COMMENT '盘点任务名称（多个货品系统编码逗号分隔）',
  `user_code` varchar(500) DEFAULT NULL COMMENT '盘点货主系统编码',
  `user_name` varchar(500) DEFAULT NULL COMMENT '盘点货主昵称',
  `check_state` int(1) DEFAULT '1' COMMENT '盘点状态(1：待处理、2：处理中、3：已完成)',
  `check_allocatstate` int(1) DEFAULT '1' COMMENT '人员分配状态(1：未分配、2：已分配)',
  `space_codes` varchar(500) DEFAULT NULL COMMENT '货位名称（多个货位名称逗号分隔）',
  `space_numbers` varchar(500) DEFAULT NULL COMMENT '货位编号（多个货位编码逗号分隔）',
  `space_halftype` int(2) DEFAULT NULL COMMENT '货位(1：始发仓货位、2：中转仓成品货位、3：中转仓半成品货位)',
  `task_user_code` varchar(500) DEFAULT NULL COMMENT '任务人员编码',
  `task_user_name` varchar(500) DEFAULT NULL COMMENT '任务人员名称',
  `task_user_logourl` varchar(500) DEFAULT NULL COMMENT '任务人员头像',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_check
-- ----------------------------

-- ----------------------------
-- Table structure for isale_checkdetail
-- ----------------------------
DROP TABLE IF EXISTS `isale_checkdetail`;
CREATE TABLE `isale_checkdetail` (
  `checkdetail_code` varchar(500) NOT NULL COMMENT '盘点明细系统编码',
  `check_code` varchar(500) DEFAULT NULL COMMENT '盘点系统编码',
  `product_code` varchar(500) DEFAULT NULL COMMENT '盘点明细货品编码',
  `product_name` varchar(500) DEFAULT NULL COMMENT '盘点明细货品名称',
  `product_sku` varchar(500) DEFAULT NULL COMMENT '盘点明细货品sku',
  `space_code` varchar(500) DEFAULT NULL COMMENT '货位系统编码',
  `space_number` varchar(500) DEFAULT NULL COMMENT '货位编号',
  `space_linenumber` varchar(500) DEFAULT NULL COMMENT '货位动线号',
  `space_count` varchar(500) DEFAULT NULL COMMENT '货品总量',
  `user_code` varchar(500) DEFAULT NULL COMMENT '盘点货主系统编码',
  `user_name` varchar(500) DEFAULT NULL COMMENT '盘点货主昵称',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_checkdetail
-- ----------------------------

-- ----------------------------
-- Table structure for isale_company
-- ----------------------------
DROP TABLE IF EXISTS `isale_company`;
CREATE TABLE `isale_company` (
  `company_code` varchar(500) NOT NULL COMMENT '企业系统编码',
  `company_name` varchar(500) DEFAULT NULL COMMENT '企业名称',
  `company_mobilephone` varchar(500) DEFAULT NULL COMMENT '企业座机',
  `company_email` varchar(500) DEFAULT NULL COMMENT '企业邮箱',
  `company_province` varchar(500) DEFAULT NULL COMMENT '企业省',
  `company_city` varchar(500) DEFAULT NULL COMMENT '企业市',
  `company_area` varchar(500) DEFAULT NULL COMMENT '企业区',
  `company_address` varchar(500) DEFAULT NULL COMMENT '企业详细地址',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_company
-- ----------------------------
INSERT INTO `isale_company` VALUES ('1011450323390392711414528', '平台管理企业', '13900000001', 'admin@manage.com', '四川省', '成都市', '青羊区', '人民南路一段', '2016-01-18 22:54:17');
INSERT INTO `isale_company` VALUES ('1011503889215519398414528', 'isale租户测试企业', '15308358888', 'isale@isale.com', '云南省', '玉溪市', '华宁县', '华宁县', '2017-08-28 11:00:15');

-- ----------------------------
-- Table structure for isale_config
-- ----------------------------
DROP TABLE IF EXISTS `isale_config`;
CREATE TABLE `isale_config` (
  `config_code` varchar(500) DEFAULT NULL COMMENT '配置系统编码',
  `config_name` varchar(500) DEFAULT NULL COMMENT '配置名称',
  `config_count` varchar(255) DEFAULT NULL COMMENT '货品移库标准（小于等于这个值,系统定时进行移库任务推荐）',
  `config_time` varchar(50) DEFAULT NULL COMMENT '配置时间',
  `config_state` int(2) DEFAULT NULL COMMENT '配置状态(1：是、2：否)',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_config
-- ----------------------------
INSERT INTO `isale_config` VALUES ('1011488791352646128000000', '始发仓-过秤', null, null, '1', '2017-03-06 17:08:35');
INSERT INTO `isale_config` VALUES ('1011488791364790245000000', '中转仓-过秤', null, null, '1', '2017-03-06 17:08:47');
INSERT INTO `isale_config` VALUES ('1011489675309796226000000', '始发仓-入库收费-卸货费', null, null, '1', '2017-03-16 22:41:56');
INSERT INTO `isale_config` VALUES ('1011489742528250634000000', '始发仓-入库收费-入库处理费', null, null, '1', '2017-03-17 17:21:06');
INSERT INTO `isale_config` VALUES ('1011489742571647502000000', '始发仓-仓库占用-仓库占用DOI费', null, null, '1', '2017-03-17 17:21:49');
INSERT INTO `isale_config` VALUES ('1011489742593455345000000', '始发仓-发货收费-发货处理费', null, null, '1', '2017-03-17 17:22:11');
INSERT INTO `isale_config` VALUES ('1011489742620832401000000', '始发仓-发货收费-复合订单费', null, null, '1', '2017-03-17 17:22:38');
INSERT INTO `isale_config` VALUES ('1011489742754397141000000', '始发仓-退货处理费-退货处理费', null, null, '1', '2017-03-17 17:24:52');
INSERT INTO `isale_config` VALUES ('1011489742771955140000000', '始发仓-退货处理-销毁费', null, null, '1', '2017-03-17 17:25:10');
INSERT INTO `isale_config` VALUES ('1011489742800702738000000', '中转仓-入库收费-验货费', null, null, '1', '2017-03-17 17:25:38');
INSERT INTO `isale_config` VALUES ('1011489742816580791000000', '中转仓-发货收费-装车费', '', null, '2', '2017-03-17 17:25:54');
INSERT INTO `isale_config` VALUES ('1011489742842982609000000', '中转仓-出入境收费-空运费', '', null, '2', '2017-03-17 17:26:21');
INSERT INTO `isale_config` VALUES ('1011489742880460760000000', '中转仓-出入境收费-海运费', '', null, '2', '2017-03-17 17:26:58');
INSERT INTO `isale_config` VALUES ('1091499826081544721391353', '始发仓-面单重量-跟随系统', null, null, '1', '2017-07-12 10:22:38');
INSERT INTO `isale_config` VALUES ('1091501144734590301612947', '自动补货', '120', '15:52', '1', '2017-07-27 16:38:54');
INSERT INTO `isale_config` VALUES ('1091501725997417199765894', '始发仓-包材-是否选择', '', null, '1', '2017-08-03 10:08:26');

-- ----------------------------
-- Table structure for isale_express
-- ----------------------------
DROP TABLE IF EXISTS `isale_express`;
CREATE TABLE `isale_express` (
  `express_code` varchar(500) DEFAULT NULL COMMENT '物流方式系统编码',
  `express_name` varchar(500) DEFAULT NULL COMMENT '物流方式中文名称',
  `express_ename` varchar(500) DEFAULT NULL COMMENT '物流方式英文名称',
  `express_price` varchar(500) DEFAULT NULL COMMENT '物流方式价格',
  `express_ebay` int(1) DEFAULT NULL COMMENT '物流方式是否绑定ebay账号(1：是、2：否)',
  `express_state` int(2) DEFAULT '1' COMMENT '造假状态(1：是、2：否)',
  `logistics_code` varchar(500) DEFAULT NULL COMMENT '物流商系统编码',
  `winitproductcode` varchar(50) DEFAULT NULL COMMENT 'winit产品编码，即物流产品代码',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_express
-- ----------------------------
INSERT INTO `isale_express` VALUES ('2031500867177122470892916', '线上中国邮政平常小包+（深圳）-winit揽收', 'SZ', '10', '1', '1', '2081501744713102782834284', 'ISP031279', '2017-07-24 11:32:57');
INSERT INTO `isale_express` VALUES ('2031501816063956262488349', '平邮', 'py', '12', '2', '1', '2081501744713102782834284', '12121', '2017-08-04 11:09:36');

-- ----------------------------
-- Table structure for isale_expressweight
-- ----------------------------
DROP TABLE IF EXISTS `isale_expressweight`;
CREATE TABLE `isale_expressweight` (
  `expressweight_code` varchar(500) DEFAULT NULL COMMENT '快递方式作假系统编码',
  `expressweight_begin` varchar(500) DEFAULT NULL COMMENT '快递方式重量区间开始值',
  `expressweight_end` varchar(500) DEFAULT NULL COMMENT '快递方式重量区间结束值',
  `expressweight_start` varchar(500) DEFAULT NULL COMMENT '快递方式作假重量区间开始值',
  `expressweight_finish` varchar(500) DEFAULT NULL COMMENT '快递方式作假重量区间结束值',
  `express_code` varchar(500) DEFAULT NULL COMMENT '物流方式系统编码',
  `logistics_code` varchar(500) DEFAULT NULL COMMENT '物流商系统编码',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_expressweight
-- ----------------------------
INSERT INTO `isale_expressweight` VALUES ('2071501816096622844410831', '1.95', '2.35', '1.88', '2', '2031501816063956262488349', '2081501744713102782834284', '2017-08-04 11:10:08');

-- ----------------------------
-- Table structure for isale_feecoefficient
-- ----------------------------
DROP TABLE IF EXISTS `isale_feecoefficient`;
CREATE TABLE `isale_feecoefficient` (
  `feecoefficient_code` varchar(500) DEFAULT NULL COMMENT '扣费系数编码',
  `feecoefficient_standard` varchar(5) DEFAULT NULL COMMENT '扣费系数标准',
  `user_code` varchar(500) DEFAULT NULL COMMENT '用户编码',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_feecoefficient
-- ----------------------------
INSERT INTO `isale_feecoefficient` VALUES ('4011500264060564831244057', '0.9', '1011489387707503696000000', '2017-07-17 12:01:00');
INSERT INTO `isale_feecoefficient` VALUES ('4011500273806970496424734', '0.5', '1011488808360385314000000', '2017-07-17 14:43:26');

-- ----------------------------
-- Table structure for isale_inorder
-- ----------------------------
DROP TABLE IF EXISTS `isale_inorder`;
CREATE TABLE `isale_inorder` (
  `inorder_code` varchar(500) DEFAULT NULL COMMENT '入库单系统编码',
  `inorder_remark` varchar(500) DEFAULT NULL COMMENT '入库单备注',
  `inorder_state` int(2) DEFAULT '1' COMMENT '入库单状态(1:待处理、2:待收费、3:已完成)（当所有子订单上架完成之后,更改为已完成，需要每次对子订单处理时候判断）',
  `inorder_verify_state` int(2) DEFAULT '1' COMMENT '验货状态（1：未确定、2：确定）',
  `inorder_mode` int(2) DEFAULT NULL COMMENT '入库模式(1:正常入库、2:二次退货入库(放到高位货位)),不同的入库类型可以按照入库条件(体积、SKU)来推荐货位',
  `inorder_type` int(2) DEFAULT NULL COMMENT '订单类型(1：始发仓、2：中转仓)',
  `user_code` varchar(500) DEFAULT NULL COMMENT '货主系统编码',
  `user_name` varchar(500) DEFAULT NULL COMMENT '用户昵称',
  `user_mobilephone` varchar(500) DEFAULT NULL COMMENT '用户手机号',
  `process_code` varchar(500) DEFAULT NULL COMMENT '加工任务系统编码',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_inorder
-- ----------------------------
INSERT INTO `isale_inorder` VALUES ('3001504681798435892206692', '', '3', '2', '1', '1', '1021503889252416585359115', '测试租户', '13349888812', null, '2017-09-06 15:09:58');

-- ----------------------------
-- Table structure for isale_inorderdetail
-- ----------------------------
DROP TABLE IF EXISTS `isale_inorderdetail`;
CREATE TABLE `isale_inorderdetail` (
  `inorderdetail_code` varchar(500) DEFAULT NULL COMMENT '入库单明细系统编码',
  `inorderdetail_state` int(2) DEFAULT '1' COMMENT '入库单明细状态(1:申请入库、2:已入库,待上架、3:取消订单、4:完成入库)',
  `inorderdetail_halftype` int(2) DEFAULT NULL COMMENT '入库子单货品（1：始发仓货位、2：中转仓成品货位、3：中转仓半成品货位）',
  `inorderdetail_selectuserstate` int(2) DEFAULT '1' COMMENT '是否选择上架人员（1：未选择、2：已选择）',
  `inorderdetail_printstate` int(2) DEFAULT '1' COMMENT '是否打印（1，未打印、2，已打印）',
  `inorder_code` varchar(500) DEFAULT NULL COMMENT '入库单系统编码',
  `inorder_mode` int(2) DEFAULT NULL COMMENT '入库模式(1:正常入库、2:二次退货入库(放到高位货位)),不同的入库类型可以按照入库条件(体积、SKU)来推荐货位',
  `operate_user_code` varchar(255) DEFAULT NULL COMMENT '验货人员系统编码',
  `user_code` varchar(500) DEFAULT NULL COMMENT '货主系统编码',
  `user_name` varchar(500) DEFAULT NULL COMMENT '用户昵称',
  `user_mobilephone` varchar(500) DEFAULT NULL COMMENT '用户手机号',
  `product_code` varchar(500) DEFAULT NULL COMMENT '货品系统编码',
  `product_name` varchar(500) DEFAULT NULL COMMENT '货品名称',
  `product_enname` varchar(500) DEFAULT NULL COMMENT '货品英文名称',
  `product_barcode` varchar(500) DEFAULT NULL COMMENT '货品条码',
  `product_sku` varchar(500) DEFAULT NULL COMMENT '货品SKU编号同步第三方平台',
  `product_unit` varchar(500) DEFAULT NULL COMMENT '货品单位',
  `product_weight` varchar(500) DEFAULT NULL COMMENT '货品重量',
  `product_length` varchar(500) DEFAULT NULL COMMENT '货品长度(单位:mm)',
  `product_width` varchar(500) DEFAULT NULL COMMENT '货品宽度(单位:mm)',
  `product_heigth` varchar(500) DEFAULT NULL COMMENT '货品高度(单位:mm)',
  `product_length_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后长边(单位:mm)',
  `product_width_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后中边(单位:mm)',
  `product_heigth_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后短边(单位:mm)',
  `product_bulk` varchar(500) DEFAULT NULL COMMENT '货品体积',
  `product_imgurl` varchar(500) DEFAULT NULL COMMENT '货品图片',
  `product_state` int(2) DEFAULT NULL COMMENT '货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)',
  `product_groupstate` int(2) DEFAULT NULL COMMENT '货品组合状态(1：未组合、2：组合)',
  `product_batterystate` int(2) DEFAULT NULL COMMENT '货品是否带电池(1：是、2：否)',
  `product_usercount` varchar(500) DEFAULT NULL COMMENT '货品数量(用户填写)',
  `product_count` varchar(500) DEFAULT NULL COMMENT '货品实际数量',
  `product_totalweight` varchar(500) DEFAULT NULL COMMENT '货品总重量',
  `product_totalbulk` varchar(500) DEFAULT NULL COMMENT '货品总体积',
  `task_user_code` varchar(500) DEFAULT NULL COMMENT '上架人员系统编码',
  `task_user_name` varchar(500) DEFAULT NULL COMMENT '上架人员名称',
  `task_user_logourl` varchar(500) DEFAULT NULL COMMENT '上架人员头像',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_inorderdetail
-- ----------------------------
INSERT INTO `isale_inorderdetail` VALUES ('3011504681798615502889985', '4', '1', '2', '1', '3001504681798435892206692', '1', '1021503889884543419268025', '1021503889252416585359115', '测试租户', '13349888812', '2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-09\\201709061131239106288977105460393_sell.png', '3', '1', '1', '50', '50', '0', '500000', '1021503889884543419268025', '手持机工作人员1', 'images/userwork.png', '2017-09-06 15:09:58');
INSERT INTO `isale_inorderdetail` VALUES ('3011504681798619239367694', '4', '1', '2', '1', '3001504681798435892206692', '1', '1021503889884543419268025', '1021503889252416585359115', '测试租户', '13349888812', '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281202208767473200554132090_sell.png', '3', '1', '1', '50', '50', '10', '500000', '1021503889884543419268025', '手持机工作人员1', 'images/userwork.png', '2017-09-06 15:09:58');
INSERT INTO `isale_inorderdetail` VALUES ('3011504681798623591168014', '4', '1', '2', '1', '3001504681798435892206692', '1', '1021503889884543419268025', '1021503889252416585359115', '测试租户', '13349888812', '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281157598622196964211611578_sell.png', '3', '1', '1', '50', '50', '5', '500000', '1021503889884543419268025', '手持机工作人员1', 'images/userwork.png', '2017-09-06 15:09:58');

-- ----------------------------
-- Table structure for isale_inorderspace_tmp
-- ----------------------------
DROP TABLE IF EXISTS `isale_inorderspace_tmp`;
CREATE TABLE `isale_inorderspace_tmp` (
  `inorderdetail_code` varchar(500) DEFAULT NULL COMMENT '入库子单系统编码',
  `task_code` varchar(500) DEFAULT NULL COMMENT '任务系统编码',
  `space_code` varchar(500) DEFAULT NULL COMMENT '货位系统编码',
  `count` varchar(500) DEFAULT NULL COMMENT '存放数量',
  `space_upbulk` varchar(500) DEFAULT NULL COMMENT '待上架体积（货品单体积*数量）',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_inorderspace_tmp
-- ----------------------------
INSERT INTO `isale_inorderspace_tmp` VALUES ('3011504681798615502889985', '7001504681869419495452706', '1051503890056357862346129', '50', '500000', '2017-09-06 15:11:09');
INSERT INTO `isale_inorderspace_tmp` VALUES ('3011504681798619239367694', '7001504681869745240341173', '1051503890056357862346129', '50', '500000', '2017-09-06 15:11:10');
INSERT INTO `isale_inorderspace_tmp` VALUES ('3011504681798623591168014', '7001504681870258614547736', '1051503890046657354762478', '50', '500000', '2017-09-06 15:11:10');

-- ----------------------------
-- Table structure for isale_logistics
-- ----------------------------
DROP TABLE IF EXISTS `isale_logistics`;
CREATE TABLE `isale_logistics` (
  `logistics_code` varchar(500) DEFAULT NULL COMMENT '物流商系统编码',
  `logistics_name` varchar(500) DEFAULT NULL COMMENT '物流商名称',
  `logistics_ename` varchar(500) DEFAULT NULL COMMENT '物流商简称（英文缩写）',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_logistics
-- ----------------------------
INSERT INTO `isale_logistics` VALUES ('2081501744690212907875070', '澳洲EMS', 'cs', '2017-08-03 15:20:00');
INSERT INTO `isale_logistics` VALUES ('2081501744713102782834284', '澳洲邮政', 'FT', '2017-08-03 15:20:23');

-- ----------------------------
-- Table structure for isale_mair
-- ----------------------------
DROP TABLE IF EXISTS `isale_mair`;
CREATE TABLE `isale_mair` (
  `mair_code` varchar(500) DEFAULT NULL COMMENT '出入境空运费系统编码',
  `mair_name` varchar(500) DEFAULT NULL COMMENT '出入境空运费名称',
  `mair_price` varchar(500) DEFAULT NULL COMMENT '出入境空运费价格',
  `mair_type` int(2) DEFAULT NULL COMMENT '出入境空运费类型(1:始发仓、2:中转仓)',
  `mair_begin` varchar(500) DEFAULT NULL COMMENT '出入境空运费重量区间开始值',
  `mair_end` varchar(500) DEFAULT NULL COMMENT '出入境空运费重量区间结束值',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_mair
-- ----------------------------

-- ----------------------------
-- Table structure for isale_markhead
-- ----------------------------
DROP TABLE IF EXISTS `isale_markhead`;
CREATE TABLE `isale_markhead` (
  `markhead_code` varchar(500) DEFAULT NULL COMMENT '唛头系统编码',
  `outorder_code` varchar(500) DEFAULT NULL COMMENT '订单系统编码',
  `basket_code` varchar(500) DEFAULT NULL COMMENT '笼子系统编码',
  `basket_way` int(2) DEFAULT NULL COMMENT '笼子货运方式(1：空运、2：海运)',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_markhead
-- ----------------------------

-- ----------------------------
-- Table structure for isale_markhead_detail
-- ----------------------------
DROP TABLE IF EXISTS `isale_markhead_detail`;
CREATE TABLE `isale_markhead_detail` (
  `markheaddetail_code` varchar(500) DEFAULT NULL COMMENT '唛头明细系统编码',
  `markheaddetail_count` varchar(500) DEFAULT NULL COMMENT '该唛头下货品的数量',
  `markhead_code` varchar(500) DEFAULT NULL COMMENT '唛头系统编码',
  `outorderdetail_code` varchar(255) DEFAULT NULL COMMENT '出库子单系统编码',
  `product_code` varchar(500) DEFAULT NULL COMMENT '货品系统编码',
  `product_name` varchar(500) DEFAULT NULL COMMENT '货品名称',
  `product_enname` varchar(500) DEFAULT NULL COMMENT '货品英文名称',
  `product_barcode` varchar(500) DEFAULT NULL COMMENT '货品条码',
  `product_sku` varchar(500) DEFAULT NULL COMMENT '货品SKU编号同步第三方平台',
  `product_unit` varchar(500) DEFAULT NULL COMMENT '货品单位',
  `product_weight` varchar(500) DEFAULT NULL COMMENT '货品重量',
  `product_length` varchar(500) DEFAULT NULL COMMENT '货品长度(单位:mm)',
  `product_width` varchar(500) DEFAULT NULL COMMENT '货品宽度(单位:mm)',
  `product_heigth` varchar(500) DEFAULT NULL COMMENT '货品高度(单位:mm)',
  `product_length_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后长边(单位:mm)',
  `product_width_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后中边(单位:mm)',
  `product_heigth_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后短边(单位:mm)',
  `product_bulk` varchar(500) DEFAULT NULL COMMENT '货品体积',
  `product_imgurl` varchar(500) DEFAULT NULL COMMENT '货品图片',
  `product_state` int(2) DEFAULT NULL COMMENT '货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)',
  `product_groupstate` int(2) DEFAULT NULL COMMENT '货品组合状态(1：未组合、2：组合)',
  `product_batterystate` int(2) DEFAULT NULL COMMENT '货品是否带电池(1：是、2：否)',
  `user_code` varchar(500) DEFAULT NULL COMMENT '货主系统编码',
  `user_name` varchar(500) DEFAULT NULL COMMENT '用户昵称',
  `user_mobilephone` varchar(500) DEFAULT NULL COMMENT '用户手机号',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_markhead_detail
-- ----------------------------

-- ----------------------------
-- Table structure for isale_material
-- ----------------------------
DROP TABLE IF EXISTS `isale_material`;
CREATE TABLE `isale_material` (
  `material_code` varchar(500) NOT NULL COMMENT '素材编码',
  `user_code` varchar(500) NOT NULL COMMENT '用户编码',
  `material_name` varchar(500) NOT NULL COMMENT '素材名称',
  `material_url` varchar(500) NOT NULL COMMENT '素材地址',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_material
-- ----------------------------
INSERT INTO `isale_material` VALUES ('1031489751276100867', '1011488808360385314', 'QQ截图20161121094523', 'resources/images\\2017-03\\20170317194756395939980962459611_sell.png', '2017-03-17 19:46:54');
INSERT INTO `isale_material` VALUES ('1031489751330854672', '1011488808360385314', 'QQ截图20161121094617', 'resources/images\\2017-03\\201703171948503850918407543379062_sell.png', '2017-03-17 19:47:49');
INSERT INTO `isale_material` VALUES ('1031490076314552320', '1011488808360385314', 'QQ截图20161121094617', 'resources/images\\2017-03\\201703211405143545309297748653296_sell.png', '2017-03-21 14:04:03');
INSERT INTO `isale_material` VALUES ('1031490076397288705', '1011488808360385314', 'QQ截图20161121094523', 'resources/images\\2017-03\\201703211406373267267093746406542_sell.png', '2017-03-21 14:05:26');
INSERT INTO `isale_material` VALUES ('1031490111536127299', '1011488762386288434', 'startup-640x1096', 'resources/images\\2017-03\\201703212352163121526940600620322_admin.png', '2017-03-21 23:52:22');
INSERT INTO `isale_material` VALUES ('1031490111542948303', '1011488762386288434', 'app-icon72x72@2x', 'resources/images\\2017-03\\201703212352223946614440956293232_admin.png', '2017-03-21 23:52:29');
INSERT INTO `isale_material` VALUES ('1041500867307310636236593', '1011488808360385314000000', 'productimg', 'resources/images\\2017-07\\201707241135077300447304551329755_sell.png', '2017-07-24 11:35:07');
INSERT INTO `isale_material` VALUES ('1041500890490373335921269', '1011488762386288434000000', 'qrcodetemplate', 'resources/images\\2017-07\\201707241801307365330834017713204_admin.png', '2017-07-24 18:01:30');
INSERT INTO `isale_material` VALUES ('1041500965749714873142884', '1011488762386288434000000', 'usersupply', 'resources/images\\2017-07\\201707251454447609346762000554389_admin.png', '2017-07-25 14:55:49');
INSERT INTO `isale_material` VALUES ('1041503889419617613218504', '1011488762386288434000000', 'usermanage', 'resources/images\\2017-08\\201708281103398611205668291543188_admin.png', '2017-08-28 11:03:39');
INSERT INTO `isale_material` VALUES ('1041503889806806245336288', '1021488762386288434000000', 'usermanage', 'resources/images\\2017-08\\201708281110068802220031473555906_admin.png', '2017-08-28 11:10:06');
INSERT INTO `isale_material` VALUES ('1041503890925840352195849', '1021503889252416585359115', '201601261402531585406347218107539_sell', 'resources/images\\2017-08\\201708281128458835419596838890294_sell.png', '2017-08-28 11:28:45');
INSERT INTO `isale_material` VALUES ('1041503892145704252341305', '1021503889252416585359115', '201601261402531585406347218107539_sell', 'resources/images\\2017-08\\201708281149058698824197422401453_sell.png', '2017-08-28 11:49:05');
INSERT INTO `isale_material` VALUES ('1041503892594437697330088', '1021503889252416585359115', '201601261402531585406347218107539_sell', 'resources/images\\2017-08\\201708281156348433921720211481961_sell.png', '2017-08-28 11:56:34');
INSERT INTO `isale_material` VALUES ('1041503892679625543748036', '1021503889252416585359115', '201601261402531585406347218107539_sell', 'resources/images\\2017-08\\201708281157598622196964211611578_sell.png', '2017-08-28 11:57:59');
INSERT INTO `isale_material` VALUES ('1041503892866825502841027', '1021503889252416585359115', '20150813152255', 'resources/images\\2017-08\\201708281201068822284928109587765_sell.png', '2017-08-28 12:01:06');
INSERT INTO `isale_material` VALUES ('1041503892940800273341219', '1021503889252416585359115', 'QQ截图20160716220752', 'resources/images\\2017-08\\201708281202208767473200554132090_sell.png', '2017-08-28 12:02:20');
INSERT INTO `isale_material` VALUES ('1041504169409273204161322', '1021503889252416585359115', '20150813152255', 'resources/images\\2017-08\\201708311650098267758163606194468_sell.png', '2017-08-31 16:50:09');
INSERT INTO `isale_material` VALUES ('1041504170143623485297814', '1021503889252416585359115', 'QQ截图20150814140247', 'resources/images\\2017-08\\201708311702238620773918282389889_sell.png', '2017-08-31 17:02:23');
INSERT INTO `isale_material` VALUES ('1041504666848537266505736', '1021503889252416585359115', 'QQ截图20150814140247', 'resources/images\\2017-09\\201709061100489518482674593973934_sell.png', '2017-09-06 11:00:48');
INSERT INTO `isale_material` VALUES ('1041504668359190373668336', '1021503889252416585359115', 'QQ截图20150814140247', 'resources/images\\2017-09\\201709061125599188863076479309647_sell.png', '2017-09-06 11:25:59');
INSERT INTO `isale_material` VALUES ('1041504668683108419550960', '1021503889252416585359115', 'QQ截图20150814140247', 'resources/images\\2017-09\\201709061131239106288977105460393_sell.png', '2017-09-06 11:31:23');

-- ----------------------------
-- Table structure for isale_mback
-- ----------------------------
DROP TABLE IF EXISTS `isale_mback`;
CREATE TABLE `isale_mback` (
  `mback_code` varchar(500) DEFAULT NULL COMMENT '退货处理费系统编码',
  `mback_name` varchar(500) DEFAULT NULL COMMENT '退货处理费名称',
  `mback_price` varchar(500) DEFAULT NULL COMMENT '退货处理费价格',
  `mback_type` int(2) DEFAULT NULL COMMENT '退货处理费类型(1:始发仓、2:中转仓)',
  `mback_begin` varchar(500) DEFAULT NULL COMMENT '退货处理费数量区间开始值',
  `mback_end` varchar(500) DEFAULT NULL COMMENT '退货处理费数量区间结束值',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_mback
-- ----------------------------

-- ----------------------------
-- Table structure for isale_mcheck
-- ----------------------------
DROP TABLE IF EXISTS `isale_mcheck`;
CREATE TABLE `isale_mcheck` (
  `mcheck_code` varchar(500) DEFAULT NULL COMMENT '入库验货费系统编码',
  `mcheck_name` varchar(500) DEFAULT NULL COMMENT '入库验货费名称',
  `mcheck_price` varchar(500) DEFAULT NULL COMMENT '入库验货费价格',
  `mcheck_type` int(2) DEFAULT NULL COMMENT '入库验货费类型(1:始发仓、2:中转仓)',
  `mcheck_begin` varchar(500) DEFAULT NULL COMMENT '入库验货费重量区间开始值',
  `mcheck_end` varchar(500) DEFAULT NULL COMMENT '入库验货费重量区间结束值',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_mcheck
-- ----------------------------

-- ----------------------------
-- Table structure for isale_mchecknumber
-- ----------------------------
DROP TABLE IF EXISTS `isale_mchecknumber`;
CREATE TABLE `isale_mchecknumber` (
  `mchecknumber_code` varchar(500) DEFAULT NULL COMMENT '入库验货数量费系统编码',
  `mchecknumber_name` varchar(500) DEFAULT NULL COMMENT '入库验货数量费名称',
  `mchecknumber_price` varchar(500) DEFAULT NULL COMMENT '入库验货数量费价格',
  `mchecknumber_type` int(2) DEFAULT NULL COMMENT '入库验货数量费类型(1:始发仓、2:中转仓)',
  `mchecknumber_begin` varchar(500) DEFAULT NULL COMMENT '入库验货费数量区间开始值',
  `mchecknumber_end` varchar(500) DEFAULT NULL COMMENT '入库验货费数量区间结束值',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_mchecknumber
-- ----------------------------
INSERT INTO `isale_mchecknumber` VALUES ('1011490260641109351000000', '数量1', '1', '2', '1', '20', '2017-03-23 17:17:18');
INSERT INTO `isale_mchecknumber` VALUES ('4061503892156916622659902', '数量2', '5', '2', '21', '100', '2017-08-28 11:49:16');
INSERT INTO `isale_mchecknumber` VALUES ('4061503892172025454599986', '数量3', '10', '2', '101', '300', '2017-08-28 11:49:32');

-- ----------------------------
-- Table structure for isale_mdeal
-- ----------------------------
DROP TABLE IF EXISTS `isale_mdeal`;
CREATE TABLE `isale_mdeal` (
  `mdeal_code` varchar(500) DEFAULT NULL COMMENT '发货处理费系统编码',
  `mdeal_name` varchar(500) DEFAULT NULL COMMENT '发货处理费名称',
  `mdeal_price` varchar(500) DEFAULT NULL COMMENT '发货处理费价格',
  `mdeal_type` int(2) DEFAULT NULL COMMENT '发货处理费类型(1:始发仓、2:中转仓)',
  `mdeal_begin` varchar(500) DEFAULT NULL COMMENT '发货处理费重量区间开始值',
  `mdeal_end` varchar(500) DEFAULT NULL COMMENT '发货处理费重量区间结束值',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_mdeal
-- ----------------------------

-- ----------------------------
-- Table structure for isale_mdealsub
-- ----------------------------
DROP TABLE IF EXISTS `isale_mdealsub`;
CREATE TABLE `isale_mdealsub` (
  `mdealsub_code` varchar(500) DEFAULT NULL COMMENT '发货复合订单费系统编码',
  `mdealsub_name` varchar(500) DEFAULT NULL COMMENT '发货复合订单费名称',
  `mdealsub_price` varchar(500) DEFAULT NULL COMMENT '发货复合订单费价格',
  `mdealsub_type` int(2) DEFAULT NULL COMMENT '发货复合订单费类型(1:始发仓、2:中转仓)',
  `mdealsub_begin` varchar(500) DEFAULT NULL COMMENT '发货复合订单费重量区间开始值',
  `mdealsub_end` varchar(500) DEFAULT NULL COMMENT '发货复合订单费重量区间结束值',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_mdealsub
-- ----------------------------

-- ----------------------------
-- Table structure for isale_mdestroy
-- ----------------------------
DROP TABLE IF EXISTS `isale_mdestroy`;
CREATE TABLE `isale_mdestroy` (
  `mdestroy_code` varchar(500) DEFAULT NULL COMMENT '退货销毁费系统编码',
  `mdestroy_name` varchar(500) DEFAULT NULL COMMENT '退货销毁费名称',
  `mdestroy_price` varchar(500) DEFAULT NULL COMMENT '退货销毁费价格',
  `mdestroy_type` int(2) DEFAULT NULL COMMENT '退货销毁费类型(1:始发仓、2:中转仓)',
  `mdestroy_begin` varchar(500) DEFAULT NULL COMMENT '退货销毁费数量区间开始值',
  `mdestroy_end` varchar(500) DEFAULT NULL COMMENT '退货销毁费数量区间结束值',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_mdestroy
-- ----------------------------

-- ----------------------------
-- Table structure for isale_mdoi
-- ----------------------------
DROP TABLE IF EXISTS `isale_mdoi`;
CREATE TABLE `isale_mdoi` (
  `mdoi_code` varchar(500) DEFAULT NULL COMMENT '仓库占用DOI收费系统编码',
  `mdoi_name` varchar(500) DEFAULT NULL COMMENT '仓库占用DOI收费名称',
  `mdoi_price` varchar(500) DEFAULT NULL COMMENT '仓库占用DOI收费价格',
  `mdoi_type` int(2) DEFAULT NULL COMMENT '仓库占用DOI收费类型(1:始发仓、2:中转仓)',
  `mdoi_begin` varchar(500) DEFAULT NULL COMMENT '仓库占用DOI收费数量区间开始值',
  `mdoi_end` varchar(500) DEFAULT NULL COMMENT '仓库占用DOI收费数量区间结束',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_mdoi
-- ----------------------------

-- ----------------------------
-- Table structure for isale_menu
-- ----------------------------
DROP TABLE IF EXISTS `isale_menu`;
CREATE TABLE `isale_menu` (
  `menu_code` varchar(500) DEFAULT NULL COMMENT '菜单系统编码',
  `menu_parentcode` varchar(500) DEFAULT NULL COMMENT '菜单父编码',
  `menu_title` varchar(500) DEFAULT NULL COMMENT '菜单名称',
  `menu_img` varchar(500) DEFAULT NULL COMMENT '菜单图片地址',
  `menu_url` varchar(500) DEFAULT NULL COMMENT '菜单url地址',
  `menu_type` int(2) DEFAULT NULL COMMENT '菜单类型 1为一级菜单 2为二级菜单',
  `menu_order` int(2) DEFAULT NULL COMMENT '菜单排序',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单表';

-- ----------------------------
-- Records of isale_menu
-- ----------------------------
INSERT INTO `isale_menu` VALUES (null, null, null, null, null, null, null, '2017-03-09 22:08:52');
INSERT INTO `isale_menu` VALUES ('100', '0', '用户管理', 'am-icon-gear', '', '1', '100', '2016-06-14 13:48:31');
INSERT INTO `isale_menu` VALUES ('101', '100', '企业管理', 'am-icon-home', 'company/findByList', '2', '101', '2016-06-14 13:49:07');
INSERT INTO `isale_menu` VALUES ('102', '100', '用户信息', 'am-icon-file-text', 'userManage/findByList', '2', '102', '2016-06-14 13:51:27');
INSERT INTO `isale_menu` VALUES ('103', '100', '权限管理', 'am-icon-file-text-o', 'role/findByList', '2', '103', '2016-06-14 13:52:38');
INSERT INTO `isale_menu` VALUES ('104', '100', '素材管理', 'am-icon-database', 'material/findByList', '2', '104', '2017-03-09 21:11:41');
INSERT INTO `isale_menu` VALUES ('200', '0', '系统配置', 'am-icon-database', '', '1', '200', '2017-03-09 21:13:43');
INSERT INTO `isale_menu` VALUES ('201', '200', '货区管理', 'am-icon-database', 'finish/area_choose', '2', '201', '2017-03-09 21:17:12');
INSERT INTO `isale_menu` VALUES ('202', '200', '货品管理', 'am-icon-database', 'product/findByList', '2', '202', '2017-03-09 21:18:33');
INSERT INTO `isale_menu` VALUES ('203', '200', '资金信息', 'am-icon-money', 'rent/findByList', '2', '203', '2016-06-14 13:52:02');
INSERT INTO `isale_menu` VALUES ('204', '200', '包装台', 'am-icon-database', 'finish/packTable_choose', '2', '204', '2017-03-09 21:21:39');
INSERT INTO `isale_menu` VALUES ('205', '200', '笼子管理', 'am-icon-database', 'finish/basket_choose', '2', '205', '2017-03-09 21:22:13');
INSERT INTO `isale_menu` VALUES ('206', '200', '托盘车', 'am-icon-database', 'salverCar/findByList?salvercar_type=1', '2', '206', '2017-03-09 21:23:14');
INSERT INTO `isale_menu` VALUES ('207', '200', '全局配置', 'am-icon-database', 'config/findByList', '2', '207', '2017-03-09 21:26:52');
INSERT INTO `isale_menu` VALUES ('300', '0', '收费管理', 'am-icon-database', '', '1', '300', '2017-03-09 21:24:13');
INSERT INTO `isale_menu` VALUES ('302', '300', '包材管理', 'am-icon-database', 'pack/findByList', '2', '302', '2017-03-09 21:25:07');
INSERT INTO `isale_menu` VALUES ('303', '300', '收费信息', 'am-icon-database', 'finish/money_choose', '2', '303', '2017-03-09 21:25:32');
INSERT INTO `isale_menu` VALUES ('400', '0', '业务管理', 'am-icon-database', '', '1', '400', '2017-03-09 21:27:24');
INSERT INTO `isale_menu` VALUES ('401', '400', '入库单', 'am-icon-database', 'finish/inOrder_choose', '2', '401', '2017-03-09 21:28:04');
INSERT INTO `isale_menu` VALUES ('402', '400', '任务管理', 'am-icon-database', 'task/findByList', '2', '402', '2017-03-20 11:23:30');
INSERT INTO `isale_menu` VALUES ('403', '400', '库存管理', 'am-icon-database', 'finish/storage_choose', '2', '403', '2017-03-20 14:46:19');
INSERT INTO `isale_menu` VALUES ('404', '400', '出库单', 'am-icon-database', 'finish/outOrder_choose', '2', '404', '2017-03-28 15:55:22');
INSERT INTO `isale_menu` VALUES ('405', '400', '波次分析', 'am-icon-database', 'finish/wave_choose', '2', '405', '2017-03-29 17:21:03');
INSERT INTO `isale_menu` VALUES ('406', '400', '检货出库', 'am-icon-database', 'wave/findWave_pick', '2', '406', '2017-06-07 09:33:20');
INSERT INTO `isale_menu` VALUES ('500', '0', '盘点管理', 'am-icon-database', '', '1', '500', '2017-07-11 14:53:51');
INSERT INTO `isale_menu` VALUES ('501', '500', '盘点管理', 'am-icon-database', 'check/findByList_endisale', '2', '501', '2017-07-11 14:57:11');
INSERT INTO `isale_menu` VALUES ('407', '400', '加工任务', 'am-icon-database', 'process/findByList', '2', '407', '2017-08-02 11:36:13');
INSERT INTO `isale_menu` VALUES ('208', '200', '物流商管理', 'am-icon-database', 'logistics/findByList', '2', '208', '2017-08-03 14:35:51');
INSERT INTO `isale_menu` VALUES ('502', '500', '预警管理', 'am-icon-database', 'finish/warning_choose', '2', '502', '2017-08-07 10:31:54');

-- ----------------------------
-- Table structure for isale_mhand
-- ----------------------------
DROP TABLE IF EXISTS `isale_mhand`;
CREATE TABLE `isale_mhand` (
  `mhand_code` varchar(500) DEFAULT NULL COMMENT '入库处理费系统编码',
  `mhand_name` varchar(500) DEFAULT NULL COMMENT '入库处理费名称',
  `mhand_price` varchar(500) DEFAULT NULL COMMENT '入库处理费价格',
  `mhand_type` int(2) DEFAULT NULL COMMENT '入库处理费类型(1:始发仓、2:中转仓)',
  `mhand_begin` varchar(500) DEFAULT NULL COMMENT '入库处理费重量区间开始值',
  `mhand_end` varchar(500) DEFAULT NULL COMMENT '入库处理费重量区间结束值',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_mhand
-- ----------------------------

-- ----------------------------
-- Table structure for isale_mloadcar
-- ----------------------------
DROP TABLE IF EXISTS `isale_mloadcar`;
CREATE TABLE `isale_mloadcar` (
  `mloadcar_code` varchar(500) DEFAULT NULL COMMENT '发货装车费系统编码',
  `mloadcar_name` varchar(500) DEFAULT NULL COMMENT '发货装车费名称',
  `mloadcar_price` varchar(500) DEFAULT NULL COMMENT '发货装车费价格',
  `mloadcar_type` int(2) DEFAULT NULL COMMENT '发货装车费类型(1:始发仓、2:中转仓)',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_mloadcar
-- ----------------------------

-- ----------------------------
-- Table structure for isale_msea
-- ----------------------------
DROP TABLE IF EXISTS `isale_msea`;
CREATE TABLE `isale_msea` (
  `msea_code` varchar(500) DEFAULT NULL COMMENT '出入境海运费系统编码',
  `msea_name` varchar(500) DEFAULT NULL COMMENT '出入境海运费名称',
  `msea_price` varchar(500) DEFAULT NULL COMMENT '出入境海运费价格',
  `msea_type` int(2) DEFAULT NULL COMMENT '出入境海运费类型(1:始发仓、2:中转仓)',
  `msea_begin` varchar(500) DEFAULT NULL COMMENT '出入境海运费重量区间开始值',
  `msea_end` varchar(500) DEFAULT NULL COMMENT '出入境海运费重量区间结束值',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_msea
-- ----------------------------

-- ----------------------------
-- Table structure for isale_munload
-- ----------------------------
DROP TABLE IF EXISTS `isale_munload`;
CREATE TABLE `isale_munload` (
  `munload_code` varchar(500) DEFAULT NULL COMMENT '入库卸货费系统编码',
  `munload_name` varchar(500) DEFAULT NULL COMMENT '入库卸货费名称',
  `munload_price` varchar(500) DEFAULT NULL COMMENT '入库卸货费价格',
  `munload_type` int(2) DEFAULT NULL COMMENT '入库卸货费类型(1:始发仓、2:中转仓)',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_munload
-- ----------------------------

-- ----------------------------
-- Table structure for isale_outorder
-- ----------------------------
DROP TABLE IF EXISTS `isale_outorder`;
CREATE TABLE `isale_outorder` (
  `outorder_code` varchar(500) DEFAULT NULL COMMENT '出库单系统编码',
  `outorder_number` varchar(500) DEFAULT NULL COMMENT '出库单号',
  `outorder_remark` varchar(500) DEFAULT NULL COMMENT '出库单备注',
  `outorder_username` varchar(500) DEFAULT NULL COMMENT '收件人姓名',
  `outorder_mobilephone` varchar(500) DEFAULT NULL COMMENT '收件人电话',
  `outorder_email` varchar(50) DEFAULT NULL COMMENT '收件人邮箱',
  `outorder_zipcode` varchar(50) DEFAULT NULL COMMENT '收件人邮编',
  `outorder_country` varchar(50) DEFAULT NULL COMMENT '收件人国家',
  `outorder_canton` varchar(50) DEFAULT NULL COMMENT '收件人州',
  `outorder_city` varchar(50) DEFAULT NULL COMMENT '收件人城市',
  `outorder_address` varchar(500) DEFAULT NULL COMMENT '收件人地址',
  `outorder_state` int(2) DEFAULT '1' COMMENT '出库单状态(1:待处理、2:待收费、3:已完成)(所有出库子单完成之后,由管理人员点击按钮为已完成)',
  `outorder_downstate` int(1) DEFAULT '1' COMMENT '下架状态(1：未下架、2：下架中 3：下架完成)',
  `outorder_level` int(2) DEFAULT NULL COMMENT '订单派发优先级(1：默认普通、2：优先(货主下单选择)、3：系统优先(系统波次分析后,当日未发出订单))',
  `outorder_type` int(2) DEFAULT NULL COMMENT '订单类型(1：始发仓、2：中转仓)',
  `outorder_way` int(2) DEFAULT NULL COMMENT '订单货运方式(1：空运、2：海运)',
  `outorder_waystate` int(2) DEFAULT '1' COMMENT '订单货运方式是否改变(1：否、2：是)',
  `outorder_serial` varchar(500) DEFAULT NULL COMMENT '订单分析序号(采用当前最大值+1)',
  `outorder_count` int(11) DEFAULT NULL COMMENT '子订单数量',
  `express_code` varchar(500) DEFAULT NULL COMMENT '快递系统编码',
  `express_name` varchar(500) DEFAULT NULL COMMENT '快递名称（用户下单选择的物流）',
  `express_number` varchar(500) DEFAULT NULL COMMENT '快递单号',
  `express_price` varchar(500) DEFAULT NULL COMMENT '快递价格',
  `sendexpress_code` varchar(500) DEFAULT NULL COMMENT '实际发送快递系统编码',
  `sendexpress_name` varchar(500) DEFAULT NULL COMMENT '实际发送快递名称（用户下单选择的物流）',
  `sendexpress_price` varchar(500) DEFAULT NULL COMMENT '实际发送快递价格',
  `pack_name` varchar(500) DEFAULT NULL COMMENT '包材名称',
  `pack_price` varchar(500) DEFAULT NULL COMMENT '包材价格',
  `outorder_sendtime` varchar(500) DEFAULT NULL COMMENT '发货时间（发给客户）',
  `outorder_downtime` varchar(500) DEFAULT NULL COMMENT '1：api推送时间、2：货主平台下单则为系统时间',
  `outorder_systemweight` varchar(500) DEFAULT NULL COMMENT '订单系统重量',
  `outorder_realweight` varchar(500) DEFAULT NULL COMMENT '订单过称的重量',
  `outorder_expressweight` varchar(500) DEFAULT NULL COMMENT '订单发给快递的重量',
  `outorder_bakweight` varchar(500) DEFAULT NULL COMMENT '备用字段（备用的一个重量）',
  `outorder_lackstate` int(2) DEFAULT NULL COMMENT '是否缺货（1.未缺货，2.缺货） 用于库存确实缺货',
  `wave_code` varchar(500) DEFAULT NULL COMMENT '波次系统编码',
  `wave_user_code` varchar(500) DEFAULT NULL COMMENT '波次分析人员系统编码',
  `user_code` varchar(500) DEFAULT NULL COMMENT '货主系统编码',
  `user_mobilephone` varchar(500) DEFAULT NULL COMMENT '用户手机号',
  `user_name` varchar(500) DEFAULT NULL COMMENT '用户昵称',
  `task_user_code` varchar(500) DEFAULT NULL COMMENT '拣货用户系统编码',
  `task_user_name` varchar(500) DEFAULT NULL COMMENT '拣货用户名称',
  `dispatch_type` varchar(255) DEFAULT NULL COMMENT '发货方式 【P:Winit揽收、S:自发快递、T:卖家自送、C:中邮揽收、D:DHL揽收】，不同物流渠道要求与提交的“寄件/提货地址“的审核情况而定，审核通过选择【Winit揽收】，审核不通过使用【自发快递、卖家自送】，其它2个是特殊渠道的揽收方式',
  `ebay_sellerid` varchar(50) DEFAULT NULL COMMENT 'ebay卖家ID（eBay订单必填）',
  `isp_orderno` varchar(50) DEFAULT NULL COMMENT 'ISP 订单号',
  `tracking_no` varchar(50) DEFAULT NULL COMMENT '跟踪号',
  `express_sheeturl` varchar(255) DEFAULT NULL COMMENT '电子面单url',
  `pack_code` varchar(255) DEFAULT NULL COMMENT '包材系统编码',
  `basket_code` varchar(500) DEFAULT NULL COMMENT '笼子系统编码',
  `packtable_code` varchar(500) DEFAULT NULL COMMENT '包装台系统编码',
  `logistics_code` varchar(500) DEFAULT NULL COMMENT '物流商系统编码',
  `pack_way` int(2) DEFAULT NULL COMMENT '包装方式',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_outorder
-- ----------------------------
INSERT INTO `isale_outorder` VALUES ('3031504682648272307835617', '20170906', '', 'Borkan akyil', '18086800000', 'kafkas1963@googlemail.com', '10559', 'DE', 'Berlin', 'Berlin', 'birkenstr 17', '1', '1', '1', '1', null, '1', '1', '3', '2031500867177122470892916', '线上中国邮政平常小包+（深圳）-winit揽收', null, '10', '2031500867177122470892916', '线上中国邮政平常小包+（深圳）-winit揽收', '10', null, null, null, null, '1.55', null, null, null, null, '6001504682770307526756420', '1021488762386288434000000', '1021503889252416585359115', '13349888812', '测试租户', '1021503889884543419268025', '手持机工作人员1', 'P', null, null, null, null, '2041503891267404565318266', null, null, '2081501744713102782834284', '1', '2017-09-06 15:24:08');
INSERT INTO `isale_outorder` VALUES ('3031504682655758234587307', '20170906', '', 'Borkan akyil', '18086800000', 'kafkas1963@googlemail.com', '10559', 'DE', 'Berlin', 'Berlin', 'birkenstr 17', '1', '1', '1', '1', null, '1', '2', '3', '2031500867177122470892916', '线上中国邮政平常小包+（深圳）-winit揽收', null, '10', '2031500867177122470892916', '线上中国邮政平常小包+（深圳）-winit揽收', '10', null, null, null, null, '1.55', null, null, null, null, '6001504682770307526756420', '1021488762386288434000000', '1021503889252416585359115', '13349888812', '测试租户', '1021503889884543419268025', '手持机工作人员1', 'P', null, null, null, null, '2041503891267404565318266', null, null, '2081501744713102782834284', '1', '2017-09-06 15:24:15');
INSERT INTO `isale_outorder` VALUES ('3031504682664812750567168', '20170906', '', 'Borkan akyil', '18086800000', 'kafkas1963@googlemail.com', '10559', 'DE', 'Berlin', 'Berlin', 'birkenstr 17', '1', '1', '1', '1', null, '1', '3', '3', '2031500867177122470892916', '线上中国邮政平常小包+（深圳）-winit揽收', null, '10', '2031500867177122470892916', '线上中国邮政平常小包+（深圳）-winit揽收', '10', null, null, null, null, '1.55', null, null, null, null, '6001504682770307526756420', '1021488762386288434000000', '1021503889252416585359115', '13349888812', '测试租户', '1021503889884543419268025', '手持机工作人员1', 'P', null, null, null, null, '2041503891267404565318266', null, null, '2081501744713102782834284', '1', '2017-09-06 15:24:24');
INSERT INTO `isale_outorder` VALUES ('3031504682673788753153868', '20170906', '', 'Borkan akyil', '18086800000', 'kafkas1963@googlemail.com', '10559', 'DE', 'Berlin', 'Berlin', 'birkenstr 17', '1', '1', '1', '1', null, '1', '4', '3', '2031500867177122470892916', '线上中国邮政平常小包+（深圳）-winit揽收', null, '10', '2031500867177122470892916', '线上中国邮政平常小包+（深圳）-winit揽收', '10', null, null, null, null, '4.65', null, null, null, null, '6001504682770307526756420', '1021488762386288434000000', '1021503889252416585359115', '13349888812', '测试租户', '1021503889884543419268025', '手持机工作人员1', 'P', null, null, null, null, '2041503891267404565318266', null, null, '2081501744713102782834284', '1', '2017-09-06 15:24:33');

-- ----------------------------
-- Table structure for isale_outorderdetail
-- ----------------------------
DROP TABLE IF EXISTS `isale_outorderdetail`;
CREATE TABLE `isale_outorderdetail` (
  `outorderdetail_code` varchar(500) DEFAULT NULL COMMENT '出库单明细系统编码',
  `outorderdetail_state` int(2) DEFAULT NULL COMMENT '出库单明细状态(1:申请出库、2:已出库,待下架、3:拒绝出库、4:完成出库)',
  `outorderdetail_packstate` int(2) DEFAULT '1' COMMENT '包装状态【1,未包装；2,包装中,3,已完成】',
  `outorderdetail_packcount` varchar(500) DEFAULT NULL COMMENT '当前打包数量',
  `outorder_code` varchar(500) DEFAULT NULL COMMENT '出库单系统编码',
  `user_code` varchar(500) DEFAULT NULL COMMENT '货主系统编码',
  `user_name` varchar(500) DEFAULT NULL COMMENT '用户昵称',
  `user_mobilephone` varchar(500) DEFAULT NULL COMMENT '用户手机号',
  `product_code` varchar(500) DEFAULT NULL COMMENT '货品系统编码',
  `product_name` varchar(500) DEFAULT NULL COMMENT '货品名称',
  `product_enname` varchar(500) DEFAULT NULL COMMENT '货品英文名称',
  `product_barcode` varchar(500) DEFAULT NULL COMMENT '货品条码',
  `product_sku` varchar(500) DEFAULT NULL COMMENT '货品SKU编号同步第三方平台',
  `product_unit` varchar(500) DEFAULT NULL COMMENT '货品单位',
  `product_weight` varchar(500) DEFAULT NULL COMMENT '货品重量',
  `product_length` varchar(500) DEFAULT NULL COMMENT '货品长度(单位:mm)',
  `product_width` varchar(500) DEFAULT NULL COMMENT '货品宽度(单位:mm)',
  `product_heigth` varchar(500) DEFAULT NULL COMMENT '货品高度(单位:mm)',
  `product_length_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后长边(单位:mm)',
  `product_width_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后中边(单位:mm)',
  `product_heigth_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后短边(单位:mm)',
  `product_bulk` varchar(500) DEFAULT NULL COMMENT '货品体积',
  `product_imgurl` varchar(500) DEFAULT NULL COMMENT '货品图片',
  `product_state` int(2) DEFAULT NULL COMMENT '货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)',
  `product_groupstate` int(2) DEFAULT NULL COMMENT '货品组合状态(1：未组合、2：组合)',
  `product_batterystate` int(2) DEFAULT NULL COMMENT '货品是否带电池(1：是、2：否)',
  `product_price` varchar(255) DEFAULT NULL COMMENT '货品单价',
  `product_count` varchar(500) DEFAULT NULL COMMENT '货品实际数量',
  `product_excount` varchar(255) DEFAULT '0' COMMENT '中转仓 贴唛头箱子货品预扣数量',
  `product_totalweight` varchar(500) DEFAULT NULL COMMENT '货品总重量',
  `product_totalbulk` varchar(500) DEFAULT NULL COMMENT '货品总体积',
  `packtable_code` varchar(500) DEFAULT NULL COMMENT '包装台系统编码',
  `transaction_id` varchar(30) DEFAULT NULL COMMENT '交易ID（eBay订单必填）',
  `item_id` varchar(30) DEFAULT NULL COMMENT '条目ID（eBay订单必填）',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_outorderdetail
-- ----------------------------
INSERT INTO `isale_outorderdetail` VALUES ('3041504682648396171293009', '2', '1', null, '3031504682648272307835617', '1021503889252416585359115', '测试租户', '13349888812', '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281157598622196964211611578_sell.png', '3', '1', '1', '3', '5', '0', '0.5', '50000', null, '141926441189', '141926441189', '2017-09-06 15:24:08');
INSERT INTO `isale_outorderdetail` VALUES ('3041504682648405822801084', '2', '1', null, '3031504682648272307835617', '1021503889252416585359115', '测试租户', '13349888812', '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281202208767473200554132090_sell.png', '3', '1', '1', '1000', '5', '0', '1.0', '50000', null, '1423128029004', '141926441189', '2017-09-06 15:24:08');
INSERT INTO `isale_outorderdetail` VALUES ('3041504682648413464800263', '2', '1', null, '3031504682648272307835617', '1021503889252416585359115', '测试租户', '13349888812', '2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-09\\201709061131239106288977105460393_sell.png', '3', '1', '1', '100', '5', '0', '0.05', '50000', null, '1423128029004', '141926441189', '2017-09-06 15:24:08');
INSERT INTO `isale_outorderdetail` VALUES ('3041504682655779228532971', '2', '1', null, '3031504682655758234587307', '1021503889252416585359115', '测试租户', '13349888812', '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281157598622196964211611578_sell.png', '3', '1', '1', '3', '5', '0', '0.5', '50000', null, '141926441189', '141926441189', '2017-09-06 15:24:15');
INSERT INTO `isale_outorderdetail` VALUES ('3041504682655806422570654', '2', '1', null, '3031504682655758234587307', '1021503889252416585359115', '测试租户', '13349888812', '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281202208767473200554132090_sell.png', '3', '1', '1', '1000', '5', '0', '1.0', '50000', null, '1423128029004', '141926441189', '2017-09-06 15:24:15');
INSERT INTO `isale_outorderdetail` VALUES ('3041504682655812248845378', '2', '1', null, '3031504682655758234587307', '1021503889252416585359115', '测试租户', '13349888812', '2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-09\\201709061131239106288977105460393_sell.png', '3', '1', '1', '100', '5', '0', '0.05', '50000', null, '1423128029004', '141926441189', '2017-09-06 15:24:15');
INSERT INTO `isale_outorderdetail` VALUES ('3041504682664835527609543', '2', '1', null, '3031504682664812750567168', '1021503889252416585359115', '测试租户', '13349888812', '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281157598622196964211611578_sell.png', '3', '1', '1', '3', '5', '0', '0.5', '50000', null, '141926441189', '141926441189', '2017-09-06 15:24:24');
INSERT INTO `isale_outorderdetail` VALUES ('3041504682664839135794888', '2', '1', null, '3031504682664812750567168', '1021503889252416585359115', '测试租户', '13349888812', '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281202208767473200554132090_sell.png', '3', '1', '1', '1000', '5', '0', '1.0', '50000', null, '1423128029004', '141926441189', '2017-09-06 15:24:24');
INSERT INTO `isale_outorderdetail` VALUES ('3041504682664846219891971', '2', '1', null, '3031504682664812750567168', '1021503889252416585359115', '测试租户', '13349888812', '2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-09\\201709061131239106288977105460393_sell.png', '3', '1', '1', '100', '5', '0', '0.05', '50000', null, '1423128029004', '141926441189', '2017-09-06 15:24:24');
INSERT INTO `isale_outorderdetail` VALUES ('3041504682673802246881190', '2', '1', null, '3031504682673788753153868', '1021503889252416585359115', '测试租户', '13349888812', '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281157598622196964211611578_sell.png', '3', '1', '1', '3', '15', '0', '1.5', '150000', null, '141926441189', '141926441189', '2017-09-06 15:24:33');
INSERT INTO `isale_outorderdetail` VALUES ('3041504682673807267181877', '2', '1', null, '3031504682673788753153868', '1021503889252416585359115', '测试租户', '13349888812', '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281202208767473200554132090_sell.png', '3', '1', '1', '1000', '15', '0', '3.0', '150000', null, '1423128029004', '141926441189', '2017-09-06 15:24:33');
INSERT INTO `isale_outorderdetail` VALUES ('3041504682673816184852512', '2', '1', null, '3031504682673788753153868', '1021503889252416585359115', '测试租户', '13349888812', '2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-09\\201709061131239106288977105460393_sell.png', '3', '1', '1', '100', '15', '0', '0.15', '150000', null, '1423128029004', '141926441189', '2017-09-06 15:24:33');

-- ----------------------------
-- Table structure for isale_pack
-- ----------------------------
DROP TABLE IF EXISTS `isale_pack`;
CREATE TABLE `isale_pack` (
  `pack_code` varchar(500) DEFAULT NULL COMMENT '包材系统编码',
  `pack_name` varchar(500) DEFAULT NULL COMMENT '包材名称',
  `pack_price` varchar(500) DEFAULT NULL COMMENT '包材价格',
  `pack_length` varchar(500) DEFAULT NULL COMMENT '包材长度(单位:mm)',
  `pack_width` varchar(500) DEFAULT NULL COMMENT '包材宽度(单位:mm)',
  `pack_heigth` varchar(500) DEFAULT NULL COMMENT '包材高度(单位:mm)',
  `pack_bulk` varchar(500) DEFAULT NULL COMMENT '包材体积',
  `pack_weight` varchar(500) DEFAULT NULL COMMENT '包材重量(kg)',
  `pack_way` int(2) DEFAULT NULL COMMENT '包装方式（1.信封，2.包裹）',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_pack
-- ----------------------------
INSERT INTO `isale_pack` VALUES ('2041503891247164624837012', '小信封', '1', '1', '1', '1', '1', '0.1', '1', '2017-08-28 11:34:07');
INSERT INTO `isale_pack` VALUES ('2041503891267404565318266', '大信封', '5', '10', '5', '5', '250', '0.2', '1', '2017-08-28 11:34:27');
INSERT INTO `isale_pack` VALUES ('2041503891299711161710812', '小箱子', '5', '101', '11', '11', '12221', '0.2', '2', '2017-08-28 11:34:59');
INSERT INTO `isale_pack` VALUES ('2041503891323278906262223', '大箱子', '10', '20', '30', '20', '12000', '0.21', '2', '2017-08-28 11:35:23');

-- ----------------------------
-- Table structure for isale_packtable
-- ----------------------------
DROP TABLE IF EXISTS `isale_packtable`;
CREATE TABLE `isale_packtable` (
  `packtable_code` varchar(500) DEFAULT NULL COMMENT '包装台系统编码',
  `packtable_name` varchar(500) DEFAULT NULL COMMENT '包装台名称',
  `packtable_number` varchar(500) DEFAULT NULL COMMENT '包装台编号',
  `packtable_type` int(2) DEFAULT NULL COMMENT '包装台类型(1：始发仓、2：中转仓)',
  `packtable_usestate` int(2) DEFAULT '1' COMMENT '使用状态(1：未使用、2：已使用）',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_packtable
-- ----------------------------
INSERT INTO `isale_packtable` VALUES ('2051500971008357695840481', '包装台1', '01', '1', '1', '2017-07-25 16:23:45');
INSERT INTO `isale_packtable` VALUES ('2051500971050070822435283', '包装台2', '02', '1', '1', '2017-07-25 16:24:15');
INSERT INTO `isale_packtable` VALUES ('2051502091864832203129306', '中转仓-包装台-1', '01', '2', '1', '2017-08-07 15:44:44');

-- ----------------------------
-- Table structure for isale_process
-- ----------------------------
DROP TABLE IF EXISTS `isale_process`;
CREATE TABLE `isale_process` (
  `process_code` varchar(500) DEFAULT NULL COMMENT '加工货品系统编码',
  `process_count` int(11) DEFAULT NULL COMMENT '加工数量(整数）',
  `process_realitycount` int(11) DEFAULT NULL COMMENT '实际加工数量/当前完成数量/上架数量(整数）',
  `process_state` int(2) DEFAULT '1' COMMENT '任务状态【1.申请加工、2.半成品拿取中、3.成品加工中、4.成品上架中、5.已完成】',
  `process_time` timestamp NULL DEFAULT NULL COMMENT '加工时间(期望值）',
  `process_remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `product_code` varchar(500) DEFAULT NULL COMMENT '加工的货品系统编码（一定是组合货品）',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_process
-- ----------------------------

-- ----------------------------
-- Table structure for isale_processdetail
-- ----------------------------
DROP TABLE IF EXISTS `isale_processdetail`;
CREATE TABLE `isale_processdetail` (
  `processdetail_code` varchar(500) DEFAULT NULL COMMENT '加工任务明细系统编码',
  `processdetail_count` int(11) DEFAULT NULL COMMENT '需要加工的数量(整数）',
  `processdetail_realitycount` int(11) DEFAULT NULL COMMENT '实际加工数量/当前完成数量/上架数量(整数）',
  `process_code` varchar(500) DEFAULT NULL COMMENT '加工任务系统编码',
  `product_code` varchar(500) DEFAULT NULL COMMENT '加工的货品系统编码（一定是组合关联的货品）',
  `storage_code` varchar(500) DEFAULT NULL COMMENT '库存系统编码',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_processdetail
-- ----------------------------

-- ----------------------------
-- Table structure for isale_processdetailspace
-- ----------------------------
DROP TABLE IF EXISTS `isale_processdetailspace`;
CREATE TABLE `isale_processdetailspace` (
  `processdetailspace_code` varchar(500) DEFAULT NULL COMMENT '加工货位取货表',
  `processdetailspace_count` varchar(500) DEFAULT NULL COMMENT '取货数量',
  `processdetailspace_excount` varchar(500) DEFAULT NULL COMMENT '已拣货数量',
  `process_code` varchar(500) DEFAULT NULL COMMENT '加工货品系统编码',
  `processdetail_code` varchar(500) DEFAULT NULL COMMENT '加工任务明细系统编码',
  `product_code` varchar(500) DEFAULT NULL COMMENT '货品系统编码',
  `product_name` varchar(500) DEFAULT NULL COMMENT '货品名称',
  `product_enname` varchar(500) DEFAULT NULL COMMENT '货品英文名称',
  `product_barcode` varchar(500) DEFAULT NULL COMMENT '货品条码',
  `product_sku` varchar(500) DEFAULT NULL COMMENT '货品SKU编号同步第三方平台',
  `product_unit` varchar(500) DEFAULT NULL COMMENT '货品单位',
  `product_weight` varchar(500) DEFAULT NULL COMMENT '货品重量',
  `product_length` varchar(500) DEFAULT NULL COMMENT '货品长度(单位:mm)',
  `product_width` varchar(500) DEFAULT NULL COMMENT '货品宽度(单位:mm)',
  `product_heigth` varchar(500) DEFAULT NULL COMMENT '货品高度(单位:mm)',
  `product_length_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后长边(单位:mm)',
  `product_width_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后中边(单位:mm)',
  `product_heigth_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后短边(单位:mm)',
  `product_bulk` varchar(500) DEFAULT NULL COMMENT '货品体积',
  `product_imgurl` varchar(500) DEFAULT NULL COMMENT '货品图片',
  `product_state` int(2) DEFAULT NULL COMMENT '货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)',
  `product_groupstate` int(2) DEFAULT NULL COMMENT '货品组合状态(1：未组合、2：组合)',
  `product_batterystate` int(2) DEFAULT NULL COMMENT '货品是否带电池(1：是、2：否)',
  `space_code` varchar(500) DEFAULT NULL COMMENT '货位系统编码',
  `space_number` varchar(500) DEFAULT NULL COMMENT '货位编号',
  `space_linenumber` varchar(500) DEFAULT NULL COMMENT '货位动线号',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_processdetailspace
-- ----------------------------
INSERT INTO `isale_processdetailspace` VALUES ('3061504174348100004256377', '15', null, '3051504168718117169452481', '3061504168718118212853793', '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281202208767473200554132090_sell.png', '3', '1', '1', '1051503890251384507744991', 'P-BC-03-01-01', '03', '2017-08-31 18:12:28');
INSERT INTO `isale_processdetailspace` VALUES ('3061504174348100009650635', '15', null, '3051504168718117169452481', '3061504168718127555466619', '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281157598622196964211611578_sell.png', '3', '1', '1', '1051503890251384507744991', 'P-BC-03-01-01', '03', '2017-08-31 18:12:28');

-- ----------------------------
-- Table structure for isale_product
-- ----------------------------
DROP TABLE IF EXISTS `isale_product`;
CREATE TABLE `isale_product` (
  `product_code` varchar(500) NOT NULL COMMENT '货品系统编码',
  `product_name` varchar(500) DEFAULT NULL COMMENT '货品名称',
  `product_enname` varchar(500) DEFAULT NULL COMMENT '货品英文名称',
  `product_barcode` varchar(500) DEFAULT NULL COMMENT '货品条码',
  `product_sku` varchar(500) DEFAULT NULL COMMENT '货品SKU编号同步第三方平台',
  `product_unit` varchar(500) DEFAULT NULL COMMENT '货品单位',
  `product_weight` varchar(500) DEFAULT NULL COMMENT '货品重量',
  `product_length` varchar(500) DEFAULT NULL COMMENT '货品长度(单位:mm)',
  `product_width` varchar(500) DEFAULT NULL COMMENT '货品宽度(单位:mm)',
  `product_heigth` varchar(500) DEFAULT NULL COMMENT '货品高度(单位:mm)',
  `product_length_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后长边(单位:mm)',
  `product_width_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后中边(单位:mm)',
  `product_heigth_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后短边(单位:mm)',
  `product_bulk` varchar(500) DEFAULT NULL COMMENT '货品体积',
  `product_imgurl` varchar(500) DEFAULT NULL COMMENT '货品图片',
  `product_delstate` int(2) DEFAULT '1' COMMENT '货品删除状态(1:启用、2:禁用)',
  `product_state` int(2) DEFAULT NULL COMMENT '货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)',
  `product_groupstate` int(2) DEFAULT NULL COMMENT '货品组合状态(1：未组合、2：组合)',
  `product_batterystate` int(2) DEFAULT NULL COMMENT '货品是否带电池(1：是、2：否)',
  `product_price` varchar(255) DEFAULT NULL COMMENT '货品单价',
  `product_move_standard` varchar(255) DEFAULT NULL COMMENT '货品移库标准（小于等于这个值,系统定时进行移库任务推荐）',
  `pack_code` varchar(255) DEFAULT NULL COMMENT '包材系统编码',
  `pack_way` int(2) DEFAULT NULL COMMENT '包装方式（1.信封，2.包裹）',
  `user_code` varchar(500) DEFAULT NULL COMMENT '货主系统编码',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_product
-- ----------------------------
INSERT INTO `isale_product` VALUES ('2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281157598622196964211611578_sell.png', '1', '3', '1', '1', '3', '', '2041503891267404565318266', '1', '1021503889252416585359115', '2017-08-28 11:59:28');
INSERT INTO `isale_product` VALUES ('2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281202208767473200554132090_sell.png', '1', '3', '1', '1', '1000', '10', '2041503891267404565318266', '1', '1021503889252416585359115', '2017-08-28 12:03:11');
INSERT INTO `isale_product` VALUES ('2001504168252401175639921', '套装', 'sbd', '1', '12121', '张', '1', '1', '1', '1', '1', '1', '1', '1', 'resources/images\\2017-08\\201708281202208767473200554132090_sell.png', '1', '1', '2', '1', '1', '10', '2041503891267404565318266', '1', '1021503889252416585359115', '2017-08-31 16:33:44');
INSERT INTO `isale_product` VALUES ('2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-09\\201709061131239106288977105460393_sell.png', '1', '3', '1', '1', '100', '60', '2041503891323278906262223', '2', '1021503889252416585359115', '2017-09-06 11:01:47');

-- ----------------------------
-- Table structure for isale_productgroup
-- ----------------------------
DROP TABLE IF EXISTS `isale_productgroup`;
CREATE TABLE `isale_productgroup` (
  `product_code` varchar(500) DEFAULT NULL COMMENT '货品系统编码',
  `product_childcode` varchar(500) DEFAULT NULL COMMENT '货品系统编码(子编码)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_productgroup
-- ----------------------------
INSERT INTO `isale_productgroup` VALUES ('2001504168252401175639921', '2001503892991638434396248');
INSERT INTO `isale_productgroup` VALUES ('2001504168252401175639921', '2001503892768198700795858');

-- ----------------------------
-- Table structure for isale_rent
-- ----------------------------
DROP TABLE IF EXISTS `isale_rent`;
CREATE TABLE `isale_rent` (
  `rent_code` varchar(500) DEFAULT NULL COMMENT '资金系统编码',
  `rent_price` varchar(200) DEFAULT NULL COMMENT '金额',
  `rent_remark` varchar(500) DEFAULT NULL COMMENT '资金说明',
  `rent_type` int(1) DEFAULT NULL COMMENT '资金类型(1:平台充值、2:平台扣费、3:流程扣费)',
  `rent_currentprice` varchar(500) DEFAULT NULL COMMENT '操作后的金额',
  `rent_tablename` varchar(500) DEFAULT NULL COMMENT '资金收费表名',
  `rent_systemcode` varchar(500) DEFAULT NULL COMMENT '资金收费表名系统编码',
  `user_code` varchar(500) DEFAULT NULL COMMENT '用户编码',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_rent
-- ----------------------------
INSERT INTO `isale_rent` VALUES ('4001504681869100000313966', '0.00', '', '3', '-50.28', null, null, '1021503889252416585359115', '2017-09-06 15:11:09');
INSERT INTO `isale_rent` VALUES ('4001504681870100004360424', '0.01', '', '3', '-50.28', null, null, '1021503889252416585359115', '2017-09-06 15:11:10');
INSERT INTO `isale_rent` VALUES ('4001504681870100000022396', '0.01', '', '3', '-50.29', null, null, '1021503889252416585359115', '2017-09-06 15:11:10');

-- ----------------------------
-- Table structure for isale_rentdetail
-- ----------------------------
DROP TABLE IF EXISTS `isale_rentdetail`;
CREATE TABLE `isale_rentdetail` (
  `rentdetail_code` varchar(500) DEFAULT NULL COMMENT '租金收费详细编码',
  `rentdetail_name` varchar(500) DEFAULT NULL COMMENT '扣费明细名称',
  `rentdetail_price` varchar(200) DEFAULT NULL COMMENT '租金收费金额',
  `rentdetail_currentprice` varchar(500) DEFAULT NULL COMMENT '租金收费操作后的金额',
  `rentdetail_remark` text COMMENT '资金收费明细说明',
  `rent_code` varchar(500) DEFAULT NULL COMMENT '资金详细表编码',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_rentdetail
-- ----------------------------
INSERT INTO `isale_rentdetail` VALUES ('4011504681869100005060463', '日租扣费', '0', '-50.28', '货品：王老吉 ,SKU：WANGLAOJI ,入库时间：2017-09-06 15:11:09 ,日租扣费：0m³×10元/m³/天', '4001504681869100000313966', '2017-09-06 15:11:09');
INSERT INTO `isale_rentdetail` VALUES ('4011504681870100006620733', '日租扣费', '0.01', '-50.29', '货品：华为P10 ,SKU：100 ,入库时间：2017-09-06 15:11:10 ,日租扣费：0.00000001m³×10元/m³/天', '4001504681870100004360424', '2017-09-06 15:11:10');
INSERT INTO `isale_rentdetail` VALUES ('4011504681870100000249781', '日租扣费', '0.01', '-50.30', '货品：苹果手机6 ,SKU：iphone6 ,入库时间：2017-09-06 15:11:10 ,日租扣费：0.000000005m³×10元/m³/天', '4001504681870100000022396', '2017-09-06 15:11:10');

-- ----------------------------
-- Table structure for isale_rentrule
-- ----------------------------
DROP TABLE IF EXISTS `isale_rentrule`;
CREATE TABLE `isale_rentrule` (
  `rentrule_code` varchar(500) DEFAULT NULL COMMENT '租金规则编码',
  `rentrule_short` varchar(500) DEFAULT NULL COMMENT '短租(金额/天)',
  `rentrule_long` varchar(500) DEFAULT NULL COMMENT '长租(金额/天)',
  `rentrule_longnorms` varchar(500) DEFAULT NULL COMMENT '长租规格(多少天算长租)',
  `user_code` varchar(500) NOT NULL COMMENT '用户编码',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_rentrule
-- ----------------------------
INSERT INTO `isale_rentrule` VALUES ('1311453705774974659', '10', '8', '30', '1011450323745900191', '2016-01-25 15:08:03');

-- ----------------------------
-- Table structure for isale_role
-- ----------------------------
DROP TABLE IF EXISTS `isale_role`;
CREATE TABLE `isale_role` (
  `role_code` varchar(500) NOT NULL COMMENT '角色编码',
  `role_name` varchar(500) NOT NULL COMMENT '角色名称',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of isale_role
-- ----------------------------
INSERT INTO `isale_role` VALUES ('1021450323862418613000000', '仓库管理人员组', '2016-01-18 21:50:33');
INSERT INTO `isale_role` VALUES ('1021450323862418614000000', '仓库工作人员组', '2016-01-18 21:50:13');
INSERT INTO `isale_role` VALUES ('1021453125019024327000000', '货主组', '2016-01-18 21:50:00');

-- ----------------------------
-- Table structure for isale_rolemenu
-- ----------------------------
DROP TABLE IF EXISTS `isale_rolemenu`;
CREATE TABLE `isale_rolemenu` (
  `menu_code` varchar(500) DEFAULT NULL COMMENT '菜单编码',
  `role_code` varchar(500) DEFAULT NULL COMMENT '角色编码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单角色关联表';

-- ----------------------------
-- Records of isale_rolemenu
-- ----------------------------
INSERT INTO `isale_rolemenu` VALUES ('101', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('102', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('103', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('104', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('201', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('202', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('203', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('204', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('205', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('206', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('207', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('301', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('302', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('303', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('401', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('403', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('100', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('200', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('300', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('400', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('404', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('405', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('406', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('500', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('501', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('202', '1021453125019024327000000');
INSERT INTO `isale_rolemenu` VALUES ('401', '1021453125019024327000000');
INSERT INTO `isale_rolemenu` VALUES ('403', '1021453125019024327000000');
INSERT INTO `isale_rolemenu` VALUES ('404', '1021453125019024327000000');
INSERT INTO `isale_rolemenu` VALUES ('501', '1021453125019024327000000');
INSERT INTO `isale_rolemenu` VALUES ('203', '1021453125019024327000000');
INSERT INTO `isale_rolemenu` VALUES ('200', '1021453125019024327000000');
INSERT INTO `isale_rolemenu` VALUES ('400', '1021453125019024327000000');
INSERT INTO `isale_rolemenu` VALUES ('500', '1021453125019024327000000');
INSERT INTO `isale_rolemenu` VALUES ('407', '1021453125019024327000000');
INSERT INTO `isale_rolemenu` VALUES ('407', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('208', '1021450323862418613000000');
INSERT INTO `isale_rolemenu` VALUES ('502', '1021450323862418613000000');

-- ----------------------------
-- Table structure for isale_salvercar
-- ----------------------------
DROP TABLE IF EXISTS `isale_salvercar`;
CREATE TABLE `isale_salvercar` (
  `salvercar_code` varchar(500) DEFAULT NULL COMMENT '托盘车系统编码',
  `salvercar_number` varchar(500) DEFAULT NULL COMMENT '托盘车编号',
  `salvercar_type` int(2) DEFAULT NULL COMMENT '托盘车类型（1：板车，2：篮车）',
  `salvercar_weight` varchar(500) DEFAULT NULL COMMENT '托盘车重量',
  `salvercar_length` varchar(500) DEFAULT NULL COMMENT '托盘车长度(单位:mm)',
  `salvercar_width` varchar(500) DEFAULT NULL COMMENT '托盘车宽度(单位:mm)',
  `salvercar_heigth` varchar(500) DEFAULT NULL COMMENT '托盘车高度(单位:mm)',
  `salvercar_bulk` varchar(500) DEFAULT NULL COMMENT '托盘车体积',
  `salvershelf_col` varchar(500) DEFAULT NULL COMMENT '托盘车规格（列）',
  `salvershelf_ros` varchar(500) DEFAULT NULL COMMENT '托盘车规格（行）',
  `salvershelf_totalbulk` varchar(500) DEFAULT NULL COMMENT '托盘车总体积',
  `salvershelf_usestate` int(2) DEFAULT '1' COMMENT '托盘车使用状态(1：未使用、2：使用中)',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_salvercar
-- ----------------------------
INSERT INTO `isale_salvercar` VALUES ('2061503890455221821645499', 'BC-001', '1', '100', '10', '10', '10', '1000', null, null, null, '1', '2017-08-28 11:20:55');
INSERT INTO `isale_salvercar` VALUES ('2061503890501725177165160', 'LC-001', '2', '100', '100', '100', '100', '1000000', '30', '30', '900000000', '1', '2017-08-28 11:21:41');

-- ----------------------------
-- Table structure for isale_space
-- ----------------------------
DROP TABLE IF EXISTS `isale_space`;
CREATE TABLE `isale_space` (
  `space_code` varchar(500) NOT NULL COMMENT '货位系统编码',
  `space_number` varchar(500) DEFAULT NULL COMMENT '货位编号',
  `space_linenumber` varchar(500) DEFAULT NULL COMMENT '货位动线号',
  `space_weight` varchar(500) DEFAULT NULL COMMENT '货位承重',
  `space_length` varchar(500) DEFAULT NULL COMMENT '货位长(单位:mm)',
  `space_width` varchar(500) DEFAULT NULL COMMENT '货位宽(单位:mm)',
  `space_heigth` varchar(500) DEFAULT NULL COMMENT '货位高(单位:mm)',
  `space_length_sort` varchar(500) DEFAULT NULL COMMENT '货位排序后长边(单位:mm)',
  `space_width_sort` varchar(500) DEFAULT NULL COMMENT '货位排序后中边(单位:mm)',
  `space_heigth_sort` varchar(500) DEFAULT NULL COMMENT '货位排序后短边(单位:mm)',
  `space_bulk` varchar(500) DEFAULT NULL COMMENT '货位体积',
  `space_usedbulk` varchar(500) DEFAULT NULL COMMENT '货位已用体积',
  `space_leftbulk` varchar(500) DEFAULT NULL COMMENT '货位剩余体积',
  `space_upbulk` varchar(500) DEFAULT NULL COMMENT '待上架体积（为推荐货位存储过程写入时候,同步体积）',
  `space_remark` varchar(500) DEFAULT NULL COMMENT '货位备注',
  `space_type` int(2) DEFAULT NULL COMMENT '货位类型(1:普通货位、2:顶层货位、3:高位货位、4:借货货位【不参与上下架业务】)',
  `space_state` int(2) DEFAULT NULL COMMENT '货位状态(1:生效、2:失效)',
  `space_usestate` int(2) DEFAULT NULL COMMENT '货位使用状态(1:未使用、2:已使用)',
  `space_lockstate` int(2) DEFAULT NULL COMMENT '货位是否锁定(1:未锁定、2:锁定)',
  `space_halftype` int(2) DEFAULT NULL COMMENT '货位(1：始发仓货位、2：中转仓成品货位、3：中转仓半成品货位)',
  `space_parentcode` varchar(500) DEFAULT NULL COMMENT '货位绑定的顶层货位编码',
  `area_code` varchar(500) DEFAULT NULL COMMENT '货位区系统编码',
  `user_code` varchar(500) DEFAULT NULL COMMENT '锁定状态下，使用者的用户系统编码',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_space
-- ----------------------------
INSERT INTO `isale_space` VALUES ('1051503889968859116819225', 'P01-01-01', '01', '1000', '100', '100', '100', '100', '100', '100', '1000000', '450000', '550000', '0', '', '1', '1', '2', '1', '1', '1051503890056357862346129', '1081503889962751336566972', null, '2017-08-28 11:13:46');
INSERT INTO `isale_space` VALUES ('1051503890028825610720820', 'P01-01-02', '01', '1000', '100', '100', '100', '100', '100', '100', '1000000', '450000', '550000', '0', '', '1', '1', '2', '1', '1', '1051503890056357862346129', '1081503889962751336566972', '', '2017-08-28 11:14:04');
INSERT INTO `isale_space` VALUES ('1051503890046657354762478', 'P01-01-03', '01', '100', '100', '100', '100', '100', '100', '100', '1000000', '0', '1000000', '500000', '', '1', '1', '1', '1', '1', '1051503890056357862346129', '1081503889962751336566972', null, '2017-08-28 11:14:14');
INSERT INTO `isale_space` VALUES ('1051503890056357862346129', 'D01-01-01', '01', '100', '100', '100', '100', '100', '100', '100', '1000000', '300000', '700000', '1000000', '', '2', '1', '2', '1', '1', null, '1081503889962751336566972', '', '2017-08-28 11:14:44');
INSERT INTO `isale_space` VALUES ('1051503890091861443486815', 'G01-01-01', '01', '100', '100', '100', '100', '100', '100', '100', '1000000', '300000', '700000', '0', '', '3', '1', '2', '1', '1', null, '1081503889962751336566972', null, '2017-08-28 11:15:05');
INSERT INTO `isale_space` VALUES ('1051503890107959685494438', 'J01-01-01', '01', '1000', '100', '100', '100', '100', '100', '100', '1000000', '0', '1000000', '0', '', '4', '1', '1', '1', '1', null, '1081503889962751336566972', null, '2017-08-28 11:15:21');
INSERT INTO `isale_space` VALUES ('1051503890123351480475401', 'P02-01-01', '02', '100', '100', '100', '100', '100', '100', '100', '1000000', '0', '1000000', '0', '', '1', '1', '1', '1', '1', null, '1081503889962751336566972', null, '2017-08-28 11:15:35');
INSERT INTO `isale_space` VALUES ('1051503890191981295282551', 'P-C-03-01-01', '03', '100', '100', '100', '100', '100', '100', '100', '1000000', '0', '1000000', '0', '', '1', '1', '1', '1', '2', '1051503890277652209417124', '1081503890153513808101310', null, '2017-08-28 11:17:29');
INSERT INTO `isale_space` VALUES ('1051503890251384507744991', 'P-BC-03-01-01', '03', '100', '100', '100', '100', '100', '100', '100', '1000000', '0', '1000000', '0', '', '1', '1', '1', '1', '3', null, '1081503890153513808101310', null, '2017-08-28 11:17:46');
INSERT INTO `isale_space` VALUES ('1051503890277652209417124', 'D03-01-01', '03', '100', '100', '100', '100', '100', '100', '100', '1000000', '0', '1000000', '0', '', '2', '1', '1', '1', '2', null, '1081503890153513808101310', null, '2017-08-28 11:18:28');

-- ----------------------------
-- Table structure for isale_spacedetail
-- ----------------------------
DROP TABLE IF EXISTS `isale_spacedetail`;
CREATE TABLE `isale_spacedetail` (
  `space_code` varchar(500) DEFAULT NULL COMMENT '货位系统编码',
  `space_halftype` int(2) DEFAULT NULL COMMENT '货位(1：始发仓货位、2：中转仓成品货位、3：中转仓半成品货位)',
  `space_count` varchar(500) DEFAULT NULL COMMENT '货品总量',
  `space_excount` varchar(500) DEFAULT NULL COMMENT '波次分析货位拣货预扣字段',
  `product_code` varchar(500) DEFAULT NULL COMMENT '货品系统编码',
  `product_name` varchar(500) DEFAULT NULL COMMENT '货品名称',
  `product_enname` varchar(500) DEFAULT NULL COMMENT '货品英文名称',
  `product_barcode` varchar(500) DEFAULT NULL COMMENT '货品条码',
  `product_sku` varchar(500) DEFAULT NULL COMMENT '货品SKU编号同步第三方平台',
  `product_unit` varchar(500) DEFAULT NULL COMMENT '货品单位',
  `product_weight` varchar(500) DEFAULT NULL COMMENT '货品重量',
  `product_length` varchar(500) DEFAULT NULL COMMENT '货品长度(单位:mm)',
  `product_width` varchar(500) DEFAULT NULL COMMENT '货品宽度(单位:mm)',
  `product_heigth` varchar(500) DEFAULT NULL COMMENT '货品高度(单位:mm)',
  `product_length_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后长边(单位:mm)',
  `product_width_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后中边(单位:mm)',
  `product_heigth_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后短边(单位:mm)',
  `product_bulk` varchar(500) DEFAULT NULL COMMENT '货品体积',
  `product_imgurl` varchar(500) DEFAULT NULL COMMENT '货品图片',
  `product_state` int(2) DEFAULT NULL COMMENT '货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)',
  `product_groupstate` int(2) DEFAULT NULL COMMENT '货品组合状态(1：未组合、2：组合)',
  `product_batterystate` int(2) DEFAULT NULL COMMENT '货品是否带电池(1：是、2：否)',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_spacedetail
-- ----------------------------
INSERT INTO `isale_spacedetail` VALUES ('1051503889968859116819225', '1', '15', '15', '2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-09/201709061131239106288977105460393_sell.png', '3', '1', '1', '2017-09-06 15:11:26');
INSERT INTO `isale_spacedetail` VALUES ('1051503890028825610720820', '1', '15', '15', '2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-09/201709061131239106288977105460393_sell.png', '3', '1', '1', '2017-09-06 15:11:34');
INSERT INTO `isale_spacedetail` VALUES ('1051503890056357862346129', '1', '10', '0', '2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-09/201709061131239106288977105460393_sell.png', '3', '1', '1', '2017-09-06 15:11:39');
INSERT INTO `isale_spacedetail` VALUES ('1051503890091861443486815', '1', '10', '0', '2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-09/201709061131239106288977105460393_sell.png', '3', '1', '1', '2017-09-06 15:11:53');
INSERT INTO `isale_spacedetail` VALUES ('1051503889968859116819225', '1', '15', '15', '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-08/201708281202208767473200554132090_sell.png', '3', '1', '1', '2017-09-06 15:12:03');
INSERT INTO `isale_spacedetail` VALUES ('1051503890028825610720820', '1', '15', '15', '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-08/201708281202208767473200554132090_sell.png', '3', '1', '1', '2017-09-06 15:12:12');
INSERT INTO `isale_spacedetail` VALUES ('1051503890056357862346129', '1', '10', '0', '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-08/201708281202208767473200554132090_sell.png', '3', '1', '1', '2017-09-06 15:12:17');
INSERT INTO `isale_spacedetail` VALUES ('1051503890091861443486815', '1', '10', '0', '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-08/201708281202208767473200554132090_sell.png', '3', '1', '1', '2017-09-06 15:12:23');
INSERT INTO `isale_spacedetail` VALUES ('1051503889968859116819225', '1', '15', '15', '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-08/201708281157598622196964211611578_sell.png', '3', '1', '1', '2017-09-06 15:12:35');
INSERT INTO `isale_spacedetail` VALUES ('1051503890028825610720820', '1', '15', '15', '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-08/201708281157598622196964211611578_sell.png', '3', '1', '1', '2017-09-06 15:12:41');
INSERT INTO `isale_spacedetail` VALUES ('1051503890056357862346129', '1', '10', '0', '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-08/201708281157598622196964211611578_sell.png', '3', '1', '1', '2017-09-06 15:12:50');
INSERT INTO `isale_spacedetail` VALUES ('1051503890091861443486815', '1', '10', '0', '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-08/201708281157598622196964211611578_sell.png', '3', '1', '1', '2017-09-06 15:13:02');

-- ----------------------------
-- Table structure for isale_spacedetaillog
-- ----------------------------
DROP TABLE IF EXISTS `isale_spacedetaillog`;
CREATE TABLE `isale_spacedetaillog` (
  `space_code` varchar(500) DEFAULT NULL COMMENT '货位系统编码',
  `space_halftype` int(2) DEFAULT NULL COMMENT '货位(1：始发仓货位、2：中转仓成品货位、3：中转仓半成品货位)',
  `space_count` varchar(500) DEFAULT NULL COMMENT '操作数量(上下架)',
  `product_code` varchar(500) DEFAULT NULL COMMENT '货品系统编码',
  `product_name` varchar(500) DEFAULT NULL COMMENT '货品名称',
  `product_enname` varchar(500) DEFAULT NULL COMMENT '货品英文名称',
  `product_barcode` varchar(500) DEFAULT NULL COMMENT '货品条码',
  `product_sku` varchar(500) DEFAULT NULL COMMENT '货品SKU编号同步第三方平台',
  `product_unit` varchar(500) CHARACTER SET utf32 DEFAULT NULL COMMENT '货品单位',
  `product_weight` varchar(500) DEFAULT NULL COMMENT '货品重量',
  `product_length` varchar(500) DEFAULT NULL COMMENT '货品长度(单位:mm)',
  `product_width` varchar(500) DEFAULT NULL COMMENT '货品宽度(单位:mm)',
  `product_heigth` varchar(500) DEFAULT NULL COMMENT '货品高度(单位:mm)',
  `product_length_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后长边(单位:mm)',
  `product_width_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后中边(单位:mm)',
  `product_heigth_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后短边(单位:mm)',
  `product_bulk` varchar(500) DEFAULT NULL COMMENT '货品体积',
  `product_imgurl` varchar(500) DEFAULT NULL COMMENT '货品图片',
  `product_state` int(2) DEFAULT NULL COMMENT '货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)',
  `product_groupstate` int(2) DEFAULT NULL COMMENT '货品组合状态(1：未组合、2：组合)',
  `product_batterystate` int(2) DEFAULT NULL COMMENT '货品是否带电池(1：是、2：否)',
  `user_code` varchar(500) DEFAULT NULL COMMENT '货主系统编码',
  `user_name` varchar(500) DEFAULT NULL COMMENT '货主用户昵称',
  `user_mobilephone` varchar(500) DEFAULT NULL COMMENT '货主用户手机号',
  `task_code` varchar(500) DEFAULT NULL COMMENT '任务系统编码',
  `task_type` int(2) DEFAULT NULL COMMENT '任务类型(1：入库、2：出库:3、拣货、4：检验货、5：盘点、6：波次分析、7：移位)',
  `task_othercode` varchar(500) DEFAULT NULL COMMENT '系统编码（入库明细、出库明细）',
  `feetime` varchar(30) DEFAULT NULL COMMENT '租户租用货位扣费时间',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_spacedetaillog
-- ----------------------------
INSERT INTO `isale_spacedetaillog` VALUES ('1051503889968859116819225', '1', '15', '2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-09/201709061131239106288977105460393_sell.png', '3', '1', '1', '1021503889252416585359115', '测试租户', '13349888812', '7001504681869419495452706', '1', '3011504681798615502889985', '2017-09-07', '2017-09-06 15:11:26');
INSERT INTO `isale_spacedetaillog` VALUES ('1051503890028825610720820', '1', '15', '2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-09/201709061131239106288977105460393_sell.png', '3', '1', '1', '1021503889252416585359115', '测试租户', '13349888812', '7001504681869419495452706', '1', '3011504681798615502889985', '2017-09-07', '2017-09-06 15:11:34');
INSERT INTO `isale_spacedetaillog` VALUES ('1051503890056357862346129', '1', '10', '2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-09/201709061131239106288977105460393_sell.png', '3', '1', '1', '1021503889252416585359115', '测试租户', '13349888812', '7001504681869419495452706', '1', '3011504681798615502889985', '2017-09-07', '2017-09-06 15:11:39');
INSERT INTO `isale_spacedetaillog` VALUES ('1051503890091861443486815', '1', '10', '2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-09/201709061131239106288977105460393_sell.png', '3', '1', '1', '1021503889252416585359115', '测试租户', '13349888812', '7001504681869419495452706', '1', '3011504681798615502889985', '2017-09-07', '2017-09-06 15:11:53');
INSERT INTO `isale_spacedetaillog` VALUES ('1051503889968859116819225', '1', '15', '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-08/201708281202208767473200554132090_sell.png', '3', '1', '1', '1021503889252416585359115', '测试租户', '13349888812', '7001504681869745240341173', '1', '3011504681798619239367694', '2017-09-07', '2017-09-06 15:12:03');
INSERT INTO `isale_spacedetaillog` VALUES ('1051503890028825610720820', '1', '15', '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-08/201708281202208767473200554132090_sell.png', '3', '1', '1', '1021503889252416585359115', '测试租户', '13349888812', '7001504681869745240341173', '1', '3011504681798619239367694', '2017-09-07', '2017-09-06 15:12:12');
INSERT INTO `isale_spacedetaillog` VALUES ('1051503890056357862346129', '1', '10', '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-08/201708281202208767473200554132090_sell.png', '3', '1', '1', '1021503889252416585359115', '测试租户', '13349888812', '7001504681869745240341173', '1', '3011504681798619239367694', '2017-09-07', '2017-09-06 15:12:17');
INSERT INTO `isale_spacedetaillog` VALUES ('1051503890091861443486815', '1', '10', '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-08/201708281202208767473200554132090_sell.png', '3', '1', '1', '1021503889252416585359115', '测试租户', '13349888812', '7001504681869745240341173', '1', '3011504681798619239367694', '2017-09-07', '2017-09-06 15:12:23');
INSERT INTO `isale_spacedetaillog` VALUES ('1051503889968859116819225', '1', '15', '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-08/201708281157598622196964211611578_sell.png', '3', '1', '1', '1021503889252416585359115', '测试租户', '13349888812', '7001504681870258614547736', '1', '3011504681798623591168014', '2017-09-07', '2017-09-06 15:12:35');
INSERT INTO `isale_spacedetaillog` VALUES ('1051503890028825610720820', '1', '15', '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-08/201708281157598622196964211611578_sell.png', '3', '1', '1', '1021503889252416585359115', '测试租户', '13349888812', '7001504681870258614547736', '1', '3011504681798623591168014', '2017-09-07', '2017-09-06 15:12:41');
INSERT INTO `isale_spacedetaillog` VALUES ('1051503890056357862346129', '1', '10', '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-08/201708281157598622196964211611578_sell.png', '3', '1', '1', '1021503889252416585359115', '测试租户', '13349888812', '7001504681870258614547736', '1', '3011504681798623591168014', '2017-09-07', '2017-09-06 15:12:50');
INSERT INTO `isale_spacedetaillog` VALUES ('1051503890091861443486815', '1', '10', '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-08/201708281157598622196964211611578_sell.png', '3', '1', '1', '1021503889252416585359115', '测试租户', '13349888812', '7001504681870258614547736', '1', '3011504681798623591168014', '2017-09-07', '2017-09-06 15:13:02');

-- ----------------------------
-- Table structure for isale_storage
-- ----------------------------
DROP TABLE IF EXISTS `isale_storage`;
CREATE TABLE `isale_storage` (
  `storage_code` varchar(500) DEFAULT NULL COMMENT '库存系统编码',
  `storage_count` varchar(500) DEFAULT NULL COMMENT '库存数量',
  `storage_excount` varchar(500) DEFAULT '0' COMMENT '待扣减数量',
  `storage_state` int(1) unsigned zerofill DEFAULT '1' COMMENT '库存状态(1:有库存、2:无库存)',
  `storage_halftype` int(2) DEFAULT NULL COMMENT '库存类型(1：始发仓货位、2：中转仓成品货位、3：中转仓半成品货位)',
  `product_code` varchar(500) DEFAULT NULL COMMENT '货品系统编码',
  `product_name` varchar(500) DEFAULT NULL COMMENT '货品名称',
  `product_enname` varchar(500) DEFAULT NULL COMMENT '货品英文名称',
  `product_barcode` varchar(500) DEFAULT NULL COMMENT '货品条码',
  `product_sku` varchar(500) DEFAULT NULL COMMENT '货品SKU编号同步第三方平台',
  `product_unit` varchar(500) CHARACTER SET utf32 DEFAULT NULL COMMENT '货品单位',
  `product_weight` varchar(500) DEFAULT NULL COMMENT '货品重量',
  `product_length` varchar(500) DEFAULT NULL COMMENT '货品长度(单位:mm)',
  `product_width` varchar(500) DEFAULT NULL COMMENT '货品宽度(单位:mm)',
  `product_heigth` varchar(500) DEFAULT NULL COMMENT '货品高度(单位:mm)',
  `product_length_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后长边(单位:mm)',
  `product_width_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后中边(单位:mm)',
  `product_heigth_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后短边(单位:mm)',
  `product_bulk` varchar(500) DEFAULT NULL COMMENT '货品体积',
  `product_imgurl` varchar(500) DEFAULT NULL COMMENT '货品图片',
  `product_state` int(2) DEFAULT NULL COMMENT '货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)',
  `product_groupstate` int(2) DEFAULT NULL COMMENT '货品组合状态(1：未组合、2：组合)',
  `product_batterystate` int(2) DEFAULT NULL COMMENT '货品是否带电池(1：是、2：否)',
  `user_code` varchar(500) DEFAULT NULL COMMENT '货主系统编码',
  `user_name` varchar(500) DEFAULT NULL COMMENT '用户昵称',
  `user_mobilephone` varchar(500) DEFAULT NULL COMMENT '用户手机号',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_storage
-- ----------------------------
INSERT INTO `isale_storage` VALUES ('4021504681700660984474958', '50', '30', '1', '1', '2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-09/201709061131239106288977105460393_sell.png', '3', '1', '1', '1021503889252416585359115', '测试租户', '13349888812', '2017-09-06 15:11:26');
INSERT INTO `isale_storage` VALUES ('4021504681737115843567073', '50', '30', '1', '1', '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-08/201708281202208767473200554132090_sell.png', '3', '1', '1', '1021503889252416585359115', '测试租户', '13349888812', '2017-09-06 15:12:03');
INSERT INTO `isale_storage` VALUES ('4021504681769615229091046', '50', '30', '1', '1', '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images/2017-08/201708281157598622196964211611578_sell.png', '3', '1', '1', '1021503889252416585359115', '测试租户', '13349888812', '2017-09-06 15:12:35');

-- ----------------------------
-- Table structure for isale_task
-- ----------------------------
DROP TABLE IF EXISTS `isale_task`;
CREATE TABLE `isale_task` (
  `task_code` varchar(500) DEFAULT NULL COMMENT '任务系统编码',
  `task_type` int(2) DEFAULT NULL COMMENT '任务类型(1：入库、2：出库、3：拣货、4：检验货、5：盘点、6：波次分析、7：移位、8：推荐移位、9：加工)',
  `task_othercode` varchar(500) DEFAULT NULL COMMENT '关联的系统编码',
  `task_count` varchar(500) DEFAULT NULL COMMENT '数量',
  `task_content` varchar(500) DEFAULT NULL COMMENT '任务内容',
  `task_state` int(2) DEFAULT '1' COMMENT '任务状态(1：待处理、2：处理中、3：已完成)',
  `product_code` varchar(500) DEFAULT NULL COMMENT '货品系统编码',
  `product_name` varchar(500) DEFAULT NULL COMMENT '货品名称',
  `product_enname` varchar(500) DEFAULT NULL COMMENT '货品英文名称',
  `product_barcode` varchar(500) DEFAULT NULL COMMENT '货品条码',
  `product_sku` varchar(500) DEFAULT NULL COMMENT '货品SKU编号同步第三方平台',
  `product_unit` varchar(500) CHARACTER SET utf32 DEFAULT NULL COMMENT '货品单位',
  `product_weight` varchar(500) DEFAULT NULL COMMENT '货品重量',
  `product_length` varchar(500) DEFAULT NULL COMMENT '货品长度(单位:mm)',
  `product_width` varchar(500) DEFAULT NULL COMMENT '货品宽度(单位:mm)',
  `product_heigth` varchar(500) DEFAULT NULL COMMENT '货品高度(单位:mm)',
  `product_length_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后长边(单位:mm)',
  `product_width_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后中边(单位:mm)',
  `product_heigth_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后短边(单位:mm)',
  `product_bulk` varchar(500) DEFAULT NULL COMMENT '货品体积',
  `product_imgurl` varchar(500) DEFAULT NULL COMMENT '货品图片',
  `product_state` int(2) DEFAULT NULL COMMENT '货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)',
  `product_groupstate` int(2) DEFAULT NULL COMMENT '货品组合状态(1：未组合、2：组合)',
  `product_batterystate` int(2) DEFAULT NULL COMMENT '货品是否带电池(1：是、2：否)',
  `user_code` varchar(500) DEFAULT NULL COMMENT '任务拥有者的系统编码',
  `user_name` varchar(500) DEFAULT NULL COMMENT '任务拥有者用户昵称',
  `user_logourl` varchar(500) DEFAULT NULL COMMENT '任务拥有者用户头像',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_task
-- ----------------------------
INSERT INTO `isale_task` VALUES ('7001504681869419495452706', '1', '3011504681798615502889985', '50', '王老吉入库50件', '3', '2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-09\\201709061131239106288977105460393_sell.png', '3', '1', '1', '1021503889884543419268025', '手持机工作人员1', 'images/userwork.png', '2017-09-06 15:11:09');
INSERT INTO `isale_task` VALUES ('7001504681869745240341173', '1', '3011504681798619239367694', '50', '华为P10入库50个', '3', '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281202208767473200554132090_sell.png', '3', '1', '1', '1021503889884543419268025', '手持机工作人员1', 'images/userwork.png', '2017-09-06 15:11:09');
INSERT INTO `isale_task` VALUES ('7001504681870258614547736', '1', '3011504681798623591168014', '50', '苹果手机6入库50个', '3', '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281157598622196964211611578_sell.png', '3', '1', '1', '1021503889884543419268025', '手持机工作人员1', 'images/userwork.png', '2017-09-06 15:11:10');
INSERT INTO `isale_task` VALUES ('7001504682780100004703238', '3', '6021504682772100006190287', '5', '王老吉出库5', '1', '2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images2017-09201709061131239106288977105460393_sell.png', '3', '1', '1', '1021503889884543419268025', '手持机工作人员1', 'images/userwork.png', '2017-09-06 15:26:20');
INSERT INTO `isale_task` VALUES ('7001504682780100009626789', '3', '6021504682772100001574581', '5', '苹果手机6出库5', '1', '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images2017-08201708281157598622196964211611578_sell.png', '3', '1', '1', '1021503889884543419268025', '手持机工作人员1', 'images/userwork.png', '2017-09-06 15:26:20');
INSERT INTO `isale_task` VALUES ('7001504682780100004024233', '3', '6021504682772100009302045', '5', '华为P10出库5', '1', '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images2017-08201708281202208767473200554132090_sell.png', '3', '1', '1', '1021503889884543419268025', '手持机工作人员1', 'images/userwork.png', '2017-09-06 15:26:20');
INSERT INTO `isale_task` VALUES ('7001504682780100001240802', '3', '6021504682772100001786486', '5', '华为P10出库5', '1', '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images2017-08201708281202208767473200554132090_sell.png', '3', '1', '1', '1021503889884543419268025', '手持机工作人员1', 'images/userwork.png', '2017-09-06 15:26:20');
INSERT INTO `isale_task` VALUES ('7001504682780100004131312', '3', '6021504682772100001026294', '5', '王老吉出库5', '1', '2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images2017-09201709061131239106288977105460393_sell.png', '3', '1', '1', '1021503889884543419268025', '手持机工作人员1', 'images/userwork.png', '2017-09-06 15:26:20');
INSERT INTO `isale_task` VALUES ('7001504682780100006934155', '3', '6021504682772100009772012', '5', '苹果手机6出库5', '1', '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images2017-08201708281157598622196964211611578_sell.png', '3', '1', '1', '1021503889884543419268025', '手持机工作人员1', 'images/userwork.png', '2017-09-06 15:26:20');
INSERT INTO `isale_task` VALUES ('7001504682780100002276842', '3', '6021504682772100005781186', '5', '华为P10出库5', '1', '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images2017-08201708281202208767473200554132090_sell.png', '3', '1', '1', '1021503889884543419268025', '手持机工作人员1', 'images/userwork.png', '2017-09-06 15:26:20');
INSERT INTO `isale_task` VALUES ('7001504682780100000581749', '3', '6021504682772100009589896', '5', '王老吉出库5', '1', '2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images2017-09201709061131239106288977105460393_sell.png', '3', '1', '1', '1021503889884543419268025', '手持机工作人员1', 'images/userwork.png', '2017-09-06 15:26:20');
INSERT INTO `isale_task` VALUES ('7001504682780100006078217', '3', '6021504682772100000605926', '5', '苹果手机6出库5', '1', '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images2017-08201708281157598622196964211611578_sell.png', '3', '1', '1', '1021503889884543419268025', '手持机工作人员1', 'images/userwork.png', '2017-09-06 15:26:20');
INSERT INTO `isale_task` VALUES ('7001504682780100008645841', '3', '6021504682772100004259940', '15', '华为P10出库15', '1', '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images2017-08201708281202208767473200554132090_sell.png', '3', '1', '1', '1021503889884543419268025', '手持机工作人员1', 'images/userwork.png', '2017-09-06 15:26:20');
INSERT INTO `isale_task` VALUES ('7001504682780100004994559', '3', '6021504682772100009481923', '15', '王老吉出库15', '1', '2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images2017-09201709061131239106288977105460393_sell.png', '3', '1', '1', '1021503889884543419268025', '手持机工作人员1', 'images/userwork.png', '2017-09-06 15:26:20');
INSERT INTO `isale_task` VALUES ('7001504682780100009035272', '3', '6021504682772100004629801', '15', '苹果手机6出库15', '1', '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images2017-08201708281157598622196964211611578_sell.png', '3', '1', '1', '1021503889884543419268025', '手持机工作人员1', 'images/userwork.png', '2017-09-06 15:26:20');

-- ----------------------------
-- Table structure for isale_user
-- ----------------------------
DROP TABLE IF EXISTS `isale_user`;
CREATE TABLE `isale_user` (
  `user_code` varchar(500) NOT NULL COMMENT '用户系统编码',
  `user_loginname` varchar(500) DEFAULT NULL COMMENT '登录账号',
  `user_loginpass` varchar(500) DEFAULT NULL COMMENT '登录密码',
  `user_type` varchar(500) DEFAULT NULL COMMENT '用户类型(1:管理员 2:工作人员 3:货主)',
  `user_name` varchar(500) DEFAULT NULL COMMENT '用户昵称',
  `user_mobilephone` varchar(500) DEFAULT NULL COMMENT '用户手机号',
  `user_logourl` varchar(500) DEFAULT NULL COMMENT '用户头像',
  `user_state` int(1) DEFAULT '1' COMMENT '用户状态(1启用,2禁用)',
  `user_workstate` int(1) DEFAULT '1' COMMENT '用户上下班状态(1：上班、2：下班)',
  `user_rent_price` varchar(500) DEFAULT '0' COMMENT '用户租金',
  `user_arrearage_price` varchar(500) DEFAULT '0' COMMENT '用户最低欠费金额',
  `company_code` varchar(500) DEFAULT NULL COMMENT '企业编码',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of isale_user
-- ----------------------------
INSERT INTO `isale_user` VALUES ('1021488762386288434000000', 'admin', '123123', '1', '超级管理员', '13900001111', 'resources/images\\2017-08\\201708281110068802220031473555906_admin.png', '1', '1', '0', '0', '1011450323390392711414528', '2017-03-06 09:06:49');
INSERT INTO `isale_user` VALUES ('1021503889252416585359115', 'sell', '123123', '3', '测试租户', '13349888812', 'images/userclient.png', '1', '1', '-50.30', '100000', '1011503889215519398414528', '2017-08-28 11:00:52');
INSERT INTO `isale_user` VALUES ('1021503889884543419268025', 'work', '123123', '2', '手持机工作人员1', '13333333333', 'images/userwork.png', '1', '1', '0', null, '1011450323390392711414528', '2017-08-28 11:11:24');
INSERT INTO `isale_user` VALUES ('1021503889918872336388545', 'worker', '123123', '2', '手持机工作人员2', '13444444444', 'images/userwork.png', '1', '1', '0', null, '1011450323390392711414528', '2017-08-28 11:11:58');

-- ----------------------------
-- Table structure for isale_userrole
-- ----------------------------
DROP TABLE IF EXISTS `isale_userrole`;
CREATE TABLE `isale_userrole` (
  `user_code` varchar(500) DEFAULT NULL COMMENT '用户编码',
  `role_code` varchar(500) DEFAULT NULL COMMENT '角色编码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色关联表';

-- ----------------------------
-- Records of isale_userrole
-- ----------------------------
INSERT INTO `isale_userrole` VALUES ('1021503889884543419268025', '1021450323862418614');
INSERT INTO `isale_userrole` VALUES ('1021503889918872336388545', '1021450323862418614');
INSERT INTO `isale_userrole` VALUES ('1021503889252416585359115', '1021453125019024327000000');
INSERT INTO `isale_userrole` VALUES ('1021488762386288434000000', '1021450323862418613000000');

-- ----------------------------
-- Table structure for isale_warning
-- ----------------------------
DROP TABLE IF EXISTS `isale_warning`;
CREATE TABLE `isale_warning` (
  `warning_code` varchar(500) DEFAULT NULL COMMENT '拿取不足预警系统编码',
  `warning_name` varchar(500) DEFAULT NULL COMMENT '预警名称（默认货位货品异常）',
  `warning_state` int(2) DEFAULT '1' COMMENT '预警状态（1、待处理，2、已处理）',
  `warning_count` varchar(255) DEFAULT NULL COMMENT '缺失数量（差值）',
  `wave_code` varchar(500) DEFAULT NULL COMMENT '波次系统编码',
  `task_code` varchar(500) DEFAULT NULL COMMENT '任务系统编码',
  `product_code` varchar(500) DEFAULT NULL COMMENT '货品系统编码',
  `product_name` varchar(500) DEFAULT NULL COMMENT '货品名称',
  `space_code` varchar(500) DEFAULT NULL COMMENT '货位系统编码',
  `space_number` varchar(500) DEFAULT NULL COMMENT '货位编号',
  `space_halftype` int(2) DEFAULT NULL COMMENT '货位(1：始发仓货位、2：中转仓成品货位、3：中转仓半成品货位)',
  `user_code` varchar(500) DEFAULT NULL COMMENT '填报预警用户编码',
  `user_name` varchar(500) DEFAULT NULL COMMENT '填报预警用户姓名',
  `user_logourl` varchar(500) DEFAULT NULL COMMENT '填报预警用户头像',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_warning
-- ----------------------------

-- ----------------------------
-- Table structure for isale_wave
-- ----------------------------
DROP TABLE IF EXISTS `isale_wave`;
CREATE TABLE `isale_wave` (
  `wave_code` varchar(500) DEFAULT NULL COMMENT '波次系统编码',
  `wave_name` varchar(500) DEFAULT NULL COMMENT '波次分析人员名称+时间',
  `wave_state` int(2) DEFAULT '1' COMMENT '波次分析状态（1：可取消、2：不可取消）根据是否分配工作人员任务',
  `wave_operstate` int(2) DEFAULT '1' COMMENT '波次处理状态(1：待处理、2：分析中、3:已分析，待分配，4：已分配)',
  `wave_taskstate` int(2) DEFAULT '1' COMMENT '任务分配状态(1：待分配、2：分配中、3：已分配)',
  `wave_halftype` int(1) DEFAULT NULL COMMENT '波次分析类型(1：始发仓货位、2：中转仓成品货位、3：中转仓半成品货位)',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_wave
-- ----------------------------
INSERT INTO `isale_wave` VALUES ('6001504682770307526756420', '超级管理员在2017-09-06 15:26:12进行波次分析', '1', '4', '3', '1', '2017-09-06 15:26:12');

-- ----------------------------
-- Table structure for isale_wavedetail
-- ----------------------------
DROP TABLE IF EXISTS `isale_wavedetail`;
CREATE TABLE `isale_wavedetail` (
  `wavedetail_code` varchar(500) DEFAULT NULL COMMENT '波次明细系统编码',
  `wave_code` varchar(500) DEFAULT NULL COMMENT '波次系统编码',
  `wave_type` int(2) DEFAULT NULL COMMENT '波次分析类型(1：批间、2：非批间)',
  `wave_count` varchar(500) DEFAULT NULL COMMENT '波次分析货品数量（批间:货品数量  非批间:货品sku数量）',
  `outorder_code` varchar(500) DEFAULT NULL COMMENT '出库单系统编码',
  `product_code` varchar(500) DEFAULT NULL COMMENT '货品系统编码',
  `product_name` varchar(500) DEFAULT NULL COMMENT '货品名称',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_wavedetail
-- ----------------------------
INSERT INTO `isale_wavedetail` VALUES ('6011504682772100004595591', '6001504682770307526756420', '2', '3', '3031504682648272307835617', null, null, '2017-09-06 15:26:12');
INSERT INTO `isale_wavedetail` VALUES ('6011504682772100004942097', '6001504682770307526756420', '2', '3', '3031504682655758234587307', null, null, '2017-09-06 15:26:12');
INSERT INTO `isale_wavedetail` VALUES ('6011504682772100000923715', '6001504682770307526756420', '2', '3', '3031504682664812750567168', null, null, '2017-09-06 15:26:12');
INSERT INTO `isale_wavedetail` VALUES ('6011504682772100009792286', '6001504682770307526756420', '2', '3', '3031504682673788753153868', null, null, '2017-09-06 15:26:12');

-- ----------------------------
-- Table structure for isale_wavedetailspace
-- ----------------------------
DROP TABLE IF EXISTS `isale_wavedetailspace`;
CREATE TABLE `isale_wavedetailspace` (
  `wavedetailspace_code` varchar(500) DEFAULT NULL COMMENT '波次明细货位系统编码',
  `wavedetail_code` varchar(500) DEFAULT NULL COMMENT '波次明细系统编码',
  `wave_code` varchar(255) DEFAULT NULL COMMENT '波次分析系统编码',
  `wavedetail_count` varchar(500) DEFAULT NULL COMMENT '波次明细对应货品拣货数量',
  `wavedetail_excount` varchar(500) DEFAULT NULL COMMENT '已拣货数量',
  `product_code` varchar(500) DEFAULT NULL COMMENT '货品系统编码',
  `product_name` varchar(500) DEFAULT NULL COMMENT '货品名称',
  `product_enname` varchar(500) DEFAULT NULL COMMENT '货品英文名称',
  `product_barcode` varchar(500) DEFAULT NULL COMMENT '货品条码',
  `product_sku` varchar(500) DEFAULT NULL COMMENT '货品SKU编号同步第三方平台',
  `product_unit` varchar(500) DEFAULT NULL COMMENT '货品单位',
  `product_weight` varchar(500) DEFAULT NULL COMMENT '货品重量',
  `product_length` varchar(500) DEFAULT NULL COMMENT '货品长度(单位:mm)',
  `product_width` varchar(500) DEFAULT NULL COMMENT '货品宽度(单位:mm)',
  `product_heigth` varchar(500) DEFAULT NULL COMMENT '货品高度(单位:mm)',
  `product_length_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后长边(单位:mm)',
  `product_width_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后中边(单位:mm)',
  `product_heigth_sort` varchar(500) DEFAULT NULL COMMENT '货品排序后短边(单位:mm)',
  `product_bulk` varchar(500) DEFAULT NULL COMMENT '货品体积',
  `product_imgurl` varchar(500) DEFAULT NULL COMMENT '货品图片',
  `product_state` int(2) DEFAULT NULL COMMENT '货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)',
  `product_groupstate` int(2) DEFAULT NULL COMMENT '货品组合状态(1：未组合、2：组合)',
  `product_batterystate` int(2) DEFAULT NULL COMMENT '货品是否带电池(1：是、2：否)',
  `space_code` varchar(500) DEFAULT NULL COMMENT '货位系统编码',
  `space_number` varchar(500) DEFAULT NULL COMMENT '货位编号',
  `space_linenumber` varchar(500) DEFAULT NULL COMMENT '货位动线号',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_wavedetailspace
-- ----------------------------
INSERT INTO `isale_wavedetailspace` VALUES ('6021504682772100006190287', '6011504682772100004595591', '6001504682770307526756420', '5', null, '2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-09\\201709061131239106288977105460393_sell.png', '3', '1', '1', '1051503889968859116819225', 'P01-01-01', '01', '2017-09-06 15:26:12');
INSERT INTO `isale_wavedetailspace` VALUES ('6021504682772100001574581', '6011504682772100004595591', '6001504682770307526756420', '5', null, '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281157598622196964211611578_sell.png', '3', '1', '1', '1051503889968859116819225', 'P01-01-01', '01', '2017-09-06 15:26:12');
INSERT INTO `isale_wavedetailspace` VALUES ('6021504682772100009302045', '6011504682772100004595591', '6001504682770307526756420', '5', null, '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281202208767473200554132090_sell.png', '3', '1', '1', '1051503889968859116819225', 'P01-01-01', '01', '2017-09-06 15:26:12');
INSERT INTO `isale_wavedetailspace` VALUES ('6021504682772100001786486', '6011504682772100004942097', '6001504682770307526756420', '5', null, '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281202208767473200554132090_sell.png', '3', '1', '1', '1051503889968859116819225', 'P01-01-01', '01', '2017-09-06 15:26:12');
INSERT INTO `isale_wavedetailspace` VALUES ('6021504682772100001026294', '6011504682772100004942097', '6001504682770307526756420', '5', null, '2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-09\\201709061131239106288977105460393_sell.png', '3', '1', '1', '1051503889968859116819225', 'P01-01-01', '01', '2017-09-06 15:26:12');
INSERT INTO `isale_wavedetailspace` VALUES ('6021504682772100009772012', '6011504682772100004942097', '6001504682770307526756420', '5', null, '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281157598622196964211611578_sell.png', '3', '1', '1', '1051503889968859116819225', 'P01-01-01', '01', '2017-09-06 15:26:12');
INSERT INTO `isale_wavedetailspace` VALUES ('6021504682772100005781186', '6011504682772100000923715', '6001504682770307526756420', '5', null, '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281202208767473200554132090_sell.png', '3', '1', '1', '1051503889968859116819225', 'P01-01-01', '01', '2017-09-06 15:26:12');
INSERT INTO `isale_wavedetailspace` VALUES ('6021504682772100009589896', '6011504682772100000923715', '6001504682770307526756420', '5', null, '2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-09\\201709061131239106288977105460393_sell.png', '3', '1', '1', '1051503889968859116819225', 'P01-01-01', '01', '2017-09-06 15:26:12');
INSERT INTO `isale_wavedetailspace` VALUES ('6021504682772100000605926', '6011504682772100000923715', '6001504682770307526756420', '5', null, '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281157598622196964211611578_sell.png', '3', '1', '1', '1051503889968859116819225', 'P01-01-01', '01', '2017-09-06 15:26:12');
INSERT INTO `isale_wavedetailspace` VALUES ('6021504682772100004259940', '6011504682772100009792286', '6001504682770307526756420', '15', null, '2001503892991638434396248', '华为P10', 'HWP10', '1000', '100', '个', '0.2', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281202208767473200554132090_sell.png', '3', '1', '1', '1051503890028825610720820', 'P01-01-02', '01', '2017-09-06 15:26:12');
INSERT INTO `isale_wavedetailspace` VALUES ('6021504682772100009481923', '6011504682772100009792286', '6001504682770307526756420', '15', null, '2001504666907916374314996', '王老吉', 'WANGLAOJI', 'WANGLAOJI', 'WANGLAOJI', '件', '0.01', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-09\\201709061131239106288977105460393_sell.png', '3', '1', '1', '1051503890028825610720820', 'P01-01-02', '01', '2017-09-06 15:26:12');
INSERT INTO `isale_wavedetailspace` VALUES ('6021504682772100004629801', '6011504682772100009792286', '6001504682770307526756420', '15', null, '2001503892768198700795858', '苹果手机6', 'iphone6', '2000', 'iphone6', '个', '0.1', '100', '10', '10', '100', '10', '10', '10000', 'resources/images\\2017-08\\201708281157598622196964211611578_sell.png', '3', '1', '1', '1051503890028825610720820', 'P01-01-02', '01', '2017-09-06 15:26:12');

-- ----------------------------
-- Table structure for isale_waveoutorder
-- ----------------------------
DROP TABLE IF EXISTS `isale_waveoutorder`;
CREATE TABLE `isale_waveoutorder` (
  `wavedetail_code` varchar(500) DEFAULT NULL COMMENT '波次明细系统编码',
  `outorder_code` varchar(500) DEFAULT NULL COMMENT '出库单系统编码',
  `wave_code` varchar(500) DEFAULT NULL COMMENT '波次系统编码',
  `wave_type` int(2) DEFAULT NULL COMMENT '波次分析类型(1：批间、2：非批间)',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of isale_waveoutorder
-- ----------------------------
INSERT INTO `isale_waveoutorder` VALUES ('6011504682772100004595591', '3031504682648272307835617', '6001504682770307526756420', '2', '2017-09-06 15:26:12');
INSERT INTO `isale_waveoutorder` VALUES ('6011504682772100004942097', '3031504682655758234587307', '6001504682770307526756420', '2', '2017-09-06 15:26:12');
INSERT INTO `isale_waveoutorder` VALUES ('6011504682772100000923715', '3031504682664812750567168', '6001504682770307526756420', '2', '2017-09-06 15:26:12');
INSERT INTO `isale_waveoutorder` VALUES ('6011504682772100009792286', '3031504682673788753153868', '6001504682770307526756420', '2', '2017-09-06 15:26:12');

-- ----------------------------
-- Procedure structure for proc_check_products_a
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_check_products_a`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_check_products_a`(_check_code varchar(500),_space_halftype int,_user_code varchar(500),_user_name varchar(500),_task_user_code varchar(500),_task_user_name varchar(500),_task_user_logourl varchar(500),_product_codes varchar(500),out result int)
BEGIN
		DECLARE _check_allocatstate INT;   #分配状态
		DECLARE _sql VARCHAR(500);	
		
    SELECT check_allocatstate INTO _check_allocatstate FROM isale_check WHERE check_code = _check_code;
		#SELECT CONCAT('_check_allocatstate：',(_check_allocatstate+0) = 1);
		
    IF (_check_allocatstate+0) = 1 THEN
				#调用分配人员存储
				#SELECT '开始分配';
				#创建临时表存储需要判断的货品集合  if not EXISTS不存在则创建
				CREATE TEMPORARY TABLE IF NOT EXISTS isale_check_products_tmp 
				( 
					product_code VARCHAR(500),product_name VARCHAR(500),product_sku VARCHAR(500)
				);
				
			  SET _sql = CONCAT('INSERT INTO isale_check_products_tmp SELECT p.product_code,p.product_name,p.product_sku FROM isale_product p WHERE p.product_code in (',_product_codes,')');   -- 拼接查询sql语句
				SET @_sql = _sql;
				PREPARE stmt FROM @_sql;
				EXECUTE stmt;
				deallocate prepare stmt;
				
				#SELECT * FROM isale_check_products_tmp;
				CALL proc_check_products_b(_check_code,_space_halftype,_user_code,_user_name,_task_user_code,_task_user_name,_task_user_logourl);
				
				#更新任务人员、已分配
				UPDATE isale_check SET check_state = 2, check_allocatstate = 2,task_user_code = _task_user_code, task_user_name = _task_user_name,task_user_logourl = _task_user_logourl  WHERE check_code = _check_code;

				SET result = 1;
		ELSE
				SET result = 2;   #已分配
		END IF;

		#删除临时表
		DROP TABLE isale_check_products_tmp;
		SELECT result;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_check_products_b
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_check_products_b`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_check_products_b`(_check_code varchar(500),_space_halftype int,_user_code varchar(500),_user_name varchar(500),_task_user_code varchar(500),_task_user_name varchar(500),_task_user_logourl varchar(500))
BEGIN
		DECLARE _product_code VARCHAR(500);					 #货品编码
		DECLARE _product_name VARCHAR(500);					 #货品名称
		DECLARE _product_sku  VARCHAR(500);          #货品sku
	  DECLARE done, error BOOLEAN DEFAULT FALSE;	 #遍历数据结束标志

	 #查询临时表中货品集合
	 DECLARE list CURSOR FOR  
	 (
			SELECT product_code,product_name,product_sku FROM isale_check_products_tmp
	  );
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
		
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _product_code,_product_name,_product_sku;
	IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
			#-----------------执行业务逻辑	
			#SELECT CONCAT('product_code ',_product_code,' product_name ',_product_name);
			#SELECT CONCAT('_task_user_code ',_task_user_code,' _task_user_name ',_task_user_name,' _task_user_logourl ',_task_user_logourl);
			#根据product_code查询存放所有货位
			CALL proc_check_products_c(_check_code,_space_halftype,_user_code,_user_name,_task_user_code,_task_user_name,_task_user_logourl,_product_code,_product_name,_product_sku);

		END LOOP;
			
	  /*关闭光标*/ 
		CLOSE list; 	

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_check_products_c
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_check_products_c`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_check_products_c`(_check_code varchar(500),_space_halftype int,_user_code varchar(500),_user_name varchar(500),_task_user_code varchar(500),_task_user_name varchar(500),_task_user_logourl varchar(500),_product_code varchar(500),_product_name varchar(500),_product_sku varchar(500))
BEGIN
		DECLARE _space_code VARCHAR(500);						 #货位编码
		DECLARE _space_number VARCHAR(500);					 #货位编号
		DECLARE _space_linenumber VARCHAR(500);      #货位动线号
	 	DECLARE _space_count VARCHAR(500);      		 #货位动线号
		DECLARE _checkdetail_code  VARCHAR(500);		 #盘点明细系统编码
		DECLARE _task_code VARCHAR(500);				     #任务系统编码
		DECLARE _task_content  VARCHAR(500);				 #任务内容
	  DECLARE done, error BOOLEAN DEFAULT FALSE;	 #遍历数据结束标志

	 #根据货品编码查询其所在货位
	 DECLARE list CURSOR FOR  
	 (
			SELECT s.space_code,s.space_number,s.space_linenumber,sd.space_count FROM isale_spacedetail sd 
			INNER JOIN isale_space s ON s.space_code = sd.space_code 
			WHERE sd.product_code = _product_code AND s.space_halftype = _space_halftype AND s.space_type <= 3
	  );
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
		
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _space_code,_space_number,_space_linenumber,_space_count;
	IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
			#-----------------执行业务逻辑

			
			#SELECT CONCAT('_space_number ',_space_number,' _product_code ',_product_code);
			#写入checkdetail
			#-----------------执行业务逻辑
			SET _checkdetail_code = CONCAT('801',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
			INSERT INTO isale_checkdetail(checkdetail_code,check_code,product_code,product_name,product_sku,space_code,space_number,space_linenumber,space_count,user_code,user_name)
			VALUES (_checkdetail_code,_check_code,_product_code,_product_name,_product_sku,_space_code,_space_number,_space_linenumber,_space_count,_user_code,_user_name);
			
			SET _task_code = CONCAT('700',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
			#写入task
			#SET _task_content = CONCAT('INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,user_code,user_name,user_logourl)
			##VALUES (',_task_code,5,_checkdetail_code,_space_count,_task_content,_task_user_code,_task_user_name,_task_user_logourl,');');
			
			SET _task_content = CONCAT(_space_number,'的',_product_name,'盘点');
			#SELECT CONCAT('_task_content ',_task_content);
			
			INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,user_code,user_name,user_logourl)
			VALUES (_task_code,5,_checkdetail_code,_space_count,_task_content,_task_user_code,_task_user_name,_task_user_logourl);

		END LOOP;
			
	  /*关闭光标*/ 
		CLOSE list; 	

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_check_spaces_a
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_check_spaces_a`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_check_spaces_a`(_check_code varchar(500),_space_halftype int ,_task_user_code varchar(500),_task_user_name varchar(500),_task_user_logourl varchar(500),_space_codes varchar(500),out result int)
BEGIN
		DECLARE _check_allocatstate int;   #分配状态
		DECLARE _sql VARCHAR(500);	
		

		#SELECT CONCAT('_task_user_code ',_task_user_code,' _task_user_name ',_task_user_name,' _task_user_logourl ',_task_user_logourl);
		#查询该盘点任务是否已经分配人员
    SELECT check_allocatstate INTO _check_allocatstate FROM isale_check WHERE check_code = _check_code;
		IF _check_allocatstate = 1 THEN
				#调用分配人员存储
				#SELECT '开始分配';
				
				#创建临时表存储需要判断的货品集合  if not EXISTS不存在则创建
				CREATE TEMPORARY TABLE IF NOT EXISTS isale_check_spaces_tmp 
				( 
					space_code VARCHAR(500)
				);
				
				SET _sql = CONCAT('INSERT INTO isale_check_spaces_tmp SELECT s.space_code FROM isale_space s WHERE s.space_code in (',_space_codes,')');   -- 拼接查询sql语句
				SET @_sql = _sql;
				PREPARE stmt FROM @_sql;
				EXECUTE stmt;
				deallocate prepare stmt;
				
				#SELECT * FROM isale_check_spaces_tmp;
				
				CALL proc_check_spaces_b(_check_code,_space_halftype,_task_user_code,_task_user_name,_task_user_logourl);
				
				#更新任务人员、已分配
				UPDATE isale_check SET check_state = 2,check_allocatstate = 2,task_user_code = _task_user_code, task_user_name = _task_user_name,task_user_logourl = _task_user_logourl  WHERE check_code = _check_code;

				SET result = 1;
		ELSE
				SET result = 2;   #已分配
		END IF;

		#删除临时表
		DROP TABLE isale_check_spaces_tmp;
		#设置返回值
		select result;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_check_spaces_b
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_check_spaces_b`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_check_spaces_b`(_check_code varchar(500),_space_halftype int,_task_user_code varchar(500),_task_user_name varchar(500),_task_user_logourl varchar(500))
BEGIN
		DECLARE _space_code VARCHAR(500);					   #货位编码
	  DECLARE done, error BOOLEAN DEFAULT FALSE;	 #遍历数据结束标志

	 #查询临时表中货位集合
	 DECLARE list CURSOR FOR  
	 (
			SELECT space_code FROM isale_check_spaces_tmp
	  );
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
		
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _space_code;
	IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
			#-----------------执行业务逻辑	
			#SELECT CONCAT('space_code ',_space_code);
			#SELECT CONCAT('_task_user_code ',_task_user_code,' _task_user_name ',_task_user_name,' _task_user_logourl ',_task_user_logourl);
			#根据product_code查询存放所有货位
			CALL proc_check_spaces_c(_check_code,_space_halftype,_task_user_code,_task_user_name,_task_user_logourl,_space_code);

		END LOOP;
			
	  /*关闭光标*/ 
		CLOSE list; 	

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_check_spaces_c
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_check_spaces_c`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_check_spaces_c`(_check_code varchar(500),_space_halftype int,_task_user_code varchar(500),_task_user_name varchar(500),_task_user_logourl varchar(500),_space_code varchar(500))
BEGIN
		DECLARE _space_number VARCHAR(500);					 #货位编号
		DECLARE _space_linenumber VARCHAR(500);      #货位动线号
	 	DECLARE _space_count VARCHAR(500);      		 #货位动线号
	  DECLARE _product_code VARCHAR(500);					 #货品编码
    DECLARE _product_name VARCHAR(500);					 #货品名称
	  DECLARE _product_sku VARCHAR(500);           #货品sku
		DECLARE _checkdetail_code  VARCHAR(500);		 #盘点明细系统编码
		DECLARE _task_code VARCHAR(500);				     #任务系统编码
		DECLARE _task_content  VARCHAR(500);				 #任务内容
		DECLARE _user_code VARCHAR(500);						 #租户编码
    DECLARE _user_name VARCHAR(500);						 #租户行嘛
	  DECLARE done, error BOOLEAN DEFAULT FALSE;	 #遍历数据结束标志

	  #根据货位编码查询齐下所以货品
	  DECLARE list CURSOR FOR  
	  (
			SELECT s.space_number,s.space_linenumber,sd.space_count,sd.product_code,sd.product_name,sd.product_sku,u.user_code,u.user_name FROM isale_spacedetail sd 
			INNER JOIN isale_space s ON s.space_code = sd.space_code 
			INNER JOIN isale_product p ON p.product_code = sd.product_code
			INNER JOIN isale_user u on u.user_code = p.user_code
			WHERE sd.space_code = _space_code AND s.space_halftype = _space_halftype AND s.space_type <= 3
	  );
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
		
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _space_number,_space_linenumber,_space_count,_product_code,_product_name,_product_sku,_user_code,_user_name;
	IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
			#-----------------执行业务逻辑

			
			#SELECT CONCAT('_space_number ',_space_number,' _product_code ',_product_code);
			#写入checkdetail
			#-----------------执行业务逻辑
			SET _checkdetail_code = CONCAT('801',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
			INSERT INTO isale_checkdetail(checkdetail_code,check_code,product_code,product_name,product_sku,space_code,space_number,space_linenumber,space_count,user_code,user_name)
			VALUES (_checkdetail_code,_check_code,_product_code,_product_name,_product_sku,_space_code,_space_number,_space_linenumber,_space_count,_user_code,_user_name);
			
			SET _task_code = CONCAT('700',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
			#写入task
			#SET _task_content = CONCAT('INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,user_code,user_name,user_logourl)
			##VALUES (',_task_code,5,_checkdetail_code,_space_count,_task_content,_task_user_code,_task_user_name,_task_user_logourl,');');
			
			SET _task_content = CONCAT(_space_number,'的',_product_name,'盘点');
			#SELECT CONCAT('_task_content ',_task_content);
			
			INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,user_code,user_name,user_logourl)
			VALUES (_task_code,5,_checkdetail_code,_space_count,_task_content,_task_user_code,_task_user_name,_task_user_logourl);

		END LOOP;
			
	  /*关闭光标*/ 
		CLOSE list; 	

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_inorder_a
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_inorder_a`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `proc_inorder_a`(task_code varchar(500),inorderdetail_code varchar(500),product_code varchar(500),product_count varchar(500),product_bulk varchar(500),product_length_sort varchar(500),product_width_sort varchar(500),product_heigth_sort varchar(500),area_type int,inorder_mode int,space_halftype int)
BEGIN
	 DECLARE _space_code varchar(500);								#货位编码
	 DECLARE _space_length VARCHAR(500);							#货位长
	 DECLARE _space_width VARCHAR(500);							  #货位宽
	 DECLARE _space_heigth VARCHAR(500);							#货位高
   DECLARE _space_length_sort VARCHAR(500);					#排序后货位长
	 DECLARE _space_width_sort VARCHAR(500);				  #排序后货位宽
	 DECLARE _space_heigth_sort VARCHAR(500);					#排序后货位高
   DECLARE x int; 																	#长边取模值
	 DECLARE y int; 																	#中边取模值
	 DECLARE z int;																		#短边取模值
	 DECLARE done, error BOOLEAN DEFAULT FALSE;				#遍历数据结束标志
	
	
	 #根据入库单模式（正常、退货）、入库类型（始发、中转）、（成品,半成品）、货位生效、未锁定、不是借货货位、查询货位列表,并且按长宽高分组
	 DECLARE spacelist CURSOR FOR  
	 (
		 select s.space_length,s.space_width,s.space_heigth,s.space_length_sort,s.space_width_sort,s.space_heigth_sort from isale_area a inner join isale_space s
		 on a.area_code = s.area_code
		 where a.area_type = area_type and a.area_usetype = inorder_mode
		 and s.space_state =  1 and s.space_lockstate = 1
		 and s.space_halftype = space_halftype and s.space_type <= 3 
		 GROUP BY s.space_length,s.space_width,s.space_heigth
	 );
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
	
	 #打开光标
   OPEN spacelist;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH spacelist INTO _space_length,_space_width,_space_heigth,_space_length_sort,_space_width_sort,_space_heigth_sort;
	IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
 
		  #创建临时表保存货位与货品的取模值  if not EXISTS不存在则创建
		 CREATE TEMPORARY TABLE IF NOT EXISTS isale_spacemod 
		 ( 
				 space_length VARCHAR(500),space_width VARCHAR(500),space_heigth VARCHAR(500),
			   space_length_sort VARCHAR(500),space_width_sort VARCHAR(500),space_heigth_sort VARCHAR(500),
			   modvalue INT
		  );
		

			#依次比较货位长边、中边、短边和货品长边、中边、短边大小。满足条件则按照排序后的数字计算取模值,字符串+0转换成数值进行判断
			#select  _space_length,_space_width,_space_heigth,_space_length_sort,_space_width_sort,_space_heigth_sort;
			IF (_space_length_sort+0) < (product_length_sort+0) || (_space_width_sort+0) < (product_width_sort+0) || (_space_heigth_sort+0) < (product_heigth_sort+0)  THEN
				#如果货位有一边小于商品的一边,则设置mod为-1,以便后续过滤
				#select 'a';
				insert into isale_spacemod   
			  values (_space_length,_space_width,_space_heigth,_space_length_sort,_space_width_sort,_space_heigth_sort,-1);
			ELSE	
				set x = ((_space_length_sort+0) % (product_length_sort+0));
        set y = ((_space_width_sort+0) % (product_width_sort+0));
        set z = ((_space_heigth_sort+0) % (product_heigth_sort+0));
				#select x,y,z;
        #长、中、短取模都为0 为最优
        IF x = 0 && y = 0 && z = 0 THEN
					#select 'b';
					insert into isale_spacemod   
					values (_space_length,_space_width,_space_heigth,_space_length_sort,_space_width_sort,_space_heigth_sort,0);
	      ELSE
					#select 'c';
					#有一边不为0,则按原始量计算
					IF x = 0 THEN
						SET x = _space_length_sort+0;
          END IF;
          IF y = 0 THEN
						SET y = _space_width_sort+0;
          END IF;
					IF z = 0 THEN
						SET z = _space_heigth_sort+0;
					END IF;
				  #select 'd';
					insert into isale_spacemod   
					values (_space_length,_space_width,_space_heigth,_space_length_sort,_space_width_sort,_space_heigth_sort,x*y*z);
				END IF;
	
	END IF;
			
		END LOOP;
			
	  /*关闭光标*/ 
		CLOSE spacelist; 
		
		#调用上架存储过程,根据临时表执行上架
		call proc_inorder_b(task_code,inorderdetail_code,product_count,product_bulk,area_type,inorder_mode,space_halftype);
		#删除临时表
		drop table isale_spacemod;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_inorder_b
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_inorder_b`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `proc_inorder_b`(task_code varchar(500),inorderdetail_code varchar(500),product_count varchar(500),product_bulk varchar(500),area_type int,inorder_mode int,space_halftype int)
BEGIN
	 DECLARE _space_length VARCHAR(500);							#货位长
	 DECLARE _space_width VARCHAR(500);							  #货位宽
	 DECLARE _space_heigth VARCHAR(500);							#货位高
   DECLARE _space_length_sort VARCHAR(500);					#排序后货位长
	 DECLARE _space_width_sort VARCHAR(500);				  #排序后货位宽
	 DECLARE _space_heigth_sort VARCHAR(500);					#排序后货位高
	 DECLARE _modvalue int;														#取模值
	 DECLARE _upcount int DEFAULT 0;									#单次入库任务已经上架数量
	 DECLARE done, error BOOLEAN DEFAULT FALSE;				#遍历数据结束标志
	
	 #根据取模值升序排序	
	 DECLARE spacelist CURSOR FOR  
	 (
		select * from isale_spacemod order by modvalue asc
	 );
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
		
	 #打开光标
   OPEN spacelist;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH spacelist INTO _space_length,_space_width,_space_heigth,_space_length_sort,_space_width_sort,_space_heigth_sort,_modvalue;
	IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
				
				IF _modvalue = -1 THEN
						SELECT '取模值为-1,不满足条件';
				ELSE
						#SELECT '满足条件'+_space_length,_space_width,_space_heigth;
						#根据task_code,inorderdetail_code判断该次上架货品数量已经上架结束
						select IFNULL(sum(count),0) into _upcount from isale_inorderspace_tmp t where t.inorderdetail_code=inorderdetail_code and t.task_code=task_code;
						IF _upcount < product_count THEN
							#查询满足条件的货位,写入上架临时表
							#SELECT 'area_type-'+area_type;
						  #SELECT 'inorder_mode-'+inorder_mode;
					    #SELECT 'space_halftype-'+space_halftype;
							call proc_inorder_c(task_code,inorderdetail_code,product_count,product_bulk,_space_length,_space_width,_space_heigth,area_type,inorder_mode,space_halftype);
						ELSE
							LEAVE read_loop;
						END IF;
						
				END IF;

		END LOOP;
			
	  /*关闭光标*/ 
		CLOSE spacelist; 
	
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_inorder_c
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_inorder_c`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `proc_inorder_c`(_task_code varchar(500),_inorderdetail_code varchar(500),_product_count varchar(500),_product_bulk varchar(500),_space_length varchar(500),_space_width varchar(500),_space_heigth varchar(500),_area_type int,_inorder_mode int,_space_halftype int)
BEGIN
	 DECLARE _space_code VARCHAR(500);               -- 货位系统编码
	 DECLARE _space_leftbulk VARCHAR(500);						-- 货位剩余体积
	 DECLARE _count int;															-- 当前货位能存放的货品数
	 DECLARE _leftcount int;													-- 剩余货品数
	 DECLARE done, error BOOLEAN DEFAULT FALSE;				-- 遍历数据结束标志

	 #根据动线号,剩余体积升序,最近最节省空间原则 需要带上第一步查询所有条件
	 DECLARE spacelist CURSOR FOR  
	 (
		select s.space_code,s.space_leftbulk-IFNULL(s.space_upbulk,0) space_leftbulk from isale_space s 
		inner join isale_area a  on a.area_code = s.area_code
		where s.space_length = _space_length and 
		s.space_width = _space_width and s.space_heigth = _space_heigth 
		and a.area_type = _area_type and a.area_usetype = _inorder_mode
		and s.space_state =  1 and s.space_lockstate = 1
    and s.space_halftype = _space_halftype and s.space_type <= 3 
    and (s.space_leftbulk+0) > 0
		order by s.space_linenumber,s.space_leftbulk-IFNULL(s.space_upbulk,0) asc
		#order by s.space_leftbulk-IFNULL(s.space_upbulk,0),s.space_linenumber asc
	  );
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
		
	 #打开光标
   OPEN spacelist;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH spacelist INTO _space_code,_space_leftbulk;
	IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
			#select _space_leftbulk;
			#剩余体积为负数,则下次循环
			IF (_space_leftbulk+0) < 0 THEN
					iterate read_loop;
			END IF;
			#根据当前剩余货位体积/货品单个体积取整判断 当前货位能存放多少货品
			SET _count = floor((_space_leftbulk+0)/(_product_bulk+0));
			#如果当前货位剩余体积不足以放下货品,则continue
			IF (_count+0) = 0 THEN
				SELECT CONCAT('当前货位：',_space_code," 能存放数量：",_count);
				iterate read_loop;
			END IF;
			SET _product_count = _product_count+0;                       
			SET _leftcount = _product_count - _count;
			#SELECT _leftcount;
			#select _count;
			#SELECT CONCAT('当前货位：',_space_code," 能存放数量：",_count," 目前还剩数量：",_leftcount);
			
			IF _leftcount <= 0 THEN
					select 'insert-1 start';
					insert into isale_inorderspace_tmp(inorderdetail_code,task_code,space_code,count,space_upbulk) values(_inorderdetail_code,_task_code,_space_code,_product_count,_product_bulk*_product_count);
					#SELECT CONCAT('insert into isale_inorderspace_tmp(inorderdetail_code,task_code,space_code,count,space_upbulk) values(',inorderdetail_code,',',task_code,',',_space_code,',',product_count,',',product_bulk*product_count,')');
					#更新对应货位待上架体积
					update isale_space set space_upbulk = IFNULL(space_upbulk,0)+ (_product_bulk*_product_count) where space_code = _space_code;
					select 'insert-1 end';
					#当所有货品已经存放完毕,则break
					leave read_loop;
			ELSE
					select 'insert-2 start';
					insert into isale_inorderspace_tmp(inorderdetail_code,task_code,space_code,count,space_upbulk) values(_inorderdetail_code,_task_code,_space_code,_count,_product_bulk*_count);		
					#SELECT CONCAT('insert into isale_inorderspace_tmp(inorderdetail_code,task_code,space_code,count,space_upbulk) values(',inorderdetail_code,',',task_code,',',_space_code,',',_count,',',product_bulk*_count,')');
					update isale_space set space_upbulk = IFNULL(space_upbulk,0)+ (_product_bulk*_count) where space_code = _space_code;
					SET _product_count = _leftcount;
					select 'insert-2 end';

				  #SELECT * from isale_inorderspace_tmp;
			END IF;
		END LOOP;
			
	  /*关闭光标*/ 
		CLOSE spacelist; 
		
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_inorder_d
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_inorder_d`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `proc_inorder_d`(task_code varchar(500))
BEGIN
	 DECLARE _space_code VARCHAR(500);               #货位系统编码
	 DECLARE _space_upbulk VARCHAR(500);						 #货位待上架体积
	 DECLARE _space_leftbulk VARCHAR(500);					 #货位剩余体积
	 DECLARE done, error BOOLEAN DEFAULT FALSE;			 #遍历数据结束标志

	 #当手持机入库任务变为已完成,则更新该任务下所有货位待上架体积
	 DECLARE spacelist CURSOR FOR  
	 (
		select t.space_code,sum(t.space_upbulk) space_upbulk from isale_inorderspace_tmp t where t.task_code=task_code
		group by t.space_code
	  );
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
		
	 #打开光标
   OPEN spacelist;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH spacelist INTO _space_code,_space_upbulk;
	IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
			#更新该货位待上架体积
			update isale_space set space_upbulk=space_upbulk-_space_upbulk where space_code=_space_code;
			#判断如果该上架体积为负数,因为存在强放,则更新待上架体积为0
			SELECT space_leftbulk INTO _space_leftbulk FROM isale_space WHERE space_code=_space_code;
			IF (_space_leftbulk+0) < 0 THEN
				update isale_space set space_upbulk=0 where space_code=_space_code;
			END IF;
		END LOOP;
			
	  /*关闭光标*/ 
		CLOSE spacelist; 
		
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_inorder_e
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_inorder_e`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_inorder_e`(inorderdetail_codes text,user_codes text)
BEGIN
	 DECLARE _sql VARCHAR(500);									#动态sql

	 #创建临时表保存传入用户  if not EXISTS不存在则创建
	 CREATE TEMPORARY TABLE IF NOT EXISTS isale_inorder_user_tmp 
	 ( 
			user_code VARCHAR(500),user_name VARCHAR(500),user_logourl VARCHAR(500),task_count INT DEFAULT 0
	 );

	 #执行动态sql结果集写入临时表
   SET _sql = CONCAT('insert into isale_inorder_user_tmp SELECT user_code,user_name,user_logourl,0 FROM isale_user WHERE user_code in (',user_codes,')');   -- 拼接查询sql语句

	 #select CONCAT('_sql：',_sql);
	 SET @_sql = _sql;
   PREPARE stmt FROM @_sql;
   EXECUTE stmt;
   deallocate prepare stmt;
	 
   #SELECT * FROM isale_inorder_user_tmp;
		
	 
	 #创建临时表保存传入订单  if not EXISTS不存在则创建
	 CREATE TEMPORARY TABLE IF NOT EXISTS isale_inorder_product_tmp 
	 ( 
			product_code VARCHAR(500),product_name VARCHAR(500)
	 );
		
	 #执行动态sql结果集写入临时表
   SET _sql = CONCAT('insert into isale_inorder_product_tmp SELECT product_code,product_name FROM isale_inorderdetail WHERE inorderdetail_code in (',inorderdetail_codes ,') group by product_code');   -- 拼接查询sql语句

	 #select CONCAT('_sql：',_sql);
	 SET @_sql = _sql;
   PREPARE stmt FROM @_sql;
   EXECUTE stmt;
   deallocate prepare stmt;
	 
   #SELECT * FROM isale_inorder_product_tmp;
		
	 CALL proc_inorder_f(inorderdetail_codes);
	 #删除临时表
	 DROP TABLE isale_inorder_user_tmp;
	 DROP TABLE isale_inorder_product_tmp;

	 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_inorder_f
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_inorder_f`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_inorder_f`(inorderdetail_codes text)
BEGIN
	
  DECLARE _product_code VARCHAR(500);						  #货品系统编码
  DECLARE _product_name VARCHAR(500);						  #货品名称
	DECLARE _user_code VARCHAR(500);								#上架人员系统编码
	DECLARE _user_name VARCHAR(500);								#上架人员名称
  DECLARE _user_logourl VARCHAR(500);							#上架人员头像
	DECLARE _sql VARCHAR(2000);	
  DECLARE done, error BOOLEAN DEFAULT FALSE;			#遍历数据结束标志

  #查询已经根据分组订单的sku
	DECLARE list CURSOR FOR  
	(
		select product_code,product_name from isale_inorder_product_tmp
	);
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
	
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _product_code,_product_name;
	IF done THEN
      LEAVE read_loop;
    END IF;
			#执行业务逻辑
			#查询当前sku分配上架人员按分配sku种类排序
			SELECT user_code,user_name,user_logourl INTO _user_code,_user_name,_user_logourl FROM isale_inorder_user_tmp ORDER BY task_count limit 1;
			#更新该sku种类对应的订单
			#select CONCAT('inorderdetail_codes：',inorderdetail_codes,'_user_code：',_user_code,'_user_name：',_user_name,'_user_logourl：',_user_logourl);
			SET _sql = CONCAT('UPDATE isale_inorderdetail set task_user_code = ''',_user_code,''', task_user_name = ''',_user_name,''', task_user_logourl = ''',_user_logourl,''' WHERE inorderdetail_code in (SELECT t.inorderdetail_code FROM(SELECT inorderdetail_code FROM isale_inorderdetail WHERE product_code = ''',_product_code,''' AND inorderdetail_code IN (',inorderdetail_codes,'))t)');

			#SELECT CONCAT('_sql ',_sql);
			SET @_sql = _sql;
			PREPARE stmt FROM @_sql;
			EXECUTE stmt;
			deallocate prepare stmt;
	

			#更新当前上架人员任务+1
			UPDATE isale_inorder_user_tmp SET task_count = task_count+1  WHERE user_code = _user_code;
		END LOOP;
			
	  /*关闭光标*/ 
		CLOSE list; 
		
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_move_autoRecommend_bh_all_1
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_move_autoRecommend_bh_all_1`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_move_autoRecommend_bh_all_1`()
BEGIN
		DECLARE _config_time VARCHAR(50);			#全局配置补货时间
		DECLARE _config_count VARCHAR(20);		#全局配置补货阀值
		DECLARE _config_state INT;						#全局配置状态

		SELECT config_time,config_count,config_state INTO _config_time,_config_count,_config_state FROM isale_config WHERE config_code = '1091501144734590301612947';
		
		#SELECT CONCAT('_config_time：',_config_time,'_config_count：',_config_count);
		
		#定时扫描,当系统时间=配置时间,首先删除task中task_type=8 高层--->普通移库,顶层 sku在普通、顶层货位总和与移库阀值比较
		IF _config_state = 1 and _config_time = date_format(SYSDATE(),'%H:%i') THEN
				DELETE FROM isale_task WHERE task_type = 8;
				CALL proc_move_autoRecommend_bh_order_1();
				CALL proc_move_autoRecommend_bh_all_2(_config_count);
		END IF;
	
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_move_autoRecommend_bh_all_2
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_move_autoRecommend_bh_all_2`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_move_autoRecommend_bh_all_2`(config_count int)
BEGIN
		DECLARE _product_code VARCHAR(500);						 #货品系统编码
		DECLARE _product_name VARCHAR(500);						 #货品名称
		DECLARE _product_enname	VARCHAR(500);          #货品英文名称
		DECLARE _product_barcode	VARCHAR(500);        #货品条码
		DECLARE _product_sku	VARCHAR(500);            #货品SKU编号同步第三方平台
		DECLARE _product_unit	VARCHAR(500);            #货品单位
		DECLARE _product_weight	VARCHAR(500);          #货品重量
		DECLARE _product_length	VARCHAR(500);          #货品长度(单位:mm)
		DECLARE _product_width	VARCHAR(500);          #货品宽度(单位:mm)
		DECLARE _product_heigth	VARCHAR(500);          #货品高度(单位:mm)
		DECLARE _product_length_sort	VARCHAR(500);    #货品排序后长边(单位:mm)
		DECLARE _product_width_sort	VARCHAR(500);      #货品排序后中边(单位:mm)
		DECLARE _product_heigth_sort	VARCHAR(500);		 #货品排序后短边(单位:mm)
		DECLARE _product_bulk	VARCHAR(500);            #货品体积
		DECLARE _product_imgurl	VARCHAR(500);          #货品图片
		DECLARE _product_state	INT;									 #货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)
		DECLARE _product_groupstate INT;               #货品组合状态(1：未组合、2：组合)
		DECLARE _product_batterystate INT;						 #货品是否带电池(1：是、2：否)
		DECLARE _space_count_total VARCHAR(50);        #货品在普通、顶层存放总数
		DECLARE _space_count_total_high VARCHAR(50);   #货品在高层货位存放总数
		DECLARE _bh_count INT;												 #需要补货数量
		DECLARE _task_code VARCHAR(500);				       #任务系统编码
		DECLARE _task_content VARCHAR(500);						 #任务内容
		DECLARE _task_content_high VARCHAR(500);			 #高位补货内容
		DECLARE done, error BOOLEAN DEFAULT FALSE;	   #遍历数据结束标志

		#查询普通、顶层货品中货品总数低于移库阀值
	  DECLARE list CURSOR FOR  
	  (
			SELECT product_code,product_name,product_enname,product_barcode,product_sku,product_unit,
			product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,
			product_imgurl,product_state,product_groupstate,product_batterystate,sum(space_count) space_count_total
			FROM isale_spacedetail sd INNER JOIN isale_space s
			ON sd.space_code = s.space_code WHERE s.space_type <= 2
			GROUP BY product_code HAVING sum(space_count) < (config_count+0)
	  );
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
		
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,
				_product_length_sort,_product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,
				_product_batterystate,_space_count_total;
   IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
			SET _task_code = CONCAT('700',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
			SET _task_content = "";
			SET _task_content_high = "";
			SET _space_count_total_high = "0";
			#-----------------执行业务逻辑	
			SELECT CONCAT('_product_code：',_product_code,'_product_name：',_product_name,' _space_count_total：',_space_count_total);
			
			SELECT GROUP_CONCAT(CONCAT(s.space_number,'有',space_count,_product_unit)) INTO _task_content
			FROM isale_spacedetail sd INNER JOIN isale_space s
			ON sd.space_code = s.space_code WHERE s.space_type <= 2 AND product_code = _product_code;
		
			#SELECT CONCAT('_task_content：',_task_content);
			
			#查询当前高位货位货品存放总数
			SELECT sum(space_count) INTO _space_count_total_high
			FROM isale_spacedetail sd INNER JOIN isale_space s
			ON sd.space_code = s.space_code WHERE product_code = _product_code AND s.space_type = 3;
			
			IF _space_count_total_high IS NULL THEN
				SET _space_count_total_high = 0;
			END IF;

			SET _space_count_total_high = _space_count_total_high + 0;

			#SELECT CONCAT('_space_count_total_high：',_space_count_total_high);
			IF (_space_count_total_high+0) = 0 THEN
					#高位货位无该货品
					SET _task_content = CONCAT(_product_name,'在',_task_content,',当前高位货位无该货品');
					
					#SELECT CONCAT('_task_content：',_task_content);

					INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,product_code,product_name,product_enname,product_barcode
					,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort
					,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate) 
					VALUES
					(_task_code,8,'',0,_task_content,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
					,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
					,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate
					);
			ELSE
					#高位货位存在该货品,计算剩余补货差值
					SET _bh_count = config_count - _space_count_total;
					
					#SELECT CONCAT('_product_name：',_product_name,'_bh_count：',_bh_count);
					#查询高位货位列表
					SELECT GROUP_CONCAT(CONCAT(s.space_number,'有',space_count,product_unit)) INTO _task_content_high
					FROM isale_spacedetail sd INNER JOIN isale_space s
					ON sd.space_code = s.space_code WHERE s.space_type = 3 AND product_code = _product_code
					GROUP BY product_code;
						
					SET _task_content = CONCAT(_product_name,'在',_task_content,',请到高位货位取货',_bh_count,_product_unit,',推荐高位货位：',_task_content_high);
					SELECT CONCAT('_task_content：',_task_content);
					
					INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,product_code,product_name,product_enname,product_barcode
					,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort
					,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate) 
					VALUES
					(_task_code,8,'',_bh_count,_task_content,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
					,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
					,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate
					);
			END IF;

		END LOOP;
			
	  /*关闭光标*/ 
		CLOSE list; 	
		
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_move_autoRecommend_bh_each_1
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_move_autoRecommend_bh_each_1`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_move_autoRecommend_bh_each_1`()
BEGIN
		#每天定时执行货位推荐,首先删除task中task_type=8,顶层、高层--->普通移库 sku在每个货位的移库阀值
		DELETE FROM isale_task WHERE task_type = 8;
		CALL proc_move_autoRecommend_bh_2();
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_move_autoRecommend_bh_each_2
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_move_autoRecommend_bh_each_2`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_move_autoRecommend_bh_each_2`()
BEGIN
		DECLARE _space_code  VARCHAR(500);						 #货位系统编码
		DECLARE _space_number VARCHAR(500);            #货位编号
		DECLARE _space_numbers VARCHAR(500) DEFAULT NULL;           #推荐货位编号
		DECLARE _space_count VARCHAR(500);						 #货品存放总量
		DECLARE _product_code	VARCHAR(500);   			   #货品系统编码
		DECLARE _product_name	VARCHAR(500); 					 #货品名称
		DECLARE _product_enname	VARCHAR(500);          #货品英文名称
		DECLARE _product_barcode	VARCHAR(500);        #货品条码
		DECLARE _product_sku	VARCHAR(500);            #货品SKU编号同步第三方平台
		DECLARE _product_unit	VARCHAR(500);            #货品单位
		DECLARE _product_weight	VARCHAR(500);          #货品重量
		DECLARE _product_length	VARCHAR(500);          #货品长度(单位:mm)
		DECLARE _product_width	VARCHAR(500);          #货品宽度(单位:mm)
		DECLARE _product_heigth	VARCHAR(500);          #货品高度(单位:mm)
		DECLARE _product_length_sort	VARCHAR(500);    #货品排序后长边(单位:mm)
		DECLARE _product_width_sort	VARCHAR(500);      #货品排序后中边(单位:mm)
		DECLARE _product_heigth_sort	VARCHAR(500);		 #货品排序后短边(单位:mm)
		DECLARE _product_bulk	VARCHAR(500);            #货品体积
		DECLARE _product_imgurl	VARCHAR(500);          #货品图片
		DECLARE _product_state	INT;									 #货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)
		DECLARE _product_groupstate INT;               #货品组合状态(1：未组合、2：组合)
		DECLARE _product_batterystate INT;						 #货品是否带电池(1：是、2：否)
		DECLARE _product_move_standard VARCHAR(500); 	 #货品移库阀值
	  DECLARE _user_code VARCHAR(500);							 #货主系统编码
		DECLARE _user_name VARCHAR(500);							 #货主系统名称
    DECLARE _user_mobilephone VARCHAR(500);        #货主联系方式
		DECLARE _task_code VARCHAR(500);				       #任务系统编码
		DECLARE _task_content VARCHAR(500);						 #任务内容
		DECLARE done, error BOOLEAN DEFAULT FALSE;	   #遍历数据结束标志

		#1:与货品中移库阀值比较,如果<=移库阀值,则生成移库推荐任务
    #2:如果货品中未设置移库阀值,则和全局配置移库阀值比较。如果<=移库阀值,则生成移库推荐任务
		#3:如果都未设置则不需要生成移库推荐任务

		#查询普通货位货品明细集合
	  DECLARE list CURSOR FOR  
	  (
			SELECT s.space_code,s.space_number,space_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit,
			product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,
			product_imgurl,product_state,product_groupstate,product_batterystate 
			FROM isale_spacedetail sd INNER JOIN isale_space s
			ON sd.space_code = s.space_code WHERE s.space_type = 1
	  );
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
		
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _space_code,_space_number,_space_count,_product_code,_product_name,_product_enname,
				_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,
				_product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,
				_product_batterystate;
   IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
			#-----------------执行业务逻辑	
			#SELECT CONCAT('_space_code：',_space_code,' _space_count：',_space_count,' _product_name：',_product_name);
			SELECT product_move_standard INTO _product_move_standard FROM isale_product WHERE product_code = _product_code;
			
			IF _product_move_standard IS NULL THEN
					#SELECT CONCAT('货品自身未设置');
					#查询全局配置是否有配置
					SELECT config_count INTO _product_move_standard FROM isale_config WHERE config_code='1091501144734590301612947';
					
					IF _product_move_standard IS NOT NULL THEN
							#SELECT CONCAT('全局设置');
							IF (_product_move_standard+0) > (_space_count+0) THEN
								#查询该货品存在的高位货位进行补货
								SELECT GROUP_CONCAT(s.space_number) INTO _space_numbers FROM isale_spacedetail sd 
								INNER JOIN isale_space s on s.space_code = sd.space_code
								WHERE product_code = _product_code AND s.space_type != 1;
								
								#判断是否存在高位、顶层
								IF _space_numbers IS NOT NULL THEN
										SET _task_code = CONCAT('700',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
										SET _task_content = CONCAT(_product_name,'已经低于移库阀值：',_product_move_standard,',请到货位：',_space_numbers,'进行移库至货位：',_space_number);

										INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,product_code,product_name,product_enname,product_barcode
										,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort
										,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate) 
										VALUES
										(_task_code,8,'',_space_count,_task_content,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
										,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
										,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate
										);
								END IF;

						END IF;
					END IF;

			ELSE
				#SELECT CONCAT('货品自身设置');
				SELECT space_number INTO _space_number FROM isale_space WHERE space_code = _space_code;
				
				IF (_product_move_standard+0) > (_space_count+0) THEN
						SELECT GROUP_CONCAT(s.space_number) INTO _space_numbers FROM isale_spacedetail sd 
						INNER JOIN isale_space s on s.space_code = sd.space_code
						WHERE product_code = _product_code AND s.space_type != 1;
								
						#判断是否存在高位、顶层
						IF _space_numbers IS NOT NULL THEN
								SET _task_code = CONCAT('700',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
								SET _task_content = CONCAT(_product_name,'已经低于移库阀值：',_product_move_standard,',请到货位：',_space_numbers,'进行移库至货位：',_space_number);

								INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,product_code,product_name,product_enname,product_barcode
								,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort
								,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate) 
								VALUES
								(_task_code,8,'',_space_count,_task_content,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
								,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
								,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate
								);
						END IF;
				END IF;
				

			END IF;
		
		END LOOP;
			
	  /*关闭光标*/ 
		CLOSE list; 	
		
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_move_autoRecommend_bh_order_1
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_move_autoRecommend_bh_order_1`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `proc_move_autoRecommend_bh_order_1`()
BEGIN
		DECLARE _product_code VARCHAR(500);						 #货品系统编码
		DECLARE _total_product_count VARCHAR(50);      #订单需要的单个货品总数
		DECLARE _product_name VARCHAR(500);						 #货品名称
		DECLARE _product_enname	VARCHAR(500);          #货品英文名称
		DECLARE _product_barcode	VARCHAR(500);        #货品条码
		DECLARE _product_sku	VARCHAR(500);            #货品SKU编号同步第三方平台
		DECLARE _product_unit	VARCHAR(500);            #货品单位
		DECLARE _product_weight	VARCHAR(500);          #货品重量
		DECLARE _product_length	VARCHAR(500);          #货品长度(单位:mm)
		DECLARE _product_width	VARCHAR(500);          #货品宽度(单位:mm)
		DECLARE _product_heigth	VARCHAR(500);          #货品高度(单位:mm)
		DECLARE _product_length_sort	VARCHAR(500);    #货品排序后长边(单位:mm)
		DECLARE _product_width_sort	VARCHAR(500);      #货品排序后中边(单位:mm)
		DECLARE _product_heigth_sort	VARCHAR(500);		 #货品排序后短边(单位:mm)
		DECLARE _product_bulk	VARCHAR(500);            #货品体积
		DECLARE _product_imgurl	VARCHAR(500);          #货品图片
		DECLARE _product_state	INT;									 #货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)
		DECLARE _product_groupstate INT;               #货品组合状态(1：未组合、2：组合)
		DECLARE _product_batterystate INT;						 #货品是否带电池(1：是、2：否)
		DECLARE _space_count_total VARCHAR(50);        #货品在普通、顶层存放总数
		DECLARE _space_count_total_high VARCHAR(50);   #货品在高层货位存放总数
		DECLARE _bh_count INT;												 #需要补货数量
		DECLARE _task_code VARCHAR(500);				       #任务系统编码
		DECLARE _task_content VARCHAR(500);						 #任务内容
		DECLARE _task_content_high VARCHAR(500);			 #高位补货内容
		DECLARE done, error BOOLEAN DEFAULT FALSE;	   #遍历数据结束标志
		
		#查询当前所有出库单的SKU数量和SKU出库数量总数
		DECLARE list CURSOR FOR  
		(
			select ood.product_code,ood.product_name,ood.product_enname,ood.product_barcode,ood.product_sku,ood.product_unit,
			ood.product_weight,ood.product_length,ood.product_width,ood.product_heigth,ood.product_length_sort,ood.product_width_sort,ood.product_heigth_sort,ood.product_bulk,
			ood.product_imgurl,ood.product_state,ood.product_groupstate,ood.product_batterystate,sum(product_count+0) as total_product_count from isale_outorder o INNER JOIN isale_outorderdetail ood on o.outorder_code=ood.outorder_code
			where o.outorder_type=1 and o.outorder_state=1 and (o.wave_code is null or LENGTH(o.wave_code)<=0) and o.outorder_lackstate=1 and ood.outorderdetail_state=1
			group by product_code
		);
			 
		#解决mysql游标错误
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
		DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
		DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
		#打开光标
		OPEN list;
	
		#循环执行
		read_loop: LOOP 
				#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,
				_product_length_sort,_product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,
				_product_batterystate,_total_product_count;
		IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
			SET _task_code = CONCAT('700',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
			SET _task_content = "";
			SET _task_content_high = "";
			SET _space_count_total_high = "0";
			#-----------------执行业务逻辑	
			#查询普通/顶层货位 当前SKU数量
			SELECT sum(sd.space_count+0) INTO _space_count_total FROM isale_spacedetail sd INNER JOIN isale_space s ON sd.space_code = s.space_code 
			WHERE s.space_type <= 2  AND product_code = _product_code GROUP BY sd.product_code;
			#SELECT CONCAT('是否需要补货',(_total_product_count+0)>(_space_count_total+0));
			#需要补货
			IF  (_total_product_count+0)>(_space_count_total+0) THEN
					
					SELECT GROUP_CONCAT(CONCAT(s.space_number,'有',sd.space_count,_product_unit)) INTO _task_content
					FROM isale_spacedetail sd INNER JOIN isale_space s
					ON sd.space_code = s.space_code WHERE s.space_type <= 2 AND product_code = _product_code;
					
					
					#查询当前高位货位货品存放总数
					SELECT sum(space_count) INTO _space_count_total_high
					FROM isale_spacedetail sd INNER JOIN isale_space s
					ON sd.space_code = s.space_code WHERE product_code = _product_code AND s.space_type = 3;
					
					IF _space_count_total_high IS NULL THEN
						SET _space_count_total_high = 0;
					END IF;
					
					SET _space_count_total_high = _space_count_total_high + 0;

					#SELECT CONCAT('_space_count_total_high：',_space_count_total_high);
					IF (_space_count_total_high+0) > 0 THEN		
							#计算剩余补货差值
							SET _bh_count = _total_product_count - _space_count_total;
							#高位货位货品充足
							IF  (_space_count_total_high+0)>=(_bh_count+0) THEN								
								#SELECT CONCAT('货品充足：','_product_name：',_product_name,'_bh_count：',_bh_count);
								#查询高位货位列表
								SELECT GROUP_CONCAT(CONCAT(s.space_number,'有',space_count,product_unit)) INTO _task_content_high
								FROM isale_spacedetail sd INNER JOIN isale_space s
								ON sd.space_code = s.space_code WHERE s.space_type = 3 AND product_code = _product_code
								GROUP BY product_code;
									
								SET _task_content = CONCAT(_product_name,'在',_task_content,',请到高位货位取货',_bh_count,_product_unit,',推荐高位货位：',_task_content_high);
								SELECT CONCAT('_task_content：',_task_content);
								
								INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,product_code,product_name,product_enname,product_barcode
								,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort
								,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate) 
								VALUES
								(_task_code,8,'',_bh_count,_task_content,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
								,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
								,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate
								);
							ELSE
									#高位货位货品不足									
									#SELECT CONCAT('货品不足：','_product_name：',_product_name,'_bh_count：',_bh_count);
									#查询高位货位列表
									SELECT GROUP_CONCAT(CONCAT(s.space_number,'有',space_count,product_unit)) INTO _task_content_high
									FROM isale_spacedetail sd INNER JOIN isale_space s
									ON sd.space_code = s.space_code WHERE s.space_type = 3 AND product_code = _product_code
									GROUP BY product_code;
										
									SET _task_content = CONCAT(_product_name,'在',_task_content,',请到高位货位取货',_bh_count,_product_unit,',推荐高位货位：',_task_content_high,',该SKU货品已不足,请尽快补充该货品。');
									SELECT CONCAT('_task_content：',_task_content);
									
									INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,product_code,product_name,product_enname,product_barcode
									,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort
									,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate) 
									VALUES
									(_task_code,8,'',_bh_count,_task_content,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
									,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
									,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate
									);
							END IF;			
				
					END IF;

			END IF;			
			
		END LOOP;
			
	  /*关闭光标*/ 
		CLOSE list;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_move_autoRecommend_ly_1
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_move_autoRecommend_ly_1`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_move_autoRecommend_ly_1`()
BEGIN
		#每天定时执行货位推荐,首先删除task中task_type=8,利用率
		DELETE FROM isale_task WHERE task_type = 8;
		CALL proc_move_autoRecommend_2();
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_move_autoRecommend_ly_2
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_move_autoRecommend_ly_2`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_move_autoRecommend_ly_2`()
BEGIN
		DECLARE _space_code  VARCHAR(500);						 #货位系统编码
		DECLARE _space_number VARCHAR(500);            #货位编号
		DECLARE _space_numbers VARCHAR(500);           #推荐货位编号
		DECLARE _space_count VARCHAR(500);						 #货品存放总量
		DECLARE _product_code	VARCHAR(500);   			   #货品系统编码
		DECLARE _product_name	VARCHAR(500); 					 #货品名称
		DECLARE _product_enname	VARCHAR(500);          #货品英文名称
		DECLARE _product_barcode	VARCHAR(500);        #货品条码
		DECLARE _product_sku	VARCHAR(500);            #货品SKU编号同步第三方平台
		DECLARE _product_unit	VARCHAR(500);            #货品单位
		DECLARE _product_weight	VARCHAR(500);          #货品重量
		DECLARE _product_length	VARCHAR(500);          #货品长度(单位:mm)
		DECLARE _product_width	VARCHAR(500);          #货品宽度(单位:mm)
		DECLARE _product_heigth	VARCHAR(500);          #货品高度(单位:mm)
		DECLARE _product_length_sort	VARCHAR(500);    #货品排序后长边(单位:mm)
		DECLARE _product_width_sort	VARCHAR(500);      #货品排序后中边(单位:mm)
		DECLARE _product_heigth_sort	VARCHAR(500);		 #货品排序后短边(单位:mm)
		DECLARE _product_bulk	VARCHAR(500);            #货品体积
		DECLARE _product_imgurl	VARCHAR(500);          #货品图片
		DECLARE _product_state	INT;									 #货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)
		DECLARE _product_groupstate INT;               #货品组合状态(1：未组合、2：组合)
		DECLARE _product_batterystate INT;						 #货品是否带电池(1：是、2：否)
		DECLARE _product_move_standard VARCHAR(500); 	 #货品移库阀值
	  DECLARE _user_code VARCHAR(500);							 #货主系统编码
		DECLARE _user_name VARCHAR(500);							 #货主系统名称
    DECLARE _user_mobilephone VARCHAR(500);        #货主联系方式
		DECLARE _task_code VARCHAR(500);				       #任务系统编码
		DECLARE _task_content VARCHAR(500);						 #任务内容
		DECLARE done, error BOOLEAN DEFAULT FALSE;	   #遍历数据结束标志

		#1:与货品中移库阀值比较,如果<=移库阀值,则生成移库推荐任务
    #2:如果货品中未设置移库阀值,则和全局配置移库阀值比较。如果<=移库阀值,则生成移库推荐任务
		#3:如果都未设置则不需要生成移库推荐任务

		#查询货位货品明细集合
	  DECLARE list CURSOR FOR  
	  (
			SELECT space_code,space_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit,
			product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,
			product_imgurl,product_state,product_groupstate,product_batterystate FROM isale_spacedetail
	  );
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
		
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _space_code,_space_count,_product_code,_product_name,_product_enname,
				_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,
				_product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,
				_product_batterystate;
   IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
			#-----------------执行业务逻辑	
			#SELECT CONCAT('_space_code：',_space_code,' _space_count：',_space_count,' _product_name：',_product_name);
			SELECT product_move_standard INTO _product_move_standard FROM isale_product WHERE product_code = _product_code;
			
			IF _product_move_standard IS NULL THEN
					#SELECT CONCAT('货品自身未设置');
					#查询全局配置是否有配置
					SELECT config_count INTO _product_move_standard FROM isale_config WHERE config_code='1091501144734590301612947';
					
					IF _product_move_standard IS NOT NULL THEN
							#SELECT CONCAT('全局设置');
							SELECT space_number INTO _space_number FROM isale_space WHERE space_code = _space_code;
	
							IF (_product_move_standard+0) > (_space_count+0) THEN
		
								SELECT GROUP_CONCAT(s.space_number) INTO _space_numbers FROM isale_spacedetail sd 
								INNER JOIN isale_space s on s.space_code = sd.space_code
								WHERE product_code = _product_code
								AND (space_count+0) >= (_product_move_standard+0);

								SET _task_code = CONCAT('700',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
								SET _task_content = CONCAT(_product_name,'已经低于移库阀值：',_product_move_standard,',请到货位：',_space_number,'进行移库至货位：',_space_numbers);

								INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,product_code,product_name,product_enname,product_barcode
								,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort
								,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate) 
								VALUES
								(_task_code,8,'',_space_count,_task_content,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
								,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
								,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate
								);
						END IF;
					END IF;

			ELSE
				#SELECT CONCAT('货品自身设置');
				SELECT space_number INTO _space_number FROM isale_space WHERE space_code = _space_code;
				
				IF (_product_move_standard+0) > (_space_count+0) THEN
						SELECT GROUP_CONCAT(s.space_number) INTO _space_numbers FROM isale_spacedetail sd 
						INNER JOIN isale_space s on s.space_code = sd.space_code
						WHERE product_code = _product_code
						AND (space_count+0) >= (_product_move_standard+0);
					
						SET _task_code = CONCAT('700',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
						SET _task_content = CONCAT(_product_name,'已经低于移库阀值：',_product_move_standard,',请到货位：',_space_number,'进行移库至货位：',_space_numbers);
			
						INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,product_code,product_name,product_enname,product_barcode
						,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort
						,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate) 
						VALUES
						(_task_code,8,'',_space_count,_task_content,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
						,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
						,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate
						);
				END IF;
				

			END IF;
		
		END LOOP;
			
	  /*关闭光标*/ 
		CLOSE list; 	
		
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_move_highToNormal
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_move_highToNormal`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_move_highToNormal`(_space_code_high varchar(500),_space_number_high varchar(500),_space_code_normal varchar(500),_space_number_normal varchar(500),_space_halftype int,_move_product_code varchar(500),_move_count int,_task_user_code varchar(500),_task_user_name varchar(500),_task_user_logourl varchar(500),out result int)
BEGIN
		DECLARE _product_code	VARCHAR(500);   			   #货品系统编码
		DECLARE _product_name	VARCHAR(500); 					 #货品名称
		DECLARE _product_enname	VARCHAR(500);          #货品英文名称
		DECLARE _product_barcode	VARCHAR(500);        #货品条码
		DECLARE _product_sku	VARCHAR(500);            #货品SKU编号同步第三方平台
		DECLARE _product_unit	VARCHAR(500);            #货品单位
		DECLARE _product_weight	VARCHAR(500);          #货品重量
		DECLARE _product_length	VARCHAR(500);          #货品长度(单位:mm)
		DECLARE _product_width	VARCHAR(500);          #货品宽度(单位:mm)
		DECLARE _product_heigth	VARCHAR(500);          #货品高度(单位:mm)
		DECLARE _product_length_sort	VARCHAR(500);    #货品排序后长边(单位:mm)
		DECLARE _product_width_sort	VARCHAR(500);      #货品排序后中边(单位:mm)
		DECLARE _product_heigth_sort	VARCHAR(500);		 #货品排序后短边(单位:mm)
		DECLARE _product_bulk	VARCHAR(500);            #货品体积
		DECLARE _product_imgurl	VARCHAR(500);          #货品图片
		DECLARE _product_state	INT;									 #货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)
		DECLARE _product_groupstate INT;               #货品组合状态(1：未组合、2：组合)
		DECLARE _product_batterystate INT;						 #货品是否带电池(1：是、2：否)
		DECLARE _product_totalbulk VARCHAR(500); 			 #移库货品总体积
		DECLARE _user_code VARCHAR(500);							 #货主系统编码
		DECLARE _user_name VARCHAR(500);							 #货主系统名称
    DECLARE _user_mobilephone VARCHAR(500);        #货主联系方式
		DECLARE _task_code VARCHAR(500);				       #任务系统编码
		DECLARE _task_content VARCHAR(500);						 #任务内容
		DECLARE _space_count VARCHAR(500);						 #货品存放总量
		DECLARE _space_code_top VARCHAR(500);					 #顶层货位编码
		DECLARE _space_number_top VARCHAR(500);        #顶层货位编号
		DECLARE _count INT;														 #移入货位当前货品存放量

		#----移位 高层-普通 模拟（高层-顶层 顶层-普通）  锁定移库货位,并且移出货位当前无任务
		
		#锁定货位
		UPDATE isale_space SET space_lockstate = 2 WHERE space_code = _space_code_high;
		UPDATE isale_space SET space_lockstate = 2 WHERE space_code = _space_code_normal;

		#根据货品编码查询货品信息
	  SELECT product_code,product_name,product_enname,product_barcode,product_sku,product_unit,
		product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,
		product_imgurl,product_state,product_groupstate,product_batterystate,user_code INTO _product_code,_product_name,_product_enname,
		_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,
		_product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,
		_product_batterystate,_user_code FROM isale_product WHERE product_code = _move_product_code;
		
		#根据货主系统编码查询货主
		SELECT user_name,user_mobilephone INTO _user_name,_user_mobilephone from isale_user WHERE user_code = _user_code;
		#根据普通货位查询其顶层货位
		SELECT space_code,space_number INTO _space_code_top,_space_number_top FROM isale_space WHERE space_code = 
		(
			SELECT space_parentcode FROM isale_space WHERE space_code = _space_code_normal
		); 
	
		#写入task,并更新状态已完成
		SET _task_code = CONCAT('700',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
		IF _space_code_top IS NULL THEN
			SET _task_content = CONCAT(_product_name,'从高层货位',_space_number_high,'移至普通货位',_space_number_normal);
		ELSE
			SET _task_content = CONCAT(_product_name,'从高层货位',_space_number_high,'移至顶层货位',_space_number_top,'移至普通货位',_space_number_normal);
		END IF;
		

		INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,product_code,product_name,product_enname,product_barcode
		,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort
		,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_logourl) 
		VALUES
		(_task_code,7,'',_move_count,_task_content,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_task_user_code,_task_user_name,_task_user_logourl
		);
		#默认更新已完成
		UPDATE isale_task SET task_state = 3 WHERE task_code = _task_code;

		#高层下架spacedetaillog
		INSERT INTO isale_spacedetaillog(space_code,space_halftype,space_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit
		,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_mobilephone,task_code,task_type)
		VALUES(_space_code_high,_space_halftype,_move_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_user_code,_user_name,_user_mobilephone,_task_code,2);
			
		#普通上架spacedetaillog
		INSERT INTO isale_spacedetaillog(space_code,space_halftype,space_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit
		,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_mobilephone,task_code,task_type)
		VALUES(_space_code_normal,_space_halftype,_move_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_user_code,_user_name,_user_mobilephone,_task_code,1);
		

		#更新spacedetail高层货品存放量 如果高层货位存放数量和移库数量一致,则删除该条记录,否则更新
		SELECT space_count INTO _space_count FROM isale_spacedetail WHERE space_code = _space_code_high AND product_code = _product_code;
		IF (_move_count+0) = (_space_count+0) THEN
				DELETE FROM isale_spacedetail WHERE space_code = _space_code_high AND product_code = _product_code;
		ELSE
				UPDATE isale_spacedetail SET space_count = space_count - _move_count WHERE space_code = _space_code_high AND product_code = _product_code;
		END IF;
		

		#更新移入普通对应货品存放量,需要判断该货位上是否已经存在
		SELECT count(1) INTO _count FROM isale_spacedetail WHERE space_code = _space_code_normal AND product_code = _product_code;
		IF (_count+0) = 0 THEN
			INSERT INTO isale_spacedetail(space_code,space_halftype,space_count,space_excount,product_code,product_name,product_enname,product_barcode,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort
			,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate)
			VALUES(
				_space_code_normal,_space_halftype,_move_count,0,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,
				_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate
			);
		ELSE
			UPDATE isale_spacedetail SET space_count = space_count + _move_count WHERE space_code = _space_code_normal AND product_code = _product_code;
		END IF;

		#移库货品总体积
		SET _product_totalbulk = _product_bulk * _move_count;
		#SELECT CONCAT('_product_totalbulk：',_product_totalbulk);
		#更新space高层货位使用、未用提交
		#SELECT space_leftbulk INTO _space_leftbulk FROM isale_space WHERE space_code = _space_code_high;
		#IF (_space_leftbulk+0) > (_product_totalbulk+0) THEN
				#考虑到移库货品体积远远大于货位体积,将其移库完毕,也有可能使用体积为负,但是还有其余小货品存放
		#所以咋不考虑更新货位一系列值
		#END IF;
		#更新高层已用减少,剩余增多
		UPDATE isale_space SET space_usedbulk = space_usedbulk - _product_totalbulk,space_leftbulk = space_leftbulk + _product_totalbulk  WHERE space_code = _space_code_high;
		#更新顶层已用增多,剩余减少
		UPDATE isale_space SET space_usedbulk = space_usedbulk + _product_totalbulk,space_leftbulk = space_leftbulk - _product_totalbulk,space_usestate = 2 WHERE space_code = _space_code_normal;
		
		
		#解锁货位
		UPDATE isale_space SET space_lockstate = 1 WHERE space_code = _space_code_high;
		UPDATE isale_space SET space_lockstate = 1 WHERE space_code = _space_code_normal;

		SET result = 1;
		#设置返回值
		SELECT result;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_move_highToTop
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_move_highToTop`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_move_highToTop`(_space_code_high varchar(500),_space_number_high varchar(500),_space_code_top varchar(500),_space_number_top varchar(500),_space_halftype int,_move_product_code varchar(500),_move_count int,_task_user_code varchar(500),_task_user_name varchar(500),_task_user_logourl varchar(500),out result int)
BEGIN
		DECLARE _product_code	VARCHAR(500);   			   #货品系统编码
		DECLARE _product_name	VARCHAR(500); 					 #货品名称
		DECLARE _product_enname	VARCHAR(500);          #货品英文名称
		DECLARE _product_barcode	VARCHAR(500);        #货品条码
		DECLARE _product_sku	VARCHAR(500);            #货品SKU编号同步第三方平台
		DECLARE _product_unit	VARCHAR(500);            #货品单位
		DECLARE _product_weight	VARCHAR(500);          #货品重量
		DECLARE _product_length	VARCHAR(500);          #货品长度(单位:mm)
		DECLARE _product_width	VARCHAR(500);          #货品宽度(单位:mm)
		DECLARE _product_heigth	VARCHAR(500);          #货品高度(单位:mm)
		DECLARE _product_length_sort	VARCHAR(500);    #货品排序后长边(单位:mm)
		DECLARE _product_width_sort	VARCHAR(500);      #货品排序后中边(单位:mm)
		DECLARE _product_heigth_sort	VARCHAR(500);		 #货品排序后短边(单位:mm)
		DECLARE _product_bulk	VARCHAR(500);            #货品体积
		DECLARE _product_imgurl	VARCHAR(500);          #货品图片
		DECLARE _product_state	INT;									 #货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)
		DECLARE _product_groupstate INT;               #货品组合状态(1：未组合、2：组合)
		DECLARE _product_batterystate INT;						 #货品是否带电池(1：是、2：否)
		DECLARE _product_totalbulk VARCHAR(500); 			 #移库货品总体积
		DECLARE _user_code VARCHAR(500);							 #货主系统编码
		DECLARE _user_name VARCHAR(500);							 #货主系统名称
    DECLARE _user_mobilephone VARCHAR(500);        #货主联系方式
		DECLARE _task_code VARCHAR(500);				       #任务系统编码
		DECLARE _task_content VARCHAR(500);						 #任务内容
		DECLARE _space_count VARCHAR(500);						 #货品存放总量
		DECLARE _count INT;														 #移入货位当前货品存放量
		#----移位 高层-顶层  锁定移库货位,并且移出货位当前无任务
		
		#锁定货位
		UPDATE isale_space SET space_lockstate = 2 WHERE space_code = _space_code_high;
		UPDATE isale_space SET space_lockstate = 2 WHERE space_code = _space_code_top;

		#根据货品编码查询货品信息
	  SELECT product_code,product_name,product_enname,product_barcode,product_sku,product_unit,
		product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,
		product_imgurl,product_state,product_groupstate,product_batterystate,user_code INTO _product_code,_product_name,_product_enname,
		_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,
		_product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,
		_product_batterystate,_user_code FROM isale_product WHERE product_code = _move_product_code;
		
		#根据货主系统编码查询货主
		SELECT user_name,user_mobilephone INTO _user_name,_user_mobilephone from isale_user WHERE user_code = _user_code;
		
		#写入task,并更新状态已完成
		SET _task_code = CONCAT('700',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
		SET _task_content = CONCAT(_product_name,'从高层货位',_space_number_high,'移至顶层货位',_space_number_top);

		INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,product_code,product_name,product_enname,product_barcode
		,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort
		,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_logourl) 
		VALUES
		(_task_code,7,'',_move_count,_task_content,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_task_user_code,_task_user_name,_task_user_logourl
		);
		#默认更新已完成
		UPDATE isale_task SET task_state = 3 WHERE task_code = _task_code;

		#高层下架spacedetaillog
		INSERT INTO isale_spacedetaillog(space_code,space_halftype,space_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit
		,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_mobilephone,task_code,task_type)
		VALUES(_space_code_high,_space_halftype,_move_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_user_code,_user_name,_user_mobilephone,_task_code,2);
			
		#普通上架spacedetaillog
		INSERT INTO isale_spacedetaillog(space_code,space_halftype,space_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit
		,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_mobilephone,task_code,task_type)
		VALUES(_space_code_top,_space_halftype,_move_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_user_code,_user_name,_user_mobilephone,_task_code,1);
		

		#更新spacedetail高层货品存放量 如果高层货位存放数量和移库数量一致,则删除该条记录,否则更新
		SELECT space_count INTO _space_count FROM isale_spacedetail WHERE space_code = _space_code_high AND product_code = _product_code;
		IF (_move_count+0) = (_space_count+0) THEN
				DELETE FROM isale_spacedetail WHERE space_code = _space_code_high AND product_code = _product_code;
		ELSE
				UPDATE isale_spacedetail SET space_count = space_count - _move_count WHERE space_code = _space_code_high AND product_code = _product_code;
		END IF;
		
		#更新移入普通对应货品存放量,需要判断该货位上是否已经存在
		SELECT count(1) INTO _count FROM isale_spacedetail WHERE space_code = _space_code_top AND product_code = _product_code;
		IF (_count+0) = 0 THEN
			INSERT INTO isale_spacedetail(space_code,space_halftype,space_count,space_excount,product_code,product_name,product_enname,product_barcode,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort
			,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate)
			VALUES(
				_space_code_top,_space_halftype,_move_count,0,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,
				_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate
			);
		ELSE
			UPDATE isale_spacedetail SET space_count = space_count + _move_count WHERE space_code = _space_code_top AND product_code = _product_code;
		END IF;

		#移库货品总体积
		SET _product_totalbulk = _product_bulk * _move_count;
		#SELECT CONCAT('_product_totalbulk：',_product_totalbulk);
		#更新space高层货位使用、未用提交
		#SELECT space_leftbulk INTO _space_leftbulk FROM isale_space WHERE space_code = _space_code_high;
		#IF (_space_leftbulk+0) > (_product_totalbulk+0) THEN
				#考虑到移库货品体积远远大于货位体积,将其移库完毕,也有可能使用体积为负,但是还有其余小货品存放
		#所以咋不考虑更新货位一系列值
		#END IF;
		#更新高层已用减少,剩余增多
		UPDATE isale_space SET space_usedbulk = space_usedbulk - _product_totalbulk,space_leftbulk = space_leftbulk + _product_totalbulk  WHERE space_code = _space_code_high;
		#更新顶层已用增多,剩余减少
		UPDATE isale_space SET space_usedbulk = space_usedbulk + _product_totalbulk,space_leftbulk = space_leftbulk - _product_totalbulk,space_usestate = 2 WHERE space_code = _space_code_top;
		
		
		#解锁货位
		UPDATE isale_space SET space_lockstate = 1 WHERE space_code = _space_code_high;
		UPDATE isale_space SET space_lockstate = 1 WHERE space_code = _space_code_top;

		SET result = 1;
		#设置返回值
		SELECT result;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_move_normalToHigh
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_move_normalToHigh`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_move_normalToHigh`(_space_code_normal varchar(500),_space_number_normal varchar(500),_space_code_high varchar(500),_space_number_high varchar(500),_space_halftype int,_move_product_code varchar(500),_move_count int,_task_user_code varchar(500),_task_user_name varchar(500),_task_user_logourl varchar(500),out result int)
BEGIN
		DECLARE _product_code	VARCHAR(500);   			   #货品系统编码
		DECLARE _product_name	VARCHAR(500); 					 #货品名称
		DECLARE _product_enname	VARCHAR(500);          #货品英文名称
		DECLARE _product_barcode	VARCHAR(500);        #货品条码
		DECLARE _product_sku	VARCHAR(500);            #货品SKU编号同步第三方平台
		DECLARE _product_unit	VARCHAR(500);            #货品单位
		DECLARE _product_weight	VARCHAR(500);          #货品重量
		DECLARE _product_length	VARCHAR(500);          #货品长度(单位:mm)
		DECLARE _product_width	VARCHAR(500);          #货品宽度(单位:mm)
		DECLARE _product_heigth	VARCHAR(500);          #货品高度(单位:mm)
		DECLARE _product_length_sort	VARCHAR(500);    #货品排序后长边(单位:mm)
		DECLARE _product_width_sort	VARCHAR(500);      #货品排序后中边(单位:mm)
		DECLARE _product_heigth_sort	VARCHAR(500);		 #货品排序后短边(单位:mm)
		DECLARE _product_bulk	VARCHAR(500);            #货品体积
		DECLARE _product_imgurl	VARCHAR(500);          #货品图片
		DECLARE _product_state	INT;									 #货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)
		DECLARE _product_groupstate INT;               #货品组合状态(1：未组合、2：组合)
		DECLARE _product_batterystate INT;						 #货品是否带电池(1：是、2：否)
		DECLARE _product_totalbulk VARCHAR(500); 			 #移库货品总体积
		DECLARE _user_code VARCHAR(500);							 #货主系统编码
		DECLARE _user_name VARCHAR(500);							 #货主系统名称
    DECLARE _user_mobilephone VARCHAR(500);        #货主联系方式
		DECLARE _task_code VARCHAR(500);				       #任务系统编码
		DECLARE _task_content VARCHAR(500);						 #任务内容
		DECLARE _space_count VARCHAR(500);						 #货品存放总量
		DECLARE _space_code_top VARCHAR(500);					 #顶层货位编码
		DECLARE _space_number_top VARCHAR(500);        #顶层货位编号
		DECLARE _count INT;														 #移入货位当前货品存放量

		#----移位 普通-高层 模拟（普通-顶层 顶层-高层）  锁定移库货位,并且移出货位当前无任务
		
		#锁定货位
		UPDATE isale_space SET space_lockstate = 2 WHERE space_code = _space_code_normal;
		UPDATE isale_space SET space_lockstate = 2 WHERE space_code = _space_code_high;
		
		#根据货品编码查询货品信息
	  SELECT product_code,product_name,product_enname,product_barcode,product_sku,product_unit,
		product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,
		product_imgurl,product_state,product_groupstate,product_batterystate,user_code INTO _product_code,_product_name,_product_enname,
		_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,
		_product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,
		_product_batterystate,_user_code FROM isale_product WHERE product_code = _move_product_code;
		
		#根据货主系统编码查询货主
		SELECT user_name,user_mobilephone INTO _user_name,_user_mobilephone from isale_user WHERE user_code = _user_code;
		#根据普通货位查询其顶层货位
		SELECT space_code,space_number INTO _space_code_top,_space_number_top FROM isale_space WHERE space_code = 
		(
			SELECT space_parentcode FROM isale_space WHERE space_code = _space_code_normal
		); 
	
		#写入task,并更新状态已完成
		SET _task_code = CONCAT('700',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
		IF _space_code_top IS NULL THEN
			SET _task_content = CONCAT(_product_name,'从普通货位',_space_number_normal,'移至高层货位',_space_number_high);
		ELSE
			SET _task_content = CONCAT(_product_name,'从普通货位',_space_number_normal,'移至顶层货位',_space_number_top,'移至高层货位',_space_number_high);
		END IF;
		

		INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,product_code,product_name,product_enname,product_barcode
		,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort
		,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_logourl) 
		VALUES
		(_task_code,7,'',_move_count,_task_content,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_task_user_code,_task_user_name,_task_user_logourl
		);
		#默认更新已完成
		UPDATE isale_task SET task_state = 3 WHERE task_code = _task_code;

		#普通下架spacedetaillog
		INSERT INTO isale_spacedetaillog(space_code,space_halftype,space_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit
		,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_mobilephone,task_code,task_type)
		VALUES(_space_code_normal,_space_halftype,_move_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_user_code,_user_name,_user_mobilephone,_task_code,2);
			
		#高层上架spacedetaillog
		INSERT INTO isale_spacedetaillog(space_code,space_halftype,space_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit
		,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_mobilephone,task_code,task_type)
		VALUES(_space_code_high,_space_halftype,_move_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_user_code,_user_name,_user_mobilephone,_task_code,1);
		

		#更新spacedetail普通货品存放量 如果货位存放数量和移库数量一致,则删除该条记录,否则更新
		SELECT space_count INTO _space_count FROM isale_spacedetail WHERE space_code = _space_code_normal AND product_code = _product_code;
		IF (_move_count+0) = (_space_count+0) THEN
				DELETE FROM isale_spacedetail WHERE space_code = _space_code_normal AND product_code = _product_code;
		ELSE
				UPDATE isale_spacedetail SET space_count = space_count - _move_count WHERE space_code = _space_code_normal AND product_code = _product_code;
		END IF;
		

		#更新高层货位对应货品存放量,需要判断该货位上是否已经存在
		SELECT count(1) INTO _count FROM isale_spacedetail WHERE space_code = _space_code_high AND product_code = _product_code;
		IF (_count+0) = 0 THEN
			INSERT INTO isale_spacedetail(space_code,space_halftype,space_count,space_excount,product_code,product_name,product_enname,product_barcode,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort
			,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate)
			VALUES(
				_space_code_high,_space_halftype,_move_count,0,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,
				_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate
			);
		ELSE
			UPDATE isale_spacedetail SET space_count = space_count + _move_count WHERE space_code = _space_code_high AND product_code = _product_code;
		END IF;

		#移库货品总体积
		SET _product_totalbulk = _product_bulk * _move_count;
		#SELECT CONCAT('_product_totalbulk：',_product_totalbulk);
		#更新space高层货位使用、未用提交
		#SELECT space_leftbulk INTO _space_leftbulk FROM isale_space WHERE space_code = _space_code_high;
		#IF (_space_leftbulk+0) > (_product_totalbulk+0) THEN
				#考虑到移库货品体积远远大于货位体积,将其移库完毕,也有可能使用体积为负,但是还有其余小货品存放
		#所以咋不考虑更新货位一系列值
		#END IF;
		#更新普通已用减少,剩余增多
		UPDATE isale_space SET space_usedbulk = space_usedbulk - _product_totalbulk,space_leftbulk = space_leftbulk + _product_totalbulk  WHERE space_code = _space_code_normal;
		#更新高层已用增多,剩余减少
		UPDATE isale_space SET space_usedbulk = space_usedbulk + _product_totalbulk,space_leftbulk = space_leftbulk - _product_totalbulk,space_usestate = 2 WHERE space_code = _space_code_high;
		
		
		#解锁货位
		UPDATE isale_space SET space_lockstate = 1 WHERE space_code = _space_code_high;
		UPDATE isale_space SET space_lockstate = 1 WHERE space_code = _space_code_normal;

		SET result = 1;
		#设置返回值
		SELECT result;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_move_normalToNormal
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_move_normalToNormal`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_move_normalToNormal`(_space_code_normal_first varchar(500),_space_number_normal_first varchar(500),_space_code_normal_second varchar(500),_space_number_normal_second varchar(500),_space_halftype int,_move_product_code varchar(500),_move_count int,_task_user_code varchar(500),_task_user_name varchar(500),_task_user_logourl varchar(500),out result int)
BEGIN
		DECLARE _product_code	VARCHAR(500);   			   #货品系统编码
		DECLARE _product_name	VARCHAR(500); 					 #货品名称
		DECLARE _product_enname	VARCHAR(500);          #货品英文名称
		DECLARE _product_barcode	VARCHAR(500);        #货品条码
		DECLARE _product_sku	VARCHAR(500);            #货品SKU编号同步第三方平台
		DECLARE _product_unit	VARCHAR(500);            #货品单位
		DECLARE _product_weight	VARCHAR(500);          #货品重量
		DECLARE _product_length	VARCHAR(500);          #货品长度(单位:mm)
		DECLARE _product_width	VARCHAR(500);          #货品宽度(单位:mm)
		DECLARE _product_heigth	VARCHAR(500);          #货品高度(单位:mm)
		DECLARE _product_length_sort	VARCHAR(500);    #货品排序后长边(单位:mm)
		DECLARE _product_width_sort	VARCHAR(500);      #货品排序后中边(单位:mm)
		DECLARE _product_heigth_sort	VARCHAR(500);		 #货品排序后短边(单位:mm)
		DECLARE _product_bulk	VARCHAR(500);            #货品体积
		DECLARE _product_imgurl	VARCHAR(500);          #货品图片
		DECLARE _product_state	INT;									 #货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)
		DECLARE _product_groupstate INT;               #货品组合状态(1：未组合、2：组合)
		DECLARE _product_batterystate INT;						 #货品是否带电池(1：是、2：否)
		DECLARE _product_totalbulk VARCHAR(500); 			 #移库货品总体积
	  DECLARE _user_code VARCHAR(500);							 #货主系统编码
		DECLARE _user_name VARCHAR(500);							 #货主系统名称
    DECLARE _user_mobilephone VARCHAR(500);        #货主联系方式
		DECLARE _task_code VARCHAR(500);				       #任务系统编码
		DECLARE _task_content VARCHAR(500);						 #任务内容
		DECLARE _space_count VARCHAR(500);						 #货品存放总量
	  DECLARE _count INT;														 #移入货位当前货品存放量
		#----移位 锁定移库货位,并且移出货位当前无任务
		
		#锁定货位
		UPDATE isale_space SET space_lockstate = 2 WHERE space_code = _space_code_normal_first;
		UPDATE isale_space SET space_lockstate = 2 WHERE space_code = _space_code_normal_second;
		
		#根据货品编码查询货品信息
	  SELECT product_code,product_name,product_enname,product_barcode,product_sku,product_unit,
		product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,
		product_imgurl,product_state,product_groupstate,product_batterystate,user_code INTO _product_code,_product_name,_product_enname,
		_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,
		_product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,
		_product_batterystate,_user_code FROM isale_product WHERE product_code = _move_product_code;
		
		#根据货主系统编码查询货主
		SELECT user_name,user_mobilephone INTO _user_name,_user_mobilephone from isale_user WHERE user_code = _user_code;

		#写入task,并更新状态已完成
		SET _task_code = CONCAT('700',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
		SET _task_content = CONCAT(_product_name,'从普通货位',_space_number_normal_first,'移至普通货位',_space_number_normal_second);

		INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,product_code,product_name,product_enname,product_barcode
		,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort
		,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_logourl) 
		VALUES
		(_task_code,7,'',_move_count,_task_content,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_task_user_code,_task_user_name,_task_user_logourl
		);
		#默认更新已完成
		UPDATE isale_task SET task_state = 3 WHERE task_code = _task_code;

		#普通下架spacedetaillog
		INSERT INTO isale_spacedetaillog(space_code,space_halftype,space_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit
		,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_mobilephone,task_code,task_type)
		VALUES(_space_code_normal_first,_space_halftype,_move_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_user_code,_user_name,_user_mobilephone,_task_code,2);
			
		#普通上架spacedetaillog
		INSERT INTO isale_spacedetaillog(space_code,space_halftype,space_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit
		,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_mobilephone,task_code,task_type)
		VALUES(_space_code_normal_second,_space_halftype,_move_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_user_code,_user_name,_user_mobilephone,_task_code,1);
		

		#更新移出spacedetail普通货位货品存放量 如果货位存放数量和移库数量一致,则删除该条记录,否则更新
		SELECT space_count INTO _space_count FROM isale_spacedetail WHERE space_code = _space_code_normal_first AND product_code = _product_code;
		IF (_move_count+0) = (_space_count+0) THEN
				DELETE FROM isale_spacedetail WHERE space_code = _space_code_normal_first AND product_code = _product_code;
		ELSE
				UPDATE isale_spacedetail SET space_count = space_count - _move_count WHERE space_code = _space_code_normal_first AND product_code = _product_code;
		END IF;
		
		
		#更新移入普通对应货品存放量,需要判断该货位上是否已经存在
		SELECT count(1) INTO _count FROM isale_spacedetail WHERE space_code = _space_code_normal_second AND product_code = _product_code;
		IF (_count+0) = 0 THEN
			INSERT INTO isale_spacedetail(space_code,space_halftype,space_count,space_excount,product_code,product_name,product_enname,product_barcode,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort
			,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate)
			VALUES(
				_space_code_normal_second,_space_halftype,_move_count,0,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,
				_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate
			);
		ELSE
			UPDATE isale_spacedetail SET space_count = space_count + _move_count WHERE space_code = _space_code_normal_second AND product_code = _product_code;
		END IF;

		#移库货品总体积
		SET _product_totalbulk = _product_bulk * _move_count;
		#SELECT CONCAT('_product_totalbulk：',_product_totalbulk);
		#更新space高层货位使用、未用提交
		#SELECT space_leftbulk INTO _space_leftbulk FROM isale_space WHERE space_code = _space_code_top;
		#IF (_space_leftbulk+0) > (_product_totalbulk+0) THEN
				#考虑到移库货品体积远远大于货位体积,将其移库完毕,也有可能使用体积为负,但是还有其余小货品存放
		#所以咋不考虑更新货位一系列值
		#END IF;
		#更新普通first已用减少,剩余增多
		UPDATE isale_space SET space_usedbulk = space_usedbulk - _product_totalbulk,space_leftbulk = space_leftbulk + _product_totalbulk  WHERE space_code = _space_code_normal_first;
		#更新普通second已用增多,剩余减少
		UPDATE isale_space SET space_usedbulk = space_usedbulk + _product_totalbulk,space_leftbulk = space_leftbulk - _product_totalbulk,space_usestate = 2 WHERE space_code = _space_code_normal_second;
	
		#解锁货位
		UPDATE isale_space SET space_lockstate = 1 WHERE space_code = _space_code_normal_first;
		UPDATE isale_space SET space_lockstate = 1 WHERE space_code = _space_code_normal_second;

		SET result = 1;
		#设置返回值
		SELECT result;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_move_normalToTop
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_move_normalToTop`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_move_normalToTop`(_space_code_normal varchar(500),_space_number_normal varchar(500),_space_code_top varchar(500),_space_number_top varchar(500),_space_halftype int,_move_product_code varchar(500),_move_count int,_task_user_code varchar(500),_task_user_name varchar(500),_task_user_logourl varchar(500),out result int)
BEGIN
		DECLARE _product_code	VARCHAR(500);   			   #货品系统编码
		DECLARE _product_name	VARCHAR(500); 					 #货品名称
		DECLARE _product_enname	VARCHAR(500);          #货品英文名称
		DECLARE _product_barcode	VARCHAR(500);        #货品条码
		DECLARE _product_sku	VARCHAR(500);            #货品SKU编号同步第三方平台
		DECLARE _product_unit	VARCHAR(500);            #货品单位
		DECLARE _product_weight	VARCHAR(500);          #货品重量
		DECLARE _product_length	VARCHAR(500);          #货品长度(单位:mm)
		DECLARE _product_width	VARCHAR(500);          #货品宽度(单位:mm)
		DECLARE _product_heigth	VARCHAR(500);          #货品高度(单位:mm)
		DECLARE _product_length_sort	VARCHAR(500);    #货品排序后长边(单位:mm)
		DECLARE _product_width_sort	VARCHAR(500);      #货品排序后中边(单位:mm)
		DECLARE _product_heigth_sort	VARCHAR(500);		 #货品排序后短边(单位:mm)
		DECLARE _product_bulk	VARCHAR(500);            #货品体积
		DECLARE _product_imgurl	VARCHAR(500);          #货品图片
		DECLARE _product_state	INT;									 #货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)
		DECLARE _product_groupstate INT;               #货品组合状态(1：未组合、2：组合)
		DECLARE _product_batterystate INT;						 #货品是否带电池(1：是、2：否)
		DECLARE _product_totalbulk VARCHAR(500); 			 #移库货品总体积
	  DECLARE _user_code VARCHAR(500);							 #货主系统编码
		DECLARE _user_name VARCHAR(500);							 #货主系统名称
    DECLARE _user_mobilephone VARCHAR(500);        #货主联系方式
		DECLARE _task_code VARCHAR(500);				       #任务系统编码
		DECLARE _task_content VARCHAR(500);						 #任务内容
		DECLARE _space_count VARCHAR(500);						 #货品存放总量
		DECLARE _count INT;														 #移入货位当前货品存放量
		#----移位 普通-顶层  锁定移库货位,并且移出货位当前无任务
		
		#锁定货位
		UPDATE isale_space SET space_lockstate = 2 WHERE space_code = _space_code_normal;
		UPDATE isale_space SET space_lockstate = 2 WHERE space_code = _space_code_top;
		
		#根据货品编码查询货品信息
	  SELECT product_code,product_name,product_enname,product_barcode,product_sku,product_unit,
		product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,
		product_imgurl,product_state,product_groupstate,product_batterystate,user_code INTO _product_code,_product_name,_product_enname,
		_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,
		_product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,
		_product_batterystate,_user_code FROM isale_product WHERE product_code = _move_product_code;
		
		#根据货主系统编码查询货主
		SELECT user_name,user_mobilephone INTO _user_name,_user_mobilephone from isale_user WHERE user_code = _user_code;

		#写入task,并更新状态已完成
		SET _task_code = CONCAT('700',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
		SET _task_content = CONCAT(_product_name,'从普通货位',_space_number_normal,'移至顶层货位',_space_number_top);

		INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,product_code,product_name,product_enname,product_barcode
		,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort
		,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_logourl) 
		VALUES
		(_task_code,7,'',_move_count,_task_content,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_task_user_code,_task_user_name,_task_user_logourl
		);
		#默认更新已完成
		UPDATE isale_task SET task_state = 3 WHERE task_code = _task_code;

		#普通下架spacedetaillog
		INSERT INTO isale_spacedetaillog(space_code,space_halftype,space_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit
		,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_mobilephone,task_code,task_type)
		VALUES(_space_code_normal,_space_halftype,_move_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_user_code,_user_name,_user_mobilephone,_task_code,2);
			
		#顶层上架spacedetaillog
		INSERT INTO isale_spacedetaillog(space_code,space_halftype,space_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit
		,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_mobilephone,task_code,task_type)
		VALUES(_space_code_top,_space_halftype,_move_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_user_code,_user_name,_user_mobilephone,_task_code,1);
		

		#更新普通货位货品存放量 如果货位存放数量和移库数量一致,则删除该条记录,否则更新
		SELECT space_count INTO _space_count FROM isale_spacedetail WHERE space_code = _space_code_normal AND product_code = _product_code;
		IF (_move_count+0) = (_space_count+0) THEN
				DELETE FROM isale_spacedetail WHERE space_code = _space_code_normal AND product_code = _product_code;
		ELSE
				UPDATE isale_spacedetail SET space_count = space_count - _move_count WHERE space_code = _space_code_normal AND product_code = _product_code;
		END IF;
		
		#更新移入顶层对应货品存放量,需要判断该货位上是否已经存在
		SELECT count(1) INTO _count FROM isale_spacedetail WHERE space_code = _space_code_top AND product_code = _product_code;
		IF (_count+0) = 0 THEN
			INSERT INTO isale_spacedetail(space_code,space_halftype,space_count,space_excount,product_code,product_name,product_enname,product_barcode,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort
			,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate)
			VALUES(
				_space_code_top,_space_halftype,_move_count,0,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,
				_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate
			);
		ELSE
			UPDATE isale_spacedetail SET space_count = space_count + _move_count WHERE space_code = _space_code_top AND product_code = _product_code;
		END IF;

	

		#移库货品总体积
		SET _product_totalbulk = _product_bulk * _move_count;
		#SELECT CONCAT('_product_totalbulk：',_product_totalbulk);
		#更新space高层货位使用、未用提交
		#SELECT space_leftbulk INTO _space_leftbulk FROM isale_space WHERE space_code = _space_code_top;
		#IF (_space_leftbulk+0) > (_product_totalbulk+0) THEN
				#考虑到移库货品体积远远大于货位体积,将其移库完毕,也有可能使用体积为负,但是还有其余小货品存放
		#所以咋不考虑更新货位一系列值
		#END IF;
		#更新普通已用减少,剩余增多
		UPDATE isale_space SET space_usedbulk = space_usedbulk - _product_totalbulk,space_leftbulk = space_leftbulk + _product_totalbulk  WHERE space_code = _space_code_normal;
		#更新顶层已用增多,剩余减少
		UPDATE isale_space SET space_usedbulk = space_usedbulk + _product_totalbulk,space_leftbulk = space_leftbulk - _product_totalbulk,space_usestate = 2 WHERE space_code = _space_code_top;
	
		#解锁货位
		UPDATE isale_space SET space_lockstate = 1 WHERE space_code = _space_code_normal;
		UPDATE isale_space SET space_lockstate = 1 WHERE space_code = _space_code_top;
		

		SET result = 1;
		#设置返回值
		SELECT result;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_move_NTHToSpecial
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_move_NTHToSpecial`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_move_NTHToSpecial`(_space_code varchar(500),_space_number varchar(500),_space_code_special varchar(500),_space_number_special varchar(500),_space_halftype int,_move_product_code varchar(500),_move_count int,_task_user_code varchar(500),_task_user_name varchar(500),_task_user_logourl varchar(500),out result int)
BEGIN
		DECLARE _product_code	VARCHAR(500);   			   #货品系统编码
		DECLARE _product_name	VARCHAR(500); 					 #货品名称
		DECLARE _product_enname	VARCHAR(500);          #货品英文名称
		DECLARE _product_barcode	VARCHAR(500);        #货品条码
		DECLARE _product_sku	VARCHAR(500);            #货品SKU编号同步第三方平台
		DECLARE _product_unit	VARCHAR(500);            #货品单位
		DECLARE _product_weight	VARCHAR(500);          #货品重量
		DECLARE _product_length	VARCHAR(500);          #货品长度(单位:mm)
		DECLARE _product_width	VARCHAR(500);          #货品宽度(单位:mm)
		DECLARE _product_heigth	VARCHAR(500);          #货品高度(单位:mm)
		DECLARE _product_length_sort	VARCHAR(500);    #货品排序后长边(单位:mm)
		DECLARE _product_width_sort	VARCHAR(500);      #货品排序后中边(单位:mm)
		DECLARE _product_heigth_sort	VARCHAR(500);		 #货品排序后短边(单位:mm)
		DECLARE _product_bulk	VARCHAR(500);            #货品体积
		DECLARE _product_imgurl	VARCHAR(500);          #货品图片
		DECLARE _product_state	INT;									 #货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)
		DECLARE _product_groupstate INT;               #货品组合状态(1：未组合、2：组合)
		DECLARE _product_batterystate INT;						 #货品是否带电池(1：是、2：否)
		DECLARE _product_totalbulk VARCHAR(500); 			 #移库货品总体积
	  DECLARE _user_code VARCHAR(500);							 #货主系统编码
		DECLARE _user_name VARCHAR(500);							 #货主系统名称
    DECLARE _user_mobilephone VARCHAR(500);        #货主联系方式
		DECLARE _task_code VARCHAR(500);				       #任务系统编码
		DECLARE _task_content VARCHAR(500);						 #任务内容
		DECLARE _space_count VARCHAR(500);						 #货品存放总量
		DECLARE _count INT;														 #移入货位当前货品存放量

		#----移位 普通、顶层、高层--->借货货位  锁定移库货位,并且移出货位当前无任务
		
		#锁定货位
		UPDATE isale_space SET space_lockstate = 2 WHERE space_code = _space_code;
		UPDATE isale_space SET space_lockstate = 2 WHERE space_code = _space_code_special;
		
		#根据货品编码查询货品信息
	  SELECT product_code,product_name,product_enname,product_barcode,product_sku,product_unit,
		product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,
		product_imgurl,product_state,product_groupstate,product_batterystate,user_code INTO _product_code,_product_name,_product_enname,
		_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,
		_product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,
		_product_batterystate,_user_code FROM isale_product WHERE product_code = _move_product_code;
		
		#根据货主系统编码查询货主
		SELECT user_name,user_mobilephone INTO _user_name,_user_mobilephone from isale_user WHERE user_code = _user_code;

		#写入task,并更新状态已完成
		SET _task_code = CONCAT('700',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
		SET _task_content = CONCAT(_product_name,'从货位',_space_number,'移至借货货位',_space_number_special);

		INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,product_code,product_name,product_enname,product_barcode
		,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort
		,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_logourl) 
		VALUES
		(_task_code,7,'',_move_count,_task_content,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_task_user_code,_task_user_name,_task_user_logourl
		);
		#默认更新已完成
		UPDATE isale_task SET task_state = 3 WHERE task_code = _task_code;

		#N,T,G下架spacedetaillog
		INSERT INTO isale_spacedetaillog(space_code,space_halftype,space_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit
		,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_mobilephone,task_code,task_type)
		VALUES(_space_code,_space_halftype,_move_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_user_code,_user_name,_user_mobilephone,_task_code,2);
			
		#借货上架spacedetaillog
		INSERT INTO isale_spacedetaillog(space_code,space_halftype,space_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit
		,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_mobilephone,task_code,task_type)
		VALUES(_space_code_special,_space_halftype,_move_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_user_code,_user_name,_user_mobilephone,_task_code,1);
		

		#更新spacedetail顶层货品存放量 如果高层货位存放数量和移库数量一致,则删除该条记录,否则更新
		SELECT space_count INTO _space_count FROM isale_spacedetail WHERE space_code = _space_code AND product_code = _product_code;
		IF (_move_count+0) = (_space_count+0) THEN
				DELETE FROM isale_spacedetail WHERE space_code = _space_code AND product_code = _product_code;
		ELSE
				UPDATE isale_spacedetail SET space_count = space_count - _move_count WHERE space_code = _space_code AND product_code = _product_code;
		END IF;
		
		#更新移入借货对应货品存放量,需要判断该货位上是否已经存在
		SELECT count(1) INTO _count FROM isale_spacedetail WHERE space_code = _space_code_special AND product_code = _product_code;
		IF (_count+0) = 0 THEN
			INSERT INTO isale_spacedetail(space_code,space_halftype,space_count,space_excount,product_code,product_name,product_enname,product_barcode,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort
			,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate)
			VALUES(
				_space_code_special,_space_halftype,_move_count,0,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,
				_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate
			);
		ELSE
			UPDATE isale_spacedetail SET space_count = space_count + _move_count WHERE space_code = _space_code_special AND product_code = _product_code;
		END IF;

	

		#移库货品总体积
		SET _product_totalbulk = _product_bulk * _move_count;
		#SELECT CONCAT('_product_totalbulk：',_product_totalbulk);
		#更新space高层货位使用、未用提交
		#SELECT space_leftbulk INTO _space_leftbulk FROM isale_space WHERE space_code = _space_code_top;
		#IF (_space_leftbulk+0) > (_product_totalbulk+0) THEN
				#考虑到移库货品体积远远大于货位体积,将其移库完毕,也有可能使用体积为负,但是还有其余小货品存放
		#所以咋不考虑更新货位一系列值
		#END IF;
		#更新N,T,G已用减少,剩余增多
		UPDATE isale_space SET space_usedbulk = space_usedbulk - _product_totalbulk,space_leftbulk = space_leftbulk + _product_totalbulk  WHERE space_code = _space_code;
		#更新借货已用增多,剩余减少
		UPDATE isale_space SET space_usedbulk = space_usedbulk + _product_totalbulk,space_leftbulk = space_leftbulk - _product_totalbulk,space_usestate = 2 WHERE space_code = _space_code_special;
	
		#解锁货位
		UPDATE isale_space SET space_lockstate = 1 WHERE space_code = _space_code;
		UPDATE isale_space SET space_lockstate = 1 WHERE space_code = _space_code_special;
		
		#预扣库存
		UPDATE isale_storage SET storage_excount = storage_excount + _move_count WHERE product_code = _move_product_code AND storage_halftype = _space_halftype;
		
		SET result = 1;
		#设置返回值
		SELECT result;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_move_specialToNTH
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_move_specialToNTH`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_move_specialToNTH`(_space_code_special varchar(500),_space_number_special varchar(500),_space_code varchar(500),_space_number varchar(500),_space_halftype int,_move_product_code varchar(500),_move_count int,_task_user_code varchar(500),_task_user_name varchar(500),_task_user_logourl varchar(500),out result int)
BEGIN
		DECLARE _product_code	VARCHAR(500);   			   #货品系统编码
		DECLARE _product_name	VARCHAR(500); 					 #货品名称
		DECLARE _product_enname	VARCHAR(500);          #货品英文名称
		DECLARE _product_barcode	VARCHAR(500);        #货品条码
		DECLARE _product_sku	VARCHAR(500);            #货品SKU编号同步第三方平台
		DECLARE _product_unit	VARCHAR(500);            #货品单位
		DECLARE _product_weight	VARCHAR(500);          #货品重量
		DECLARE _product_length	VARCHAR(500);          #货品长度(单位:mm)
		DECLARE _product_width	VARCHAR(500);          #货品宽度(单位:mm)
		DECLARE _product_heigth	VARCHAR(500);          #货品高度(单位:mm)
		DECLARE _product_length_sort	VARCHAR(500);    #货品排序后长边(单位:mm)
		DECLARE _product_width_sort	VARCHAR(500);      #货品排序后中边(单位:mm)
		DECLARE _product_heigth_sort	VARCHAR(500);		 #货品排序后短边(单位:mm)
		DECLARE _product_bulk	VARCHAR(500);            #货品体积
		DECLARE _product_imgurl	VARCHAR(500);          #货品图片
		DECLARE _product_state	INT;									 #货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)
		DECLARE _product_groupstate INT;               #货品组合状态(1：未组合、2：组合)
		DECLARE _product_batterystate INT;						 #货品是否带电池(1：是、2：否)
		DECLARE _product_totalbulk VARCHAR(500); 			 #移库货品总体积
	  DECLARE _user_code VARCHAR(500);							 #货主系统编码
		DECLARE _user_name VARCHAR(500);							 #货主系统名称
    DECLARE _user_mobilephone VARCHAR(500);        #货主联系方式
		DECLARE _task_code VARCHAR(500);				       #任务系统编码
		DECLARE _task_content VARCHAR(500);						 #任务内容
		DECLARE _space_count VARCHAR(500);						 #货品存放总量
		DECLARE _count INT;														 #移入货位当前货品存放量

		#----移位 借货货位--->普通、顶层、高层 锁定移库货位,并且移出货位当前无任务
		
		#锁定货位
		UPDATE isale_space SET space_lockstate = 2 WHERE space_code = _space_code_special;
		UPDATE isale_space SET space_lockstate = 2 WHERE space_code = _space_code;
		
		#根据货品编码查询货品信息
	  SELECT product_code,product_name,product_enname,product_barcode,product_sku,product_unit,
		product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,
		product_imgurl,product_state,product_groupstate,product_batterystate,user_code INTO _product_code,_product_name,_product_enname,
		_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,
		_product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,
		_product_batterystate,_user_code FROM isale_product WHERE product_code = _move_product_code;
		
		#根据货主系统编码查询货主
		SELECT user_name,user_mobilephone INTO _user_name,_user_mobilephone from isale_user WHERE user_code = _user_code;

		#写入task,并更新状态已完成
		SET _task_code = CONCAT('700',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
		SET _task_content = CONCAT(_product_name,'从借货货位',_space_number_special,'移至货位',_space_number);

		INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,product_code,product_name,product_enname,product_barcode
		,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort
		,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_logourl) 
		VALUES
		(_task_code,7,'',_move_count,_task_content,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_task_user_code,_task_user_name,_task_user_logourl
		);
		#默认更新已完成
		UPDATE isale_task SET task_state = 3 WHERE task_code = _task_code;

		#借货下架spacedetaillog
		INSERT INTO isale_spacedetaillog(space_code,space_halftype,space_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit
		,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_mobilephone,task_code,task_type)
		VALUES(_space_code_special,_space_halftype,_move_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_user_code,_user_name,_user_mobilephone,_task_code,2);
			
		#N,T,G上架spacedetaillog
		INSERT INTO isale_spacedetaillog(space_code,space_halftype,space_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit
		,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_mobilephone,task_code,task_type)
		VALUES(_space_code,_space_halftype,_move_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_user_code,_user_name,_user_mobilephone,_task_code,1);
		

		#更新移出货品存放量 如果货位存放数量和移库数量一致,则删除该条记录,否则更新
		SELECT space_count INTO _space_count FROM isale_spacedetail WHERE space_code = _space_code_special AND product_code = _product_code;
		IF (_move_count+0) = (_space_count+0) THEN
				DELETE FROM isale_spacedetail WHERE space_code = _space_code_special AND product_code = _product_code;
		ELSE
				UPDATE isale_spacedetail SET space_count = space_count - _move_count WHERE space_code = _space_code_special AND product_code = _product_code;
		END IF;
		
		#更新移入货品存放量,需要判断该货位上是否已经存在
		SELECT count(1) INTO _count FROM isale_spacedetail WHERE space_code = _space_code AND product_code = _product_code;
		IF (_count+0) = 0 THEN
			INSERT INTO isale_spacedetail(space_code,space_halftype,space_count,space_excount,product_code,product_name,product_enname,product_barcode,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort
			,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate)
			VALUES(
				_space_code,_space_halftype,_move_count,0,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,
				_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate
			);
		ELSE
			UPDATE isale_spacedetail SET space_count = space_count + _move_count WHERE space_code = _space_code AND product_code = _product_code;
		END IF;

	

		#移库货品总体积
		SET _product_totalbulk = _product_bulk * _move_count;
		#SELECT CONCAT('_product_totalbulk：',_product_totalbulk);
		#更新space高层货位使用、未用提交
		#SELECT space_leftbulk INTO _space_leftbulk FROM isale_space WHERE space_code = _space_code_top;
		#IF (_space_leftbulk+0) > (_product_totalbulk+0) THEN
				#考虑到移库货品体积远远大于货位体积,将其移库完毕,也有可能使用体积为负,但是还有其余小货品存放
		#所以咋不考虑更新货位一系列值
		#END IF;
		#更新借货已用减少,剩余增多
		UPDATE isale_space SET space_usedbulk = space_usedbulk - _product_totalbulk,space_leftbulk = space_leftbulk + _product_totalbulk  WHERE space_code = _space_code_special;
		#更新N,T,G已用增多,剩余减少
		UPDATE isale_space SET space_usedbulk = space_usedbulk + _product_totalbulk,space_leftbulk = space_leftbulk - _product_totalbulk,space_usestate = 2 WHERE space_code = _space_code;
	
		#解锁货位
		UPDATE isale_space SET space_lockstate = 1 WHERE space_code = _space_code_special;
		UPDATE isale_space SET space_lockstate = 1 WHERE space_code = _space_code;
		
		#预扣库存
		UPDATE isale_storage SET storage_excount = storage_excount - _move_count WHERE product_code = _move_product_code AND storage_halftype = _space_halftype;
		
		SET result = 1;
		#设置返回值
		SELECT result;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_move_topToHigh
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_move_topToHigh`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_move_topToHigh`(_space_code_top varchar(500),_space_number_top varchar(500),_space_code_high varchar(500),_space_number_high varchar(500),_space_halftype int,_move_product_code varchar(500),_move_count int,_task_user_code varchar(500),_task_user_name varchar(500),_task_user_logourl varchar(500),out result int)
BEGIN
		DECLARE _product_code	VARCHAR(500);   			   #货品系统编码
		DECLARE _product_name	VARCHAR(500); 					 #货品名称
		DECLARE _product_enname	VARCHAR(500);          #货品英文名称
		DECLARE _product_barcode	VARCHAR(500);        #货品条码
		DECLARE _product_sku	VARCHAR(500);            #货品SKU编号同步第三方平台
		DECLARE _product_unit	VARCHAR(500);            #货品单位
		DECLARE _product_weight	VARCHAR(500);          #货品重量
		DECLARE _product_length	VARCHAR(500);          #货品长度(单位:mm)
		DECLARE _product_width	VARCHAR(500);          #货品宽度(单位:mm)
		DECLARE _product_heigth	VARCHAR(500);          #货品高度(单位:mm)
		DECLARE _product_length_sort	VARCHAR(500);    #货品排序后长边(单位:mm)
		DECLARE _product_width_sort	VARCHAR(500);      #货品排序后中边(单位:mm)
		DECLARE _product_heigth_sort	VARCHAR(500);		 #货品排序后短边(单位:mm)
		DECLARE _product_bulk	VARCHAR(500);            #货品体积
		DECLARE _product_imgurl	VARCHAR(500);          #货品图片
		DECLARE _product_state	INT;									 #货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)
		DECLARE _product_groupstate INT;               #货品组合状态(1：未组合、2：组合)
		DECLARE _product_batterystate INT;						 #货品是否带电池(1：是、2：否)
		DECLARE _product_totalbulk VARCHAR(500); 			 #移库货品总体积
		DECLARE _user_code VARCHAR(500);							 #货主系统编码
		DECLARE _user_name VARCHAR(500);							 #货主系统名称
    DECLARE _user_mobilephone VARCHAR(500);        #货主联系方式
		DECLARE _task_code VARCHAR(500);				       #任务系统编码
		DECLARE _task_content VARCHAR(500);						 #任务内容
		DECLARE _space_count VARCHAR(500);						 #货品存放总量
		DECLARE _count INT;														 #移入货位当前货品存放量
		#----移位 顶层-高层  锁定移库货位,并且移出货位当前无任务
		
		#锁定货位
		UPDATE isale_space SET space_lockstate = 2 WHERE space_code = _space_code_top;
		UPDATE isale_space SET space_lockstate = 2 WHERE space_code = _space_code_high;
		

		#根据货品编码查询货品信息
	  SELECT product_code,product_name,product_enname,product_barcode,product_sku,product_unit,
		product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,
		product_imgurl,product_state,product_groupstate,product_batterystate,user_code INTO _product_code,_product_name,_product_enname,
		_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,
		_product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,
		_product_batterystate,_user_code FROM isale_product WHERE product_code = _move_product_code;
		
		#根据货主系统编码查询货主
		SELECT user_name,user_mobilephone INTO _user_name,_user_mobilephone from isale_user WHERE user_code = _user_code;
		
		#写入task,并更新状态已完成
		SET _task_code = CONCAT('700',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
		SET _task_content = CONCAT(_product_name,'从顶层货位',_space_number_top,'移至高层货位',_space_number_high);

		INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,product_code,product_name,product_enname,product_barcode
		,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort
		,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_logourl) 
		VALUES
		(_task_code,7,'',_move_count,_task_content,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_task_user_code,_task_user_name,_task_user_logourl
		);
		#默认更新已完成
		UPDATE isale_task SET task_state = 3 WHERE task_code = _task_code;

		#顶层下架spacedetaillog
		INSERT INTO isale_spacedetaillog(space_code,space_halftype,space_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit
		,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_mobilephone,task_code,task_type)
		VALUES(_space_code_top,_space_halftype,_move_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_user_code,_user_name,_user_mobilephone,_task_code,2);
			
		#高层上架spacedetaillog
		INSERT INTO isale_spacedetaillog(space_code,space_halftype,space_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit
		,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_mobilephone,task_code,task_type)
		VALUES(_space_code_high,_space_halftype,_move_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_user_code,_user_name,_user_mobilephone,_task_code,1);
		

		#更新顶层货品存放量 如果货位存放数量和移库数量一致,则删除该条记录,否则更新
		SELECT space_count INTO _space_count FROM isale_spacedetail WHERE space_code = _space_code_top AND product_code = _product_code;
		IF (_move_count+0) = (_space_count+0) THEN
				DELETE FROM isale_spacedetail WHERE space_code = _space_code_top AND product_code = _product_code;
		ELSE
				UPDATE isale_spacedetail SET space_count = space_count - _move_count WHERE space_code = _space_code_top AND product_code = _product_code;
		END IF;
		
		#更新移入高层对应货品存放量,需要判断该货位上是否已经存在
		SELECT count(1) INTO _count FROM isale_spacedetail WHERE space_code = _space_code_high AND product_code = _product_code;
		IF (_count+0) = 0 THEN
			INSERT INTO isale_spacedetail(space_code,space_halftype,space_count,space_excount,product_code,product_name,product_enname,product_barcode,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort
			,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate)
			VALUES(
				_space_code_high,_space_halftype,_move_count,0,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,
				_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate
			);
		ELSE
			UPDATE isale_spacedetail SET space_count = space_count + _move_count WHERE space_code = _space_code_high AND product_code = _product_code;
		END IF;

		#移库货品总体积
		SET _product_totalbulk = _product_bulk * _move_count;
		#SELECT CONCAT('_product_totalbulk：',_product_totalbulk);
		#更新space高层货位使用、未用提交
		#SELECT space_leftbulk INTO _space_leftbulk FROM isale_space WHERE space_code = _space_code_high;
		#IF (_space_leftbulk+0) > (_product_totalbulk+0) THEN
				#考虑到移库货品体积远远大于货位体积,将其移库完毕,也有可能使用体积为负,但是还有其余小货品存放
		#所以咋不考虑更新货位一系列值
		#END IF;
		#更新顶层已用减少,剩余增多
		UPDATE isale_space SET space_usedbulk = space_usedbulk - _product_totalbulk,space_leftbulk = space_leftbulk + _product_totalbulk  WHERE space_code = _space_code_top;
		#更新高层已用增多,剩余减少
		UPDATE isale_space SET space_usedbulk = space_usedbulk + _product_totalbulk,space_leftbulk = space_leftbulk - _product_totalbulk,space_usestate = 2 WHERE space_code = _space_code_high;
		
		
		#解锁货位
		UPDATE isale_space SET space_lockstate = 1 WHERE space_code = _space_code_top;
		UPDATE isale_space SET space_lockstate = 1 WHERE space_code = _space_code_high;
		
		SET result = 1;
		#设置返回值
		SELECT result;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_move_topToNormal
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_move_topToNormal`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_move_topToNormal`(_space_code_top varchar(500),_space_number_top varchar(500),_space_code_normal varchar(500),_space_number_normal varchar(500),_space_halftype int,_move_product_code varchar(500),_move_count int,_task_user_code varchar(500),_task_user_name varchar(500),_task_user_logourl varchar(500),out result int)
BEGIN
		DECLARE _product_code	VARCHAR(500);   			   #货品系统编码
		DECLARE _product_name	VARCHAR(500); 					 #货品名称
		DECLARE _product_enname	VARCHAR(500);          #货品英文名称
		DECLARE _product_barcode	VARCHAR(500);        #货品条码
		DECLARE _product_sku	VARCHAR(500);            #货品SKU编号同步第三方平台
		DECLARE _product_unit	VARCHAR(500);            #货品单位
		DECLARE _product_weight	VARCHAR(500);          #货品重量
		DECLARE _product_length	VARCHAR(500);          #货品长度(单位:mm)
		DECLARE _product_width	VARCHAR(500);          #货品宽度(单位:mm)
		DECLARE _product_heigth	VARCHAR(500);          #货品高度(单位:mm)
		DECLARE _product_length_sort	VARCHAR(500);    #货品排序后长边(单位:mm)
		DECLARE _product_width_sort	VARCHAR(500);      #货品排序后中边(单位:mm)
		DECLARE _product_heigth_sort	VARCHAR(500);		 #货品排序后短边(单位:mm)
		DECLARE _product_bulk	VARCHAR(500);            #货品体积
		DECLARE _product_imgurl	VARCHAR(500);          #货品图片
		DECLARE _product_state	INT;									 #货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)
		DECLARE _product_groupstate INT;               #货品组合状态(1：未组合、2：组合)
		DECLARE _product_batterystate INT;						 #货品是否带电池(1：是、2：否)
		DECLARE _product_totalbulk VARCHAR(500); 			 #移库货品总体积
	  DECLARE _user_code VARCHAR(500);							 #货主系统编码
		DECLARE _user_name VARCHAR(500);							 #货主系统名称
    DECLARE _user_mobilephone VARCHAR(500);        #货主联系方式
		DECLARE _task_code VARCHAR(500);				       #任务系统编码
		DECLARE _task_content VARCHAR(500);						 #任务内容
		DECLARE _space_count VARCHAR(500);						 #货品存放总量
		DECLARE _count INT;														 #移入货位当前货品存放量
		#----移位 顶层-普通  锁定移库货位,并且移出货位当前无任务
		
		#锁定货位
		UPDATE isale_space SET space_lockstate = 2 WHERE space_code = _space_code_top;
		UPDATE isale_space SET space_lockstate = 2 WHERE space_code = _space_code_normal;
		
		#根据货品编码查询货品信息
	  SELECT product_code,product_name,product_enname,product_barcode,product_sku,product_unit,
		product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,
		product_imgurl,product_state,product_groupstate,product_batterystate,user_code INTO _product_code,_product_name,_product_enname,
		_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,
		_product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,
		_product_batterystate,_user_code FROM isale_product WHERE product_code = _move_product_code;
		
		#根据货主系统编码查询货主
		SELECT user_name,user_mobilephone INTO _user_name,_user_mobilephone from isale_user WHERE user_code = _user_code;

		#写入task,并更新状态已完成
		SET _task_code = CONCAT('700',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
		SET _task_content = CONCAT(_product_name,'从顶层货位',_space_number_top,'移至普通货位',_space_number_normal);

		INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,product_code,product_name,product_enname,product_barcode
		,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort
		,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_logourl) 
		VALUES
		(_task_code,7,'',_move_count,_task_content,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_task_user_code,_task_user_name,_task_user_logourl
		);
		#默认更新已完成
		UPDATE isale_task SET task_state = 3 WHERE task_code = _task_code;

		#顶层下架spacedetaillog
		INSERT INTO isale_spacedetaillog(space_code,space_halftype,space_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit
		,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_mobilephone,task_code,task_type)
		VALUES(_space_code_top,_space_halftype,_move_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_user_code,_user_name,_user_mobilephone,_task_code,2);
			
		#普通上架spacedetaillog
		INSERT INTO isale_spacedetaillog(space_code,space_halftype,space_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit
		,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_mobilephone,task_code,task_type)
		VALUES(_space_code_top,_space_halftype,_move_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit
		,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort
		,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_user_code,_user_name,_user_mobilephone,_task_code,1);
		

		#更新spacedetail顶层货品存放量 如果高层货位存放数量和移库数量一致,则删除该条记录,否则更新
		SELECT space_count INTO _space_count FROM isale_spacedetail WHERE space_code = _space_code_top AND product_code = _product_code;
		IF (_move_count+0) = (_space_count+0) THEN
				DELETE FROM isale_spacedetail WHERE space_code = _space_code_top AND product_code = _product_code;
		ELSE
				UPDATE isale_spacedetail SET space_count = space_count - _move_count WHERE space_code = _space_code_top AND product_code = _product_code;
		END IF;
		
		#更新移入普通对应货品存放量,需要判断该货位上是否已经存在
		SELECT count(1) INTO _count FROM isale_spacedetail WHERE space_code = _space_code_normal AND product_code = _product_code;
		IF (_count+0) = 0 THEN
			INSERT INTO isale_spacedetail(space_code,space_halftype,space_count,space_excount,product_code,product_name,product_enname,product_barcode,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort
			,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate)
			VALUES(
				_space_code_normal,_space_halftype,_move_count,0,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,
				_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate
			);
		ELSE
			UPDATE isale_spacedetail SET space_count = space_count + _move_count WHERE space_code = _space_code_normal AND product_code = _product_code;
		END IF;

	

		#移库货品总体积
		SET _product_totalbulk = _product_bulk * _move_count;
		#SELECT CONCAT('_product_totalbulk：',_product_totalbulk);
		#更新space高层货位使用、未用提交
		#SELECT space_leftbulk INTO _space_leftbulk FROM isale_space WHERE space_code = _space_code_top;
		#IF (_space_leftbulk+0) > (_product_totalbulk+0) THEN
				#考虑到移库货品体积远远大于货位体积,将其移库完毕,也有可能使用体积为负,但是还有其余小货品存放
		#所以咋不考虑更新货位一系列值
		#END IF;
		#更新顶层已用减少,剩余增多
		UPDATE isale_space SET space_usedbulk = space_usedbulk - _product_totalbulk,space_leftbulk = space_leftbulk + _product_totalbulk  WHERE space_code = _space_code_top;
		#更新普通已用增多,剩余减少
		UPDATE isale_space SET space_usedbulk = space_usedbulk + _product_totalbulk,space_leftbulk = space_leftbulk - _product_totalbulk,space_usestate = 2 WHERE space_code = _space_code_normal;
	
		#解锁货位
		UPDATE isale_space SET space_lockstate = 1 WHERE space_code = _space_code_top;
		UPDATE isale_space SET space_lockstate = 1 WHERE space_code = _space_code_normal;

		SET result = 1;
		#设置返回值
		SELECT result;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_outorder_a
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_outorder_a`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `proc_outorder_a`(wave_code varchar(500),wave_user_code varchar(500),wave_user_name varchar(500),search_type int,search_content varchar(500),space_halftype int,out result int)
BEGIN
	 #根据search_type调用
	 DECLARE _sql VARCHAR(500);									#动态sql
	 DECLARE outorder_serial varchar(500);      #波次分析订单最大序列号

	 #创建临时表保存货位与货品的取模值  if not EXISTS不存在则创建
	 CREATE TEMPORARY TABLE IF NOT EXISTS isale_waveoutorder_tmp 
	 ( 
			outorder_serial VARCHAR(500),outorder_code VARCHAR(500),outorder_count INT
	 );
	 #查询波次分析订单最大序列号
	 SELECT max(t.outorder_serial+"0") INTO outorder_serial FROM isale_outorder t;		#一定需要加0

	 #执行动态sql结果集写入临时表
   IF search_type = 1 THEN
		 set _sql = CONCAT('insert into isale_waveoutorder_tmp SELECT outorder_serial,outorder_code,outorder_count FROM isale_outorder WHERE wave_code is null and CONVERT(outorder_serial,SIGNED)<=CONVERT(',outorder_serial,',SIGNED) AND outorder_code in (',search_content,')');   -- 拼接查询sql语句
	 ELSEIF search_type = 2 THEN
		 set _sql = CONCAT('insert into isale_waveoutorder_tmp SELECT outorder_serial,outorder_code,outorder_count FROM isale_outorder WHERE  wave_code is null and CONVERT(outorder_serial,SIGNED)<=CONVERT(',outorder_serial,',SIGNED) AND outorder_code not in (',search_content,')');   -- 拼接查询sql语句
   ELSE
			set _sql = CONCAT('insert into isale_waveoutorder_tmp SELECT outorder_serial,outorder_code,outorder_count FROM isale_outorder WHERE wave_code is null and CONVERT(outorder_serial,SIGNED)<=CONVERT(',outorder_serial,',SIGNED)');   -- 拼接查询sql语句
	 END IF;

	 #select CONCAT('_sql：',_sql);
	 set @_sql = _sql;
   PREPARE stmt FROM @_sql;
   EXECUTE stmt;
   deallocate prepare stmt;
	 
   #select * from isale_waveoutorder_tmp;
	 #SELECT 'outorder_serial'+outorder_serial;
	 IF search_type = 1 THEN
			#SELECT '执行select in';
      call proc_outorder_a_1(wave_code,wave_user_code,wave_user_name,outorder_serial,search_type,search_content,space_halftype);
	 ELSEIF search_type = 2 THEN
			#SELECT '执行select not in';
		  call proc_outorder_a_2(wave_code,wave_user_code,wave_user_name,outorder_serial,search_type,search_content,space_halftype);
   ELSE
			#SELECT '执行select all';
      call proc_outorder_a_3(wave_code,wave_user_code,wave_user_name,outorder_serial,search_type,search_content,space_halftype);
	 END IF;
	
		#删除临时表
		drop table isale_waveoutorder_tmp;
		#调用波次分析
		call proc_outorder_bcfx(wave_code,space_halftype,result);
		#波次分析结束后,将该批波次的订单选择包装台
		
		#设置返回值
		SET result = 1;
		select result;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_outorder_a_1
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_outorder_a_1`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `proc_outorder_a_1`(wave_code varchar(500),wave_user_code varchar(500),wave_user_name varchar(500),outorder_seq varchar(500),search_type int,search_content varchar(500),wave_halftype int)
BEGIN
	
  DECLARE _outorder_code VARCHAR(500);						#出库主单编码
  DECLARE _outorder_count VARCHAR(500);						#子订单数量
  DECLARE done, error BOOLEAN DEFAULT FALSE;			#遍历数据结束标志

  #根据波次系统编码查询主订单下只有一个子订单 根据货品编码分组 找到批间数量
	DECLARE list CURSOR FOR  
	(
		#select search_content;
		#select * from isale_waveoutorder_tmp;
		#SELECT outorder_code,outorder_count FROM isale_outorder WHERE CONVERT(outorder_serial,SIGNED)<=CONVERT(outorder_serial,SIGNED) AND outorder_serial in (search_content)
		select outorder_code,outorder_count from isale_waveoutorder_tmp
	);
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
	
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _outorder_code,_outorder_count;
	IF done THEN
			#select 'no data';
      #select search_content;
      #select CONCAT('SELECT outorder_code,outorder_count FROM isale_outorder WHERE CONVERT(outorder_serial,SIGNED)<=CONVERT(',outorder_serial,'SIGNED) AND outorder_serial in (',search_content,')');
      LEAVE read_loop;
    END IF;
			#执行业务逻辑
			#SELECT CONCAT('_outorder_code>>',_outorder_code,'_outorder_count>>',_outorder_count);
			#select CONCAT('SELECT outorder_code,outorder_count FROM isale_outorder WHERE CONVERT(outorder_serial,SIGNED)<=CONVERT(',outorder_serial,'SIGNED) AND outorder_serial in (replace(',search_content,''-',',')');
			#select search_content;
      IF _outorder_count = 1 THEN
					#SELECT '批间';
					INSERT INTO isale_waveoutorder (outorder_code,wave_code,wave_type)
					VALUES(_outorder_code,wave_code,1);   #批间
      ELSE
					#SELECT '非批间';
					INSERT INTO isale_waveoutorder (outorder_code,wave_code,wave_type)
				  VALUES(_outorder_code,wave_code,2);   #非批间
      END IF;
		END LOOP;
			
	  /*关闭光标*/ 
		CLOSE list; 
		
	 #新增isale_wave
	 INSERT INTO isale_wave(wave_code,wave_name,wave_halftype) VALUES
	 (wave_code,CONCAT(wave_user_name,'在',SYSDATE(),'进行波次分析'),wave_halftype);
	 #更新已经加入波次的订单
	 UPDATE isale_outorder SET wave_code=wave_code,wave_user_code=wave_user_code WHERE outorder_code in(select outorder_code from isale_waveoutorder_tmp);

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_outorder_a_2
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_outorder_a_2`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `proc_outorder_a_2`(wave_code varchar(500),wave_user_code varchar(500),wave_user_name varchar(500),outorder_seq varchar(500),search_type int,search_content varchar(500),wave_halftype int)
BEGIN
  DECLARE _outorder_code VARCHAR(500);						#出库主单编码
  DECLARE _outorder_count VARCHAR(500);						#子订单数量
  DECLARE done, error BOOLEAN DEFAULT FALSE;			#遍历数据结束标志
  #根据波次系统编码查询主订单下只有一个子订单 根据货品编码分组 找到批间数量
	DECLARE list CURSOR FOR  
	(	
		select outorder_code,outorder_count from isale_waveoutorder_tmp
	);
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
	
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _outorder_code,_outorder_count;
	IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
			#执行业务逻辑
      IF _outorder_count = 1 THEN					
					INSERT INTO isale_waveoutorder (outorder_code,wave_code,wave_type)
					VALUES(_outorder_code,wave_code,1);   #批间
      ELSE
					INSERT INTO isale_waveoutorder (outorder_code,wave_code,wave_type)
				  VALUES(_outorder_code,wave_code,2);   #非批间
      END IF;
		END LOOP;
			
	  /*关闭光标*/ 
		CLOSE list; 
		
	 #新增isale_wave
	 INSERT INTO isale_wave(wave_code,wave_name,wave_halftype) VALUES
	 (wave_code,CONCAT(wave_user_name,'在',SYSDATE(),'进行波次分析'),wave_halftype);
	 #更新已经加入波次的订单
	 UPDATE isale_outorder SET wave_code=wave_code,wave_user_code=wave_user_code WHERE outorder_code in(select outorder_code from isale_waveoutorder_tmp);
	
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_outorder_a_3
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_outorder_a_3`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `proc_outorder_a_3`(wave_code varchar(500),wave_user_code varchar(500),wave_user_name varchar(500),outorder_seq varchar(500),search_type int,search_content varchar(500),wave_halftype int)
BEGIN
  DECLARE _outorder_code VARCHAR(500);						#出库主单编码
  DECLARE _outorder_count VARCHAR(500);						#子订单数量
  DECLARE done, error BOOLEAN DEFAULT FALSE;			#遍历数据结束标志
  #根据波次系统编码查询主订单下只有一个子订单 根据货品编码分组 找到批间数量
	DECLARE list CURSOR FOR  
	(	
		select outorder_code,outorder_count from isale_waveoutorder_tmp
	);
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
	
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _outorder_code,_outorder_count;
	IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
			#执行业务逻辑
			#SELECT CONCAT('_outorder_code：',_outorder_code);
      IF _outorder_count = 1 THEN
					INSERT INTO isale_waveoutorder (outorder_code,wave_code,wave_type)
					VALUES(_outorder_code,wave_code,1);   #批间
      ELSE
					INSERT INTO isale_waveoutorder (outorder_code,wave_code,wave_type)
				  VALUES(_outorder_code,wave_code,2);   #非批间

      END IF;
				
			
		END LOOP;
			
	  /*关闭光标*/ 
		CLOSE list; 
		
	 #新增isale_wave
	 INSERT INTO isale_wave(wave_code,wave_name,wave_halftype) VALUES
	 (wave_code,CONCAT(wave_user_name,'在',SYSDATE(),'进行波次分析'),wave_halftype);
		
	 #更新已经加入波次的订单
	 UPDATE isale_outorder SET wave_code=wave_code,wave_user_code=wave_user_code WHERE outorder_code in(select outorder_code from isale_waveoutorder_tmp);

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_outorder_bcfx
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_outorder_bcfx`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `proc_outorder_bcfx`(_wave_code varchar(500),_space_halftype int,out result int)
BEGIN
		#更新波次主表状态分析中
    UPDATE isale_wave SET wave_operstate = 2 WHERE wave_code = _wave_code;
		#1:调用批间存储
		CALL proc_outorder_pj(_wave_code,_space_halftype);
		#2:调用非批间存储
	  CALL proc_outorder_fpj(_wave_code,_space_halftype);
		#3：批间/非批间处理完成后,更新波次主表状态已分析，待分配
    UPDATE isale_wave SET wave_operstate = 3 WHERE wave_code = _wave_code;
		#设置返回值
		#SET result = 1;
		#select result;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_outorder_fpj
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_outorder_fpj`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `proc_outorder_fpj`(_wave_code varchar(500),_space_halftype int)
BEGIN
		DECLARE _outorder_code VARCHAR(500);					 #出库主单编码
	  DECLARE _outorder_count  INT;									 #非批间出库单对应子单总数
		DECLARE _wavedetail_code VARCHAR(500);				 #波次明细编码
	  DECLARE done, error BOOLEAN DEFAULT FALSE;		 #遍历数据结束标志

	 #根据波次系统编码查询主订单下不止一个子订单
	 DECLARE list CURSOR FOR  
	 (
			select oo.outorder_code,oo.outorder_count from  isale_outorder oo
			where oo.outorder_count != 1 and oo.wave_code = _wave_code
			order by oo.addtime#oo.outorder_code
	  );
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
		
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _outorder_code,_outorder_count;
	IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
			#-----------------执行业务逻辑
			SET _wavedetail_code = CONCAT('601',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
			#SELECT CONCAT('非批间wavedetail_code:',_wavedetail_code);
      #新增波次明细
			INSERT INTO isale_wavedetail (wavedetail_code,wave_code,wave_type,wave_count,outorder_code)
			VALUES(_wavedetail_code,_wave_code,2,_outorder_count,_outorder_code);
			#更新波次订单中间表
			UPDATE isale_waveoutorder SET wavedetail_code=_wavedetail_code WHERE wave_code = _wave_code AND outorder_code = _outorder_code;
			
			#根据outorder_code查询子单list,大于库存数进行踢单
			CALL proc_outorder_fpj_a(_wavedetail_code,_outorder_code,_space_halftype);

		END LOOP;
			
	  /*关闭光标*/ 
		CLOSE list; 	
	
		#踢单以后根据wave_code,wave_type=2查询剩余的波次明细
		CALL proc_outorder_fpj_b(_wave_code,_space_halftype);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_outorder_fpj_a
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_outorder_fpj_a`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `proc_outorder_fpj_a`(_wavedetail_code varchar(500),_outorder_code varchar(500),_space_halftype int)
BEGIN
		DECLARE _product_code	VARCHAR(500);   			   #货品系统编码
    DECLARE _product_count VARCHAR(500);					 #出库子单货品出库数量
		DECLARE _storage_count  VARCHAR(500);					 #库存总数
		DECLARE _wavedetail_count VARCHAR(500);				 #货品在波次分析中已经出库的数量
	  DECLARE done, error BOOLEAN DEFAULT FALSE;		 #遍历数据结束标志

	 #根据出库主单编码查询对应子单
	 DECLARE list CURSOR FOR  
	 (
		 SELECT ood.product_code,ood.product_count FROM isale_outorderdetail ood WHERE ood.outorder_code = _outorder_code 
	 );
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
		
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _product_code,_product_count;
	IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
			#-----------------执行业务逻辑
			
			#根据product_code,storage_halftyp,成品查询普通、顶层货位库存数
			SELECT (sum(sd.space_count+0)-sum(sd.space_excount+0)) into _storage_count FROM isale_spacedetail sd
			INNER JOIN isale_space s on s.space_code = sd.space_code
			WHERE sd.product_code = _product_code and s.space_halftype = _space_halftype
			AND s.space_type <= 2; #s.space_type != 3 and s.space_type != 4 ;

			#查询已经被批间拿走的库存中数量?
			#SELECT IFNULL(sum(wds.wavedetail_count),0) INTO _wavedetail_count FROM isale_wavedetailspace wds GROUP BY wds.product_code = _product_code;
			#IF _wavedetail_count IS NULL THEN
			#	SET _wavedetail_count = 0;
			#END IF;
			
			#SELECT CONCAT('_product_code：',_product_code);
			#SELECT CONCAT(' _wavedetail_count：',_wavedetail_count);
			SET _product_count = _product_count + 0;
			SET _storage_count = _storage_count + 0;
			#SET _wavedetail_count = _wavedetail_count + 0;
			#SET _storage_count = _storage_count - _wavedetail_count;  #实际货品在普通、顶层货位的存放数量=货品在普通、顶层货位的存放数量-波次明细货位中间表对应货品数量
			#如果主单中任意一个子单货品在库存中不满足,则剔除该子单
			IF (_product_count+0) > (_storage_count+0) THEN
				#SELECT CONCAT('非批间踢单：',_outorder_code,' product_count：',_product_count,' storage_count：',_storage_count);
				#不满足波次分析的出库单需要重置波次内容,更新优先级,跳槽循环
				UPDATE isale_outorder SET wave_code = null,wave_user_code = null,outorder_level=3 WHERE outorder_code = _outorder_code;
				#删除波次订单中间表
        DELETE FROM isale_waveoutorder WHERE wavedetail_code = _wavedetail_code AND outorder_code = _outorder_code;
				#删除波次明细
				DELETE FROM isale_wavedetail where wavedetail_code = _wavedetail_code AND outorder_code = _outorder_code;
				LEAVE read_loop;
			END IF;

		END LOOP;
			
	  /*关闭光标*/ 
		CLOSE list; 

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_outorder_fpj_b
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_outorder_fpj_b`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `proc_outorder_fpj_b`(_wave_code varchar(500),_space_halftype int)
BEGIN
		DECLARE _wavedetail_code VARCHAR(500);         #波次明细编码
	  DECLARE done, error BOOLEAN DEFAULT FALSE;		 #遍历数据结束标志

	 #根据波次系统编码查询已经踢过单以后的波次明细
	 DECLARE list CURSOR FOR  
	 (
			select wavedetail_code from isale_wavedetail where wave_code = _wave_code and wave_type = 2
	  );
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
		
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _wavedetail_code;
	IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
			#-----------------执行业务逻辑
			#SELECT CONCAT('_wavedetail_code',_wavedetail_code);
		  #根据product_code查询对应
			call proc_outorder_fpj_c(_wave_code,_wavedetail_code,_space_halftype);		
	
		END LOOP;
			
	  /*关闭光标*/ 
		CLOSE list; 

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_outorder_fpj_c
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_outorder_fpj_c`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `proc_outorder_fpj_c`(_wave_code varchar(500),_wavedetail_code varchar(500),_space_halftype int)
BEGIN
		DECLARE _outorder_code VARCHAR(500);					 #出库主单编码
    DECLARE _outorderdetail_code VARCHAR(500);		 #出库子单编码
		DECLARE _product_code	VARCHAR(500);   			   #货品系统编码
		DECLARE _product_name	varchar(500); 					 #货品名称
		DECLARE _product_enname	varchar(500);          #货品英文名称
		DECLARE _product_barcode	varchar(500);        #货品条码
		DECLARE _product_sku	varchar(500);            #货品SKU编号同步第三方平台
		DECLARE _product_unit	varchar(500);            #货品单位
		DECLARE _product_weight	varchar(500);          #货品重量
		DECLARE _product_length	varchar(500);          #货品长度(单位:mm)
		DECLARE _product_width	varchar(500);          #货品宽度(单位:mm)
		DECLARE _product_heigth	varchar(500);          #货品高度(单位:mm)
		DECLARE _product_length_sort	varchar(500);    #货品排序后长边(单位:mm)
		DECLARE _product_width_sort	varchar(500);      #货品排序后中边(单位:mm)
		DECLARE _product_heigth_sort	varchar(500);		 #货品排序后短边(单位:mm)
		DECLARE _product_bulk	varchar(500);            #货品体积
		DECLARE _product_imgurl	varchar(500);          #货品图片
		DECLARE _product_state	INT;									 #货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)
		DECLARE _product_groupstate INT;               #货品组合状态(1：未组合、2：组合)
		DECLARE _product_batterystate INT;						 #货品是否带电池(1：是、2：否)
    DECLARE _product_count VARCHAR(500);					 #出库子单货品出库数量
		DECLARE _storage_count  VARCHAR(500);					 #库存总数
		DECLARE _flag int;														 #根据wave_code,outorder_code判断波次明细是否写入
	  DECLARE done, error BOOLEAN DEFAULT FALSE;		 #遍历数据结束标志

	 #根据波次系统编码查询主订单下多个子订单
	 DECLARE list CURSOR FOR  
	 (
			select ood.outorder_code,ood.outorderdetail_code,ood.product_count,ood.product_code,ood.product_name,ood.product_enname,
			ood.product_barcode,ood.product_sku,ood.product_unit,ood.product_weight,ood.product_length,
			ood.product_width,ood.product_heigth,ood.product_length_sort,ood.product_width_sort,ood.product_heigth_sort,
			ood.product_bulk,ood.product_imgurl,ood.product_state,ood.product_groupstate,ood.product_batterystate
			from isale_outorderdetail ood
			inner join isale_outorder oo on ood.outorder_code = oo.outorder_code
			inner join isale_wavedetail wd on wd.outorder_code = oo.outorder_code
			where oo.outorder_count != 1 and oo.wave_code = _wave_code and wd.wavedetail_code = _wavedetail_code
		  order by oo.outorder_level desc,oo.outorder_sendtime,oo.outorder_downtime,oo.addtime
	  );
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
		
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _outorder_code,_outorderdetail_code,_product_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,
			 _product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,
			 _product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,
			 _product_batterystate;
	IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
			#-----------------执行业务逻辑
			#SELECT CONCAT('_outorderdetail_code：',_outorderdetail_code);
		  #根据product_code查询对应
			call proc_outorder_fpj_d(_wave_code,_wavedetail_code,_product_code,_product_name,_product_enname
					,_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width
				  ,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort,_product_bulk
					,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_product_count,_space_halftype);		
	
		END LOOP;
			
	  /*关闭光标*/ 
		CLOSE list; 

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_outorder_fpj_d
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_outorder_fpj_d`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `proc_outorder_fpj_d`(_wave_code varchar(500),_wavedetail_code varchar(500),_product_code varchar(500),_product_name varchar(500),_product_enname varchar(500),_product_barcode varchar(500),_product_sku varchar(500),_product_unit varchar(500),_product_weight varchar(500),_product_length varchar(500),_product_width varchar(500),_product_heigth varchar(500),_product_length_sort varchar(500),_product_width_sort varchar(500),_product_heigth_sort varchar(500),_product_bulk varchar(500),_product_imgurl varchar(500),_product_state int,_product_groupstate int,_product_batterystate int,_product_count varchar(500),_space_halftype int)
BEGIN
  DECLARE _space_count VARCHAR(500);						 #货位存放数量
  DECLARE _space_code VARCHAR(500);						   #货位编码
  DECLARE _space_linenumber VARCHAR(500);				 #货位动线号
	DECLARE _space_number VARCHAR(500);            #货位编号
  DECLARE _wavedetailspace_code VARCHAR(500);    #波次明细货位编码
  DECLARE done, error BOOLEAN DEFAULT FALSE;		 #遍历数据结束标志
		
   #根据货品编码查询对应货位存放情况
	 DECLARE list CURSOR FOR  
	 (
			SELECT (sum(sd.space_count)-sum(sd.space_excount)) space_count,s.space_code,s.space_linenumber,s.space_number FROM isale_spacedetail sd
			INNER JOIN isale_space s ON s.space_code = sd.space_code
			WHERE sd.product_code = _product_code AND s.space_halftype = _space_halftype AND s.space_type <= 2
			GROUP BY s.space_code HAVING (sum(sd.space_count)-sum(sd.space_excount)) != 0
			ORDER BY s.space_linenumber ASC
	 );
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
		
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _space_count,_space_code,_space_linenumber,_space_number;
	IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
			#-------------执行业务逻辑
			#select _space_number;
			#select _space_count;

			SET _wavedetailspace_code = CONCAT('602',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));
			SET _product_count = _product_count + 0;
			#SELECT CONCAT('_space_count：',_space_code,'_space_count：',_space_count,'_product_name：',_product_name,' _product_count：',_product_count);
			#当前货位货品数量已经满足出库单
			#SELECT CONCAT('_space_count >= _product_count：',_space_count >= _product_count);
      IF (_space_count+0) >= (_product_count+0) THEN 
					#SELECT '1';

					INSERT INTO isale_wavedetailspace 
					(wavedetailspace_code,wavedetail_code,wave_code,wavedetail_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,space_code,space_number,space_linenumber)
					VALUES
          (_wavedetailspace_code,_wavedetail_code,_wave_code,_product_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_space_code,_space_number,_space_linenumber);  
					
					#更新货位明细表预扣字段
					UPDATE isale_spacedetail SET space_excount = space_excount+_product_count WHERE space_code = _space_code AND product_code = _product_code;

					LEAVE read_loop;
      ELSE
					#SELECT '2';
					INSERT INTO isale_wavedetailspace 
					(wavedetailspace_code,wavedetail_code,wave_code,wavedetail_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,space_code,space_number,space_linenumber)
					VALUES
          (_wavedetailspace_code,_wavedetail_code,_wave_code,_space_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_space_code,_space_number,_space_linenumber);
         
					#更新货位明细表预扣字段
					UPDATE isale_spacedetail SET space_excount = space_excount+_space_count WHERE space_code = _space_code AND product_code = _product_code;

					#记录一个后,减少对应数量
					SET _product_count = _product_count-(_space_count+0);
			END IF;
			
		END LOOP;
			
	  /*关闭光标*/ 
		CLOSE list; 
  

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_outorder_pick
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_outorder_pick`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_outorder_pick`(_wave_code varchar(500),_pager_offset int,user_codes longtext,out result int)
BEGIN
		DECLARE _sql VARCHAR(500);	
		
		#创建临时表保存页面传入用户  if not EXISTS不存在则创建
		CREATE TEMPORARY TABLE IF NOT EXISTS isale_user_tmp
		( 
			user_code VARCHAR(500),user_name VARCHAR(500),user_logourl VARCHAR(500)
		);

		#创建临时表保存用户的任务量  if not EXISTS不存在则创建
		CREATE TEMPORARY TABLE IF NOT EXISTS isale_task_user_tmp 
		( 
			user_code VARCHAR(500),user_name VARCHAR(500),user_logourl VARCHAR(500),task_count INT
		);
		
		
		SET _sql = CONCAT('INSERT INTO isale_user_tmp SELECT u.user_code,u.user_name,u.user_logourl FROM isale_user u WHERE u.user_code in (',user_codes,')');   -- 拼接查询sql语句
		SET @_sql = _sql;
		PREPARE stmt FROM @_sql;
		EXECUTE stmt;
		deallocate prepare stmt;
		
		#SELECT * FROM isale_user_tmp;
		
		#SELECT CONCAT('wave_code：',_wave_code);
		#根据波次分配状态  分配中
		UPDATE isale_wave SET wave_taskstate = 2 WHERE wave_code = _wave_code;
		#批间按照sku种类,进行出库人员分配
	  CALL proc_outorder_pick_pj_1(_wave_code,_pager_offset);
		#非批间按照订单个数,传入波次分析编码、订单分配量
		CALL proc_outorder_pick_fpj_1(_wave_code,_pager_offset);
		#根据波次分配状态  分配完成
		UPDATE isale_wave SET wave_taskstate = 3 WHERE wave_code = _wave_code;
		#批间/非批间处理完成后,更新波次主表状态分配完成
		UPDATE isale_wave SET wave_operstate = 4 WHERE wave_code = _wave_code;
		#删除临时表
		DROP TABLE isale_user_tmp;
		DROP TABLE isale_task_user_tmp;
		#根据wave_code更新所有子单状态
		UPDATE isale_outorderdetail SET outorderdetail_state = 2 WHERE outorder_code in (SELECT outorder_code FROM isale_outorder WHERE wave_code = _wave_code);
		#设置返回值
		SET result = 1;
		SELECT result;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_outorder_pick_fpj_1
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_outorder_pick_fpj_1`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_outorder_pick_fpj_1`(_wave_code varchar(500),_pager_offset int)
BEGIN
  DECLARE _user_code VARCHAR(500);						#工作人员编码
  DECLARE _user_name VARCHAR(500);						#工作人员名称
	DECLARE _user_logourl VARCHAR(500);					#工作人员头像
	DECLARE _task_count INT;										#工作人员当前任务量
  DECLARE done, error BOOLEAN DEFAULT FALSE;			#遍历数据结束标志
	

  #查询页面传入的工作人员
	DECLARE list CURSOR FOR  
	(	
		SELECT u.user_code,u.user_name,u.user_logourl FROM isale_user_tmp u
	);
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
	
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _user_code,_user_name,_user_logourl;
	IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
			#--------------------执行业务逻辑
      #SELECT CONCAT('user_code：',_user_code);
		  #根据用户编码查询当下任务数量,写入临时表,如果无任务则写0
			SELECT count(1) INTO _task_count FROM isale_task WHERE user_code = _user_code AND task_state != 3;
			#写入临时表
			INSERT INTO isale_task_user_tmp VALUES(_user_code,_user_name,_user_logourl,_task_count);
		END LOOP;	
	  /*关闭光标*/ 
		CLOSE list; 
		
		#SELECT * FROM isale_task_user_tmp ORDER BY task_count ASC;

		CALL proc_outorder_pick_fpj_2(_wave_code,_pager_offset);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_outorder_pick_fpj_2
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_outorder_pick_fpj_2`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_outorder_pick_fpj_2`(_wave_code varchar(500),_pager_offset int)
BEGIN
	DECLARE _outorder_count_left INT;               #当前波次中剩余还未分配的订单
	DECLARE _i INT DEFAULT 1;
	
	WHILE 0<(_i+0) DO
		SELECT count(1) INTO _outorder_count_left FROM isale_outorder WHERE wave_code = _wave_code AND outorder_count != 1 AND task_user_code IS NULL;
		#SELECT CONCAT('_outorder_count_left：',_outorder_count_left);
		IF (_outorder_count_left+0) > 0 THEN
			#SELECT '递归';
			#SELECT CONCAT('_i-start：',_i);
			CALL proc_outorder_pick_fpj_3(_wave_code,_pager_offset);
		END IF;	 
		SELECT count(1) INTO _i FROM isale_outorder WHERE wave_code = _wave_code AND outorder_count != 1 AND task_user_code IS NULL;
		#SELECT CONCAT('_i-end：',_i);
	END WHILE;
	
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_outorder_pick_fpj_3
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_outorder_pick_fpj_3`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_outorder_pick_fpj_3`(_wave_code varchar(500),_pager_offset int)
BEGIN
  DECLARE _outorder_code VARCHAR(500);						#主订单编码
	DECLARE _user_code VARCHAR(500);								#工作人员编码
  DECLARE _user_name VARCHAR(500);								#工作人员名称
	DECLARE _user_logourl VARCHAR(500);							#工作人员头像
	DECLARE _task_count INT;
	DECLARE _outorder_count_left INT;               #当前波次中剩余还未分配的订单
  DECLARE done, error BOOLEAN DEFAULT FALSE;			#遍历数据结束标志


  #查询工作人员并且状态启用、当前为上班状态的当前任务量升序排序
	DECLARE list CURSOR FOR  
	(	
		SELECT outorder_code FROM isale_outorder WHERE wave_code = _wave_code AND outorder_count != 1 AND task_user_code IS NULL ORDER BY outorder_count DESC LIMIT 0,_pager_offset
		#SELECT outorder_code FROM isale_wave_outorder_user_tmp
	);
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
	
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _outorder_code;
	IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
			#--------------------执行业务逻辑
      #SELECT CONCAT('outorder_code：',_outorder_code);
			#根据任务量查询用户任务临时表,取第一条用户
			#SELECT * FROM isale_task_user_tmp ORDER BY task_count ASC;
			SELECT user_code,user_name,user_logourl,task_count INTO _user_code,_user_name,_user_logourl,_task_count FROM isale_task_user_tmp ORDER BY task_count+0 ASC LIMIT 1;
			#SELECT CONCAT('user_code：',_user_code,' task_count：',_task_count);
			#根据_outorder_code查询该订单对应的波次分析货位明细数据
			CALL proc_outorder_pick_fpj_4(_user_code,_user_name,_user_logourl,_outorder_code);
			
		END LOOP;
	  /*关闭光标*/ 
		CLOSE list; 
		

		
	 #当第一轮人员循环结束后,需要判断是否还有未分配,如果有则递归调用本函数继续分配
	 #SELECT count(1) INTO _outorder_count_left  FROM isale_outorder WHERE wave_code = wave_code AND task_user_code IS NULL;
	 #IF _outorder_count_left+0 > 0 THEN
		#	CALL proc_outorder_pick_1(wave_code,pager_offset);
	# END IF;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_outorder_pick_fpj_4
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_outorder_pick_fpj_4`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_outorder_pick_fpj_4`(_user_code varchar(500),_user_name varchar(500),_user_logourl varchar(500),_outorder_code varchar(500))
BEGIN
	DECLARE _product_code	VARCHAR(500);   			   #货品系统编码
	DECLARE _product_name	varchar(500); 					 #货品名称
	DECLARE _product_enname	varchar(500);          #货品英文名称
	DECLARE _product_barcode	varchar(500);        #货品条码
	DECLARE _product_sku	varchar(500);            #货品SKU编号同步第三方平台
	DECLARE _product_unit	varchar(500);            #货品单位
	DECLARE _product_weight	varchar(500);          #货品重量
	DECLARE _product_length	varchar(500);          #货品长度(单位:mm)
	DECLARE _product_width	varchar(500);          #货品宽度(单位:mm)
	DECLARE _product_heigth	varchar(500);          #货品高度(单位:mm)
	DECLARE _product_length_sort	varchar(500);    #货品排序后长边(单位:mm)
	DECLARE _product_width_sort	varchar(500);      #货品排序后中边(单位:mm)
	DECLARE _product_heigth_sort	varchar(500);		 #货品排序后短边(单位:mm)
	DECLARE _product_bulk	varchar(500);            #货品体积
	DECLARE _product_imgurl	varchar(500);          #货品图片
	DECLARE _product_state	INT;									 #货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)
	DECLARE _product_groupstate INT;               #货品组合状态(1：未组合、2：组合)
	DECLARE _product_batterystate INT;						 #货品是否带电池(1：是、2：否)
	DECLARE _wavedetailspace_code varchar(500);		 #波次明细货位系统编码
	DECLARE _wavedetail_count  INT;								 #波次明细货位拣货数量
	DECLARE _task_code VARCHAR(500);				       #任务系统编码
	DECLARE _sql VARCHAR(500);										 #动态sql
	DECLARE _insert LONGTEXT DEFAULT '';
	DECLARE _content VARCHAR(500);
  DECLARE done, error BOOLEAN DEFAULT FALSE;		 #遍历数据结束标志
	DECLARE _i INT DEFAULT 0;

  #查询工作人员并且状态启用、当前为上班状态的当前任务量升序排序
	DECLARE list CURSOR FOR  
	(	
		SELECT DISTINCT wds.product_code,wds.product_name,wds.product_enname,wds.product_barcode,wds.product_sku,wds.product_unit,wds.product_weight,
		wds.product_length,wds.product_width,wds.product_heigth,wds.product_length_sort,wds.product_width_sort,wds.product_heigth_sort,wds.product_bulk,
		wds.product_imgurl,wds.product_state,wds.product_groupstate,wds.product_batterystate,wds.wavedetailspace_code,wds.wavedetail_count
		FROM isale_wavedetailspace wds 
		INNER JOIN isale_waveoutorder woo ON wds.wavedetail_code = woo.wavedetail_code
		WHERE woo.outorder_code = _outorder_code
	);
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
	
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit,_product_weight,
			_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort,_product_bulk,
			_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_wavedetailspace_code,_wavedetail_count;
	IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
				#SELECT CONCAT('product_name：',_product_name);
				#SET _i = _i + 1;
				#如果task中已经存在,则continue;
				SELECT count(1) INTO _i FROM isale_task t WHERE t.task_othercode = _wavedetailspace_code AND t.task_type = 3;
				IF (_i+0) > 0 THEN
						ITERATE read_loop;
				END IF;
				
				#-------------执行业务逻辑
				SET _task_code = CONCAT('700',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
				
				SET _content = CONCAT('''',_product_name,'出库',_wavedetail_count,'''');
				SET _insert = CONCAT(_insert,
				'(''',_task_code,''',',3,',''',_wavedetailspace_code,''',',_wavedetail_count,',',_content,',''',_product_code,''',''',_product_name,''',''',_product_enname,''',''',_product_barcode
				,''',''',_product_sku,''',''',_product_unit,''',''',_product_weight,''',''',_product_length,''',''',_product_width,''',''',_product_heigth,''',''',_product_length_sort,''',''',_product_width_sort,''',''',_product_heigth_sort
				,''',''',_product_bulk,''',''',_product_imgurl,''',',_product_state,',',_product_groupstate,',',_product_batterystate,',''',_user_code,''',''',_user_name,''',''',_user_logourl,'''),');
			
		END LOOP;
	  /*关闭光标*/ 
		CLOSE list; 

		SET _insert = CONCAT('',left(_insert,char_length(_insert)-1));
		#写入任务表
		SET _insert = CONCAT('INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,product_code,product_name,product_enname,product_barcode
		,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort
		,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_logourl) VALUES',_insert);
		
		#SELECT CONCAT('_insert：',_insert);
		SET @_insert = _insert;
		PREPARE stmt FROM @_insert;
		EXECUTE stmt;
		deallocate prepare stmt;

		#根据当前订单更新对应任务人员
		#SELECT CONCAT('UPDATE isale_outorder SET task_user_code = ''', user_code,''', task_user_name = ''',user_name ,''' WHERE outorder_code = ''',outorder_code,'''');
		#UPDATE isale_outorder SET task_user_code = user_code,task_user_name = user_name WHERE outorder_code = outorder_code;
		SET _sql = CONCAT('UPDATE isale_outorder SET task_user_code = ''', _user_code,''', task_user_name = ''',_user_name ,''' WHERE outorder_code = ''',_outorder_code,''''); 
		#UPDATE isale_task_user_tmp SET task_count = task_count + 1 WHERE user_code = user_code;
		#SELECT CONCAT('_sql：',_sql);
		SET @_sql = _sql;
		PREPARE stmt FROM @_sql;
		EXECUTE stmt;
		deallocate prepare stmt;

		#根据user_code更新用户任务临时表任务量
		#SELECT CONCAT('UPDATE isale_task_user_tmp SET task_count = task_count + 1 WHERE user_code = ',user_code);
		SET _sql = CONCAT('UPDATE isale_task_user_tmp SET task_count = task_count + 1 WHERE user_code = ',_user_code); 
		#UPDATE isale_task_user_tmp SET task_count = task_count + 1 WHERE user_code = user_code;
		#SELECT CONCAT('_sql：',_sql);
		SET @_sql = _sql;
		PREPARE stmt FROM @_sql;
		EXECUTE stmt;
		deallocate prepare stmt;
		
		#SELECT CONCAT('_outorder_code ',_outorder_code,' _i ',_i);
		#COMMIT;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_outorder_pick_pj_1
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_outorder_pick_pj_1`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_outorder_pick_pj_1`(_wave_code varchar(500),_pager_offset int)
BEGIN
  DECLARE _user_code VARCHAR(500);								#工作人员编码
  DECLARE _user_name VARCHAR(500);								#工作人员名称
	DECLARE _user_logourl VARCHAR(500);							#工作人员头像
	DECLARE _task_count INT;												#工作人员当前任务量
  DECLARE done, error BOOLEAN DEFAULT FALSE;			#遍历数据结束标志
	

  #查询页面传入的工作人员
	DECLARE list CURSOR FOR  
	(	
		SELECT u.user_code,u.user_name,u.user_logourl FROM isale_user_tmp u
	);
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
	
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _user_code,_user_name,_user_logourl;
	IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
			#--------------------执行业务逻辑
      #SELECT CONCAT('user_code：',_user_code);
		  #根据用户编码查询当下任务数量,写入临时表,如果无任务则写0
			SELECT count(1) INTO _task_count FROM isale_task WHERE user_code = _user_code AND task_state != 3;
			#写入临时表
			INSERT INTO isale_task_user_tmp VALUES(_user_code,_user_name,_user_logourl,_task_count);
		END LOOP;	
	  /*关闭光标*/ 
		CLOSE list; 
		
		#SELECT * FROM isale_task_user_tmp ORDER BY task_count ASC;

		CALL proc_outorder_pick_pj_2(_wave_code,_pager_offset);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_outorder_pick_pj_2
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_outorder_pick_pj_2`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_outorder_pick_pj_2`(_wave_code varchar(500),_pager_offset int)
BEGIN
	DECLARE _outorder_count_left INT;               #当前波次中剩余还未分配的批间订单
	DECLARE _i INT DEFAULT 1;
	
	WHILE 0<(_i+0) DO
		SELECT count(1) INTO _outorder_count_left FROM isale_outorder WHERE wave_code = _wave_code AND outorder_count = 1 AND task_user_code IS NULL;
		#SELECT CONCAT('_outorder_count_left：',_outorder_count_left);
		IF (_outorder_count_left+0) > 0 THEN
			#SELECT '递归';
			#SELECT CONCAT('_i-start：',_i);
			CALL proc_outorder_pick_pj_3(_wave_code,_pager_offset);
		END IF;	 
		SELECT count(1) INTO _i FROM isale_outorder WHERE wave_code = _wave_code AND outorder_count = 1 AND task_user_code IS NULL;
		#SELECT CONCAT('_i-end：',_i);
	END WHILE;
	
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_outorder_pick_pj_3
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_outorder_pick_pj_3`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_outorder_pick_pj_3`(_wave_code varchar(500),_pager_offset int)
BEGIN
  DECLARE _product_code VARCHAR(500);						  #sku系统编码
	DECLARE _user_code VARCHAR(500);								#工作人员编码
  DECLARE _user_name VARCHAR(500);								#工作人员名称
	DECLARE _user_logourl VARCHAR(500);							#工作人员头像
	DECLARE _task_count INT;
	DECLARE _outorder_count_left INT;               #当前波次中剩余还未分配的订单
  DECLARE done, error BOOLEAN DEFAULT FALSE;			#遍历数据结束标志


  #查询批间出库的sku
	DECLARE list CURSOR FOR  
	(	
		SELECT DISTINCT wds.product_code
		FROM isale_wavedetailspace wds 
		INNER JOIN isale_waveoutorder woo ON wds.wavedetail_code = woo.wavedetail_code
		WHERE woo.wave_code = _wave_code AND woo.wave_type = 1 LIMIT 0,_pager_offset
	);
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
	
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _product_code;
	IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
			#--------------------执行业务逻辑
      #SELECT CONCAT('_product_code',_product_code);
			#根据任务量查询用户任务临时表,取第一条用户
			#SELECT * FROM isale_task_user_tmp ORDER BY task_count ASC;
			SELECT user_code,user_name,user_logourl,task_count INTO _user_code,_user_name,_user_logourl,_task_count FROM isale_task_user_tmp ORDER BY task_count+0 ASC LIMIT 1;
			#SELECT CONCAT('user_code：',_user_code,' task_count：',_task_count);
			#根据_outorder_code查询该订单对应的波次分析货位明细数据
			CALL proc_outorder_pick_pj_4(_wave_code,_user_code,_user_name,_user_logourl,_product_code);
			
		END LOOP;
	  /*关闭光标*/ 
		CLOSE list; 
		

		
	 #当第一轮人员循环结束后,需要判断是否还有未分配,如果有则递归调用本函数继续分配
	 #SELECT count(1) INTO _outorder_count_left  FROM isale_outorder WHERE wave_code = wave_code AND task_user_code IS NULL;
	 #IF _outorder_count_left+0 > 0 THEN
		#	CALL proc_outorder_pick_1(wave_code,pager_offset);
	# END IF;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_outorder_pick_pj_4
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_outorder_pick_pj_4`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_outorder_pick_pj_4`(_wave_code varchar(500),_user_code varchar(500),_user_name varchar(500),_user_logourl varchar(500),_product_code varchar(500))
BEGIN
	DECLARE _product_name	varchar(500); 					 #货品名称
	DECLARE _product_enname	varchar(500);          #货品英文名称
	DECLARE _product_barcode	varchar(500);        #货品条码
	DECLARE _product_sku	varchar(500);            #货品SKU编号同步第三方平台
	DECLARE _product_unit	varchar(500);            #货品单位
	DECLARE _product_weight	varchar(500);          #货品重量
	DECLARE _product_length	varchar(500);          #货品长度(单位:mm)
	DECLARE _product_width	varchar(500);          #货品宽度(单位:mm)
	DECLARE _product_heigth	varchar(500);          #货品高度(单位:mm)
	DECLARE _product_length_sort	varchar(500);    #货品排序后长边(单位:mm)
	DECLARE _product_width_sort	varchar(500);      #货品排序后中边(单位:mm)
	DECLARE _product_heigth_sort	varchar(500);		 #货品排序后短边(单位:mm)
	DECLARE _product_bulk	varchar(500);            #货品体积
	DECLARE _product_imgurl	varchar(500);          #货品图片
	DECLARE _product_state	INT;									 #货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)
	DECLARE _product_groupstate INT;               #货品组合状态(1：未组合、2：组合)
	DECLARE _product_batterystate INT;						 #货品是否带电池(1：是、2：否)
	DECLARE _wavedetailspace_code varchar(500);		 #波次明细货位系统编码
	DECLARE _wavedetail_count  INT;								 #波次明细货位拣货数量
	DECLARE _task_code VARCHAR(500);				       #任务系统编码
	DECLARE _sql VARCHAR(500);										 #动态sql
	DECLARE _insert LONGTEXT DEFAULT '';
	DECLARE _content VARCHAR(500);
  DECLARE done, error BOOLEAN DEFAULT FALSE;		 #遍历数据结束标志
	DECLARE _i INT DEFAULT 0;

  #根据sku编码查询当前批间拣货任务
	DECLARE list CURSOR FOR  
	(	
		SELECT DISTINCT wds.product_name,wds.product_enname,wds.product_barcode,wds.product_sku,wds.product_unit,wds.product_weight,
		wds.product_length,wds.product_width,wds.product_heigth,wds.product_length_sort,wds.product_width_sort,wds.product_heigth_sort,wds.product_bulk,
		wds.product_imgurl,wds.product_state,wds.product_groupstate,wds.product_batterystate,wds.wavedetailspace_code,wds.wavedetail_count
		FROM isale_wavedetailspace wds 
		INNER JOIN isale_waveoutorder woo ON wds.wavedetail_code = woo.wavedetail_code
		WHERE woo.wave_code = _wave_code AND woo.wave_type = 1 AND wds.product_code = _product_code 
	);
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
	
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _product_name,_product_enname,_product_barcode,_product_sku,_product_unit,_product_weight,
			_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort,_product_bulk,
			_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_wavedetailspace_code,_wavedetail_count;
	IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
				#SET _i = _i + 1;
				#如果task中已经存在,则continue;
				SELECT count(1) INTO _i FROM isale_task t WHERE t.task_othercode = _wavedetailspace_code AND t.task_type = 3;
				IF (_i+0) > 0 THEN
						ITERATE read_loop;
				END IF;
				
				#-------------执行业务逻辑
				SET _task_code = CONCAT('700',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
				
				SET _content = CONCAT('''',_product_name,'出库',_wavedetail_count,'''');
				SET _insert = CONCAT(_insert,
				'(''',_task_code,''',',3,',''',_wavedetailspace_code,''',',_wavedetail_count,',',_content,',''',_product_code,''',''',_product_name,''',''',_product_enname,''',''',_product_barcode
				,''',''',_product_sku,''',''',_product_unit,''',''',_product_weight,''',''',_product_length,''',''',_product_width,''',''',_product_heigth,''',''',_product_length_sort,''',''',_product_width_sort,''',''',_product_heigth_sort
				,''',''',_product_bulk,''',''',_product_imgurl,''',',_product_state,',',_product_groupstate,',',_product_batterystate,',''',_user_code,''',''',_user_name,''',''',_user_logourl,'''),');
			
		END LOOP;
	  /*关闭光标*/ 
		CLOSE list; 

		SET _insert = CONCAT('',left(_insert,char_length(_insert)-1));
		#写入任务表
		SET _insert = CONCAT('INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,product_code,product_name,product_enname,product_barcode
		,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort
		,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_logourl) VALUES',_insert);
		
		#SELECT CONCAT('_insert：',_insert);
		SET @_insert = _insert;
		PREPARE stmt FROM @_insert;
		EXECUTE stmt;
		deallocate prepare stmt;

		#SELECT CONCAT('_user_code：',_user_code,'_user_name：',_user_name,'_wave_code：',_wave_code,'_product_code',_product_code);
		#根据当前订单更新对应任务人员
		#SELECT CONCAT('UPDATE isale_outorder SET task_user_code = ''', user_code,''', task_user_name = ''',user_name ,''' WHERE outorder_code = ''',outorder_code,'''');
		#UPDATE isale_outorder SET task_user_code = user_code,task_user_name = user_name WHERE outorder_code = outorder_code;
		SET _sql = CONCAT('UPDATE isale_outorder SET task_user_code = ''',_user_code,''',task_user_name = ''',_user_name,'''WHERE outorder_code IN (SELECT * FROM (SELECT oo.outorder_code FROM isale_outorder oo INNER JOIN isale_outorderdetail ood ON ood.outorder_code = oo.outorder_code WHERE oo.wave_code = ''',_wave_code,''' AND ood.product_code = ''',_product_code,''' AND outorder_count = 1) t)'); 
		
		#UPDATE isale_task_user_tmp SET task_count = task_count + 1 WHERE user_code = user_code;
		#SELECT CONCAT('_sql：',_sql);
		SET @_sql = _sql;
		PREPARE stmt FROM @_sql;
		EXECUTE stmt;
		deallocate prepare stmt;

		#根据user_code更新用户任务临时表任务量
		#SELECT CONCAT('UPDATE isale_task_user_tmp SET task_count = task_count + 1 WHERE user_code = ',user_code);
		SET _sql = CONCAT('UPDATE isale_task_user_tmp SET task_count = task_count + 1 WHERE user_code = ',_user_code); 
		#UPDATE isale_task_user_tmp SET task_count = task_count + 1 WHERE user_code = user_code;
		#SELECT CONCAT('_sql：',_sql);
		SET @_sql = _sql;
		PREPARE stmt FROM @_sql;
		EXECUTE stmt;
		deallocate prepare stmt;
		
		#SELECT CONCAT('_outorder_code ',_outorder_code,' _i ',_i);
		#COMMIT;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_outorder_pj
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_outorder_pj`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `proc_outorder_pj`(_wave_code varchar(500),_space_halftype int)
BEGIN
		DECLARE _product_code	VARCHAR(500);   			   #货品系统编码
		DECLARE _product_name	VARCHAR(500); 					 #货品名称
		DECLARE _product_enname	VARCHAR(500);          #货品英文名称
		DECLARE _product_barcode	VARCHAR(500);        #货品条码
		DECLARE _product_sku	VARCHAR(500);            #货品SKU编号同步第三方平台
		DECLARE _product_unit	VARCHAR(500);            #货品单位
		DECLARE _product_weight	VARCHAR(500);          #货品重量
		DECLARE _product_length	VARCHAR(500);          #货品长度(单位:mm)
		DECLARE _product_width	VARCHAR(500);          #货品宽度(单位:mm)
		DECLARE _product_heigth	VARCHAR(500);          #货品高度(单位:mm)
		DECLARE _product_length_sort	VARCHAR(500);    #货品排序后长边(单位:mm)
		DECLARE _product_width_sort	VARCHAR(500);      #货品排序后中边(单位:mm)
		DECLARE _product_heigth_sort	VARCHAR(500);		 #货品排序后短边(单位:mm)
		DECLARE _product_bulk	VARCHAR(500);            #货品体积
		DECLARE _product_imgurl	VARCHAR(500);          #货品图片
		DECLARE _product_state	INT;									 #货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)
		DECLARE _product_groupstate INT;               #货品组合状态(1：未组合、2：组合)
		DECLARE _product_batterystate INT;						 #货品是否带电池(1：是、2：否)
    DECLARE _total_count VARCHAR(500);						 #根据sku分组后出库总数
		DECLARE _wavedetail_code VARCHAR(500);				 #波次明细编码
		DECLARE _storage_count  VARCHAR(500);					 #库存总数
	  DECLARE done, error BOOLEAN DEFAULT FALSE;		 #遍历数据结束标志

	  #根据波次系统编码查询主订单下只有一个子订单 根据货品编码分组 找到批间货品出库数量
	  DECLARE list CURSOR FOR  
	  (
			select sum(ood.product_count) total_count,ood.product_code,ood.product_name,ood.product_enname,
      ood.product_barcode,ood.product_sku,ood.product_unit,ood.product_weight,ood.product_length,
      ood.product_width,ood.product_heigth,ood.product_length_sort,ood.product_width_sort,ood.product_heigth_sort,
      ood.product_bulk,ood.product_imgurl,ood.product_state,ood.product_groupstate,ood.product_batterystate
			from isale_outorderdetail ood
			inner join isale_outorder oo on ood.outorder_code = oo.outorder_code
			where oo.outorder_count = 1 and oo.wave_code = _wave_code
			GROUP BY ood.product_code
	  );
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
		
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _total_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,
			 _product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,
			 _product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,
			 _product_batterystate;
	IF done THEN
			#SELECT 'no data';
      LEAVE read_loop;
    END IF;
			#---------执行业务逻辑
      #新增波次明细
			SET _wavedetail_code = CONCAT('601',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));
		  #SELECT CONCAT('批间wavedetail_code:',_wavedetail_code);
		  INSERT INTO isale_wavedetail (wavedetail_code,wave_code,wave_type,wave_count,product_code,product_name)
			VALUES(_wavedetail_code,_wave_code,1,_total_count,_product_code,_product_name);
			

			#根据product_code,space_halftype,查询当前普通、顶层货位库存数
      SELECT (sum(sd.space_count+0)-sum(sd.space_excount+0)) into _storage_count FROM isale_spacedetail sd
			INNER JOIN isale_space s on s.space_code = sd.space_code
			WHERE sd.product_code = _product_code and s.space_halftype = _space_halftype
			AND s.space_type != 3;
			
			#SELECT CONCAT('total_count：',_total_count,' storage_count：',_storage_count);

      #如果当前普通，顶层货位对应货品库存>=出库单货品分组后总数量,按照货位动线号↑,始发、中转取货
      SET _storage_count = _storage_count + 0;
      SET _total_count = _total_count + 0;

			#先进行踢单,如果库存不够,则根据出库单优先级进行出库,未能出库的需要将wave内容设置为null,并且更改此优先级3,以便下次提前筛选
			call proc_outorder_pj_a(_wave_code,_product_code,_space_halftype,_storage_count,_wavedetail_code);

			IF (_storage_count+0) >= (_total_count+0) THEN
					#SELECT '批间满足';
					call proc_outorder_pj_b(_wave_code,_wavedetail_code,_product_code,_product_name,_product_enname
					,_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width
				  ,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort,_product_bulk
					,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_total_count,_space_halftype);
			ELSE 
				  #SELECT '批间不满足';
					
					#剔除不满足条件的出库单以后,获取当前批间出库单货品总数
					select sum(ood.product_count) INTO _total_count from isale_wavedetail WHERE wavedetail_code=_wavedetail_code;
					SET _total_count = _total_count + 0;

          call proc_outorder_pj_b(_wave_code,_wavedetail_code,_product_code,_product_name,_product_enname
					,_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width
				  ,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort,_product_bulk
					,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_total_count,_space_halftype);
			END IF;
					
		END LOOP;
		
	  /*关闭光标*/ 
		CLOSE list; 

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_outorder_pj_a
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_outorder_pj_a`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `proc_outorder_pj_a`(_wave_code varchar(500),_product_code varchar(500),_space_halftype int,storage_count int,_wavedetail_code varchar(500))
BEGIN
  DECLARE _outorder_code VARCHAR(500);					 #出库单系统编码
  DECLARE _product_count VARCHAR(500);					 #出库货品数量
	DECLARE _update_count INT DEFAULT 0;					 #踢单的出库货品数量
  DECLARE done, error BOOLEAN DEFAULT FALSE;		 #遍历数据结束标志
		
   #根据波次编码,订单优先级等因素排序
	 DECLARE list CURSOR FOR  
	 (
			SELECT ood.outorder_code,ood.product_count from isale_outorderdetail ood 
			inner join isale_outorder oo on oo.outorder_code = ood.outorder_code
			where oo.outorder_count = 1 and oo.wave_code = _wave_code and ood.product_code = _product_code
			order by oo.outorder_level desc,oo.outorder_sendtime,oo.outorder_downtime,oo.addtime
	 );
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
		
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _outorder_code,_product_count;
	IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
			#---------执行业务逻辑
		
			SET _product_count = _product_count + 0;  
      #出库货品库存总数大于等于某一单出库,该出库单满足
			IF storage_count >= _product_count THEN
				#SELECT CONCAT('批间不踢单：',_outorder_code);
				SET	storage_count = storage_count - _product_count;
				#SELECT '剩余storage_count：'+ storage_count;
        #更新波次明细isale_waveoutorder
				#SELECT CONCAT('wave_code：',wave_code,' outorder_code：',_outorder_code);
				UPDATE isale_waveoutorder SET wavedetail_code = _wavedetail_code,wave_type = 1 WHERE wave_code = _wave_code and outorder_code=_outorder_code;
			ELSE
				#SELECT CONCAT('批间踢单：',_outorder_code);
        #SELECT CONCAT('product_count>>',_product_count);
				SET _update_count = _update_count + _product_count;
				#不满足波次分析的出库单需要重置波次内容,更新优先级
				UPDATE isale_outorder SET wave_code = null,wave_user_code = null,outorder_level=3 WHERE outorder_code=_outorder_code;
				#删除波次订单中间表
        DELETE FROM isale_waveoutorder WHERE wave_code = _wave_code AND outorder_code = _outorder_code AND wave_type=1;
				#删除波次明细表
				DELETE FROM isale_wavedetail WHERE wavedetail_code = _wavedetail_code AND wave_type = 1;
		END IF;
		
		END LOOP;
			
	  /*关闭光标*/ 
		CLOSE list; 
		#SELECT CONCAT('update_count',_update_count);
		UPDATE isale_wavedetail SET wave_count = (wave_count+0) - _update_count WHERE wavedetail_code = _wavedetail_code;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_outorder_pj_b
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_outorder_pj_b`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `proc_outorder_pj_b`(_wave_code varchar(500),_wavedetail_code varchar(500),_product_code varchar(500),_product_name varchar(500),_product_enname varchar(500),_product_barcode varchar(500),_product_sku varchar(500),_product_unit varchar(500),_product_weight varchar(500),_product_length varchar(500),_product_width varchar(500),_product_heigth varchar(500),_product_length_sort varchar(500),_product_width_sort varchar(500),_product_heigth_sort varchar(500),_product_bulk varchar(500),_product_imgurl varchar(500),_product_state int,_product_groupstate int,_product_batterystate int,_total_count int,_space_halftype int)
BEGIN
  DECLARE _space_count VARCHAR(500);						 #货位存放数量
  DECLARE _space_code VARCHAR(500);						   #货位编码
  DECLARE _space_linenumber VARCHAR(500);				 #货位动线号
	DECLARE _space_number VARCHAR(500);            #货位编号
  DECLARE _wavedetailspace_code VARCHAR(500);    #波次明细货位编码
  DECLARE done, error BOOLEAN DEFAULT FALSE;		 #遍历数据结束标志
		
   #根据货品编码查询对应货位存放情况
	 DECLARE list CURSOR FOR  
	 (
			SELECT (sum(sd.space_count)-sum(sd.space_excount)) space_count,s.space_code,s.space_linenumber,s.space_number FROM isale_spacedetail sd
			INNER JOIN isale_space s ON s.space_code = sd.space_code
			WHERE sd.product_code = _product_code AND s.space_halftype = _space_halftype AND s.space_type <= 2
			GROUP BY s.space_code HAVING (sum(sd.space_count)-sum(sd.space_excount)) != 0
			ORDER BY s.space_linenumber ASC
	 );
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
		
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			 FETCH list INTO _space_count,_space_code,_space_linenumber,_space_number;
	IF done THEN
			#select 'no data';
      LEAVE read_loop;
    END IF;
			#-----------执行业务逻辑
			SET _space_count = _space_count + 0;
			#SELECT CONCAT('space_number',_space_number);
			#SELECT CONCAT('space_count',_space_count);
			
			#SET _wavedetailspace_code = unix_timestamp(NOW());
		  SET _wavedetailspace_code = CONCAT('602',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));
			#当前货位货品数量已经满足出库单
      IF (_space_count+0) >= (_total_count+0) THEN 
					INSERT INTO isale_wavedetailspace 
					(wavedetailspace_code,wavedetail_code,wave_code,wavedetail_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,space_code,space_number,space_linenumber)
					VALUES
          (_wavedetailspace_code,_wavedetail_code,_wave_code,_total_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_space_code,_space_number,_space_linenumber);
          
					#更新货位明细表预扣字段
					UPDATE isale_spacedetail set space_excount = space_excount+_total_count where space_code = _space_code AND product_code = _product_code;

					LEAVE read_loop;
      ELSE
					INSERT INTO isale_wavedetailspace 
					(wavedetailspace_code,wavedetail_code,wave_code,wavedetail_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,space_code,space_number,space_linenumber)
					VALUES
          (_wavedetailspace_code,_wavedetail_code,_wave_code,_space_count,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_space_code,_space_number,_space_linenumber);
          
					#更新货位明细表预扣字段
					UPDATE isale_spacedetail set space_excount = space_excount+_space_count where space_code = _space_code AND product_code = _product_code;

					#记录一个后,减少对应数量
					SET _total_count = _total_count-_space_count;
			END IF;
			
		END LOOP;
			
	  /*关闭光标*/ 
		CLOSE list; 
  

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_packtable_bc
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_packtable_bc`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_packtable_bc`(_wave_code varchar(500),_packtable_type int,search_type int, out result varchar(500))
BEGIN
	 DECLARE _packtable_code VARCHAR(500);				 #包装台编码
	 DECLARE _packtable_name VARCHAR(500);				 #包装台名称
	 DECLARE _task_count INT DEFAULT 0;						 #包装台
	 #DECLARE _task_count_current INT DEFAULT 0;		 #当前拣货任务对应包装台需要处理的任务量
	 DECLARE done, error BOOLEAN DEFAULT FALSE;		 #遍历数据结束标志
	 
   #根据包装台类型查询
	 DECLARE list CURSOR FOR  
	 (
			SELECT packtable_code,packtable_name FROM isale_packtable WHERE packtable_type = _packtable_type
	 );
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
		
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			FETCH list INTO _packtable_code,_packtable_name;
				IF done THEN
					#select 'no data';
					LEAVE read_loop;
				END IF;
				#---------执行业务逻辑
				#SELECT CONCAT('_packtable_code：',_packtable_code);
				#创建临时表保存包装台的任务量  if not EXISTS不存在则创建
				CREATE TEMPORARY TABLE IF NOT EXISTS isale_task_packtable_tmp 
				( 
					packtable_code VARCHAR(500),packtable_name VARCHAR(500),task_count INT
				);
				#写入临时表
				SELECT count(1) INTO _task_count FROM isale_outorderdetail WHERE packtable_code = _packtable_code AND outorderdetail_packstate < 3;
				INSERT INTO isale_task_packtable_tmp VALUES (_packtable_code,_packtable_name,_task_count);
			

		END LOOP;
		
		#SELECT * FROM isale_task_packtable_tmp;
		SELECT t.packtable_code,t.packtable_name,t.task_count INTO _packtable_code,_packtable_name,_task_count FROM isale_task_packtable_tmp t ORDER BY t.task_count ASC LIMIT 1;
		#调用批间存储
		IF search_type = 1 THEN
				#SELECT CONCAT('_packtable_code:',_packtable_code,' _task_count:',_task_count);
				
				CALL proc_packtable_bc_pj(_wave_code,_packtable_code);
		ELSE  	#调用非批间存储	
				#SELECT CONCAT('_packtable_code:',_packtable_code,' _task_count:',_task_count);
				
				CALL proc_packtable_bc_fpj(_wave_code,_packtable_code);
		END IF;	
		
		SELECT packtable_name INTO _packtable_name FROM isale_task_packtable_tmp WHERE packtable_code = _packtable_code;
		#SELECT task_count_current,packtable_name INTO _task_count_current,_packtable_name FROM isale_task_packtable_tmp WHERE packtable_code = _packtable_code;
		#SELECT CONCAT('_task_count_current：',_task_count_current);
		#当前包装台绑定订单,返回包装台名称
		#IF (_task_count_current+0) > 0 THEN
				#设置返回值
			#	SET result = _packtable_name;
		#ELSE	
		#		SET result = '';
		#END IF;
		
		#返回包装台名称
		SET result = _packtable_name;
		#删除临时表
		DROP TABLE isale_task_packtable_tmp;

		select result;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_packtable_bc_fpj
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_packtable_bc_fpj`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_packtable_bc_fpj`(_wave_code varchar(500),_packtable_code varchar(500))
BEGIN
	#DECLARE _task_count_current INT;    #当前更新包装台的任务数
	
	#查询需要更新包装台的任务量
	#SELECT count(1) INTO _task_count_current FROM isale_outorder oo 
	#INNER JOIN isale_outorderdetail ood 
	#ON oo.outorder_code = ood.outorder_code
	#WHERE oo.wave_code = _wave_code AND oo.outorder_count != 1 AND ood.packtable_code IS NULL;

	#通过波次编码绑定当前该波次下所有非批间子单包装台
	#UPDATE isale_outorderdetail set packtable_code = _packtable_code
	#WHERE outorderdetail_code in
	#(
		#SELECT t.outorderdetail_code FROM 
		#(
			#SELECT ood.outorderdetail_code FROM isale_outorder oo 
			#INNER JOIN isale_outorderdetail ood 
			#ON oo.outorder_code = ood.outorder_code
			#WHERE oo.wave_code = _wave_code AND oo.outorder_count != 1 AND ood.packtable_code IS NULL
		#)t
	#);
	
	#通过波次编码绑定当前该波次下所有非批间订单包装台
	UPDATE isale_outorder set packtable_code = _packtable_code WHERE wave_code = _wave_code AND outorder_count != 1 AND packtable_code IS NULL;
	

	#更新此次包装台任务量
	#UPDATE isale_task_packtable_tmp SET task_count_current = _task_count_current WHERE packtable_code = _packtable_code;

		
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_packtable_bc_pj
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_packtable_bc_pj`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_packtable_bc_pj`(_wave_code varchar(500),_packtable_code varchar(500))
BEGIN
	#DECLARE _task_count_current INT;    #当前更新包装台的任务数
	

	#查询需要更新包装台的任务量
	#SELECT count(1) INTO _task_count_current FROM isale_outorder oo 
	#INNER JOIN isale_outorderdetail ood 
	#ON oo.outorder_code = ood.outorder_code
	#WHERE oo.wave_code = _wave_code AND oo.outorder_count = 1 AND ood.packtable_code IS NULL;


	#通过波次编码绑定当前该波次下所有批间子单包装台
	#UPDATE isale_outorderdetail set packtable_code = _packtable_code
	#WHERE outorderdetail_code in
	#(
		#SELECT t.outorderdetail_code FROM 
		#(
			#SELECT ood.outorderdetail_code FROM isale_outorder oo 
			#INNER JOIN isale_outorderdetail ood 
			#ON oo.outorder_code = ood.outorder_code
			#WHERE oo.wave_code = _wave_code AND oo.outorder_count = 1 AND ood.packtable_code IS NULL
		#)t
	#);
	
	#通过波次编码绑定当前该波次下所有批间订单包装台
	UPDATE isale_outorder set packtable_code = _packtable_code WHERE wave_code = _wave_code AND outorder_count = 1 AND packtable_code IS NULL;

	#更新此次包装台任务量
	#UPDATE isale_task_packtable_tmp SET task_count_current = _task_count_current WHERE packtable_code = _packtable_code;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_packtable_lc
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_packtable_lc`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_packtable_lc`(_wave_code varchar(500),_packtable_type int,search_type int,search_content varchar(2000),out result varchar(500))
BEGIN
	 DECLARE _packtable_code VARCHAR(500);				 #包装台编码
	 DECLARE _packtable_name VARCHAR(500);				 #包装台名称
	 DECLARE _task_count INT DEFAULT 0;						 #包装台
	 #DECLARE _task_count_current INT DEFAULT 0;		 #当前拣货任务对应包装台需要处理的任务量
	 DECLARE done, error BOOLEAN DEFAULT FALSE;		 #遍历数据结束标志
	 
   #根据包装台类型查询
	 DECLARE list CURSOR FOR  
	 (
			SELECT packtable_code,packtable_name FROM isale_packtable WHERE packtable_type = _packtable_type
	 );
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
		
	 #打开光标
   OPEN list;
	
	 #循环执行
	 read_loop: LOOP 
			#数据填充的时候要注意字段匹配,否则填充失败
			FETCH list INTO _packtable_code,_packtable_name;
				IF done THEN
					#select 'no data';
					LEAVE read_loop;
				END IF;
				#---------执行业务逻辑
				#SELECT CONCAT('_packtable_code：',_packtable_code);
				#创建临时表保存包装台的任务量  if not EXISTS不存在则创建
				CREATE TEMPORARY TABLE IF NOT EXISTS isale_task_packtable_tmp 
				( 
					packtable_code VARCHAR(500),packtable_name VARCHAR(500),task_count INT
				);
				#写入临时表
				SELECT count(1) INTO _task_count FROM isale_outorderdetail WHERE packtable_code = _packtable_code AND outorderdetail_packstate < 3;
				INSERT INTO isale_task_packtable_tmp VALUES (_packtable_code,_packtable_name,_task_count);
			

		END LOOP;
		
		#SELECT * FROM isale_task_packtable_tmp;
		SELECT t.packtable_code,t.packtable_name,t.task_count INTO _packtable_code,_packtable_name,_task_count FROM isale_task_packtable_tmp t ORDER BY t.task_count ASC LIMIT 1;
		#调用批间存储
		IF search_type = 1 THEN
				#SELECT CONCAT('_packtable_code:',_packtable_code,' _task_count:',_task_count);
				
				CALL proc_packtable_lc_pj(_wave_code,_packtable_code,search_content);
		ELSE  	#调用非批间存储	
				#SELECT CONCAT('_packtable_code:',_packtable_code,' _task_count:',_task_count);
				
				CALL proc_packtable_lc_fpj(_wave_code,_packtable_code,search_content);
		END IF;	
		
		SELECT packtable_name INTO _packtable_name FROM isale_task_packtable_tmp WHERE packtable_code = _packtable_code;
		#SELECT task_count_current,packtable_name INTO _task_count_current,_packtable_name FROM isale_task_packtable_tmp WHERE packtable_code = _packtable_code;
		#SELECT CONCAT('_task_count_current：',_task_count_current);
		#当前包装台绑定订单,返回包装台名称
		#IF (_task_count_current+0) > 0 THEN
				#设置返回值
			#	SET result = _packtable_name;
		#ELSE	
		#		SET result = '';
		#END IF;
		
		#返回包装台名称
		SET result = _packtable_name;
		#删除临时表
		DROP TABLE isale_task_packtable_tmp;

		select result;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_packtable_lc_fpj
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_packtable_lc_fpj`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_packtable_lc_fpj`(_wave_code varchar(500),_packtable_code varchar(500),search_content varchar(2000))
BEGIN
	#DECLARE _task_count_current INT DEFAULT 0;    #当前更新包装台的任务数
	DECLARE _sql VARCHAR(2000);

	#通过波次编码绑定当前该波次下所有批间子单包装台
	#SET _sql = CONCAT('UPDATE isale_outorderdetail set packtable_code = ',_packtable_code,'
	#WHERE outorderdetail_code in
	#(
		#SELECT t.outorderdetail_code FROM 
		#(
			#SELECT ood.outorderdetail_code FROM isale_outorder oo 
			#INNER JOIN isale_outorderdetail ood 
			#ON oo.outorder_code = ood.outorder_code
			#WHERE oo.wave_code = ', _wave_code,' AND oo.outorder_count != 1 AND ood.packtable_code IS NULL AND oo.outorder_code IN (',search_content,')
		#)t
	#)');
	
	#通过波次编码绑定当前该波次下所有批间订单包装台
	SET _sql = CONCAT('UPDATE isale_outorder set packtable_code = ',_packtable_code,' WHERE wave_code = ', _wave_code,' AND outorder_count != 1 AND packtable_code IS NULL AND outorder_code IN (',search_content,'))');

	#SELECT CONCAT('_sql:',_sql);
  SET @_sql = _sql;
  PREPARE stmt FROM @_sql;
  EXECUTE stmt;
  deallocate prepare stmt;
	
	#更新此次包装台任务量
	#UPDATE isale_task_packtable_tmp SET task_count_current = _task_count_current WHERE packtable_code = _packtable_code;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_packtable_lc_pj
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_packtable_lc_pj`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_packtable_lc_pj`(_wave_code varchar(500),_packtable_code varchar(500),search_content varchar(500))
BEGIN
	DECLARE _sql VARCHAR(2000);	
	
	#SELECT CONCAT('_wave_code：',_wave_code,' _packtable_code:',_packtable_code,' search_content:',search_content);
	#通过波次编码绑定当前该波次下所有批间子单包装台
  #SET _sql = CONCAT('UPDATE isale_outorderdetail set packtable_code = ',_packtable_code,'
	#WHERE outorderdetail_code in
	#(
		#SELECT t.outorderdetail_code FROM 
		#(
			#SELECT ood.outorderdetail_code FROM isale_outorder oo 
			#INNER JOIN isale_outorderdetail ood 
			#ON oo.outorder_code = ood.outorder_code
			#WHERE oo.wave_code = ', _wave_code,' AND oo.outorder_count = 1 AND ood.packtable_code IS NULL AND ood.product_code IN (',search_content,')
		#)t
	#)');
	
	#通过波次编码绑定当前该波次下所有批间订单包装台
  SET _sql = CONCAT('UPDATE isale_outorder set packtable_code = ',_packtable_code,'
	WHERE outorder_code in
	(
		SELECT DISTINCT t.outorder_code FROM 
		(
			SELECT oo.outorder_code FROM isale_outorder oo 
			INNER JOIN isale_outorderdetail ood 
			ON oo.outorder_code = ood.outorder_code
			WHERE oo.wave_code = ', _wave_code,' AND oo.outorder_count = 1 AND oo.packtable_code IS NULL AND ood.product_code IN (',search_content,')
		)t
	)');

	#SELECT CONCAT('_sql ',_sql);
	SET @_sql = _sql;
	PREPARE stmt FROM @_sql;
	EXECUTE stmt;
	deallocate prepare stmt;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_process
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_process`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `proc_process`(_process_code varchar(500),user_codes longtext,out result int)
BEGIN
		DECLARE _process_state INT;		#加工状态
		DECLARE _sql VARCHAR(500);	

		#创建临时表保存用户的任务量  if not EXISTS不存在则创建
		CREATE TEMPORARY TABLE IF NOT EXISTS isale_task_user_p_tmp 
		( 
			user_code VARCHAR(500),user_name VARCHAR(500),user_logourl VARCHAR(500),task_count INT DEFAULT 0
		);
		
		
		SET _sql = CONCAT('INSERT INTO isale_task_user_p_tmp SELECT u.user_code,u.user_name,u.user_logourl,0 FROM isale_user u WHERE u.user_code in (',user_codes,')');   -- 拼接查询sql语句
		SET @_sql = _sql;
		PREPARE stmt FROM @_sql;
		EXECUTE stmt;
		deallocate prepare stmt;
		
		#SELECT * FROM isale_task_user_p_tmp;

		select process_state INTO _process_state from isale_process where process_code=_process_code;

		IF _process_state < 2 THEN
			#根据加工状态  申请中
			UPDATE isale_process SET process_state = 2 WHERE process_code = _process_code;
			#批间按照sku种类,进行出库人员分配
			CALL proc_process_1(_process_code);
			#设置返回值
			SET result = 1;	
		ELSE
			#设置返回值
			SET result = 2;
		END IF;
		#删除临时表
		DROP TABLE isale_task_user_p_tmp;
		#返回值
		SELECT result;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_process_1
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_process_1`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `proc_process_1`(_process_code varchar(500))
BEGIN
	DECLARE _processdetail_code VARCHAR(500);				#加工明细系统编码
  DECLARE _product_code VARCHAR(500);						  #加工sku系统编码
	DECLARE _processdetail_count INT;								#加工sku需要的数量
	DECLARE _user_code VARCHAR(500);								#工作人员编码
  DECLARE _user_name VARCHAR(500);								#工作人员名称
	DECLARE _user_logourl VARCHAR(500);							#工作人员头像
	DECLARE _task_count INT;
  DECLARE done, error BOOLEAN DEFAULT FALSE;			#遍历数据结束标志


  #查询加工的明细内容
	DECLARE list CURSOR FOR  
	(	
		select processdetail_code,processdetail_count,product_code  from isale_processdetail where process_code=_process_code
	);
	 
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
	
	 #打开光标
   OPEN list;
		 
	 #循环执行
	 read_loop: LOOP 
		 #数据填充的时候要注意字段匹配,否则填充失败
		 FETCH list INTO _processdetail_code,_processdetail_count,_product_code;
	 IF done THEN
		 LEAVE read_loop;
	 END IF;
		 #--------------------执行业务逻辑

		 #根据任务量查询用户任务临时表,取第一条用户
		
		 SELECT user_code,user_name,user_logourl,task_count INTO _user_code,_user_name,_user_logourl,_task_count FROM isale_task_user_p_tmp ORDER BY task_count+0 ASC LIMIT 1;
		
		 #根据_process_code加工内容编写相关数据
		 CALL proc_process_2(_process_code,_processdetail_code,_processdetail_count,_user_code,_user_name,_user_logourl,_product_code);
		 
		 #更新临时表任务数
		 UPDATE isale_task_user_p_tmp set task_count=task_count+1 where user_code=_user_code;
	END LOOP;
	/*关闭光标*/ 
	CLOSE list; 

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_process_2
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_process_2`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `proc_process_2`(_process_code varchar(500),_processdetail_code varchar(500),_processdetail_count int,_user_code varchar(500),_user_name varchar(500),_user_logourl varchar(500),_product_code varchar(500))
BEGIN
	DECLARE _product_name	VARCHAR(500); 					 #货品名称
	DECLARE _product_enname	VARCHAR(500);          #货品英文名称
	DECLARE _product_barcode	VARCHAR(500);        #货品条码
	DECLARE _product_sku	VARCHAR(500);            #货品SKU编号同步第三方平台
	DECLARE _product_unit	VARCHAR(500);            #货品单位
	DECLARE _product_weight	VARCHAR(500);          #货品重量
	DECLARE _product_length	VARCHAR(500);          #货品长度(单位:mm)
	DECLARE _product_width	VARCHAR(500);          #货品宽度(单位:mm)
	DECLARE _product_heigth	VARCHAR(500);          #货品高度(单位:mm)
	DECLARE _product_length_sort	VARCHAR(500);    #货品排序后长边(单位:mm)
	DECLARE _product_width_sort	VARCHAR(500);      #货品排序后中边(单位:mm)
	DECLARE _product_heigth_sort	VARCHAR(500);		 #货品排序后短边(单位:mm)
	DECLARE _product_bulk	VARCHAR(500);            #货品体积
	DECLARE _product_imgurl	VARCHAR(500);          #货品图片
	DECLARE _product_state	INT;									 #货品状态(1:待审核、2:审核中(货主通过)、3:审核通过(管理员通过)、4:审核不通过(管理员不通过,1,4下都可以删除、修改)
	DECLARE _product_groupstate INT;               #货品组合状态(1：未组合、2：组合)
	DECLARE _product_batterystate INT;						 #货品是否带电池(1：是、2：否)
  DECLARE _space_count VARCHAR(500);						 #货位存放数量
  DECLARE _space_code VARCHAR(500);						   #货位编码
  DECLARE _space_linenumber VARCHAR(500);				 #货位动线号
	DECLARE _space_number VARCHAR(500);            #货位编号
  DECLARE _processdetailspace_code VARCHAR(500); #加工任务货位明细编码
  DECLARE done, error BOOLEAN DEFAULT FALSE;		 #遍历数据结束标志
	DECLARE _task_code VARCHAR(500);				       #任务系统编码
	DECLARE _content VARCHAR(500);								 #task任务说明
		
	#根据货品编码查询对应货位存放情况
	DECLARE list CURSOR FOR  
	(
		SELECT (sum(sd.space_count)-sum(sd.space_excount)) space_count,s.space_code,s.space_linenumber,s.space_number FROM isale_spacedetail sd
		INNER JOIN isale_space s ON s.space_code = sd.space_code
		WHERE sd.product_code = _product_code AND s.space_halftype = 3 AND s.space_type <= 2
		GROUP BY s.space_code HAVING (sum(sd.space_count)-sum(sd.space_excount)) >= 1
		ORDER BY s.space_linenumber ASC
	);
	 
	#解决mysql游标错误
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;       #游标为空,无数据
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
	DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
		
	#打开光标
	OPEN list;

	#循环执行
	read_loop: LOOP 
		#数据填充的时候要注意字段匹配,否则填充失败
		FETCH list INTO _space_count,_space_code,_space_linenumber,_space_number;
	IF done THEN
	
		LEAVE read_loop;
	END IF;
		#-----------执行业务逻辑
		#SKU属性赋值
		select product_name,product_enname,product_barcode,product_sku,product_unit,product_weight,product_length,
		product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate
		INTO _product_name,_product_enname,_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate 
		from isale_product where product_code=_product_code;
		
		#库存量
		SET _space_count = _space_count + 0;
		#select CONCAT("_user_code:",_user_code);
		#设置编码
		SET _processdetailspace_code = CONCAT('306',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));
		#当前货位货品数量已经满足出库单
		IF (_space_count+0) >= _processdetail_count THEN 
				
				INSERT INTO isale_processdetailspace(processdetailspace_code,process_code,processdetail_code,processdetailspace_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,space_code,space_number,space_linenumber)
				VALUES(_processdetailspace_code,_process_code,_processdetail_code,CONCAT(_processdetail_count,''),_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_space_code,_space_number,_space_linenumber);
				
				#更新货位明细表预扣字段
				UPDATE isale_spacedetail set space_excount = space_excount+_processdetail_count where space_code = _space_code;
				
				#插入任务表
				SET _task_code = CONCAT('700',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
				SET _content = CONCAT('''',_product_name,'拿取',_processdetail_count,'''');
				INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,product_code,product_name,product_enname,product_barcode
				,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort
				,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_logourl) 
				VALUES
				(_task_code,9,_processdetailspace_code,CONCAT(_processdetail_count,''),_content,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_user_code,_user_name,_user_logourl);

				LEAVE read_loop;
		ELSE

				INSERT INTO isale_processdetailspace 
				(processdetailspace_code,process_code,processdetail_code,processdetailspace_count,product_code,product_name,product_enname,product_barcode,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,space_code,space_number,space_linenumber)
				VALUES
				(_processdetailspace_code,_process_code,_processdetail_code,CONCAT(_processdetail_count,''),_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_space_code,_space_number,_space_linenumber);
				
				#更新货位明细表预扣字段
				UPDATE isale_spacedetail set space_excount = space_excount+_space_count where space_code = _space_code;
				
				#插入任务表
				SET _task_code = CONCAT('700',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));	
				SET _content = CONCAT('''',_product_name,'拿取',_space_count,'''');
				INSERT INTO isale_task(task_code,task_type,task_othercode,task_count,task_content,product_code,product_name,product_enname,product_barcode
				,product_sku,product_unit,product_weight,product_length,product_width,product_heigth,product_length_sort,product_width_sort,product_heigth_sort
				,product_bulk,product_imgurl,product_state,product_groupstate,product_batterystate,user_code,user_name,user_logourl) 
				VALUES
				(_task_code,9,_processdetailspace_code,_space_count,_content,_product_code,_product_name,_product_enname,_product_barcode,_product_sku,_product_unit,_product_weight,_product_length,_product_width,_product_heigth,_product_length_sort,_product_width_sort,_product_heigth_sort,_product_bulk,_product_imgurl,_product_state,_product_groupstate,_product_batterystate,_user_code,_user_name,_user_logourl);

				#设置最新需要拿取的数量
				SET _processdetail_count = _processdetail_count-_space_count;
		END IF;
			
	END LOOP;
			
	/*关闭光标*/ 
	CLOSE list; 


END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_rent_a
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_rent_a`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_rent_a`(in _current_time varchar(500))
BEGIN
	 DECLARE _user_code VARCHAR(500);									#用户编码
	 DECLARE done, error BOOLEAN DEFAULT FALSE;				#遍历数据结束标志
	
	 #查询所有租户游标
	 DECLARE payment_userlist CURSOR FOR  
	 select user_code from isale_user where user_type='3';
		
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
	
	 #打开光标
   OPEN payment_userlist;
	
	 #循环执行
	 read_loop: LOOP 
			 FETCH payment_userlist INTO _user_code;
		IF done THEN
      LEAVE read_loop;
    END IF;
			#-----------执行业务逻辑
			call proc_rent_b(_user_code,_current_time);
		END LOOP;
	 /*关闭光标*/ 
		CLOSE payment_userlist; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_rent_auto_a
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_rent_auto_a`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_rent_auto_a`(in _current_time varchar(500))
BEGIN
	 DECLARE _user_code VARCHAR(500);									#用户编码
	 DECLARE _rent_code VARCHAR(500);									#租金收费系统编码
	 DECLARE done, error BOOLEAN DEFAULT FALSE;				#遍历数据结束标志
	
	 #查询所有租户游标
	 DECLARE payment_userlist CURSOR FOR  
	 select user_code from isale_user where user_type='3';
		
	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;
	
	 #打开光标
   OPEN payment_userlist;
	
	 #循环执行
	 read_loop: LOOP 
			 FETCH payment_userlist INTO _user_code;
		IF done THEN
      LEAVE read_loop;
    END IF;
			#-----------执行业务逻辑
			#租金收费父编码
			set _rent_code = CONCAT('400',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));
			call proc_rentauto_b(_user_code,_current_time,_rent_code);
		END LOOP;
	 /*关闭光标*/ 
		CLOSE payment_userlist; 
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_rent_auto_b
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_rent_auto_b`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_rent_auto_b`(_user_code varchar(500),_current_time varchar(500),_rent_code varchar(500))
BEGIN
	 DECLARE _product_code varchar(500);													#货品编码
	 DECLARE _product_name VARCHAR(500);													#货品名称
	 DECLARE _product_sku VARCHAR(500);														#SKU编码
	 DECLARE _space_usedbulk VARCHAR(500);												#货位使用体积
	 DECLARE _space_usedbulk_m3 VARCHAR(500);											#货位使用 换成立方米
	 DECLARE _space_usedbulk_m3_sum VARCHAR(500) DEFAULT 0;				#货位使用立方米总和
	 DECLARE _space_usedbulk_m3_sum_float DECIMAL(20,6);					#货位使用立方米总和
	 DECLARE _payment_time VARCHAR(500);													#库存货位中间表付费时间
	 DECLARE _storage_intime varchar(500);												#库存入库时间
	 DECLARE _rentrule_short VARCHAR(500);												#短租(金额/天)
	 DECLARE _rentrule_long  VARCHAR(500);												#长租(金额/天)
	 DECLARE _rentrule_longnorms  VARCHAR(500);      							#长租规格(多少天算长租)
	 DECLARE _time_diff VARCHAR(50);															#系统时间-库存入库时间
	 DECLARE _user_rent_price VARCHAR(50);												#用户余额
	 DECLARE _rent_currentprice VARCHAR(500);											#操作后的金额
	 DECLARE _rent_price VARCHAR(500);														#租金   
	 DECLARE _rent_currentprice_sum VARCHAR(500) DEFAULT 0;				#操作后的金额
	 DECLARE _rent_price_sum VARCHAR(500) DEFAULT 0;							#租金   
	 DECLARE _rent_price_left VARCHAR(20);												#租金左边数据
	 DECLARE _rent_price_right VARCHAR(20);												#租金右侧数据
	 DECLARE _rent_price_back VARCHAR(500);												#超过长租返回金额
	 DECLARE _feecoefficient_standard VARCHAR(5);									#用户扣费系数
	 DECLARE _rentdetail_code VARCHAR(500);												#租金收费明细编码
   DECLARE _price_feecoefficient VARCHAR(500);									#租金*用户扣费系数
   DECLARE done, error BOOLEAN DEFAULT FALSE;										#遍历数据结束标志
		
		
	 #定义游标
	 DECLARE payment_userlist CURSOR FOR 
	 (
		 #查询系统前一天的上架货品
		 select distinct sdl.product_code,sdl.product_name,sdl.product_sku,(sdl.space_count*sdl.product_bulk) space_usedbulk,sdl.feetime payment_time,sdl.addtime storage_intime from isale_spacedetaillog sdl
		 inner join isale_space ss on sdl.space_code = ss.space_code
		 inner join isale_user u on u.user_code = sdl.user_code
		 where  u.user_code = _user_code and sdl.task_type = 1
		 and timestampdiff(day,date_format(sdl.feetime,'%Y-%m-%d'),date_format(_current_time,'%Y-%m-%d')) = 1 
		 group by sdl.product_code,date_format(sdl.feetime,'%Y-%m-%d')
	 );

	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;

	 #查询租金规则
	 select rentrule_short,rentrule_long,rentrule_longnorms into _rentrule_short,_rentrule_long,_rentrule_longnorms from isale_rentrule;

	 #打开光标
   OPEN payment_userlist; 
	
	 #循环执行
	 read_loop: LOOP 
			 FETCH payment_userlist INTO _product_code,_product_name,_product_sku,_space_usedbulk,_payment_time,_storage_intime;
		IF done THEN
      LEAVE read_loop;
    END IF;
		#------------执行业务逻辑
		set _rentdetail_code = CONCAT('401',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));
		#查询库存入库时间差
		select timestampdiff(day,date_format(_storage_intime,'%Y-%m-%d'),date_format(_current_time,'%Y-%m-%d')) into _time_diff;
		#查询用户当前金额
		select user_rent_price into _user_rent_price from isale_user where user_code = _user_code;
		#查询用户扣费系数,为null则默认为1
		select IFNULL(feecoefficient_standard,1) into _feecoefficient_standard from isale_feecoefficient where user_code=_user_code;
		IF _feecoefficient_standard IS NULL THEN
			SET _feecoefficient_standard = 1;
	  END IF;
		#货位使用体积  立方毫米转换立方米
		set _space_usedbulk_m3 = _space_usedbulk/1000000000;
	
		#select CONCAT('货品：',_product_name,'入库时间差：',_time_diff,' 暂用体积m³：',_space_usedbulk_m3,' 扣费系数：',_feecoefficient_standard);

		#如果系统时间-入库时间=长租时间 就按长租收费,需要把短租收费换成长租收费-->(短租金额-长租金额)*该货位体积*扣费系数,写入租金日志
		IF (_time_diff+0) = (_rentrule_longnorms+0) THEN
			set _rent_price_back = (_rentrule_short-_rentrule_long)*_rentrule_longnorms*_space_usedbulk_m3*_feecoefficient_standard;
			#select CONCAT('退还原始租金：',_rent_price_back);
			#整数 从小数点第三位开始截断,判断如果大于0,则小数点第二位加1,否则直接截断
			IF LOCATE('.',_rent_price_back) = 0 THEN
					set _rent_price_back = _rent_price_back;
			ELSE#小数
					set _rent_price_left = substring(_rent_price_back,1,LOCATE('.',_rent_price_back)+2);
					set _rent_price_right = replace(substring(_rent_price_back,LOCATE('.',_rent_price_back)+3),'0','');
					#select CONCAT('短租变长租_rent_price_left：',_rent_price_left,'_rent_price_right：',_rent_price_right);
					IF LENGTH(_rent_price_right) = 0 THEN
							#select '小数点第三位没有了';
							set _rent_price_back = _rent_price_left;
					ELSE
						IF _rent_price_right > 0 THEN
							#select '小数点第三位后大于0';
							set _rent_price_back = CONVERT(_rent_price_left,DECIMAL(20,2))+0.01;
						ELSE
							set _rent_price_back = _rent_price_left;
						END IF;
					END IF;
			END IF;

			set _rent_currentprice = CONVERT(_user_rent_price,DECIMAL(20,2)) + CONVERT(_rent_price_back,DECIMAL(20,2));
	
			insert into isale_rent(rent_code,rent_price,rent_remark,rent_type,rent_currentprice,user_code) 
			values(_rent_code,_rent_price_back,CONCAT('租用体积：',_space_usedbulk_m3,'m³ ,退还租金：',_rent_price_back,'元/m³'),1,_rent_currentprice,_user_code);

			update isale_spacedetaillog set feetime = _current_time where product_code = _product_code 
			and timestampdiff(day,date_format(feetime,'%Y-%m-%d'),date_format(_current_time,'%Y-%m-%d')) = 1 ; 

			update isale_user set user_rent_price = _user_rent_price+_rent_price_back where user_code = _user_code;
			
		#如果系统时间-入库时间>长租时间 就按长租收费,长租金额*货位体积*系数 写入租金日志明细表
		ELSEIF (_time_diff+0) > (_rentrule_longnorms+0) THEN
			set _price_feecoefficient = _rentrule_long * _feecoefficient_standard;
			set _rent_price =  _space_usedbulk_m3 * _price_feecoefficient;
			#select CONCAT('长租原始金额：',_rent_price);
			#整数
			IF LOCATE('.',_rent_price) = 0 THEN
					set _rent_price = _rent_price;
			ELSE#小数
					set _rent_price_left = substring(_rent_price,1,LOCATE('.',_rent_price)+2);
					set _rent_price_right = replace(substring(_rent_price,LOCATE('.',_rent_price)+3),'0','');
					#select CONCAT('长租扣费_rent_price_left：',_rent_price_left,' _rent_price_right：',_rent_price_right);
					IF LENGTH(_rent_price_right) = 0 THEN
							#select '小数点第三位没有了';
							set _rent_price = _rent_price_left;
					ELSE
						IF _rent_price_right > 0 THEN
							#select '小数点第三位后大于0';
							set _rent_price = CONVERT(_rent_price_left,DECIMAL(20,2))+0.01;
						ELSE
							set _rent_price = _rent_price_left;
						END IF;
					END IF;
			END IF;
			
			set _rent_currentprice = CONVERT(_user_rent_price,DECIMAL(20,2)) - CONVERT(_rent_price,DECIMAL(20,2));
			#select CONCAT('_rent_currentprice：',_rent_currentprice);
			set _rent_price_sum = CONVERT(_rent_price_sum,DECIMAL(20,2)) + CONVERT(_rent_price,DECIMAL(20,2));
			#select CONCAT('_rent_price_sum：',_rent_price_sum);
			#set _rent_currentprice_sum = CONVERT(_rent_currentprice_sum,DECIMAL(20,2)) + CONVERT(_rent_currentprice,DECIMAL(20,2));
			#select CONCAT('_rent_currentprice_sum：',_rent_currentprice_sum);
			
			#select CONCAT('_space_usedbulk_m3：',_space_usedbulk_m3);
			set _space_usedbulk_m3_sum = CONVERT(_space_usedbulk_m3_sum,DECIMAL(20,6)) + CONVERT(_space_usedbulk_m3,DECIMAL(20,6));
			#select CONCAT('_space_usedbulk_m3_sum：',_space_usedbulk_m3_sum);
			
			insert into isale_rentdetail(rentdetail_code,rentdetail_name,rentdetail_price,rentdetail_currentprice,rentdetail_remark,rent_code) 
			values(_rentdetail_code,'日租扣费',_rent_price,_rent_currentprice,CONCAT('货品：',_product_name,' ,SKU：',_product_sku,' ,入库时间：',_storage_intime,' ,日租扣费：',_space_usedbulk_m3,'m³×',_price_feecoefficient,'元/m³/天'),_rent_code);
		
			update isale_user set user_rent_price = _rent_currentprice where user_code = _user_code;			
			
			update isale_spacedetaillog set feetime = _current_time where product_code = _product_code 
			and timestampdiff(day,date_format(feetime,'%Y-%m-%d'),date_format(_current_time,'%Y-%m-%d')) = 1 ;

		#如果系统时间-入库时间<长租时间 就按短租收费,短租金额*货位体积*系数 写入租金日志明细表
		ELSE
			set _price_feecoefficient = _rentrule_short * _feecoefficient_standard;
			set _rent_price =  _space_usedbulk_m3 * _price_feecoefficient;
			#select CONCAT('短租原始金额：',_rent_price);
			#整数
			IF LOCATE('.',_rent_price) = 0 THEN
				set _rent_price = _rent_price;
			ELSE#小数
					set _rent_price_left = substring(_rent_price,1,LOCATE('.',_rent_price)+2);
					set _rent_price_right = replace(substring(_rent_price,LOCATE('.',_rent_price)+3),'0','');
					#select CONCAT('短租金额：',_rent_price,'_rent_price_left：',_rent_price_left,'_rent_price_right：',_rent_price_right);
					IF LENGTH(_rent_price_right) = 0 THEN
							#select '小数点第三位没有了';
							set _rent_price = _rent_price_left;
					ELSE
						IF _rent_price_right > 0 THEN
							#select '小数点第三位后大于0';
							set _rent_price = CONVERT(_rent_price_left,DECIMAL(20,2))+0.01;
						ELSE
							set _rent_price = _rent_price_left;
						END IF;
					END IF;
			END IF;
			
			set _rent_currentprice = CONVERT(_user_rent_price,DECIMAL(20,2)) - CONVERT(_rent_price,DECIMAL(20,2));
			set _rent_price_sum = CONVERT(_rent_price_sum,DECIMAL(20,2)) + CONVERT(_rent_price,DECIMAL(20,2));
			set _space_usedbulk_m3_sum = CONVERT(_space_usedbulk_m3_sum,DECIMAL(20,6)) + CONVERT(_space_usedbulk_m3,DECIMAL(20,6));

			insert into isale_rentdetail(rentdetail_code,rentdetail_name,rentdetail_price,rentdetail_currentprice,rent_code,rentdetail_remark) 
			values(_rentdetail_code,'日租扣费',_rent_price,_rent_currentprice,_rent_code,CONCAT('货品：',_product_name,' SKU：',_product_sku,' ,入库时间：',_storage_intime,' ,日租扣费：',_space_usedbulk_m3,'m³×',_price_feecoefficient,'元/m³/天'));
			
			update isale_user set user_rent_price = _rent_currentprice where user_code = _user_code;	
			
			update isale_spacedetaillog set feetime = _current_time where product_code = _product_code 
			and timestampdiff(day,date_format(feetime,'%Y-%m-%d'),date_format(_current_time,'%Y-%m-%d')) = 1 ;

		END IF;

		END LOOP;
		#租户多批货位可能存在扣费和返回租金的情况,如果扣费,则需要统计扣费总和
		#select CONCAT('_rent_price_sum：',_rent_price_sum);
		IF _rent_price_sum > 0 THEN
			select user_rent_price into _rent_currentprice_sum from isale_user where user_code = _user_code;
			#select CONVERT(_space_usedbulk_m3_sum,DECIMAL(20,6)) into _space_usedbulk_m3_sum_float;
		 # select TRUNCATE(_space_usedbulk_m3_sum_float,6) into _space_usedbulk_m3_sum_float;
			insert into isale_rent(rent_code,rent_price,rent_remark,rent_type,rent_currentprice,user_code) 
			values(_rent_code,_rent_price_sum,'',3,_rent_currentprice_sum,_user_code);
		END IF;
	 /*关闭光标*/ 
		CLOSE payment_userlist; 

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_rent_b
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_rent_b`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_rent_b`(_user_code varchar(500),_current_time varchar(500))
BEGIN
	 DECLARE _product_name VARCHAR(500);													#货品名称
	 DECLARE _product_code varchar(500);													#货品编码
	 DECLARE _space_usedbulk VARCHAR(500);												#货位使用体积
	 DECLARE _space_usedbulk_m3 VARCHAR(500);											#货位使用 换成立方米
	 DECLARE _space_usedbulk_m3_sum VARCHAR(500) DEFAULT 0;				#货位使用立方米总和
	 DECLARE _space_usedbulk_m3_sum_float DECIMAL(20,6);					#货位使用立方米总和
	 DECLARE _payment_time VARCHAR(500);													#库存货位中间表付费时间
	 DECLARE _storage_intime varchar(500);												#库存入库时间
	 DECLARE _rentrule_short VARCHAR(500);												#短租(金额/天)
	 DECLARE _rentrule_long  VARCHAR(500);												#长租(金额/天)
	 DECLARE _rentrule_longnorms  VARCHAR(500);      							#长租规格(多少天算长租)
	 DECLARE _time_diff VARCHAR(50);															#系统时间-库存入库时间
	 DECLARE _user_rent_price VARCHAR(50);												#用户余额
	 DECLARE _rent_currentprice VARCHAR(500);											#操作后的金额
	 DECLARE _rent_price VARCHAR(500);														#租金   
	 DECLARE _rent_currentprice_sum VARCHAR(500) DEFAULT 0;				#操作后的金额
	 DECLARE _rent_price_sum VARCHAR(500) DEFAULT 0;							#租金   
	 DECLARE _rent_price_left VARCHAR(20);												#租金左边数据
	 DECLARE _rent_price_right VARCHAR(20);												#租金右侧数据
	 DECLARE _rent_price_back VARCHAR(500);												#超过长租返回金额
	 DECLARE _feecoefficient_standard VARCHAR(5);									#用户扣费系数
	 DECLARE _rent_code VARCHAR(500);															#租金收费编码
	 DECLARE _rentdetail_code VARCHAR(500);												#租金收费明细编码
   DECLARE _price_feecoefficient VARCHAR(500);									#租金*用户扣费系数
   DECLARE done, error BOOLEAN DEFAULT FALSE;										#遍历数据结束标志
		
		
	 #定义游标
	 DECLARE payment_userlist CURSOR FOR 
	 (
		 #查询系统前一天的上架货品
		 select distinct sdl.product_code,sdl.product_name,(sdl.space_count*sdl.product_bulk) space_usedbulk,sdl.feetime payment_time,sdl.addtime storage_intime from isale_spacedetaillog sdl
		 inner join isale_space ss on sdl.space_code = ss.space_code
		 inner join isale_user u on u.user_code = sdl.user_code
		 where  u.user_code = _user_code and sdl.task_type = 1
		 and timestampdiff(day,date_format(sdl.feetime,'%Y-%m-%d'),date_format('2017-07-08','%Y-%m-%d')) = 1 
		 group by sdl.product_code,date_format(sdl.feetime,'%Y-%m-%d')
	 );

	 #解决mysql游标错误
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
 	 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET error = TRUE,done=TRUE;
   DECLARE CONTINUE HANDLER FOR 1329 SET done = TRUE;

	 #查询租金规则
	 select rentrule_short,rentrule_long,rentrule_longnorms into _rentrule_short,_rentrule_long,_rentrule_longnorms from isale_rentrule;
	 #租金收费父编码
	 set _rent_code = CONCAT('400',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));

	 #打开光标
   OPEN payment_userlist; 
	
	 #循环执行
	 read_loop: LOOP 
			 FETCH payment_userlist INTO _product_code,_product_name,_space_usedbulk,_payment_time,_storage_intime;
		IF done THEN
      LEAVE read_loop;
    END IF;
		#------------执行业务逻辑

		set _rentdetail_code = CONCAT('401',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));
		#查询库存入库时间差
		select timestampdiff(day,date_format(_storage_intime,'%Y-%m-%d'),date_format(_current_time,'%Y-%m-%d')) into _time_diff;
		#查询用户当前金额
		select user_rent_price into _user_rent_price from isale_user where user_code = _user_code;
		#查询用户扣费系数,为null则默认为1
		select IFNULL(feecoefficient_standard,1) into _feecoefficient_standard from isale_feecoefficient where user_code=_user_code;
		#货位使用体积  立方毫米转换立方米
		set _space_usedbulk_m3 = _space_usedbulk/1000000000;
	
		#select CONCAT('货品：',_product_name,'入库时间差：',_time_diff,' 货位体积m³：',_space_usedbulk_m3,' 扣费系数：',_feecoefficient_standard);

		#如果系统时间-入库时间=长租时间 就按长租收费,需要把短租收费换成长租收费-->(短租金额-长租金额)*该货位体积*扣费系数,写入租金日志
		IF _time_diff = _rentrule_longnorms THEN
			set _rent_price_back = (_rentrule_short-_rentrule_long)*_rentrule_longnorms*_space_usedbulk_m3*_feecoefficient_standard;
			#select CONCAT('退还原始租金：',_rent_price_back);
			#整数 从小数点第三位开始截断,判断如果大于0,则小数点第二位加1,否则直接截断
			IF LOCATE('.',_rent_price_back) = 0 THEN
					set _rent_price_back = _rent_price_back;
			ELSE#小数
					set _rent_price_left = substring(_rent_price_back,1,LOCATE('.',_rent_price_back)+2);
					set _rent_price_right = replace(substring(_rent_price_back,LOCATE('.',_rent_price_back)+3),'0','');
					#select CONCAT('短租变长租_rent_price_left：',_rent_price_left,'_rent_price_right：',_rent_price_right);
					IF LENGTH(_rent_price_right) = 0 THEN
							#select '小数点第三位没有了';
							set _rent_price_back = _rent_price_left;
					ELSE
						IF _rent_price_right > 0 THEN
							#select '小数点第三位后大于0';
							set _rent_price_back = CONVERT(_rent_price_left,DECIMAL(20,2))+0.01;
						ELSE
							set _rent_price_back = _rent_price_left;
						END IF;
					END IF;
			END IF;

			set _rent_currentprice = CONVERT(_user_rent_price,DECIMAL(20,2)) + CONVERT(_rent_price_back,DECIMAL(20,2));
	
			insert into isale_rent(rent_code,rent_price,rent_remark,rent_type,rent_currentprice,user_code) 
			values(_rent_code,_rent_price_back,CONCAT('租用体积：',_space_usedbulk_m3,'m³ ,退还租金：',_rent_price_back,'元/m³'),1,_rent_currentprice,_user_code);

			update isale_spacedetaillog set feetime = _current_time where product_code = _product_code 
			and timestampdiff(day,date_format(feetime,'%Y-%m-%d'),date_format(_current_time,'%Y-%m-%d')) = 1 ; 

			update isale_user set user_rent_price = _user_rent_price+_rent_price_back where user_code = _user_code;
			
		#如果系统时间-入库时间>长租时间 就按长租收费,长租金额*货位体积*系数 写入租金日志明细表
		ELSEIF _time_diff > _rentrule_longnorms THEN
			set _price_feecoefficient = _rentrule_long * _feecoefficient_standard;
			set _rent_price =  _space_usedbulk_m3 * _price_feecoefficient;
			#select CONCAT('长租原始金额：',_rent_price);
			#整数
			IF LOCATE('.',_rent_price) = 0 THEN
					set _rent_price = _rent_price;
			ELSE#小数
					set _rent_price_left = substring(_rent_price,1,LOCATE('.',_rent_price)+2);
					set _rent_price_right = replace(substring(_rent_price,LOCATE('.',_rent_price)+3),'0','');
					#select CONCAT('长租扣费_rent_price_left：',_rent_price_left,' _rent_price_right：',_rent_price_right);
					IF LENGTH(_rent_price_right) = 0 THEN
							#select '小数点第三位没有了';
							set _rent_price = _rent_price_left;
					ELSE
						IF _rent_price_right > 0 THEN
							#select '小数点第三位后大于0';
							set _rent_price = CONVERT(_rent_price_left,DECIMAL(20,2))+0.01;
						ELSE
							set _rent_price = _rent_price_left;
						END IF;
					END IF;
			END IF;
			
			set _rent_currentprice = CONVERT(_user_rent_price,DECIMAL(20,2)) - CONVERT(_rent_price,DECIMAL(20,2));
			#select CONCAT('_rent_currentprice：',_rent_currentprice);
			set _rent_price_sum = CONVERT(_rent_price_sum,DECIMAL(20,2)) + CONVERT(_rent_price,DECIMAL(20,2));
			#select CONCAT('_rent_price_sum：',_rent_price_sum);
			#set _rent_currentprice_sum = CONVERT(_rent_currentprice_sum,DECIMAL(20,2)) + CONVERT(_rent_currentprice,DECIMAL(20,2));
			#select CONCAT('_rent_currentprice_sum：',_rent_currentprice_sum);
			
			#select CONCAT('_space_usedbulk_m3：',_space_usedbulk_m3);
			set _space_usedbulk_m3_sum = CONVERT(_space_usedbulk_m3_sum,DECIMAL(20,6)) + CONVERT(_space_usedbulk_m3,DECIMAL(20,6));
			#select CONCAT('_space_usedbulk_m3_sum：',_space_usedbulk_m3_sum);
			
			insert into isale_rentdetail(rentdetail_code,rentdetail_name,rentdetail_price,rentdetail_currentprice,rent_code,rentdetail_remark) 
			values(_rentdetail_code,'日租扣费',_rent_price,_rent_currentprice,_rent_code,CONCAT('货品：',_product_name,' ,入库时间：',_storage_intime,' ,日租扣费：',_storagespace_usedbulk_m3,'m³×',_price_feecoefficient,'元/m³/天'));
		
			update isale_user set user_rent_price = _rent_currentprice where user_code = _user_code;			
			
			update isale_spacedetaillog set feetime = _current_time where product_code = _product_code 
			and timestampdiff(day,date_format(feetime,'%Y-%m-%d'),date_format(_current_time,'%Y-%m-%d')) = 1 ;

		#如果系统时间-入库时间<长租时间 就按短租收费,短租金额*货位体积*系数 写入租金日志明细表
		ELSE
			set _price_feecoefficient = _rentrule_short * _feecoefficient_standard;
			set _rent_price =  _space_usedbulk_m3 * _price_feecoefficient;
			#select CONCAT('短租原始金额：',_rent_price);
			#整数
			IF LOCATE('.',_rent_price) = 0 THEN
				set _rent_price = _rent_price;
			ELSE#小数
					set _rent_price_left = substring(_rent_price,1,LOCATE('.',_rent_price)+2);
					set _rent_price_right = replace(substring(_rent_price,LOCATE('.',_rent_price)+3),'0','');
					#select CONCAT('短租金额：',_rent_price,'_rent_price_left：',_rent_price_left,'_rent_price_right：',_rent_price_right);
					IF LENGTH(_rent_price_right) = 0 THEN
							#select '小数点第三位没有了';
							set _rent_price = _rent_price_left;
					ELSE
						IF _rent_price_right > 0 THEN
							#select '小数点第三位后大于0';
							set _rent_price = CONVERT(_rent_price_left,DECIMAL(20,2))+0.01;
						ELSE
							set _rent_price = _rent_price_left;
						END IF;
					END IF;
			END IF;
			
			set _rent_currentprice = CONVERT(_user_rent_price,DECIMAL(20,2)) - CONVERT(_rent_price,DECIMAL(20,2));
			set _rent_price_sum = CONVERT(_rent_price_sum,DECIMAL(20,2)) + CONVERT(_rent_price,DECIMAL(20,2));
			set _space_usedbulk_m3_sum = CONVERT(_space_usedbulk_m3_sum,DECIMAL(20,6)) + CONVERT(_space_usedbulk_m3,DECIMAL(20,6));

			insert into isale_rentdetail(rentdetail_code,rentdetail_name,rentdetail_price,rentdetail_currentprice,rent_code,rentdetail_remark) 
			values(_rentdetail_code,'日租扣费',_rent_price,_rent_currentprice,_rent_code,CONCAT('货品：',_product_name,' ,入库时间：',_storage_intime,' ,日租扣费：',_storagespace_usedbulk_m3,'m³×',_price_feecoefficient,'元/m³/天'));
			
			update isale_user set user_rent_price = _rent_currentprice where user_code = _user_code;	
			
			update isale_spacedetaillog set feetime = _current_time where product_code = _product_code 
			and timestampdiff(day,date_format(feetime,'%Y-%m-%d'),date_format(_current_time,'%Y-%m-%d')) = 1 ;

		END IF;

		END LOOP;
		#租户多批货位可能存在扣费和返回租金的情况,如果扣费,则需要统计扣费总和
		#select CONCAT('_rent_price_sum：',_rent_price_sum);
		IF _rent_price_sum > 0 THEN
			select user_rent_price into _rent_currentprice_sum from isale_user where user_code = _user_code;
			#select CONVERT(_space_usedbulk_m3_sum,DECIMAL(20,6)) into _space_usedbulk_m3_sum_float;
		 # select TRUNCATE(_space_usedbulk_m3_sum_float,6) into _space_usedbulk_m3_sum_float;
			insert into isale_rent(rent_code,rent_price,rent_remark,rent_type,rent_currentprice,user_code) 
			values(_rent_code,_rent_price_sum,'',3,_rent_currentprice_sum,_user_code);
		END IF;
	 /*关闭光标*/ 
		CLOSE payment_userlist; 

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_rent_inorder
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_rent_inorder`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_rent_inorder`(_user_code varchar(500),_product_code varchar(500),_product_name varchar(500),_product_sku varchar(500),_space_usedbulk varchar(500))
BEGIN
	 DECLARE _space_usedbulk_m3 VARCHAR(500);											#货位使用体积
	 DECLARE _space_usedbulk_m3_sum VARCHAR(500) DEFAULT 0;				#货位使用立方米总和
	 DECLARE _space_usedbulk_m3_sum_float DECIMAL(20,6);					#货位使用立方米总和
	 DECLARE _rentrule_short VARCHAR(500);												#短租(金额/天)
	 DECLARE _rentrule_long  VARCHAR(500);												#长租(金额/天)
	 DECLARE _rentrule_longnorms  VARCHAR(500);      							#长租规格(多少天算长租)
	 DECLARE _user_rent_price VARCHAR(50);												#用户余额
	 DECLARE _rent_currentprice VARCHAR(500);											#操作后的金额
	 DECLARE _rent_price VARCHAR(500);														#租金   
	 DECLARE _rent_currentprice_sum VARCHAR(500) DEFAULT 0;				#操作后的金额
	 DECLARE _rent_price_sum VARCHAR(500) DEFAULT 0;							#租金   
	 DECLARE _rent_price_left VARCHAR(20);												#租金左边数据
	 DECLARE _rent_price_right VARCHAR(20);												#租金右侧数据
	 DECLARE _rent_price_back VARCHAR(500);												#超过长租返回金额
	 DECLARE _feecoefficient_standard VARCHAR(5);									#用户扣费系数
	 DECLARE _rent_code VARCHAR(500);															#租金收费系统编码
	 DECLARE _rentdetail_code VARCHAR(500);												#租金收费明细编码
   DECLARE _price_feecoefficient VARCHAR(500);									#租金*用户扣费系数		
	
	  #资金收费编码
	 set _rent_code = CONCAT('400',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));
	 #资金明细编码
	 set _rentdetail_code = CONCAT('401',unix_timestamp(NOW()),FLOOR(RAND()*9999999 + 99999999999));
	 #查询租金规则
	 select rentrule_short,rentrule_long,rentrule_longnorms into _rentrule_short,_rentrule_long,_rentrule_longnorms from isale_rentrule;
	 #查询用户当前金额
	 select user_rent_price into _user_rent_price from isale_user where user_code = _user_code;
	 #查询用户扣费系数,为null则默认为1
	 select IFNULL(feecoefficient_standard,1) into _feecoefficient_standard from isale_feecoefficient where user_code=_user_code;
	 IF _feecoefficient_standard IS NULL THEN
			SET _feecoefficient_standard = 1;
	 END IF;

	#货位使用体积  立方毫米转换立方米
	 set _space_usedbulk_m3 = _space_usedbulk/1000000000;
	
	 SELECT CONCAT('_product_name：',_product_name);
   SELECT CONCAT('_space_usedbulk_m3：',_space_usedbulk_m3);
	 SELECT CONCAT('_feecoefficient_standard：',_feecoefficient_standard);

	 #select CONCAT('货品：',_product_name,' 暂用体积m³：',_space_usedbulk_m3,' 扣费系数：',_feecoefficient_standard);
		
	 set _price_feecoefficient = _rentrule_short * _feecoefficient_standard;
	 set _rent_price =  _space_usedbulk_m3 * _price_feecoefficient;
	 #select CONCAT('入库扣费：',_rent_price);

		#整数
	 IF LOCATE('.',_rent_price) = 0 THEN
			set _rent_price = _rent_price;
	 ELSE#小数
				set _rent_price_left = substring(_rent_price,1,LOCATE('.',_rent_price)+2);
				set _rent_price_right = replace(substring(_rent_price,LOCATE('.',_rent_price)+3),'0','');
				#select CONCAT('短租金额：',_rent_price,'_rent_price_left：',_rent_price_left,'_rent_price_right：',_rent_price_right);
				IF LENGTH(_rent_price_right) = 0 THEN
						#select '小数点第三位没有了';
						set _rent_price = _rent_price_left;
				ELSE
					IF _rent_price_right > 0 THEN
						#select '小数点第三位后大于0';
						set _rent_price = CONVERT(_rent_price_left,DECIMAL(20,2))+0.01;
					ELSE
						set _rent_price = _rent_price_left;
					END IF;
				END IF;
		END IF;
		
		set _rent_currentprice = CONVERT(_user_rent_price,DECIMAL(20,2)) - CONVERT(_rent_price,DECIMAL(20,2));
		set _rent_price_sum = CONVERT(_rent_price_sum,DECIMAL(20,2)) + CONVERT(_rent_price,DECIMAL(20,2));
		set _space_usedbulk_m3_sum = CONVERT(_space_usedbulk_m3_sum,DECIMAL(20,6)) + CONVERT(_space_usedbulk_m3,DECIMAL(20,6));
		
		select user_rent_price into _rent_currentprice_sum from isale_user where user_code = _user_code;
		
		insert into isale_rent(rent_code,rent_price,rent_remark,rent_type,rent_currentprice,user_code) 
		values(_rent_code,_rent_price_sum,'',3,_rent_currentprice_sum,_user_code);

		insert into isale_rentdetail(rentdetail_code,rentdetail_name,rentdetail_price,rentdetail_currentprice,rent_code,rentdetail_remark) 
		values(_rentdetail_code,'日租扣费',_rent_price,_rent_currentprice,_rent_code,CONCAT('货品：',_product_name,' ,SKU：',_product_sku,' ,入库时间：',NOW(),' ,日租扣费：',_space_usedbulk_m3,'m³×',_price_feecoefficient,'元/m³/天'));
		
		update isale_user set user_rent_price = _rent_currentprice where user_code = _user_code;	

END
;;
DELIMITER ;

-- ----------------------------
-- Event structure for event_proc_move_auto
-- ----------------------------
DROP EVENT IF EXISTS `event_proc_move_auto`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` EVENT `event_proc_move_auto` ON SCHEDULE EVERY 1 SECOND STARTS '2017-07-28 11:05:00' ON COMPLETION PRESERVE ENABLE DO CALL proc_rent_auto_a(SYSDATE())
;;
DELIMITER ;

-- ----------------------------
-- Event structure for event_proc_move_autoRecommend_bh
-- ----------------------------
DROP EVENT IF EXISTS `event_proc_move_autoRecommend_bh`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` EVENT `event_proc_move_autoRecommend_bh` ON SCHEDULE EVERY 1 MINUTE STARTS '2017-07-26 00:00:00' ON COMPLETION PRESERVE ENABLE DO CALL proc_move_autoRecommend_bh_all_1()
;;
DELIMITER ;
