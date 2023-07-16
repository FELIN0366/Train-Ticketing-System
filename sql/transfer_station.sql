drop table if exists `city_station`;
create table `city_station` (
                                `id` bigint not null comment 'id',
                                `city_name`varchar(20) not null comment '城市名',
                                `station_name`varchar(20)not null comment '站点名',
                                primary key (`id`)
) engine=innodb default charset=utf8mb4 comment='城市内站点';

drop table if exists `graph`;
create table `graph` (
                             `id` bigint not null comment 'id',
                             `start_city`varchar(20) not null comment '出发城市',
                             `end_city`varchar(20) not null comment '到达城市',
                             `timediff`datetime comment '时间间隔',
                             `start_date`datetime comment '发车日期',
                             primary key (`id`)
) engine=innodb default charset=utf8mb4 comment='城市时间图';



drop table if exists `city_train`;
create table `city_train` (
                         `id` bigint not null comment 'id',
                         `city_name`varchar(20) not null comment '城市名',
                         `train_code`bigint not null comment '列车编号',
                         `date`datetime comment '发车日期',
                         primary key (`id`)
) engine=innodb default charset=utf8mb4 comment='城市时间图';

drop table if exists `train`;
create table `train` (
                              `train_code`bigint not null comment '列车编号',
                              `start` varchar(20) not null comment '发车站点',
                              `start_pinyin` varchar(20) not null comment '发车站点拼音',
                              `end` varchar(20) not null comment '收车站点',
                              `end_pinyin` varchar(20) not null comment  '收车站点拼音',
                              `start_time` datetime comment '发车时间',
                              `end_time` datetime comment '收车时间',
                              `create_time` datetime comment'创建时间',
                              `update_time` datetime comment '更新时间',
                              primary key (`train_code`)
) engine=innodb default charset=utf8mb4 comment='列车';

drop table if exists `station`;
create table `station` (
                              `train_code`bigint not null comment '列车编号',
                              `station_NO`bigint not null comment '站点号',
                              `name` varchar(20) not null comment '站点名',
                              `name_pinyin` varchar(20) not null comment '站点拼音',
                              `start_time` datetime not null comment '该站点发车时间',
                              `duration` datetime not null comment '该站点至下一站点的时间间隔',
                              `create_time` datetime comment'创建时间',
                              `update_time` datetime comment '更新时间',
                              primary key (`train_code`,`station_NO`)
) engine=innodb default charset=utf8mb4 comment='站点';

drop table if exists `carriage`;
create table `carriage` (
                           `train_code`bigint not null comment '列车编号',
                           `station_NO`bigint not null comment '站点号',
                           `carriage_index` bigint not null comment  '车厢号',
                           `seat_type` bigint not null comment '座位类型|枚举[SeatTypeEnum]',
                           `col_count` bigint not null comment '列数',
                           `row_count` bigint not null comment '行数',
                           `seat_count` bigint not null comment '座位余量',
                           `create_time` datetime comment'创建时间',
                           `update_time` datetime comment '更新时间',
                           primary key (`train_code`,`station_NO`,`carriage_index`)
) engine=innodb default charset=utf8mb4 comment='站点';




