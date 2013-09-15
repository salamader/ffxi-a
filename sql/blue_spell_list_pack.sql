/*
MySQL Data Transfer
Source Host: localhost
Source Database: database
Target Host: localhost
Target Database: database
Date: 9/14/2013 10:54:49 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for blue_spell_list
-- ----------------------------
CREATE TABLE `blue_spell_list` (
  `spellid` smallint(3) NOT NULL,
  `mob_skill_id` smallint(4) unsigned NOT NULL,
  `set_points` smallint(2) NOT NULL,
  `trait_category` smallint(2) NOT NULL,
  `trait_category_weight` smallint(2) NOT NULL,
  `primary_sc` smallint(2) NOT NULL,
  `secondary_sc` smallint(2) NOT NULL,
  PRIMARY KEY (`spellid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for blue_spell_mods
-- ----------------------------
CREATE TABLE `blue_spell_mods` (
  `spellId` smallint(3) unsigned NOT NULL,
  `modid` smallint(5) unsigned NOT NULL,
  `value` smallint(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`spellId`,`modid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for blue_traits
-- ----------------------------
CREATE TABLE `blue_traits` (
  `trait_category` smallint(2) unsigned NOT NULL,
  `trait_points_needed` smallint(2) unsigned NOT NULL,
  `traitid` tinyint(3) unsigned NOT NULL,
  `modifier` smallint(5) unsigned NOT NULL,
  `value` smallint(5) NOT NULL,
  PRIMARY KEY (`trait_category`,`trait_points_needed`,`modifier`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `blue_spell_list` VALUES ('513', '1316', '3', '4', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('515', '206', '5', '4', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('517', '192', '1', '10', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('519', '196', '3', '18', '1', '1', '4');
INSERT INTO `blue_spell_list` VALUES ('521', '165', '4', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('522', '181', '2', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('524', '170', '2', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('527', '257', '3', '7', '1', '6', '0');
INSERT INTO `blue_spell_list` VALUES ('529', '427', '2', '7', '1', '3', '0');
INSERT INTO `blue_spell_list` VALUES ('530', '313', '4', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('531', '420', '3', '13', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('532', '279', '4', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('533', '253', '3', '14', '2', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('534', '267', '4', '10', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('535', '1390', '1', '14', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('536', '210', '1', '4', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('537', '233', '2', '14', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('538', '274', '4', '6', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('539', '219', '3', '11', '1', '2', '5');
INSERT INTO `blue_spell_list` VALUES ('540', '1522', '4', '8', '1', '4', '6');
INSERT INTO `blue_spell_list` VALUES ('541', '229', '2', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('542', '177', '2', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('543', '23', '2', '12', '1', '7', '0');
INSERT INTO `blue_spell_list` VALUES ('544', '403', '2', '6', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('545', '554', '4', '20', '1', '2', '0');
INSERT INTO `blue_spell_list` VALUES ('547', '90', '1', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('548', '108', '3', '4', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('549', '79', '1', '5', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('551', '82', '1', '12', '1', '5', '0');
INSERT INTO `blue_spell_list` VALUES ('554', '97', '5', '8', '1', '2', '5');
INSERT INTO `blue_spell_list` VALUES ('555', '535', '3', '13', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('557', '293', '4', '6', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('560', '1455', '3', '16', '1', '7', '0');
INSERT INTO `blue_spell_list` VALUES ('561', '245', '3', '14', '2', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('563', '304', '3', '10', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('564', '389', '4', '15', '1', '8', '0');
INSERT INTO `blue_spell_list` VALUES ('565', '565', '4', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('567', '366', '2', '0', '1', '1', '0');
INSERT INTO `blue_spell_list` VALUES ('569', '139', '4', '9', '1', '8', '0');
INSERT INTO `blue_spell_list` VALUES ('570', '138', '2', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('572', '154', '1', '6', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('573', '1445', '3', '4', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('574', '146', '2', '19', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('575', '0', '4', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('576', '1457', '3', '5', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('577', '1', '2', '3', '1', '6', '0');
INSERT INTO `blue_spell_list` VALUES ('578', '67', '3', '5', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('579', '1451', '4', '14', '3', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('581', '31', '4', '2', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('582', '397', '2', '17', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('584', '8', '2', '2', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('585', '10', '4', '3', '1', '12', '0');
INSERT INTO `blue_spell_list` VALUES ('587', '17', '2', '3', '1', '4', '0');
INSERT INTO `blue_spell_list` VALUES ('588', '241', '2', '4', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('589', '190', '5', '16', '1', '1', '8');
INSERT INTO `blue_spell_list` VALUES ('591', '544', '4', '6', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('592', '36', '2', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('593', '39', '3', '5', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('594', '328', '3', '8', '1', '3', '8');
INSERT INTO `blue_spell_list` VALUES ('595', '66', '5', '1', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('596', '73', '2', '0', '1', '3', '0');
INSERT INTO `blue_spell_list` VALUES ('597', '431', '2', '1', '1', '5', '0');
INSERT INTO `blue_spell_list` VALUES ('598', '178', '4', '4', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('599', '54', '2', '0', '1', '2', '0');
INSERT INTO `blue_spell_list` VALUES ('603', '46', '3', '1', '1', '1', '0');
INSERT INTO `blue_spell_list` VALUES ('604', '63', '5', '22', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('605', '260', '3', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('606', '0', '2', '4', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('608', '121', '3', '17', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('610', '116', '4', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('611', '1128', '5', '16', '1', '10', '0');
INSERT INTO `blue_spell_list` VALUES ('612', '1185', '4', '14', '4', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('613', '0', '5', '6', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('614', '1096', '3', '11', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('615', '0', '5', '14', '4', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('616', '0', '5', '8', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('617', '1191', '3', '11', '1', '9', '0');
INSERT INTO `blue_spell_list` VALUES ('618', '392', '2', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('620', '353', '3', '8', '1', '8', '0');
INSERT INTO `blue_spell_list` VALUES ('621', '0', '2', '4', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('622', '409', '2', '11', '1', '7', '0');
INSERT INTO `blue_spell_list` VALUES ('623', '356', '3', '0', '1', '8', '0');
INSERT INTO `blue_spell_list` VALUES ('626', '335', '3', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('628', '0', '3', '15', '1', '8', '0');
INSERT INTO `blue_spell_list` VALUES ('629', '104', '3', '15', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('631', '521', '3', '9', '1', '5', '0');
INSERT INTO `blue_spell_list` VALUES ('632', '1488', '3', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('633', '1489', '5', '21', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('634', '529', '5', '14', '2', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('636', '1478', '4', '4', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('637', '1477', '5', '17', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('638', '361', '3', '9', '1', '1', '0');
INSERT INTO `blue_spell_list` VALUES ('640', '1515', '4', '20', '1', '5', '0');
INSERT INTO `blue_spell_list` VALUES ('641', '1510', '5', '18', '1', '6', '0');
INSERT INTO `blue_spell_list` VALUES ('642', '0', '3', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('643', '0', '3', '0', '1', '11', '0');
INSERT INTO `blue_spell_list` VALUES ('644', '0', '4', '4', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('645', '0', '4', '5', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('646', '1702', '4', '6', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('647', '1466', '2', '17', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('648', '1897', '1', '19', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('650', '0', '4', '1', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('651', '0', '4', '4', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('652', '1925', '3', '12', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('653', '0', '2', '21', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('654', '0', '4', '22', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('655', '0', '3', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('656', '2306', '3', '24', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('657', '2308', '3', '25', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('658', '1913', '4', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('659', '0', '4', '24', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('660', '0', '3', '27', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('661', '0', '5', '25', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('662', '269', '3', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('663', '75', '4', '27', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('664', '205', '2', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('665', '80', '1', '26', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('666', '334', '3', '23', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('667', '132', '2', '16', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('668', '299', '3', '10', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('669', '258', '2', '26', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('670', '2373', '4', '23', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('671', '964', '4', '22', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('672', '2375', '5', '13', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('673', '485', '4', '25', '1', '10', '0');
INSERT INTO `blue_spell_list` VALUES ('674', '0', '1', '20', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('675', '0', '3', '8', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('677', '974', '3', '24', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('678', '45', '3', '6', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('679', '999', '3', '18', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('680', '0', '4', '28', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('681', '989', '5', '14', '4', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('682', '1898', '2', '25', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('683', '0', '4', '28', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('684', '0', '4', '27', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('685', '0', '3', '15', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('686', '0', '4', '25', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('687', '0', '2', '17', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('688', '0', '2', '24', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('689', '0', '3', '21', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('690', '0', '5', '2', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('692', '0', '4', '20', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('693', '0', '5', '23', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('694', '0', '3', '10', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('695', '0', '4', '15', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('696', '0', '5', '21', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('697', '0', '4', '28', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('698', '0', '2', '22', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('699', '0', '2', '25', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('736', '0', '0', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('737', '0', '0', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('738', '0', '0', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('739', '0', '0', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('740', '0', '0', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('741', '0', '0', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('742', '0', '0', '0', '1', '0', '0');
INSERT INTO `blue_spell_list` VALUES ('743', '0', '0', '0', '1', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('513', '13', '2');
INSERT INTO `blue_spell_mods` VALUES ('515', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('517', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('519', '10', '1');
INSERT INTO `blue_spell_mods` VALUES ('519', '14', '1');
INSERT INTO `blue_spell_mods` VALUES ('519', '2', '10');
INSERT INTO `blue_spell_mods` VALUES ('521', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('522', '2', '-5');
INSERT INTO `blue_spell_mods` VALUES ('522', '5', '5');
INSERT INTO `blue_spell_mods` VALUES ('524', '10', '1');
INSERT INTO `blue_spell_mods` VALUES ('527', '11', '3');
INSERT INTO `blue_spell_mods` VALUES ('529', '8', '1');
INSERT INTO `blue_spell_mods` VALUES ('530', '11', '2');
INSERT INTO `blue_spell_mods` VALUES ('531', '12', '1');
INSERT INTO `blue_spell_mods` VALUES ('532', '9', '3');
INSERT INTO `blue_spell_mods` VALUES ('533', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('534', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('535', '12', '-1');
INSERT INTO `blue_spell_mods` VALUES ('536', '13', '1');
INSERT INTO `blue_spell_mods` VALUES ('537', '11', '1');
INSERT INTO `blue_spell_mods` VALUES ('538', '12', '1');
INSERT INTO `blue_spell_mods` VALUES ('539', '2', '-5');
INSERT INTO `blue_spell_mods` VALUES ('539', '5', '10');
INSERT INTO `blue_spell_mods` VALUES ('540', '10', '2');
INSERT INTO `blue_spell_mods` VALUES ('540', '12', '1');
INSERT INTO `blue_spell_mods` VALUES ('540', '13', '1');
INSERT INTO `blue_spell_mods` VALUES ('541', '2', '-5');
INSERT INTO `blue_spell_mods` VALUES ('541', '5', '5');
INSERT INTO `blue_spell_mods` VALUES ('542', '2', '-5');
INSERT INTO `blue_spell_mods` VALUES ('542', '5', '5');
INSERT INTO `blue_spell_mods` VALUES ('543', '12', '1');
INSERT INTO `blue_spell_mods` VALUES ('544', '13', '1');
INSERT INTO `blue_spell_mods` VALUES ('545', '2', '-5');
INSERT INTO `blue_spell_mods` VALUES ('545', '5', '15');
INSERT INTO `blue_spell_mods` VALUES ('547', '9', '3');
INSERT INTO `blue_spell_mods` VALUES ('548', '10', '1');
INSERT INTO `blue_spell_mods` VALUES ('549', '2', '5');
INSERT INTO `blue_spell_mods` VALUES ('549', '14', '1');
INSERT INTO `blue_spell_mods` VALUES ('551', '13', '1');
INSERT INTO `blue_spell_mods` VALUES ('554', '13', '2');
INSERT INTO `blue_spell_mods` VALUES ('554', '14', '2');
INSERT INTO `blue_spell_mods` VALUES ('554', '2', '5');
INSERT INTO `blue_spell_mods` VALUES ('555', '10', '2');
INSERT INTO `blue_spell_mods` VALUES ('557', '2', '-5');
INSERT INTO `blue_spell_mods` VALUES ('557', '5', '15');
INSERT INTO `blue_spell_mods` VALUES ('560', '12', '1');
INSERT INTO `blue_spell_mods` VALUES ('561', '11', '2');
INSERT INTO `blue_spell_mods` VALUES ('563', '11', '1');
INSERT INTO `blue_spell_mods` VALUES ('564', '10', '1');
INSERT INTO `blue_spell_mods` VALUES ('564', '5', '5');
INSERT INTO `blue_spell_mods` VALUES ('565', '2', '5');
INSERT INTO `blue_spell_mods` VALUES ('565', '14', '1');
INSERT INTO `blue_spell_mods` VALUES ('567', '14', '1');
INSERT INTO `blue_spell_mods` VALUES ('567', '2', '5');
INSERT INTO `blue_spell_mods` VALUES ('569', '9', '2');
INSERT INTO `blue_spell_mods` VALUES ('570', '5', '5');
INSERT INTO `blue_spell_mods` VALUES ('572', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('573', '11', '1');
INSERT INTO `blue_spell_mods` VALUES ('574', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('576', '2', '5');
INSERT INTO `blue_spell_mods` VALUES ('576', '14', '1');
INSERT INTO `blue_spell_mods` VALUES ('577', '11', '1');
INSERT INTO `blue_spell_mods` VALUES ('578', '2', '5');
INSERT INTO `blue_spell_mods` VALUES ('579', '11', '2');
INSERT INTO `blue_spell_mods` VALUES ('581', '2', '10');
INSERT INTO `blue_spell_mods` VALUES ('581', '14', '1');
INSERT INTO `blue_spell_mods` VALUES ('582', '11', '1');
INSERT INTO `blue_spell_mods` VALUES ('584', '2', '5');
INSERT INTO `blue_spell_mods` VALUES ('584', '14', '1');
INSERT INTO `blue_spell_mods` VALUES ('585', '2', '5');
INSERT INTO `blue_spell_mods` VALUES ('587', '10', '1');
INSERT INTO `blue_spell_mods` VALUES ('588', '2', '-5');
INSERT INTO `blue_spell_mods` VALUES ('589', '9', '1');
INSERT INTO `blue_spell_mods` VALUES ('589', '14', '1');
INSERT INTO `blue_spell_mods` VALUES ('589', '2', '5');
INSERT INTO `blue_spell_mods` VALUES ('591', '8', '3');
INSERT INTO `blue_spell_mods` VALUES ('592', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('593', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('594', '8', '2');
INSERT INTO `blue_spell_mods` VALUES ('594', '9', '1');
INSERT INTO `blue_spell_mods` VALUES ('595', '10', '3');
INSERT INTO `blue_spell_mods` VALUES ('595', '11', '3');
INSERT INTO `blue_spell_mods` VALUES ('596', '8', '1');
INSERT INTO `blue_spell_mods` VALUES ('597', '13', '1');
INSERT INTO `blue_spell_mods` VALUES ('598', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('599', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('603', '14', '1');
INSERT INTO `blue_spell_mods` VALUES ('603', '2', '10');
INSERT INTO `blue_spell_mods` VALUES ('604', '12', '2');
INSERT INTO `blue_spell_mods` VALUES ('604', '13', '2');
INSERT INTO `blue_spell_mods` VALUES ('605', '2', '-5');
INSERT INTO `blue_spell_mods` VALUES ('605', '5', '10');
INSERT INTO `blue_spell_mods` VALUES ('608', '12', '1');
INSERT INTO `blue_spell_mods` VALUES ('610', '12', '1');
INSERT INTO `blue_spell_mods` VALUES ('611', '12', '1');
INSERT INTO `blue_spell_mods` VALUES ('611', '13', '1');
INSERT INTO `blue_spell_mods` VALUES ('612', '2', '20');
INSERT INTO `blue_spell_mods` VALUES ('612', '14', '2');
INSERT INTO `blue_spell_mods` VALUES ('614', '5', '10');
INSERT INTO `blue_spell_mods` VALUES ('614', '10', '2');
INSERT INTO `blue_spell_mods` VALUES ('614', '11', '2');
INSERT INTO `blue_spell_mods` VALUES ('617', '10', '1');
INSERT INTO `blue_spell_mods` VALUES ('617', '2', '-5');
INSERT INTO `blue_spell_mods` VALUES ('617', '5', '5');
INSERT INTO `blue_spell_mods` VALUES ('618', '8', '1');
INSERT INTO `blue_spell_mods` VALUES ('620', '9', '2');
INSERT INTO `blue_spell_mods` VALUES ('622', '12', '1');
INSERT INTO `blue_spell_mods` VALUES ('623', '9', '2');
INSERT INTO `blue_spell_mods` VALUES ('626', '8', '2');
INSERT INTO `blue_spell_mods` VALUES ('629', '11', '1');
INSERT INTO `blue_spell_mods` VALUES ('631', '13', '2');
INSERT INTO `blue_spell_mods` VALUES ('632', '10', '1');
INSERT INTO `blue_spell_mods` VALUES ('633', '2', '-5');
INSERT INTO `blue_spell_mods` VALUES ('633', '5', '5');
INSERT INTO `blue_spell_mods` VALUES ('634', '2', '15');
INSERT INTO `blue_spell_mods` VALUES ('634', '14', '1');
INSERT INTO `blue_spell_mods` VALUES ('636', '10', '1');
INSERT INTO `blue_spell_mods` VALUES ('637', '8', '3');
INSERT INTO `blue_spell_mods` VALUES ('638', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('640', '13', '2');
INSERT INTO `blue_spell_mods` VALUES ('641', '9', '2');
INSERT INTO `blue_spell_mods` VALUES ('641', '11', '1');
INSERT INTO `blue_spell_mods` VALUES ('646', '5', '-5');
INSERT INTO `blue_spell_mods` VALUES ('646', '13', '2');
INSERT INTO `blue_spell_mods` VALUES ('647', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('648', '5', '3');
INSERT INTO `blue_spell_mods` VALUES ('648', '12', '1');
INSERT INTO `blue_spell_mods` VALUES ('648', '13', '1');
INSERT INTO `blue_spell_mods` VALUES ('652', '2', '5');
INSERT INTO `blue_spell_mods` VALUES ('652', '8', '1');
INSERT INTO `blue_spell_mods` VALUES ('656', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('657', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('658', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('662', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('663', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('664', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('665', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('666', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('667', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('668', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('669', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('670', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('671', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('672', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('673', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('677', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('678', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('679', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('681', '0', '0');
INSERT INTO `blue_spell_mods` VALUES ('682', '0', '0');
INSERT INTO `blue_traits` VALUES ('1', '2', '32', '230', '8');
INSERT INTO `blue_traits` VALUES ('2', '2', '9', '370', '1');
INSERT INTO `blue_traits` VALUES ('3', '2', '35', '227', '8');
INSERT INTO `blue_traits` VALUES ('4', '2', '24', '295', '1');
INSERT INTO `blue_traits` VALUES ('4', '4', '24', '295', '2');
INSERT INTO `blue_traits` VALUES ('4', '6', '24', '295', '3');
INSERT INTO `blue_traits` VALUES ('4', '8', '24', '295', '4');
INSERT INTO `blue_traits` VALUES ('5', '2', '48', '240', '2');
INSERT INTO `blue_traits` VALUES ('6', '2', '5', '28', '20');
INSERT INTO `blue_traits` VALUES ('7', '2', '39', '231', '8');
INSERT INTO `blue_traits` VALUES ('8', '2', '3', '23', '10');
INSERT INTO `blue_traits` VALUES ('8', '2', '3', '24', '10');
INSERT INTO `blue_traits` VALUES ('9', '2', '11', '357', '10');
INSERT INTO `blue_traits` VALUES ('10', '2', '8', '5', '10');
INSERT INTO `blue_traits` VALUES ('10', '4', '8', '5', '30');
INSERT INTO `blue_traits` VALUES ('11', '2', '4', '1', '10');
INSERT INTO `blue_traits` VALUES ('12', '2', '33', '229', '8');
INSERT INTO `blue_traits` VALUES ('13', '2', '6', '29', '10');
INSERT INTO `blue_traits` VALUES ('14', '8', '10', '369', '1');
INSERT INTO `blue_traits` VALUES ('15', '2', '7', '2', '30');
INSERT INTO `blue_traits` VALUES ('15', '4', '7', '2', '90');
INSERT INTO `blue_traits` VALUES ('16', '2', '1', '25', '10');
INSERT INTO `blue_traits` VALUES ('16', '2', '1', '26', '10');
INSERT INTO `blue_traits` VALUES ('17', '2', '13', '296', '25');
INSERT INTO `blue_traits` VALUES ('18', '2', '2', '69', '10');
INSERT INTO `blue_traits` VALUES ('19', '2', '58', '249', '2');
INSERT INTO `blue_traits` VALUES ('20', '2', '14', '73', '10');
INSERT INTO `blue_traits` VALUES ('20', '4', '14', '73', '25');
INSERT INTO `blue_traits` VALUES ('21', '2', '17', '291', '10');
INSERT INTO `blue_traits` VALUES ('22', '2', '12', '170', '5');
INSERT INTO `blue_traits` VALUES ('22', '4', '12', '170', '15');
INSERT INTO `blue_traits` VALUES ('23', '2', '106', '174', '8');
INSERT INTO `blue_traits` VALUES ('24', '2', '15', '288', '7');
INSERT INTO `blue_traits` VALUES ('24', '4', '16', '302', '5');
INSERT INTO `blue_traits` VALUES ('25', '2', '18', '259', '10');
INSERT INTO `blue_traits` VALUES ('25', '4', '18', '259', '15');
INSERT INTO `blue_traits` VALUES ('25', '6', '18', '259', '25');
INSERT INTO `blue_traits` VALUES ('26', '2', '70', '306', '15');
INSERT INTO `blue_traits` VALUES ('27', '2', '110', '407', '5');
INSERT INTO `blue_traits` VALUES ('28', '2', '20', '0', '0');
INSERT INTO `blue_traits` VALUES ('28', '3', '19', '303', '1');
