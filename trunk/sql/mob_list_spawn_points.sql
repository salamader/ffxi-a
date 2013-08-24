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
INSERT INTO `mob_list_spawn_points` VALUES ('447', '4', '6.190', '2.000', '-6.617', '165', '185');
INSERT INTO `mob_list_spawn_points` VALUES ('448', '5', '3.923', '2.000', '-11.662', '202', '185');
INSERT INTO `mob_list_spawn_points` VALUES ('449', '6', '2.567', '2.000', '-11.400', '135', '185');
INSERT INTO `mob_list_spawn_points` VALUES ('450', '7', '1.108', '2.000', '-10.835', '169', '185');
INSERT INTO `mob_list_spawn_points` VALUES ('451', '8', '-0.796', '2.000', '-10.678', '154', '185');
INSERT INTO `mob_list_spawn_points` VALUES ('452', '9', '-3.039', '2.000', '-10.152', '211', '185');
INSERT INTO `mob_list_spawn_points` VALUES ('453', '10', '-4.695', '2.000', '-10.960', '138', '185');
INSERT INTO `mob_list_spawn_points` VALUES ('454', '11', '-4.967', '2.000', '-11.639', '80', '185');
INSERT INTO `mob_list_spawn_points` VALUES ('455', '12', '-7.997', '2.000', '-14.180', '123', '185');
INSERT INTO `mob_list_spawn_points` VALUES ('456', '13', '-7.748', '2.000', '-15.775', '57', '185');
INSERT INTO `mob_list_spawn_points` VALUES ('457', '14', '-8.957', '2.000', '-16.252', '112', '185');
INSERT INTO `mob_list_spawn_points` VALUES ('458', '15', '-12.453', '2.000', '-17.626', '112', '185');
INSERT INTO `mob_list_spawn_points` VALUES ('459', '16', '-14.708', '2.000', '-19.311', '109', '185');
INSERT INTO `mob_list_spawn_points` VALUES ('460', '17', '-17.035', '2.000', '-22.368', '101', '185');
INSERT INTO `mob_list_spawn_points` VALUES ('461', '18', '-18.518', '2.000', '-22.297', '110', '185');
INSERT INTO `mob_list_spawn_points` VALUES ('462', '19', '-20.771', '2.000', '-21.688', '117', '185');
INSERT INTO `mob_list_spawn_points` VALUES ('463', '20', '-29.346', '2.000', '-21.891', '122', '185');
INSERT INTO `mob_list_spawn_points` VALUES ('464', '220', '-31.370', '2.000', '-23.285', '116', '185');
INSERT INTO `mob_list_spawn_points` VALUES ('465', '222', '-32.396', '2.000', '-22.264', '127', '185');
