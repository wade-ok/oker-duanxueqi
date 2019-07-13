/*
Navicat MySQL Data Transfer

Source Server         : test
Source Server Version : 50615
Source Host           : localhost:3306
Source Database       : test

Target Server Type    : MYSQL
Target Server Version : 50615
File Encoding         : 65001

Date: 2019-07-13 09:43:01
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `cardid` varchar(255) DEFAULT NULL,
  `repassword` varchar(255) DEFAULT NULL,
  `leadid` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('10', 'y', null, null, 'b5086d21eed73280115dd65ca4d5e84c', '67ef8a22656938f2', 'user', '100001', '1234', null);
INSERT INTO `user` VALUES ('11', 'z', null, null, 'a292ffb4a95052a8e8401667a23bc558', 'b2100304d33f08c2', 'readmin', '100002', '1234', null);
INSERT INTO `user` VALUES ('12', 't', null, null, 'bd41e38b1584edf9b43041b624abb55e', '9cdc68b14dca0741', 'sendadmin', '100003', '1234', null);
INSERT INTO `user` VALUES ('13', 'k', null, null, '355c904e586e94a5f8271480b5b7aad3', '0f965fddea3355a6', 'sendadmin', '000001', '12345', null);
INSERT INTO `user` VALUES ('49', 'za1', null, null, 'e7f94617234ee38d1c4bfc13a0231f4c', '79b25211347bf6c8', 'user', null, '1234', '11');
INSERT INTO `user` VALUES ('50', 'za2', null, null, '44930706664a865073a94e8bc70e1b36', '766cc68d93364cad', 'user', null, '1234', '11');
INSERT INTO `user` VALUES ('52', 'zb1', null, null, '907b64aa8ffbddd1c9bdbc0a746e4480', 'bc5d60c55818a7d8', 'user', null, '1234', '11');
INSERT INTO `user` VALUES ('53', 'zc1', null, null, '1f0ce1143108d8737ce6eeb13f8650a3', 'a7251de350066858', 'user', null, '1234', '11');
INSERT INTO `user` VALUES ('54', 'zc2', null, null, '7a84a875a265ed60879e8234c266928d', 'e7bda15e944201c6', 'user', null, '1234', '11');
INSERT INTO `user` VALUES ('55', 'zd1', null, null, '13e864559100e6aad31ced8c644a9b8e', '2b98c31f84c9e640', 'user', null, '1234', '11');
