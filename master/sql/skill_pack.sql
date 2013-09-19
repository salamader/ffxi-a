/*
MySQL Data Transfer
Source Host: localhost
Source Database: database
Target Host: localhost
Target Database: database
Date: 9/14/2013 11:03:19 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for skill_caps
-- ----------------------------
CREATE TABLE `skill_caps` (
  `level` tinyint(2) unsigned NOT NULL,
  `r0` smallint(3) unsigned NOT NULL DEFAULT '0',
  `r1` smallint(3) unsigned NOT NULL DEFAULT '0',
  `r2` smallint(3) unsigned NOT NULL DEFAULT '0',
  `r3` smallint(3) unsigned NOT NULL DEFAULT '0',
  `r4` smallint(3) unsigned NOT NULL DEFAULT '0',
  `r5` smallint(3) unsigned NOT NULL DEFAULT '0',
  `r6` smallint(3) unsigned NOT NULL DEFAULT '0',
  `r7` smallint(3) unsigned NOT NULL DEFAULT '0',
  `r8` smallint(3) unsigned NOT NULL DEFAULT '0',
  `r9` smallint(3) unsigned NOT NULL DEFAULT '0',
  `r10` smallint(3) unsigned NOT NULL DEFAULT '0',
  `r11` smallint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`level`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=32 PACK_KEYS=1 ROW_FORMAT=FIXED;

-- ----------------------------
-- Table structure for skill_ranks
-- ----------------------------
CREATE TABLE `skill_ranks` (
  `skillid` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `name` char(12) DEFAULT NULL,
  `war` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `mnk` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `whm` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `blm` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `rdm` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `thf` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `pld` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `drk` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `bst` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `brd` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `rng` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `sam` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `nin` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `drg` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `smn` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `blu` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `cor` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `pup` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `dnc` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `sch` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `geo` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `run` tinyint(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`skillid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=44 PACK_KEYS=1;

-- ----------------------------
-- Table structure for skillchain_damage_modifiers
-- ----------------------------
CREATE TABLE `skillchain_damage_modifiers` (
  `chain_level` enum('1','2','3','4') NOT NULL DEFAULT '1',
  `chain_count` enum('1','2','3','4','5') NOT NULL DEFAULT '1',
  `initial_modifier` int(3) NOT NULL DEFAULT '1',
  `magic_burst_modifier` int(3) NOT NULL DEFAULT '1',
  PRIMARY KEY (`chain_level`,`chain_count`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `skill_caps` VALUES ('0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `skill_caps` VALUES ('1', '0', '6', '6', '5', '5', '5', '5', '5', '5', '4', '4', '4');
INSERT INTO `skill_caps` VALUES ('2', '0', '9', '9', '7', '7', '7', '7', '7', '7', '6', '6', '6');
INSERT INTO `skill_caps` VALUES ('3', '0', '12', '12', '10', '10', '10', '10', '10', '10', '9', '9', '8');
INSERT INTO `skill_caps` VALUES ('4', '0', '15', '15', '13', '13', '13', '13', '13', '13', '12', '11', '10');
INSERT INTO `skill_caps` VALUES ('5', '0', '18', '18', '16', '16', '16', '16', '16', '16', '14', '14', '13');
INSERT INTO `skill_caps` VALUES ('6', '0', '21', '21', '19', '19', '19', '19', '19', '19', '17', '16', '15');
INSERT INTO `skill_caps` VALUES ('7', '0', '24', '24', '22', '22', '22', '21', '21', '21', '20', '19', '17');
INSERT INTO `skill_caps` VALUES ('8', '0', '27', '27', '25', '25', '25', '24', '24', '24', '22', '21', '20');
INSERT INTO `skill_caps` VALUES ('9', '0', '30', '30', '28', '28', '28', '27', '27', '27', '25', '24', '22');
INSERT INTO `skill_caps` VALUES ('10', '0', '33', '33', '31', '31', '31', '30', '30', '30', '28', '26', '24');
INSERT INTO `skill_caps` VALUES ('11', '0', '36', '36', '34', '34', '34', '33', '33', '33', '31', '29', '27');
INSERT INTO `skill_caps` VALUES ('12', '0', '39', '39', '36', '36', '36', '35', '35', '35', '33', '31', '29');
INSERT INTO `skill_caps` VALUES ('13', '0', '42', '42', '39', '39', '39', '38', '38', '38', '36', '34', '31');
INSERT INTO `skill_caps` VALUES ('14', '0', '45', '45', '42', '42', '42', '41', '41', '41', '39', '36', '33');
INSERT INTO `skill_caps` VALUES ('15', '0', '48', '48', '45', '45', '45', '44', '44', '44', '41', '39', '36');
INSERT INTO `skill_caps` VALUES ('16', '0', '51', '51', '48', '48', '48', '47', '47', '47', '44', '41', '38');
INSERT INTO `skill_caps` VALUES ('17', '0', '54', '54', '51', '51', '51', '49', '49', '49', '47', '44', '40');
INSERT INTO `skill_caps` VALUES ('18', '0', '57', '57', '54', '54', '54', '52', '52', '52', '49', '46', '43');
INSERT INTO `skill_caps` VALUES ('19', '0', '60', '60', '57', '57', '57', '55', '55', '55', '52', '49', '45');
INSERT INTO `skill_caps` VALUES ('20', '0', '63', '63', '60', '60', '60', '58', '58', '58', '55', '51', '47');
INSERT INTO `skill_caps` VALUES ('21', '0', '66', '66', '63', '63', '63', '61', '61', '61', '58', '54', '50');
INSERT INTO `skill_caps` VALUES ('22', '0', '69', '69', '65', '65', '65', '63', '63', '63', '60', '56', '52');
INSERT INTO `skill_caps` VALUES ('23', '0', '72', '72', '68', '68', '68', '66', '66', '66', '63', '59', '54');
INSERT INTO `skill_caps` VALUES ('24', '0', '75', '75', '71', '71', '71', '69', '69', '69', '66', '61', '56');
INSERT INTO `skill_caps` VALUES ('25', '0', '78', '78', '74', '74', '74', '72', '72', '72', '68', '64', '59');
INSERT INTO `skill_caps` VALUES ('26', '0', '81', '81', '77', '77', '77', '75', '75', '75', '71', '66', '61');
INSERT INTO `skill_caps` VALUES ('27', '0', '84', '84', '80', '80', '80', '77', '77', '77', '74', '69', '63');
INSERT INTO `skill_caps` VALUES ('28', '0', '87', '87', '83', '83', '83', '80', '80', '80', '76', '71', '66');
INSERT INTO `skill_caps` VALUES ('29', '0', '90', '90', '86', '86', '86', '83', '83', '83', '79', '74', '68');
INSERT INTO `skill_caps` VALUES ('30', '0', '93', '93', '89', '89', '89', '86', '86', '86', '82', '76', '70');
INSERT INTO `skill_caps` VALUES ('31', '0', '96', '96', '92', '92', '92', '89', '89', '89', '85', '79', '73');
INSERT INTO `skill_caps` VALUES ('32', '0', '99', '99', '94', '94', '94', '91', '91', '91', '87', '81', '75');
INSERT INTO `skill_caps` VALUES ('33', '0', '102', '102', '97', '97', '97', '94', '94', '94', '90', '84', '77');
INSERT INTO `skill_caps` VALUES ('34', '0', '105', '105', '100', '100', '100', '97', '97', '97', '93', '86', '79');
INSERT INTO `skill_caps` VALUES ('35', '0', '108', '108', '103', '103', '103', '100', '100', '100', '95', '89', '82');
INSERT INTO `skill_caps` VALUES ('36', '0', '111', '111', '106', '106', '106', '103', '103', '103', '98', '91', '84');
INSERT INTO `skill_caps` VALUES ('37', '0', '114', '114', '109', '109', '109', '105', '105', '105', '101', '94', '86');
INSERT INTO `skill_caps` VALUES ('38', '0', '117', '117', '112', '112', '112', '108', '108', '108', '103', '96', '89');
INSERT INTO `skill_caps` VALUES ('39', '0', '120', '120', '115', '115', '115', '111', '111', '111', '106', '99', '91');
INSERT INTO `skill_caps` VALUES ('40', '0', '123', '123', '118', '118', '118', '114', '114', '114', '109', '101', '93');
INSERT INTO `skill_caps` VALUES ('41', '0', '126', '126', '121', '121', '121', '117', '117', '117', '112', '104', '96');
INSERT INTO `skill_caps` VALUES ('42', '0', '129', '129', '123', '123', '123', '119', '119', '119', '114', '106', '98');
INSERT INTO `skill_caps` VALUES ('43', '0', '132', '132', '126', '126', '126', '122', '122', '122', '117', '109', '100');
INSERT INTO `skill_caps` VALUES ('44', '0', '135', '135', '129', '129', '129', '125', '125', '125', '120', '111', '102');
INSERT INTO `skill_caps` VALUES ('45', '0', '138', '138', '132', '132', '132', '128', '128', '128', '122', '114', '105');
INSERT INTO `skill_caps` VALUES ('46', '0', '141', '141', '135', '135', '135', '131', '131', '131', '125', '116', '107');
INSERT INTO `skill_caps` VALUES ('47', '0', '144', '144', '138', '138', '138', '133', '133', '133', '128', '119', '109');
INSERT INTO `skill_caps` VALUES ('48', '0', '147', '147', '141', '141', '141', '136', '136', '136', '130', '121', '112');
INSERT INTO `skill_caps` VALUES ('49', '0', '150', '150', '144', '144', '144', '139', '139', '139', '133', '124', '114');
INSERT INTO `skill_caps` VALUES ('50', '0', '153', '153', '147', '147', '147', '142', '142', '142', '136', '126', '116');
INSERT INTO `skill_caps` VALUES ('51', '0', '158', '158', '151', '151', '151', '146', '146', '146', '140', '130', '120');
INSERT INTO `skill_caps` VALUES ('52', '0', '163', '163', '156', '156', '156', '151', '151', '151', '145', '135', '124');
INSERT INTO `skill_caps` VALUES ('53', '0', '168', '168', '161', '161', '161', '156', '156', '156', '150', '139', '128');
INSERT INTO `skill_caps` VALUES ('54', '0', '173', '173', '166', '166', '166', '161', '161', '161', '154', '144', '133');
INSERT INTO `skill_caps` VALUES ('55', '0', '178', '178', '171', '171', '171', '166', '166', '166', '159', '148', '137');
INSERT INTO `skill_caps` VALUES ('56', '0', '183', '183', '176', '176', '176', '170', '170', '170', '164', '153', '141');
INSERT INTO `skill_caps` VALUES ('57', '0', '188', '188', '181', '181', '181', '175', '175', '175', '168', '157', '146');
INSERT INTO `skill_caps` VALUES ('58', '0', '193', '193', '186', '186', '186', '180', '180', '180', '173', '162', '150');
INSERT INTO `skill_caps` VALUES ('59', '0', '198', '198', '191', '191', '191', '185', '185', '185', '178', '166', '154');
INSERT INTO `skill_caps` VALUES ('60', '0', '203', '203', '196', '196', '196', '190', '190', '190', '183', '171', '159');
INSERT INTO `skill_caps` VALUES ('61', '0', '207', '207', '199', '199', '198', '192', '192', '192', '184', '172', '161');
INSERT INTO `skill_caps` VALUES ('62', '0', '212', '211', '203', '202', '201', '195', '194', '194', '186', '174', '163');
INSERT INTO `skill_caps` VALUES ('63', '0', '217', '215', '207', '205', '204', '197', '196', '196', '188', '176', '165');
INSERT INTO `skill_caps` VALUES ('64', '0', '222', '219', '210', '208', '206', '200', '199', '198', '190', '178', '167');
INSERT INTO `skill_caps` VALUES ('65', '0', '227', '223', '214', '212', '209', '202', '201', '200', '192', '180', '169');
INSERT INTO `skill_caps` VALUES ('66', '0', '232', '227', '218', '215', '212', '205', '203', '202', '194', '182', '171');
INSERT INTO `skill_caps` VALUES ('67', '0', '236', '231', '221', '218', '214', '207', '205', '204', '195', '184', '173');
INSERT INTO `skill_caps` VALUES ('68', '0', '241', '235', '225', '221', '217', '210', '208', '206', '197', '186', '175');
INSERT INTO `skill_caps` VALUES ('69', '0', '246', '239', '229', '225', '220', '212', '210', '208', '199', '188', '177');
INSERT INTO `skill_caps` VALUES ('70', '0', '251', '244', '233', '228', '223', '215', '212', '210', '201', '190', '179');
INSERT INTO `skill_caps` VALUES ('71', '0', '256', '249', '237', '232', '226', '218', '214', '212', '203', '192', '181');
INSERT INTO `skill_caps` VALUES ('72', '0', '261', '254', '241', '236', '229', '221', '217', '214', '205', '194', '183');
INSERT INTO `skill_caps` VALUES ('73', '0', '266', '259', '246', '240', '232', '224', '219', '216', '207', '196', '185');
INSERT INTO `skill_caps` VALUES ('74', '0', '271', '264', '251', '245', '236', '227', '222', '218', '208', '198', '187');
INSERT INTO `skill_caps` VALUES ('75', '0', '276', '269', '256', '250', '240', '230', '225', '220', '210', '200', '189');
INSERT INTO `skill_caps` VALUES ('76', '0', '281', '274', '261', '255', '245', '235', '230', '225', '214', '203', '191');
INSERT INTO `skill_caps` VALUES ('77', '0', '286', '279', '266', '260', '250', '240', '235', '230', '218', '206', '193');
INSERT INTO `skill_caps` VALUES ('78', '0', '291', '284', '271', '265', '255', '245', '240', '235', '222', '209', '195');
INSERT INTO `skill_caps` VALUES ('79', '0', '296', '289', '276', '270', '260', '250', '245', '240', '226', '212', '197');
INSERT INTO `skill_caps` VALUES ('80', '0', '301', '294', '281', '275', '265', '255', '250', '245', '230', '215', '199');
INSERT INTO `skill_caps` VALUES ('81', '0', '307', '300', '287', '281', '271', '261', '256', '251', '235', '219', '202');
INSERT INTO `skill_caps` VALUES ('82', '0', '313', '306', '293', '287', '277', '267', '262', '257', '240', '223', '205');
INSERT INTO `skill_caps` VALUES ('83', '0', '319', '312', '299', '293', '283', '273', '268', '263', '245', '227', '208');
INSERT INTO `skill_caps` VALUES ('84', '0', '325', '318', '305', '299', '289', '279', '274', '269', '250', '231', '211');
INSERT INTO `skill_caps` VALUES ('85', '0', '331', '324', '311', '305', '295', '285', '280', '275', '255', '235', '214');
INSERT INTO `skill_caps` VALUES ('86', '0', '337', '330', '317', '311', '301', '291', '286', '281', '260', '239', '217');
INSERT INTO `skill_caps` VALUES ('87', '0', '343', '336', '323', '317', '307', '297', '292', '287', '265', '243', '220');
INSERT INTO `skill_caps` VALUES ('88', '0', '349', '342', '329', '323', '313', '303', '298', '293', '270', '247', '223');
INSERT INTO `skill_caps` VALUES ('89', '0', '355', '348', '335', '329', '319', '309', '304', '299', '275', '251', '226');
INSERT INTO `skill_caps` VALUES ('90', '0', '361', '354', '341', '335', '325', '315', '310', '305', '280', '255', '229');
INSERT INTO `skill_caps` VALUES ('91', '0', '367', '360', '347', '341', '331', '321', '316', '311', '285', '259', '232');
INSERT INTO `skill_caps` VALUES ('92', '0', '373', '366', '353', '347', '337', '327', '322', '317', '290', '263', '235');
INSERT INTO `skill_caps` VALUES ('93', '0', '379', '372', '359', '353', '343', '333', '328', '323', '295', '267', '238');
INSERT INTO `skill_caps` VALUES ('94', '0', '385', '378', '365', '359', '349', '339', '334', '329', '300', '271', '241');
INSERT INTO `skill_caps` VALUES ('95', '0', '391', '384', '371', '365', '355', '345', '340', '335', '305', '275', '244');
INSERT INTO `skill_caps` VALUES ('96', '0', '397', '390', '377', '371', '361', '351', '346', '341', '310', '279', '247');
INSERT INTO `skill_caps` VALUES ('97', '0', '403', '396', '383', '377', '367', '357', '352', '347', '315', '283', '250');
INSERT INTO `skill_caps` VALUES ('98', '0', '409', '402', '389', '383', '373', '363', '358', '353', '320', '287', '253');
INSERT INTO `skill_caps` VALUES ('99', '0', '415', '408', '395', '389', '379', '369', '364', '359', '325', '291', '256');
INSERT INTO `skill_ranks` VALUES ('1', 'hand2hand', '9', '1', '0', '0', '0', '10', '0', '0', '0', '0', '0', '0', '10', '0', '0', '0', '0', '7', '9', '0', '0', '0');
INSERT INTO `skill_ranks` VALUES ('2', 'dagger', '5', '0', '0', '9', '4', '2', '8', '7', '6', '5', '5', '10', '6', '10', '10', '0', '3', '8', '3', '10', '0', '0');
INSERT INTO `skill_ranks` VALUES ('3', 'sword', '4', '0', '0', '0', '4', '9', '1', '5', '10', '8', '9', '6', '7', '8', '0', '2', '5', '0', '9', '0', '0', '0');
INSERT INTO `skill_ranks` VALUES ('4', 'great sword', '3', '0', '0', '0', '0', '0', '4', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `skill_ranks` VALUES ('5', 'axe', '2', '0', '0', '0', '0', '0', '0', '5', '2', '0', '5', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `skill_ranks` VALUES ('6', 'great axe', '1', '0', '0', '0', '0', '0', '0', '5', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `skill_ranks` VALUES ('7', 'scythe', '3', '0', '0', '10', '0', '0', '0', '1', '5', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `skill_ranks` VALUES ('8', 'polearm', '5', '0', '0', '0', '0', '0', '10', '0', '0', '0', '0', '5', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `skill_ranks` VALUES ('9', 'katana', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `skill_ranks` VALUES ('10', 'great katana', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '8', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `skill_ranks` VALUES ('11', 'club', '5', '6', '3', '6', '9', '10', '2', '8', '9', '9', '10', '10', '10', '10', '6', '5', '0', '9', '0', '6', '0', '0');
INSERT INTO `skill_ranks` VALUES ('12', 'staff', '4', '4', '6', '5', '0', '0', '2', '0', '0', '6', '0', '0', '0', '5', '4', '0', '0', '0', '0', '6', '0', '0');
INSERT INTO `skill_ranks` VALUES ('25', 'archery', '9', '0', '0', '0', '9', '8', '0', '0', '0', '0', '2', '6', '10', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `skill_ranks` VALUES ('26', 'marksmanship', '9', '0', '0', '0', '0', '6', '0', '10', '0', '0', '2', '0', '7', '0', '0', '0', '4', '0', '0', '0', '0', '0');
INSERT INTO `skill_ranks` VALUES ('27', 'throwing', '9', '10', '10', '9', '11', '9', '0', '0', '0', '10', '8', '7', '2', '0', '0', '0', '6', '6', '4', '9', '0', '0');
INSERT INTO `skill_ranks` VALUES ('28', 'guarding', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '5', '0', '0', '0', '0');
INSERT INTO `skill_ranks` VALUES ('29', 'evasion', '7', '3', '10', '10', '9', '1', '7', '7', '7', '9', '10', '3', '2', '4', '10', '8', '9', '4', '3', '10', '0', '0');
INSERT INTO `skill_ranks` VALUES ('30', 'shield', '6', '0', '9', '0', '11', '11', '1', '0', '10', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `skill_ranks` VALUES ('31', 'parrying', '8', '10', '0', '0', '10', '2', '7', '10', '7', '10', '0', '2', '2', '5', '0', '9', '2', '9', '2', '10', '0', '0');
INSERT INTO `skill_ranks` VALUES ('32', 'divine', '0', '0', '2', '0', '10', '0', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '9', '0', '0');
INSERT INTO `skill_ranks` VALUES ('33', 'healing', '0', '0', '1', '0', '8', '0', '7', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '9', '0', '0');
INSERT INTO `skill_ranks` VALUES ('34', 'enhancing', '0', '0', '6', '10', '3', '0', '9', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '9', '0', '0');
INSERT INTO `skill_ranks` VALUES ('35', 'enfeebling', '0', '0', '7', '6', '1', '0', '0', '7', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '9', '0', '0');
INSERT INTO `skill_ranks` VALUES ('36', 'elemental', '0', '0', '0', '1', '6', '0', '0', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '9', '0', '0');
INSERT INTO `skill_ranks` VALUES ('37', 'dark', '0', '0', '0', '2', '10', '0', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '9', '0', '0');
INSERT INTO `skill_ranks` VALUES ('38', 'summoning', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '2', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `skill_ranks` VALUES ('39', 'ninjutsu', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `skill_ranks` VALUES ('40', 'singing', '0', '0', '0', '0', '0', '0', '0', '0', '0', '7', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `skill_ranks` VALUES ('41', 'string', '0', '0', '0', '0', '0', '0', '0', '0', '0', '7', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `skill_ranks` VALUES ('42', 'wind', '0', '0', '0', '0', '0', '0', '0', '0', '0', '7', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `skill_ranks` VALUES ('43', 'blue', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0');
INSERT INTO `skillchain_damage_modifiers` VALUES ('1', '1', '500', '1300');
INSERT INTO `skillchain_damage_modifiers` VALUES ('1', '2', '600', '1350');
INSERT INTO `skillchain_damage_modifiers` VALUES ('1', '3', '700', '1400');
INSERT INTO `skillchain_damage_modifiers` VALUES ('1', '4', '800', '1450');
INSERT INTO `skillchain_damage_modifiers` VALUES ('1', '5', '900', '1500');
INSERT INTO `skillchain_damage_modifiers` VALUES ('2', '1', '600', '1300');
INSERT INTO `skillchain_damage_modifiers` VALUES ('2', '2', '750', '1350');
INSERT INTO `skillchain_damage_modifiers` VALUES ('2', '3', '1000', '1400');
INSERT INTO `skillchain_damage_modifiers` VALUES ('2', '4', '1250', '1450');
INSERT INTO `skillchain_damage_modifiers` VALUES ('2', '5', '1500', '1500');
INSERT INTO `skillchain_damage_modifiers` VALUES ('3', '1', '1000', '1300');
INSERT INTO `skillchain_damage_modifiers` VALUES ('3', '2', '1500', '1350');
INSERT INTO `skillchain_damage_modifiers` VALUES ('3', '3', '1750', '1400');
INSERT INTO `skillchain_damage_modifiers` VALUES ('3', '4', '2000', '1450');
INSERT INTO `skillchain_damage_modifiers` VALUES ('3', '5', '2250', '1500');
INSERT INTO `skillchain_damage_modifiers` VALUES ('4', '1', '1000', '1300');
INSERT INTO `skillchain_damage_modifiers` VALUES ('4', '2', '1500', '1350');
INSERT INTO `skillchain_damage_modifiers` VALUES ('4', '3', '1750', '1400');
INSERT INTO `skillchain_damage_modifiers` VALUES ('4', '4', '2000', '1450');
INSERT INTO `skillchain_damage_modifiers` VALUES ('4', '5', '2250', '1500');
