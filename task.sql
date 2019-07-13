/*
Navicat MySQL Data Transfer

Source Server         : test
Source Server Version : 50615
Source Host           : localhost:3306
Source Database       : test

Target Server Type    : MYSQL
Target Server Version : 50615
File Encoding         : 65001

Date: 2019-07-13 09:42:54
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task` (
  `tid` bigint(20) NOT NULL AUTO_INCREMENT,
  `taskname` varchar(255) DEFAULT NULL,
  `pid` bigint(20) DEFAULT NULL,
  `uid` bigint(20) DEFAULT NULL,
  `upassword` varchar(255) DEFAULT NULL,
  `tstate` varchar(255) DEFAULT NULL,
  `taskexplain` varchar(255) DEFAULT NULL,
  `taskdocument` varchar(255) DEFAULT NULL,
  `starttime` datetime DEFAULT NULL,
  `endtime` datetime DEFAULT NULL,
  `expectdays` bigint(20) DEFAULT NULL,
  `factdays` bigint(20) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `proname` varchar(255) DEFAULT NULL,
  `rname` varchar(255) DEFAULT NULL,
  `reid` bigint(20) DEFAULT NULL,
  `taskupload` varchar(255) DEFAULT NULL,
  `texpecttime` datetime DEFAULT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task
-- ----------------------------
INSERT INTO `task` VALUES ('34', '病毒杀手任务一', '82', '49', '1234', '已完成', '病毒杀手病毒杀手狂欢节可好看了就', '病毒杀手任务一.docx', '2019-07-15 00:00:00', '2019-08-23 00:00:00', '49', '30', 'a1', '病毒杀手', 'z', null, '病毒杀手任务一代码包 .docx', '2019-09-12 00:00:00');
INSERT INTO `task` VALUES ('35', '病毒杀手任务二', '82', '50', '1234', '已完成', '病毒杀手病毒杀手狂欢节可好看了就二二二二二二二二', '病毒杀手任务二.docx', '2019-07-15 00:00:00', '2019-08-30 00:00:00', '50', '35', 'a2', '病毒杀手', 'z', null, '病毒杀手任务二代码包.docx', '2019-09-12 00:00:00');
INSERT INTO `task` VALUES ('37', '健康速测任务一', '84', '52', '1234', '开发中', '健康速测任务一健康速测任务一健康速测任务一', '健康速测任务一.docx', '2019-07-17 00:00:00', null, '52', '0', 'b1', '健康速测', 'z', null, null, '2019-08-28 00:00:00');
INSERT INTO `task` VALUES ('38', '龙族特效一', '85', '53', '1234', '开发中', '龙族特效一龙族特效一龙族特效一', '龙族特效一.docx', '2019-07-18 00:00:00', null, '53', '0', 'c1', '龙族特效', 'z', null, null, '2019-09-01 00:00:00');
INSERT INTO `task` VALUES ('39', '龙族特效二', '85', '54', '1234', '开发中', '龙族特效二龙族特效二龙族特效二龙族特效二', '龙族特效二.docx', '2019-07-18 00:00:00', null, '54', '0', 'c2', '龙族特效', 'z', null, null, '2019-09-01 00:00:00');
INSERT INTO `task` VALUES ('40', '无人驾驶任务一', '90', '55', '1234', '开发中', '无人驾驶任务一无人驾驶任务一无人驾驶任务一', '无人驾驶任务一 .docx', '2019-07-16 00:00:00', null, '55', '0', 'd1', '无人驾驶', 'z', null, null, '2019-08-29 00:00:00');
