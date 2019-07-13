/*
Navicat MySQL Data Transfer

Source Server         : test
Source Server Version : 50615
Source Host           : localhost:3306
Source Database       : test

Target Server Type    : MYSQL
Target Server Version : 50615
File Encoding         : 65001

Date: 2019-07-13 09:42:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for projects
-- ----------------------------
DROP TABLE IF EXISTS `projects`;
CREATE TABLE `projects` (
  `pid` bigint(20) NOT NULL AUTO_INCREMENT,
  `proname` varchar(255) DEFAULT NULL,
  `expecttime` datetime DEFAULT NULL,
  `prodocument` varchar(255) DEFAULT NULL,
  `pstate` varchar(255) DEFAULT NULL,
  `proexplain` varchar(255) DEFAULT NULL,
  `sendid` bigint(20) DEFAULT NULL,
  `receiveid` bigint(20) DEFAULT NULL,
  `sendname` varchar(255) DEFAULT NULL,
  `rname` varchar(255) DEFAULT NULL,
  `pstarttime` datetime DEFAULT NULL,
  `pendtime` datetime DEFAULT NULL,
  `pexpectdays` bigint(20) DEFAULT NULL,
  `pfactdays` bigint(20) DEFAULT NULL,
  `devnumbers` bigint(20) DEFAULT NULL,
  `comnumbers` bigint(20) DEFAULT NULL,
  `finalpro` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of projects
-- ----------------------------
INSERT INTO `projects` VALUES ('82', '病毒杀手', '2019-09-27 00:00:00', '病毒杀手.docx', '已验收', '病毒杀手病毒杀手病毒杀手病毒杀手病毒杀手病毒杀手病毒杀手病毒杀手病毒杀手', '12', '11', 't', 'z', '2019-07-13 06:57:55', '2019-08-30 00:00:00', '99', '65', '2', '2', '病毒杀手工程文件.docx');
INSERT INTO `projects` VALUES ('83', '导弹轨迹分析', '2019-10-09 00:00:00', '导弹轨迹分析.docx', '未发布', '导弹轨迹分析导弹轨迹分析导弹轨迹分析导弹轨迹分析导弹轨迹分析导弹轨迹分析导弹轨迹分析导弹轨迹分析', '12', null, 't', null, null, null, null, null, null, null, null);
INSERT INTO `projects` VALUES ('84', '健康速测', '2019-09-11 00:00:00', '健康速测.docx', '开发中', '健康速测健康速测健康速测健康速测', '12', '11', 't', 'z', '2019-07-13 06:57:58', null, '52', '0', '1', '0', null);
INSERT INTO `projects` VALUES ('85', '龙族特效', '2019-09-03 00:00:00', '龙族特效.docx', '开发中', '龙族特效龙族特效龙族特效龙族特效龙族特效龙族特效', '12', '11', 't', 'z', '2019-07-13 06:58:22', null, '107', '0', '2', '0', null);
INSERT INTO `projects` VALUES ('86', '气象分析', '2019-10-24 00:00:00', '气象分析.docx', '待接', '气象分析气象分析气象分析气象分析气象分析气象分析', '12', null, 't', null, null, null, null, null, null, null, null);
INSERT INTO `projects` VALUES ('87', '人流量统计', '2019-09-11 00:00:00', '人流量统计.docx', '待开发', '人流量统计人流量统计人流量统计', '12', '11', 't', 'z', '2019-07-13 06:58:24', null, null, null, null, null, null);
INSERT INTO `projects` VALUES ('88', '视频推荐', '2019-09-17 00:00:00', '视频推荐.docx', '未发布', '视频推荐视频推荐视频推荐视频推荐', '12', null, 't', null, null, null, null, null, null, null, null);
INSERT INTO `projects` VALUES ('89', '完美世界', '2019-09-18 00:00:00', '完美世界.docx', '未发布', '完美世界完美世界完美世界完美世界完美世界', '12', null, 't', null, null, null, null, null, null, null, null);
INSERT INTO `projects` VALUES ('90', '无人驾驶', '2019-10-04 00:00:00', '无人驾驶.docx', '开发中', '无人驾驶无人驾驶无人驾驶', '12', '11', 't', 'z', '2019-07-13 06:58:26', null, '55', '0', '1', '0', null);
INSERT INTO `projects` VALUES ('91', '雨量监测', '2019-09-30 00:00:00', '雨量监测.docx', '待接', '雨量监测雨量监测雨量监测雨量监测', '12', null, 't', null, null, null, null, null, null, null, null);
INSERT INTO `projects` VALUES ('92', '智能分类', '2019-10-24 00:00:00', '智能分类.docx', '未发布', '智能分类智能分类智能分类智能分类智能分类', '12', null, 't', null, null, null, null, null, null, null, null);
