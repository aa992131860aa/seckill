-- 数据库初始化脚本
-- 创建数据库
CREATE DATABASE seckill;
-- 使用数据库
use scekill;
-- 创建秒杀库存表
CREATE TABLE seckill(
`seckill_id` bigint NOT NULL AUTO_INCREMENT COMMENT '商品库存id',
`name` varchar(120) NOT NULL COMMENT '商品名称',
`number` int NOT NULL COMMENT '库存数量',
`start_time` timestamp NOT NULL COMMENT '秒杀开始时间',
`end_time` timestamp NOT NULL COMMENT '秒杀结束时间',
`create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间' ,
PRIMARY KEY (seckill_id),
key idx_start_time(start_time),
key idx_end_time(end_time),
key idx_create_time(create_time)

) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='秒杀库存表';

-- 初始化数据表
INSERT INTO seckill(name,number,start_time,end_time)
values
('1000元',100,'2017-12-26 00:00:00','2017-12-26 00:00:00'),
('500元',200,'2017-12-26 00:00:00','2017-12-26 00:00:00'),
('400元',300,'2017-12-26 00:00:00','2017-12-26 00:00:00'),
('200元',400,'2017-12-26 00:00:00','2017-12-26 00:00:00')


-- 秒杀成功明细表
-- 用户登录认证相关的信息
CREATE TABLE success_killed(
`seckill_id` bigint NOT NULL COMMENT '秒杀商品id',
`user_phone` bigint NOT NULL COMMENT '用户手机号',
`state` tinyint NOT NULL DEFAULT -1 COMMENT '状态标识：-1无效  0：成功  1：已付款',
`create_time` timestamp NOT NULL COMMENT '创建时间',
PRIMARY KEY (seckill_id,user_phone),/*联合组件*/
key idx_create_time(create_time)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='秒杀明细表';


mysql -uroot -p
-- show create table seckill\G 表的结构
mysql -u root -p
--用户修改版本
ALTER TABLE seckill
DROP INDEX idx_create_time,
ADD index inx_c_s(start_time,create_time)

