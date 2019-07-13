/*
Navicat MySQL Data Transfer

Source Server         : test
Source Server Version : 50615
Source Host           : localhost:3306
Source Database       : test

Target Server Type    : MYSQL
Target Server Version : 50615
File Encoding         : 65001

Date: 2019-07-13 09:42:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for leaves
-- ----------------------------
DROP TABLE IF EXISTS `leaves`;
CREATE TABLE `leaves` (
  `Lid` bigint(20) NOT NULL AUTO_INCREMENT,
  `id` bigint(20) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `days` decimal(20,2) DEFAULT NULL,
  `adminid` bigint(20) DEFAULT NULL,
  `adminname` varchar(255) DEFAULT NULL,
  `kind` varchar(255) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Lid`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of leaves
-- ----------------------------
INSERT INTO `leaves` VALUES ('4', '10', 'yi', '2019-04-27 00:00:00', '2019-05-26 00:00:00', '4.00', null, 'admin', '护理假', '回家', '同意', '早去早回');
INSERT INTO `leaves` VALUES ('19', '10', 'yi', '2019-06-19 00:00:00', '2019-06-29 00:00:00', '10.00', '12', 'ti', '事假', '78977', '不同意', '464456');
INSERT INTO `leaves` VALUES ('20', '10', 'yi', '2019-06-06 00:00:00', '2019-06-12 00:00:00', '6.00', '12', 'ti', '事假', '8879798', '同意', '112131');
INSERT INTO `leaves` VALUES ('21', '10', 'yi', '2019-06-05 00:00:00', '2019-06-08 00:00:00', '3.00', '12', 'ti', '其他', '798789', '同意', '456456');
INSERT INTO `leaves` VALUES ('22', '12', 'ti', '2019-06-12 00:00:00', '2019-06-28 00:00:00', '16.00', '12', 'ti', '产假', '456', '不同意', '7987889');
INSERT INTO `leaves` VALUES ('23', '12', 'ti', '2019-06-12 21:02:12', '2019-06-14 07:01:10', '1.00', '12', 'ti', '事假', '87989', '同意', '897');
INSERT INTO `leaves` VALUES ('52', '10', 'yi', '2019-06-14 00:00:00', '2019-06-28 00:00:00', '14.00', '12', 'ti', '护理假', '897', '不同意', '645');
INSERT INTO `leaves` VALUES ('58', '10', 'yi', '2019-06-18 00:00:00', '2019-06-19 17:00:00', '1.00', '12', 'ti', '事假', '8979', '不同意', '87');
INSERT INTO `leaves` VALUES ('59', '10', 'yi', '2019-06-13 00:00:00', '2019-06-20 00:00:00', '7.00', '12', 'ti', '事假', '4654', '同意', '5456');
INSERT INTO `leaves` VALUES ('62', '12', 'ti', '2019-06-05 00:00:00', '2019-06-20 00:00:00', '15.00', '11', 'zi', '事假', '8799', '同意', '64564');
INSERT INTO `leaves` VALUES ('63', '12', 'ti', '2019-06-06 00:00:00', '2019-06-12 00:00:00', '6.00', '11', 'zi', '年休', '787', '同意', '14654');
INSERT INTO `leaves` VALUES ('68', '10', 'yi', '2019-06-14 00:00:00', '2019-06-27 00:00:00', '13.00', '12', 'ti', '事假', '8699786', '同意', '8798798');
INSERT INTO `leaves` VALUES ('72', '10', 'yi', '2019-06-06 00:00:00', '2019-06-22 00:00:00', '16.00', '11', 'zi', '事假', '8899', '同意', '978');
INSERT INTO `leaves` VALUES ('76', '11', 'zi', '2019-06-15 00:00:00', '2019-06-20 00:00:00', '5.00', '12', 'ti', '事假', '87987', '同意', '546546456');
INSERT INTO `leaves` VALUES ('78', '12', 'ti', '2019-06-14 00:00:00', '2019-06-19 00:00:00', '5.00', null, null, '事假', '46456', '待审批', null);
