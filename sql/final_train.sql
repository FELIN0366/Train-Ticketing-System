/*
Navicat MySQL Data Transfer

Source Server         : 本机
Source Server Version : 50724
Source Host           : localhost:3306
Source Database       : train

Target Server Type    : MYSQL
Target Server Version : 50724
File Encoding         : 65001

Date: 2023-06-30 00:40:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for city
-- ----------------------------
DROP TABLE IF EXISTS `city`;
CREATE TABLE `city` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `city_name` varchar(11) DEFAULT NULL COMMENT '城市名称',
  `station` varchar(11) DEFAULT NULL COMMENT '站点',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='城市';

-- ----------------------------
-- Records of city
-- ----------------------------
INSERT INTO `city` VALUES ('5555', 'shanghai', 'shanghaibei');

-- ----------------------------
-- Table structure for daily_train
-- ----------------------------
DROP TABLE IF EXISTS `daily_train`;
CREATE TABLE `daily_train` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `date` date NOT NULL COMMENT '日期',
  `code` varchar(20) NOT NULL COMMENT '车次编号',
  `type` char(1) NOT NULL COMMENT '车次类型|枚举[TrainTypeEnum]',
  `start` varchar(20) NOT NULL COMMENT '始发站',
  `start_pinyin` varchar(50) NOT NULL COMMENT '始发站拼音',
  `start_time` time NOT NULL COMMENT '出发时间',
  `end` varchar(20) NOT NULL COMMENT '终点站',
  `end_pinyin` varchar(50) NOT NULL COMMENT '终点站拼音',
  `end_time` time NOT NULL COMMENT '到站时间',
  `create_time` datetime(3) DEFAULT NULL COMMENT '新增时间',
  `update_time` datetime(3) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `date_code_unique` (`date`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='每日车次';

-- ----------------------------
-- Records of daily_train
-- ----------------------------
INSERT INTO `daily_train` VALUES ('1674337165334679552', '2023-06-29', 'G1', 'D', '上海', 'shanghai', '17:02:03', '广州', 'guangzhou', '20:02:14', '2023-06-29 16:41:02.547', '2023-06-29 16:41:02.547');
INSERT INTO `daily_train` VALUES ('1674337221286694912', '2023-06-29', 'G2', 'G', '广州', 'guangzhou', '11:11:00', '北京西', 'beijingxi', '12:12:00', '2023-06-29 16:41:15.893', '2023-06-29 16:41:15.893');
INSERT INTO `daily_train` VALUES ('1674337271651897344', '2023-06-16', 'D3', 'D', '广州', 'guangzhou', '00:08:00', '上海', 'shanghai', '05:48:50', '2023-06-29 16:41:27.901', '2023-06-29 16:41:27.901');
INSERT INTO `daily_train` VALUES ('1674455828184305664', '2023-06-30', 'D3', 'D', '广州', 'guangzhou', '00:08:00', '上海', 'shanghai', '05:48:50', '2023-06-30 00:32:33.970', '2023-06-30 00:32:33.970');

-- ----------------------------
-- Table structure for daily_train_carriage
-- ----------------------------
DROP TABLE IF EXISTS `daily_train_carriage`;
CREATE TABLE `daily_train_carriage` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `date` date NOT NULL COMMENT '日期',
  `train_code` varchar(20) NOT NULL COMMENT '车次编号',
  `index` int(11) NOT NULL COMMENT '箱序',
  `seat_type` char(1) NOT NULL COMMENT '座位类型|枚举[SeatTypeEnum]',
  `seat_count` int(11) NOT NULL COMMENT '座位数',
  `row_count` int(11) NOT NULL COMMENT '排数',
  `col_count` int(11) NOT NULL COMMENT '列数',
  `create_time` datetime(3) DEFAULT NULL COMMENT '新增时间',
  `update_time` datetime(3) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `date_train_code_index_unique` (`date`,`train_code`,`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='每日车箱';

-- ----------------------------
-- Records of daily_train_carriage
-- ----------------------------
INSERT INTO `daily_train_carriage` VALUES ('1674351717308829696', '2023-06-29', 'D3', '1', '1', '20', '5', '4', '2023-06-29 17:39:00.865', '2023-06-29 17:38:52.000');

-- ----------------------------
-- Table structure for daily_train_seat
-- ----------------------------
DROP TABLE IF EXISTS `daily_train_seat`;
CREATE TABLE `daily_train_seat` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `date` date NOT NULL COMMENT '日期',
  `train_code` varchar(20) NOT NULL COMMENT '车次编号',
  `carriage_index` int(11) NOT NULL COMMENT '箱序',
  `row` char(2) NOT NULL COMMENT '排号|01, 02',
  `col` char(1) NOT NULL COMMENT '列号|枚举[SeatColEnum]',
  `seat_type` char(1) NOT NULL COMMENT '座位类型|枚举[SeatTypeEnum]',
  `carriage_seat_index` int(11) NOT NULL COMMENT '同车箱座序',
  `sell` varchar(50) NOT NULL COMMENT '售卖情况|将经过的车站用01拼接，0表示可卖，1表示已卖',
  `create_time` datetime(3) DEFAULT NULL COMMENT '新增时间',
  `update_time` datetime(3) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='每日座位';

-- ----------------------------
-- Records of daily_train_seat
-- ----------------------------

-- ----------------------------
-- Table structure for daily_train_station
-- ----------------------------
DROP TABLE IF EXISTS `daily_train_station`;
CREATE TABLE `daily_train_station` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `date` date NOT NULL COMMENT '日期',
  `train_code` varchar(20) NOT NULL COMMENT '车次编号',
  `index` int(11) NOT NULL COMMENT '站序',
  `name` varchar(20) NOT NULL COMMENT '站名',
  `name_pinyin` varchar(50) NOT NULL COMMENT '站名拼音',
  `in_time` time DEFAULT NULL COMMENT '进站时间',
  `out_time` time DEFAULT NULL COMMENT '出站时间',
  `stop_time` time DEFAULT NULL COMMENT '停站时长',
  `km` decimal(8,2) NOT NULL COMMENT '里程（公里）|从上一站到本站的距离',
  `create_time` datetime(3) DEFAULT NULL COMMENT '新增时间',
  `update_time` datetime(3) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `date_train_code_index_unique` (`date`,`train_code`,`index`),
  UNIQUE KEY `date_train_code_name_unique` (`date`,`train_code`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='每日车站';

-- ----------------------------
-- Records of daily_train_station
-- ----------------------------
INSERT INTO `daily_train_station` VALUES ('1674339459170177024', '2023-06-29', 'G1', '1', '上海', 'shanghai', '16:49:54', '16:49:56', '00:00:02', '1.00', '2023-06-29 16:50:09.445', '2023-06-29 16:50:09.445');
INSERT INTO `daily_train_station` VALUES ('1674456012683350016', '2023-06-30', 'G1', '2', '广州', 'guangzhou', '00:03:00', '00:03:03', '00:00:03', '65.00', '2023-06-30 00:33:17.969', '2023-06-30 00:33:17.969');

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `mobile` varchar(11) DEFAULT NULL COMMENT '手机号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mobile_unique` (`mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员';

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES ('1685029705698', '123');
INSERT INTO `member` VALUES ('1662136973902614528', '1234');
INSERT INTO `member` VALUES ('1663183071949754368', '12345');
INSERT INTO `member` VALUES ('1664082515247370240', '12900008888');
INSERT INTO `member` VALUES ('1663188873750122496', '18022226886');
INSERT INTO `member` VALUES ('1665211876625223680', '18922226885');
INSERT INTO `member` VALUES ('1663945454506872832', '19022227998');
INSERT INTO `member` VALUES ('1685082736735', '222');
INSERT INTO `member` VALUES ('1685089041576', '233');
INSERT INTO `member` VALUES ('1685090275006', '2335');
INSERT INTO `member` VALUES ('1685094808406', '23355');
INSERT INTO `member` VALUES ('1', '233590');
INSERT INTO `member` VALUES ('8888888888888888', 'ahhhh');

-- ----------------------------
-- Table structure for passenger
-- ----------------------------
DROP TABLE IF EXISTS `passenger`;
CREATE TABLE `passenger` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `member_id` bigint(20) NOT NULL COMMENT 'member表id',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `id_card` varchar(18) NOT NULL COMMENT '身份证',
  `type` char(1) NOT NULL COMMENT '旅客类型|枚举[PassengerTypeEnum]',
  `create_time` datetime(3) DEFAULT NULL COMMENT '新增时间',
  `update_time` datetime(3) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `member_id_index` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='乘车人';

-- ----------------------------
-- Records of passenger
-- ----------------------------
INSERT INTO `passenger` VALUES ('1665281464419356672', '1663188873750122496', 'jyw', '2333', '1', '2023-06-10 14:49:16.936', '2023-06-04 16:56:55.000');
INSERT INTO `passenger` VALUES ('1665283420944732160', '1663188873750122496', 'jyw', '23333', '1', '2023-06-04 17:04:41.679', '2023-06-04 17:04:41.679');
INSERT INTO `passenger` VALUES ('1665338839050358784', '1663188873750122496', 'jyw', '23333', '1', '2023-06-04 20:44:54.378', '2023-06-04 20:44:54.378');
INSERT INTO `passenger` VALUES ('1665340311540469760', '1663188873750122496', 'jyw', '23333', '2', '2023-06-10 14:36:40.091', '2023-06-04 20:50:45.000');
INSERT INTO `passenger` VALUES ('1667746308204662784', '1663188873750122496', 'Jiayi Wang', '111222666655559998', '3', '2023-06-25 17:09:37.935', '2023-06-11 12:11:19.000');
INSERT INTO `passenger` VALUES ('1672974431179378688', '1', '汪嘉仪', '111', '1', '2023-06-25 22:26:01.392', '2023-06-25 22:26:01.392');

-- ----------------------------
drop table if exists `confirm_order`;
create table `confirm_order` (
                               `id` bigint not null comment 'id',
                               `member_id` bigint not null comment '会员id',
                               `date` date not null comment '日期',
                               `train_code` varchar(20) not null comment '车次编号',
                               `start` varchar(20) not null comment '出发站',
                               `end` varchar(20) not null comment '到达站',
                               `daily_train_ticket_id` bigint not null comment '余票ID',
                               `tickets` json not null comment '车票',
                               `status` char(1) not null comment '订单状态|枚举[ConfirmOrderStatusEnum]',
                               `create_time` datetime(3) comment '新增时间',
                               `update_time` datetime(3) comment '修改时间',
                               primary key (`id`),
                               index `date_train_code_index` (`date`, `train_code`)
) engine=innodb default charset=utf8mb4 comment='确认订单';

-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '定时任务名称',
  `TRIGGER_NAME` varchar(200) NOT NULL COMMENT '触发器名称',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
  `BLOB_DATA` blob COMMENT '数据',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '定时任务名称',
  `CALENDAR_NAME` varchar(200) NOT NULL COMMENT '日程名称',
  `CALENDAR` blob NOT NULL COMMENT '日程数据',
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '定时任务名称',
  `TRIGGER_NAME` varchar(200) NOT NULL COMMENT '触发器名称',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
  `CRON_EXPRESSION` varchar(200) NOT NULL COMMENT 'cron表达式',
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '定时任务名称',
  `ENTRY_ID` varchar(95) NOT NULL COMMENT 'entryId',
  `TRIGGER_NAME` varchar(200) NOT NULL COMMENT '触发器名称',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
  `INSTANCE_NAME` varchar(200) NOT NULL COMMENT '实例名称',
  `FIRED_TIME` bigint(13) NOT NULL COMMENT '执行时间',
  `SCHED_TIME` bigint(13) NOT NULL COMMENT '定时任务时间',
  `PRIORITY` int(11) NOT NULL COMMENT '等级',
  `STATE` varchar(16) NOT NULL COMMENT '状态',
  `JOB_NAME` varchar(200) DEFAULT NULL COMMENT 'job名称',
  `JOB_GROUP` varchar(200) DEFAULT NULL COMMENT 'job组',
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL COMMENT '是否异步',
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL COMMENT '是否请求覆盖',
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '定时任务名称',
  `JOB_NAME` varchar(200) NOT NULL COMMENT 'job名称',
  `JOB_GROUP` varchar(200) NOT NULL COMMENT 'job组',
  `DESCRIPTION` varchar(250) DEFAULT NULL COMMENT '描述',
  `JOB_CLASS_NAME` varchar(250) NOT NULL COMMENT 'job类名',
  `IS_DURABLE` varchar(1) NOT NULL COMMENT '是否持久化',
  `IS_NONCONCURRENT` varchar(1) NOT NULL COMMENT '是否非同步',
  `IS_UPDATE_DATA` varchar(1) NOT NULL COMMENT '是否更新数据',
  `REQUESTS_RECOVERY` varchar(1) NOT NULL COMMENT '请求是否覆盖',
  `JOB_DATA` blob COMMENT 'job数据',
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '定时任务名称',
  `LOCK_NAME` varchar(40) NOT NULL COMMENT 'lock名称',
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('schedulerFactoryBean', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '定时任务名称',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '定时任务名称',
  `INSTANCE_NAME` varchar(200) NOT NULL COMMENT '实例名称',
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL COMMENT '最近检入时间',
  `CHECKIN_INTERVAL` bigint(13) NOT NULL COMMENT '检入间隔',
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '定时任务名称',
  `TRIGGER_NAME` varchar(200) NOT NULL COMMENT '触发器名称',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
  `REPEAT_COUNT` bigint(7) NOT NULL COMMENT '重复执行次数',
  `REPEAT_INTERVAL` bigint(12) NOT NULL COMMENT '重复执行间隔',
  `TIMES_TRIGGERED` bigint(10) NOT NULL COMMENT '已经触发次数',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '定时任务名称',
  `TRIGGER_NAME` varchar(200) NOT NULL COMMENT '触发器名称',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
  `STR_PROP_1` varchar(512) DEFAULT NULL COMMENT '开始配置1',
  `STR_PROP_2` varchar(512) DEFAULT NULL COMMENT '开始配置2',
  `STR_PROP_3` varchar(512) DEFAULT NULL COMMENT '开始配置3',
  `INT_PROP_1` int(11) DEFAULT NULL COMMENT 'int配置1',
  `INT_PROP_2` int(11) DEFAULT NULL COMMENT 'int配置2',
  `LONG_PROP_1` bigint(20) DEFAULT NULL COMMENT 'long配置1',
  `LONG_PROP_2` bigint(20) DEFAULT NULL COMMENT 'long配置2',
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL COMMENT '配置描述1',
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL COMMENT '配置描述2',
  `BOOL_PROP_1` varchar(1) DEFAULT NULL COMMENT 'bool配置1',
  `BOOL_PROP_2` varchar(1) DEFAULT NULL COMMENT 'bool配置2',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '定时任务名称',
  `TRIGGER_NAME` varchar(200) NOT NULL COMMENT '触发器名称',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
  `JOB_NAME` varchar(200) NOT NULL COMMENT 'job名称',
  `JOB_GROUP` varchar(200) NOT NULL COMMENT 'job组',
  `DESCRIPTION` varchar(250) DEFAULT NULL COMMENT '描述',
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL COMMENT '下一次触发时间',
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL COMMENT '前一次触发时间',
  `PRIORITY` int(11) DEFAULT NULL COMMENT '等级',
  `TRIGGER_STATE` varchar(16) NOT NULL COMMENT '触发状态',
  `TRIGGER_TYPE` varchar(8) NOT NULL COMMENT '触发类型',
  `START_TIME` bigint(13) NOT NULL COMMENT '开始时间',
  `END_TIME` bigint(13) DEFAULT NULL COMMENT '结束时间',
  `CALENDAR_NAME` varchar(200) DEFAULT NULL COMMENT '日程名称',
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL COMMENT '未触发实例',
  `JOB_DATA` blob COMMENT 'job数据',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for station
-- ----------------------------
DROP TABLE IF EXISTS `station`;
CREATE TABLE `station` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `name` varchar(20) NOT NULL COMMENT '站名',
  `name_pinyin` varchar(50) NOT NULL COMMENT '站名拼音',
  `name_py` varchar(50) NOT NULL COMMENT '站名拼音首字母',
  `create_time` datetime(3) DEFAULT NULL COMMENT '新增时间',
  `update_time` datetime(3) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='车站';

-- ----------------------------
-- Records of station
-- ----------------------------
INSERT INTO `station` VALUES ('1673349983669194752', '上海', 'shanghai', 'sh', '2023-06-27 03:24:26.099', '2023-06-26 23:18:20.000');
INSERT INTO `station` VALUES ('1673412194496286720', '北京西', 'beijingxi', 'bjx', '2023-06-27 03:25:32.316', '2023-06-27 03:25:32.316');
INSERT INTO `station` VALUES ('1673412277337985024', '广州', 'guangzhou', 'gz', '2023-06-27 03:25:52.070', '2023-06-27 03:25:52.070');
INSERT INTO `station` VALUES ('1673456649379123200', '广州1', 'guangzhou1', 'gz1', '2023-06-27 06:22:11.187', '2023-06-27 06:22:11.187');

-- ----------------------------
-- Table structure for train
-- ----------------------------
DROP TABLE IF EXISTS `train`;
CREATE TABLE `train` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `code` varchar(20) NOT NULL COMMENT '车次编号',
  `type` char(1) NOT NULL COMMENT '车次类型|枚举[TrainTypeEnum]',
  `start` varchar(20) NOT NULL COMMENT '始发站',
  `start_pinyin` varchar(50) NOT NULL COMMENT '始发站拼音',
  `start_time` time NOT NULL COMMENT '出发时间',
  `end` varchar(20) NOT NULL COMMENT '终点站',
  `end_pinyin` varchar(50) NOT NULL COMMENT '终点站拼音',
  `end_time` time NOT NULL COMMENT '到站时间',
  `create_time` datetime(3) DEFAULT NULL COMMENT '新增时间',
  `update_time` datetime(3) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='车次';

-- ----------------------------
-- Records of train
-- ----------------------------
INSERT INTO `train` VALUES ('1673357024034951168', 'G2', 'G', '广州', 'guangzhou', '11:11:00', '北京西', 'beijingxi', '12:12:00', '2023-06-27 04:02:16.734', '2023-06-26 23:46:18.000');
INSERT INTO `train` VALUES ('1673363352069476352', 'G1', 'D', '上海', 'shanghai', '17:02:03', '广州', 'guangzhou', '20:02:14', '2023-06-27 03:26:18.027', '2023-06-27 00:11:27.000');
INSERT INTO `train` VALUES ('1673448262524342272', 'D3', 'D', '广州', 'guangzhou', '00:08:00', '上海', 'shanghai', '05:48:50', '2023-06-27 05:48:51.608', '2023-06-27 05:48:51.608');

-- ----------------------------
-- Table structure for train_carriage
-- ----------------------------
DROP TABLE IF EXISTS `train_carriage`;
CREATE TABLE `train_carriage` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `train_code` varchar(20) NOT NULL COMMENT '车次编号',
  `index` int(11) NOT NULL COMMENT '厢号',
  `seat_type` char(1) NOT NULL COMMENT '座位类型|枚举[SeatTypeEnum]',
  `seat_count` int(11) NOT NULL COMMENT '座位数',
  `row_count` int(11) NOT NULL COMMENT '排数',
  `col_count` int(11) NOT NULL COMMENT '列数',
  `create_time` datetime(3) DEFAULT NULL COMMENT '新增时间',
  `update_time` datetime(3) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `train_code_index_unique` (`train_code`,`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='火车车厢';

-- ----------------------------
-- Records of train_carriage
-- ----------------------------
INSERT INTO `train_carriage` VALUES ('1673394764621418496', 'G1', '3', '2', '25', '5', '5', '2023-06-27 04:28:42.744', '2023-06-27 02:16:16.000');
INSERT INTO `train_carriage` VALUES ('1673453593832853504', 'G1', '5', '1', '24', '6', '4', '2023-06-27 06:10:02.645', '2023-06-27 06:10:02.645');
INSERT INTO `train_carriage` VALUES ('1673454057085341696', 'G2', '4', '1', '20', '5', '4', '2023-06-27 06:11:53.139', '2023-06-27 06:11:53.139');
INSERT INTO `train_carriage` VALUES ('1674456147437948928', 'D3', '3', '2', '30', '6', '5', '2023-06-30 00:33:50.081', '2023-06-30 00:33:50.081');

-- ----------------------------
-- Table structure for train_seat
-- ----------------------------
DROP TABLE IF EXISTS `train_seat`;
CREATE TABLE `train_seat` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `train_code` varchar(20) NOT NULL COMMENT '车次编号',
  `carriage_index` int(11) NOT NULL COMMENT '厢序',
  `row` char(2) NOT NULL COMMENT '排号|01, 02 两位数表示',
  `col` char(1) NOT NULL COMMENT '列号|枚举[SeatColEnum]',
  `seat_type` char(1) NOT NULL COMMENT '座位类型|枚举[SeatTypeEnum]',
  `carriage_seat_index` int(11) NOT NULL COMMENT '同车厢座位序',
  `create_time` datetime(3) DEFAULT NULL COMMENT '新增时间',
  `update_time` datetime(3) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='座位';

-- ----------------------------
-- Records of train_seat
-- ----------------------------
INSERT INTO `train_seat` VALUES ('1673447185154445312', 'G1', '3', '01', 'A', '2', '1', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185167028224', 'G1', '3', '01', 'B', '2', '2', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185171222528', 'G1', '3', '01', 'C', '2', '3', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185179611136', 'G1', '3', '01', 'D', '2', '4', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185183805440', 'G1', '3', '01', 'F', '2', '5', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185192194048', 'G1', '3', '02', 'A', '2', '6', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185196388352', 'G1', '3', '02', 'B', '2', '7', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185200582656', 'G1', '3', '02', 'C', '2', '8', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185204776960', 'G1', '3', '02', 'D', '2', '9', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185208971264', 'G1', '3', '02', 'F', '2', '10', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185217359872', 'G1', '3', '03', 'A', '2', '11', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185221554176', 'G1', '3', '03', 'B', '2', '12', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185225748480', 'G1', '3', '03', 'C', '2', '13', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185229942784', 'G1', '3', '03', 'D', '2', '14', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185238331392', 'G1', '3', '03', 'F', '2', '15', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185242525696', 'G1', '3', '04', 'A', '2', '16', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185250914304', 'G1', '3', '04', 'B', '2', '17', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185255108608', 'G1', '3', '04', 'C', '2', '18', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185259302912', 'G1', '3', '04', 'D', '2', '19', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185263497216', 'G1', '3', '04', 'F', '2', '20', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185267691520', 'G1', '3', '05', 'A', '2', '21', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185271885824', 'G1', '3', '05', 'B', '2', '22', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185276080128', 'G1', '3', '05', 'C', '2', '23', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185280274432', 'G1', '3', '05', 'D', '2', '24', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185288663040', 'G1', '3', '05', 'F', '2', '25', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185297051648', 'G1', '3', '06', 'A', '2', '26', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185301245952', 'G1', '3', '06', 'B', '2', '27', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185305440256', 'G1', '3', '06', 'C', '2', '28', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185313828864', 'G1', '3', '06', 'D', '2', '29', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673447185318023168', 'G1', '3', '06', 'F', '2', '30', '2023-06-27 05:44:34.725', '2023-06-27 05:44:34.725');
INSERT INTO `train_seat` VALUES ('1673454121245609984', 'G2', '4', '01', 'A', '1', '1', '2023-06-27 06:12:08.414', '2023-06-27 06:12:08.414');
INSERT INTO `train_seat` VALUES ('1673454121258192896', 'G2', '4', '01', 'C', '1', '2', '2023-06-27 06:12:08.414', '2023-06-27 06:12:08.414');
INSERT INTO `train_seat` VALUES ('1673454121266581504', 'G2', '4', '01', 'D', '1', '3', '2023-06-27 06:12:08.414', '2023-06-27 06:12:08.414');
INSERT INTO `train_seat` VALUES ('1673454121279164416', 'G2', '4', '01', 'F', '1', '4', '2023-06-27 06:12:08.414', '2023-06-27 06:12:08.414');
INSERT INTO `train_seat` VALUES ('1673454121283358720', 'G2', '4', '02', 'A', '1', '5', '2023-06-27 06:12:08.414', '2023-06-27 06:12:08.414');
INSERT INTO `train_seat` VALUES ('1673454121291747328', 'G2', '4', '02', 'C', '1', '6', '2023-06-27 06:12:08.414', '2023-06-27 06:12:08.414');
INSERT INTO `train_seat` VALUES ('1673454121308524544', 'G2', '4', '02', 'D', '1', '7', '2023-06-27 06:12:08.414', '2023-06-27 06:12:08.414');
INSERT INTO `train_seat` VALUES ('1673454121316913152', 'G2', '4', '02', 'F', '1', '8', '2023-06-27 06:12:08.414', '2023-06-27 06:12:08.414');
INSERT INTO `train_seat` VALUES ('1673454121325301760', 'G2', '4', '03', 'A', '1', '9', '2023-06-27 06:12:08.414', '2023-06-27 06:12:08.414');
INSERT INTO `train_seat` VALUES ('1673454121329496064', 'G2', '4', '03', 'C', '1', '10', '2023-06-27 06:12:08.414', '2023-06-27 06:12:08.414');
INSERT INTO `train_seat` VALUES ('1673454121342078976', 'G2', '4', '03', 'D', '1', '11', '2023-06-27 06:12:08.414', '2023-06-27 06:12:08.414');
INSERT INTO `train_seat` VALUES ('1673454121350467584', 'G2', '4', '03', 'F', '1', '12', '2023-06-27 06:12:08.414', '2023-06-27 06:12:08.414');
INSERT INTO `train_seat` VALUES ('1673454121358856192', 'G2', '4', '04', 'A', '1', '13', '2023-06-27 06:12:08.414', '2023-06-27 06:12:08.414');
INSERT INTO `train_seat` VALUES ('1673454121363050496', 'G2', '4', '04', 'C', '1', '14', '2023-06-27 06:12:08.414', '2023-06-27 06:12:08.414');
INSERT INTO `train_seat` VALUES ('1673454121371439104', 'G2', '4', '04', 'D', '1', '15', '2023-06-27 06:12:08.414', '2023-06-27 06:12:08.414');
INSERT INTO `train_seat` VALUES ('1673454121371439105', 'G2', '4', '04', 'F', '1', '16', '2023-06-27 06:12:08.414', '2023-06-27 06:12:08.414');
INSERT INTO `train_seat` VALUES ('1673454121388216320', 'G2', '4', '05', 'A', '1', '17', '2023-06-27 06:12:08.414', '2023-06-27 06:12:08.414');
INSERT INTO `train_seat` VALUES ('1673454121396604928', 'G2', '4', '05', 'C', '1', '18', '2023-06-27 06:12:08.414', '2023-06-27 06:12:08.414');
INSERT INTO `train_seat` VALUES ('1673454121400799232', 'G2', '4', '05', 'D', '1', '19', '2023-06-27 06:12:08.414', '2023-06-27 06:12:08.414');
INSERT INTO `train_seat` VALUES ('1673454121409187840', 'G2', '4', '05', 'F', '1', '20', '2023-06-27 06:12:08.414', '2023-06-27 06:12:08.414');
INSERT INTO `train_seat` VALUES ('1674456213930250240', 'D3', '3', '01', 'A', '2', '1', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456213972193280', 'D3', '3', '01', 'B', '2', '2', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456213972193281', 'D3', '3', '01', 'C', '2', '3', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214014136320', 'D3', '3', '01', 'D', '2', '4', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214014136321', 'D3', '3', '01', 'F', '2', '5', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214056079360', 'D3', '3', '02', 'A', '2', '6', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214056079361', 'D3', '3', '02', 'B', '2', '7', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214139965440', 'D3', '3', '02', 'C', '2', '8', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214144159744', 'D3', '3', '02', 'D', '2', '9', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214186102784', 'D3', '3', '02', 'F', '2', '10', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214198685696', 'D3', '3', '03', 'A', '2', '11', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214228045824', 'D3', '3', '03', 'B', '2', '12', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214228045825', 'D3', '3', '03', 'C', '2', '13', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214274183168', 'D3', '3', '03', 'D', '2', '14', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214274183169', 'D3', '3', '03', 'F', '2', '15', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214311931904', 'D3', '3', '04', 'A', '2', '16', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214353874944', 'D3', '3', '04', 'B', '2', '17', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214404206592', 'D3', '3', '04', 'C', '2', '18', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214404206593', 'D3', '3', '04', 'D', '2', '19', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214605533184', 'D3', '3', '04', 'F', '2', '20', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214639087616', 'D3', '3', '05', 'A', '2', '21', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214655864832', 'D3', '3', '05', 'B', '2', '22', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214676836352', 'D3', '3', '05', 'C', '2', '23', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214676836353', 'D3', '3', '05', 'D', '2', '24', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214710390784', 'D3', '3', '05', 'F', '2', '25', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214710390785', 'D3', '3', '06', 'A', '2', '26', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214739750912', 'D3', '3', '06', 'B', '2', '27', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214739750913', 'D3', '3', '06', 'C', '2', '28', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214739750914', 'D3', '3', '06', 'D', '2', '29', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');
INSERT INTO `train_seat` VALUES ('1674456214777499648', 'D3', '3', '06', 'F', '2', '30', '2023-06-30 00:34:05.919', '2023-06-30 00:34:05.919');

-- ----------------------------
-- Table structure for train_station
-- ----------------------------
DROP TABLE IF EXISTS `train_station`;
CREATE TABLE `train_station` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `train_code` varchar(20) NOT NULL COMMENT '车次编号',
  `index` int(11) NOT NULL COMMENT '站序',
  `name` varchar(20) NOT NULL COMMENT '站名',
  `name_pinyin` varchar(50) NOT NULL COMMENT '站名拼音',
  `in_time` time DEFAULT NULL COMMENT '进站时间',
  `out_time` time DEFAULT NULL COMMENT '出站时间',
  `stop_time` time DEFAULT NULL COMMENT '停站时长',
  `km` decimal(8,2) NOT NULL COMMENT '里程|上一站到本站距离',
  `create_time` datetime(3) DEFAULT NULL COMMENT '新增时间',
  `update_time` datetime(3) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `train_code_index_unique` (`train_code`,`index`),
  UNIQUE KEY `train_code_name_unique` (`train_code`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='火车车站';

-- ----------------------------
-- Records of train_station
-- ----------------------------
INSERT INTO `train_station` VALUES ('1673377951225352192', '134', '1', 'sd', 'sdd', '00:02:00', '00:05:00', '00:03:00', '123.00', '2023-06-27 01:09:28.087', '2023-06-27 01:09:28.087');
INSERT INTO `train_station` VALUES ('1673389205537034240', '233', '2', '广州', 'guangzhou', '00:01:00', '00:03:00', '00:02:00', '1.00', '2023-06-27 01:54:11.324', '2023-06-27 01:54:11.324');
INSERT INTO `train_station` VALUES ('1673459215257178112', 'D3', '3', '广州', 'guangzhou', '00:00:02', '03:00:02', '03:00:00', '45.00', '2023-06-27 06:32:22.938', '2023-06-27 06:32:22.938');
