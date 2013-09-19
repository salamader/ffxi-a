/*
MySQL Data Transfer
Source Host: localhost
Source Database: database
Target Host: localhost
Target Database: database
Date: 9/14/2013 11:04:06 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for water_points
-- ----------------------------
CREATE TABLE `water_points` (
  `waterid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `zoneid` smallint(3) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `pointid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `pos_x` float(7,2) NOT NULL DEFAULT '0.00',
  `pos_y` float(7,2) NOT NULL DEFAULT '0.00',
  `pos_z` float(7,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`waterid`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `water_points` VALUES ('1', '100', '0', '0', '0.00', '0.00', '0.00');
