/*
MySQL Data Transfer
Source Host: localhost
Source Database: database
Target Host: localhost
Target Database: database
Date: 8/24/2013 2:49:58 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for mob_list_spawn_points
-- ----------------------------
DROP TABLE IF EXISTS `mob_list_spawn_points`;
CREATE TABLE `mob_list_spawn_points` (
  `count` int(255) NOT NULL AUTO_INCREMENT,
  `mob_id` int(10) NOT NULL,
  `pos_x` float(7,3) NOT NULL DEFAULT '0.000',
  `pos_y` float(7,3) NOT NULL DEFAULT '0.000',
  `pos_z` float(7,3) NOT NULL DEFAULT '0.000',
  `pos_rot` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `pos_zone` int(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`count`,`mob_id`)
) ENGINE=MyISAM AUTO_INCREMENT=466 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=33;

-- ----------------------------
-- Records 
-- ----------------------------
