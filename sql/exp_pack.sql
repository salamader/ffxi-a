/*
MySQL Data Transfer
Source Host: localhost
Source Database: database
Target Host: localhost
Target Database: database
Date: 9/14/2013 10:56:45 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for exp_base
-- ----------------------------
CREATE TABLE `exp_base` (
  `level` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `exp` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`level`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=9;

-- ----------------------------
-- Table structure for exp_table
-- ----------------------------
CREATE TABLE `exp_table` (
  `level` tinyint(2) NOT NULL,
  `r1` smallint(4) unsigned NOT NULL DEFAULT '0',
  `r2` smallint(4) unsigned NOT NULL DEFAULT '0',
  `r3` smallint(4) unsigned NOT NULL DEFAULT '0',
  `r4` smallint(4) unsigned NOT NULL DEFAULT '0',
  `r5` smallint(4) unsigned NOT NULL DEFAULT '0',
  `r6` smallint(4) unsigned NOT NULL DEFAULT '0',
  `r7` smallint(4) unsigned NOT NULL DEFAULT '0',
  `r8` smallint(4) unsigned NOT NULL DEFAULT '0',
  `r9` smallint(4) unsigned NOT NULL DEFAULT '0',
  `r10` smallint(4) unsigned NOT NULL DEFAULT '0',
  `r11` smallint(4) unsigned NOT NULL DEFAULT '0',
  `r12` smallint(4) unsigned NOT NULL DEFAULT '0',
  `r13` smallint(4) unsigned NOT NULL DEFAULT '0',
  `r14` smallint(4) unsigned NOT NULL DEFAULT '0',
  `r15` smallint(4) unsigned NOT NULL DEFAULT '0',
  `r16` smallint(4) unsigned NOT NULL DEFAULT '0',
  `r17` smallint(4) unsigned NOT NULL DEFAULT '0',
  `r18` smallint(4) unsigned NOT NULL DEFAULT '0',
  `r19` smallint(4) unsigned NOT NULL DEFAULT '0',
  `r20` smallint(4) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`level`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=65;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `exp_base` VALUES ('1', '0');
INSERT INTO `exp_base` VALUES ('2', '500');
INSERT INTO `exp_base` VALUES ('3', '750');
INSERT INTO `exp_base` VALUES ('4', '1000');
INSERT INTO `exp_base` VALUES ('5', '1250');
INSERT INTO `exp_base` VALUES ('6', '1500');
INSERT INTO `exp_base` VALUES ('7', '1750');
INSERT INTO `exp_base` VALUES ('8', '2000');
INSERT INTO `exp_base` VALUES ('9', '2200');
INSERT INTO `exp_base` VALUES ('10', '2400');
INSERT INTO `exp_base` VALUES ('11', '2600');
INSERT INTO `exp_base` VALUES ('12', '2800');
INSERT INTO `exp_base` VALUES ('13', '3000');
INSERT INTO `exp_base` VALUES ('14', '3200');
INSERT INTO `exp_base` VALUES ('15', '3400');
INSERT INTO `exp_base` VALUES ('16', '3600');
INSERT INTO `exp_base` VALUES ('17', '3800');
INSERT INTO `exp_base` VALUES ('18', '4000');
INSERT INTO `exp_base` VALUES ('19', '4200');
INSERT INTO `exp_base` VALUES ('20', '4400');
INSERT INTO `exp_base` VALUES ('21', '4600');
INSERT INTO `exp_base` VALUES ('22', '4800');
INSERT INTO `exp_base` VALUES ('23', '5000');
INSERT INTO `exp_base` VALUES ('24', '5100');
INSERT INTO `exp_base` VALUES ('25', '5200');
INSERT INTO `exp_base` VALUES ('26', '5300');
INSERT INTO `exp_base` VALUES ('27', '5400');
INSERT INTO `exp_base` VALUES ('28', '5500');
INSERT INTO `exp_base` VALUES ('29', '5600');
INSERT INTO `exp_base` VALUES ('30', '5700');
INSERT INTO `exp_base` VALUES ('31', '5800');
INSERT INTO `exp_base` VALUES ('32', '5900');
INSERT INTO `exp_base` VALUES ('33', '6000');
INSERT INTO `exp_base` VALUES ('34', '6100');
INSERT INTO `exp_base` VALUES ('35', '6200');
INSERT INTO `exp_base` VALUES ('36', '6300');
INSERT INTO `exp_base` VALUES ('37', '6400');
INSERT INTO `exp_base` VALUES ('38', '6500');
INSERT INTO `exp_base` VALUES ('39', '6600');
INSERT INTO `exp_base` VALUES ('40', '6700');
INSERT INTO `exp_base` VALUES ('41', '6800');
INSERT INTO `exp_base` VALUES ('42', '6900');
INSERT INTO `exp_base` VALUES ('43', '7000');
INSERT INTO `exp_base` VALUES ('44', '7100');
INSERT INTO `exp_base` VALUES ('45', '7200');
INSERT INTO `exp_base` VALUES ('46', '7300');
INSERT INTO `exp_base` VALUES ('47', '7400');
INSERT INTO `exp_base` VALUES ('48', '7500');
INSERT INTO `exp_base` VALUES ('49', '7600');
INSERT INTO `exp_base` VALUES ('50', '7700');
INSERT INTO `exp_base` VALUES ('51', '7800');
INSERT INTO `exp_base` VALUES ('52', '8000');
INSERT INTO `exp_base` VALUES ('53', '9200');
INSERT INTO `exp_base` VALUES ('54', '10400');
INSERT INTO `exp_base` VALUES ('55', '11600');
INSERT INTO `exp_base` VALUES ('56', '12800');
INSERT INTO `exp_base` VALUES ('57', '14000');
INSERT INTO `exp_base` VALUES ('58', '15200');
INSERT INTO `exp_base` VALUES ('59', '16400');
INSERT INTO `exp_base` VALUES ('60', '17600');
INSERT INTO `exp_base` VALUES ('61', '18800');
INSERT INTO `exp_base` VALUES ('62', '20000');
INSERT INTO `exp_base` VALUES ('63', '21500');
INSERT INTO `exp_base` VALUES ('64', '23000');
INSERT INTO `exp_base` VALUES ('65', '24500');
INSERT INTO `exp_base` VALUES ('66', '26000');
INSERT INTO `exp_base` VALUES ('67', '27500');
INSERT INTO `exp_base` VALUES ('68', '29000');
INSERT INTO `exp_base` VALUES ('69', '30500');
INSERT INTO `exp_base` VALUES ('70', '32000');
INSERT INTO `exp_base` VALUES ('71', '34000');
INSERT INTO `exp_base` VALUES ('72', '36000');
INSERT INTO `exp_base` VALUES ('73', '38000');
INSERT INTO `exp_base` VALUES ('74', '40000');
INSERT INTO `exp_base` VALUES ('75', '42000');
INSERT INTO `exp_base` VALUES ('76', '44000');
INSERT INTO `exp_base` VALUES ('77', '44500');
INSERT INTO `exp_base` VALUES ('78', '45000');
INSERT INTO `exp_base` VALUES ('79', '45500');
INSERT INTO `exp_base` VALUES ('80', '46000');
INSERT INTO `exp_base` VALUES ('81', '46500');
INSERT INTO `exp_base` VALUES ('82', '47000');
INSERT INTO `exp_base` VALUES ('83', '47500');
INSERT INTO `exp_base` VALUES ('84', '48000');
INSERT INTO `exp_base` VALUES ('85', '48500');
INSERT INTO `exp_base` VALUES ('86', '49000');
INSERT INTO `exp_base` VALUES ('87', '49500');
INSERT INTO `exp_base` VALUES ('88', '50000');
INSERT INTO `exp_base` VALUES ('89', '50500');
INSERT INTO `exp_base` VALUES ('90', '51000');
INSERT INTO `exp_base` VALUES ('91', '51500');
INSERT INTO `exp_base` VALUES ('92', '52000');
INSERT INTO `exp_base` VALUES ('93', '52500');
INSERT INTO `exp_base` VALUES ('94', '53000');
INSERT INTO `exp_base` VALUES ('95', '53500');
INSERT INTO `exp_base` VALUES ('96', '54000');
INSERT INTO `exp_base` VALUES ('97', '54500');
INSERT INTO `exp_base` VALUES ('98', '55000');
INSERT INTO `exp_base` VALUES ('99', '55500');
INSERT INTO `exp_base` VALUES ('100', '56000');
INSERT INTO `exp_table` VALUES ('15', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800');
INSERT INTO `exp_table` VALUES ('14', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800', '720', '720', '720', '640', '640', '640', '640', '640');
INSERT INTO `exp_table` VALUES ('13', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800', '630', '630', '630', '580', '580', '580', '580', '580');
INSERT INTO `exp_table` VALUES ('12', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800', '580', '580', '580', '520', '520', '520', '520', '520');
INSERT INTO `exp_table` VALUES ('11', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800', '580', '530', '530', '530', '460', '460', '460', '460', '460');
INSERT INTO `exp_table` VALUES ('10', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800', '800', '530', '480', '480', '480', '430', '430', '430', '430', '430');
INSERT INTO `exp_table` VALUES ('9', '800', '800', '800', '800', '800', '800', '600', '600', '600', '600', '530', '480', '440', '440', '440', '400', '400', '400', '400', '400');
INSERT INTO `exp_table` VALUES ('8', '600', '600', '600', '600', '600', '600', '550', '550', '550', '530', '480', '430', '400', '400', '400', '380', '380', '380', '380', '380');
INSERT INTO `exp_table` VALUES ('7', '550', '550', '550', '550', '550', '550', '500', '500', '500', '470', '430', '380', '360', '360', '360', '340', '340', '340', '340', '340');
INSERT INTO `exp_table` VALUES ('6', '450', '450', '450', '450', '450', '450', '450', '450', '450', '400', '370', '330', '320', '320', '320', '300', '300', '300', '300', '300');
INSERT INTO `exp_table` VALUES ('5', '350', '350', '350', '350', '350', '350', '400', '400', '400', '340', '310', '280', '280', '280', '280', '260', '260', '260', '260', '260');
INSERT INTO `exp_table` VALUES ('4', '200', '200', '200', '200', '200', '200', '300', '300', '300', '270', '250', '240', '240', '240', '240', '230', '230', '230', '230', '230');
INSERT INTO `exp_table` VALUES ('3', '160', '160', '160', '160', '160', '160', '200', '200', '200', '200', '200', '200', '200', '200', '200', '220', '220', '220', '220', '220');
INSERT INTO `exp_table` VALUES ('2', '140', '140', '140', '140', '140', '140', '150', '150', '150', '150', '150', '160', '160', '160', '160', '180', '180', '180', '180', '180');
INSERT INTO `exp_table` VALUES ('1', '120', '120', '120', '120', '120', '120', '125', '125', '125', '125', '125', '130', '130', '130', '130', '140', '140', '140', '140', '140');
INSERT INTO `exp_table` VALUES ('0', '100', '100', '100', '100', '100', '100', '100', '100', '100', '100', '100', '100', '100', '100', '100', '100', '100', '100', '100', '100');
INSERT INTO `exp_table` VALUES ('-1', '90', '90', '90', '90', '90', '90', '93', '95', '95', '95', '96', '96', '96', '96', '96', '97', '97', '97', '98', '98');
INSERT INTO `exp_table` VALUES ('-2', '80', '80', '80', '80', '80', '80', '86', '86', '90', '90', '93', '93', '93', '93', '94', '95', '95', '95', '96', '96');
INSERT INTO `exp_table` VALUES ('-3', '70', '70', '75', '75', '75', '75', '75', '80', '86', '86', '88', '88', '91', '91', '92', '92', '92', '92', '93', '93');
INSERT INTO `exp_table` VALUES ('-4', '65', '65', '70', '70', '70', '70', '72', '76', '80', '80', '82', '84', '86', '86', '90', '90', '90', '90', '90', '90');
INSERT INTO `exp_table` VALUES ('-5', '60', '60', '65', '65', '65', '65', '68', '72', '76', '76', '78', '80', '83', '83', '86', '86', '86', '86', '87', '87');
INSERT INTO `exp_table` VALUES ('-6', '50', '50', '60', '60', '60', '60', '65', '70', '72', '72', '74', '76', '80', '80', '83', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-7', '0', '40', '50', '50', '55', '55', '60', '65', '68', '68', '70', '72', '76', '77', '80', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-8', '0', '30', '40', '40', '50', '50', '55', '60', '65', '65', '68', '68', '73', '75', '77', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-9', '0', '0', '30', '30', '40', '40', '50', '55', '60', '60', '65', '65', '70', '72', '75', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-10', '0', '0', '0', '0', '30', '30', '40', '50', '55', '56', '60', '62', '66', '70', '73', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-11', '0', '0', '0', '0', '0', '0', '30', '40', '50', '53', '56', '58', '63', '66', '70', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-12', '0', '0', '0', '0', '0', '0', '0', '30', '40', '50', '53', '56', '60', '63', '66', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-13', '0', '0', '0', '0', '0', '0', '0', '0', '30', '40', '50', '53', '56', '60', '63', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-14', '0', '0', '0', '0', '0', '0', '0', '0', '0', '30', '40', '50', '53', '56', '60', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-15', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '30', '40', '50', '53', '56', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-16', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '30', '40', '50', '53', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-17', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '30', '40', '50', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-18', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '30', '40', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-19', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '30', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-20', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-23', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-24', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-25', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-26', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-27', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-28', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-29', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-30', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-31', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-32', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-33', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `exp_table` VALUES ('-34', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
