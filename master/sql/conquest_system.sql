/*
MySQL Data Transfer
Source Host: localhost
Source Database: database
Target Host: localhost
Target Database: database
Date: 9/14/2013 10:55:52 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for conquest_system
-- ----------------------------
CREATE TABLE `conquest_system` (
  `region_id` tinyint(2) NOT NULL DEFAULT '0',
  `region_control` tinyint(2) NOT NULL DEFAULT '0',
  `sandoria_influence` int(10) NOT NULL DEFAULT '0',
  `bastok_influence` int(10) NOT NULL DEFAULT '0',
  `windurst_influence` int(10) NOT NULL DEFAULT '0',
  `beastmen_influence` int(10) NOT NULL DEFAULT '0',
  `graphics_arrows` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`region_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `conquest_system` VALUES ('0', '0', '5', '0', '0', '24', '64');
INSERT INTO `conquest_system` VALUES ('1', '1', '0', '0', '0', '0', '0');
INSERT INTO `conquest_system` VALUES ('2', '0', '2', '4', '0', '0', '13');
INSERT INTO `conquest_system` VALUES ('3', '0', '10', '7', '0', '36', '64');
INSERT INTO `conquest_system` VALUES ('4', '2', '0', '0', '0', '24', '64');
INSERT INTO `conquest_system` VALUES ('5', '1', '0', '0', '1', '12', '64');
INSERT INTO `conquest_system` VALUES ('6', '1', '0', '0', '0', '0', '0');
INSERT INTO `conquest_system` VALUES ('7', '2', '129', '0', '0', '0', '3');
INSERT INTO `conquest_system` VALUES ('8', '1', '0', '0', '0', '0', '0');
INSERT INTO `conquest_system` VALUES ('9', '2', '0', '0', '0', '0', '0');
INSERT INTO `conquest_system` VALUES ('10', '2', '1', '9', '0', '0', '12');
INSERT INTO `conquest_system` VALUES ('11', '1', '4', '14', '0', '0', '12');
INSERT INTO `conquest_system` VALUES ('12', '0', '0', '0', '0', '0', '0');
INSERT INTO `conquest_system` VALUES ('13', '2', '0', '0', '0', '12', '64');
INSERT INTO `conquest_system` VALUES ('14', '2', '0', '5', '0', '0', '12');
INSERT INTO `conquest_system` VALUES ('15', '0', '0', '0', '0', '0', '0');
INSERT INTO `conquest_system` VALUES ('16', '0', '0', '0', '0', '0', '0');
INSERT INTO `conquest_system` VALUES ('17', '1', '0', '2', '0', '0', '46');
INSERT INTO `conquest_system` VALUES ('18', '0', '0', '0', '0', '0', '0');
