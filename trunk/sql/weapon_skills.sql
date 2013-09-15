/*
MySQL Data Transfer
Source Host: localhost
Source Database: database
Target Host: localhost
Target Database: database
Date: 9/15/2013 2:00:45 AM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for weapon_skills
-- ----------------------------
CREATE TABLE `weapon_skills` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `weaponskillid` tinyint(3) unsigned NOT NULL,
  `name` text NOT NULL,
  `jobs` binary(22) NOT NULL,
  `type` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `skilllevel` smallint(3) unsigned NOT NULL DEFAULT '0',
  `element` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `animation` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `range` tinyint(2) unsigned NOT NULL DEFAULT '5',
  `aoe` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `primary_sc` tinyint(4) NOT NULL DEFAULT '0',
  `secondary_sc` tinyint(4) NOT NULL DEFAULT '0',
  `tertiary_sc` tinyint(4) NOT NULL DEFAULT '0',
  `main_only` tinyint(1) NOT NULL DEFAULT '0',
  `learnall` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`,`weaponskillid`)
) ENGINE=MyISAM AUTO_INCREMENT=206 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `weapon_skills` VALUES ('1', '1', 'combo', '', '1', '5', '0', '16', '5', '1', '8', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('2', '2', 'shoulder_tackle', '', '1', '40', '0', '17', '5', '1', '5', '8', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('3', '3', 'one_inch_punch', '', '1', '75', '0', '18', '5', '1', '2', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('4', '4', 'backhand_blow', '', '1', '100', '0', '19', '5', '1', '6', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('5', '5', 'raging_fists', '', '1', '125', '0', '20', '5', '1', '8', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('6', '6', 'spinning_attack', '', '1', '150', '0', '21', '5', '2', '3', '8', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('7', '7', 'howling_fist', '', '1', '200', '0', '22', '5', '1', '1', '8', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('8', '8', 'dragon_kick', '', '1', '225', '0', '23', '5', '1', '12', '0', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('9', '9', 'asuran_fists', '', '1', '250', '0', '24', '5', '1', '9', '3', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('10', '10', 'final_heaven', '', '1', '300', '0', '25', '5', '1', '13', '11', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('11', '11', 'ascetics_fury', '', '1', '300', '0', '26', '5', '1', '11', '1', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('12', '12', 'stringing_pummel', '', '1', '300', '0', '27', '5', '1', '9', '3', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('13', '13', 'tornado_kick', '', '1', '300', '0', '28', '5', '1', '7', '8', '6', '0', '1');
INSERT INTO `weapon_skills` VALUES ('14', '14', 'victory_smite', '', '1', '300', '0', '29', '5', '1', '13', '12', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('15', '15', 'shijin_spiral', '', '1', '357', '0', '30', '5', '1', '11', '5', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('16', '16', 'wasp_sting', '', '2', '5', '0', '31', '5', '1', '4', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('17', '19', 'gust_slash', '', '2', '40', '16', '34', '5', '1', '6', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('18', '18', 'shadowstitch', '', '2', '70', '0', '33', '5', '1', '5', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('19', '17', 'viper_bite', '', '2', '100', '0', '32', '5', '1', '4', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('20', '20', 'cyclone', '', '2', '125', '16', '35', '5', '2', '6', '8', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('21', '21', 'energy_steal', '', '2', '150', '0', '36', '5', '1', '0', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('22', '22', 'energy_drain', '', '2', '175', '0', '37', '5', '1', '0', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('23', '23', 'dancing_edge', '', '2', '200', '0', '38', '5', '1', '4', '6', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('24', '24', 'shark_bite', '', '2', '225', '0', '39', '5', '1', '12', '0', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('25', '25', 'evisceration', '', '2', '230', '0', '40', '5', '1', '9', '1', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('26', '30', 'aeolian_edge', '', '2', '290', '16', '45', '5', '2', '8', '4', '6', '0', '1');
INSERT INTO `weapon_skills` VALUES ('27', '26', 'mercy_stroke', '', '2', '300', '0', '41', '5', '1', '14', '9', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('28', '27', 'mandalic_stab', '', '2', '300', '0', '42', '5', '1', '11', '2', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('29', '28', 'mordant_rime', '', '2', '300', '0', '43', '5', '1', '12', '10', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('30', '29', 'pyrrhic_kleos', '', '2', '300', '0', '44', '5', '1', '10', '4', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('31', '31', 'rudras_storm', '', '2', '300', '0', '236', '5', '1', '14', '10', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('32', '224', 'exenterator', '', '2', '357', '0', '238', '5', '1', '12', '4', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('33', '32', 'fast_blade', '', '3', '5', '0', '1', '5', '1', '4', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('34', '33', 'burning_blade', '', '3', '30', '2', '2', '5', '1', '3', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('35', '34', 'red_lotus_blade', '', '3', '50', '2', '3', '5', '1', '3', '6', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('36', '35', 'flat_blade', '', '3', '75', '0', '6', '5', '1', '8', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('37', '36', 'shining_blade', '', '3', '100', '128', '4', '5', '1', '4', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('38', '37', 'seraph_blade', '', '3', '125', '128', '5', '5', '1', '4', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('39', '38', 'circle_blade', '', '3', '150', '0', '7', '5', '2', '5', '8', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('40', '39', 'spirits_within', '', '3', '175', '0', '8', '5', '1', '0', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('41', '40', 'vorpal_blade', '', '3', '200', '0', '9', '5', '1', '4', '8', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('42', '41', 'swift_blade', '', '3', '225', '0', '10', '5', '1', '9', '0', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('43', '238', 'uriel_blade', '', '3', '240', '128', '243', '6', '2', '13', '12', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('44', '239', 'glory_slash', '', '3', '240', '0', '242', '6', '2', '13', '11', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('45', '42', 'savage_blade', '', '3', '240', '0', '11', '5', '1', '12', '4', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('46', '225', 'chant_du_cygne', '', '3', '300', '0', '233', '5', '1', '13', '10', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('47', '43', 'knights_of_round', '', '3', '300', '0', '12', '5', '1', '13', '11', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('48', '44', 'death_blossom', '', '3', '300', '0', '13', '5', '1', '12', '10', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('49', '45', 'atonement', '', '3', '300', '0', '14', '5', '1', '11', '5', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('50', '46', 'expiacion', '', '3', '300', '0', '15', '5', '1', '10', '4', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('51', '47', 'sanguine_blade', '', '3', '300', '0', '230', '5', '1', '0', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('52', '226', 'requiescat', '', '3', '357', '1', '237', '5', '1', '9', '4', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('53', '48', 'hard_slash', '', '4', '5', '0', '106', '5', '1', '4', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('54', '49', 'power_slash', '', '4', '30', '0', '107', '5', '1', '1', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('55', '50', 'frostbite', '', '4', '70', '32', '108', '5', '1', '7', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('56', '51', 'freezebite', '', '4', '100', '32', '109', '5', '1', '7', '6', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('57', '52', 'shockwave', '', '4', '150', '0', '110', '5', '2', '5', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('58', '53', 'crescent_moon', '', '4', '175', '0', '111', '5', '1', '4', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('59', '54', 'sickle_moon', '', '4', '200', '0', '112', '5', '1', '4', '8', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('60', '55', 'spinning_slash', '', '4', '225', '0', '113', '5', '1', '12', '0', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('61', '56', 'ground_strike', '', '4', '250', '0', '114', '5', '1', '12', '10', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('62', '58', 'herculean_slash', '', '4', '290', '0', '116', '5', '1', '7', '8', '6', '0', '1');
INSERT INTO `weapon_skills` VALUES ('63', '57', 'scourge', '', '4', '300', '0', '115', '5', '1', '13', '11', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('64', '59', 'torcleaver', '', '4', '300', '0', '117', '5', '1', '13', '10', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('65', '60', 'resolution', '', '4', '357', '0', '118', '5', '1', '12', '4', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('66', '64', 'raging_axe', '', '5', '5', '0', '46', '5', '1', '6', '8', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('67', '65', 'smash_axe', '', '5', '40', '0', '47', '5', '1', '7', '5', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('68', '66', 'gale_axe', '', '5', '70', '0', '48', '5', '1', '6', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('69', '67', 'avalanche_axe', '', '5', '100', '0', '49', '5', '1', '4', '8', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('70', '68', 'spinning_axe', '', '5', '150', '0', '50', '5', '1', '3', '4', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('71', '69', 'rampage', '', '5', '175', '0', '51', '5', '1', '4', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('72', '70', 'calamity', '', '5', '200', '0', '52', '5', '1', '4', '8', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('73', '71', 'mistral_axe', '', '5', '225', '0', '53', '15', '1', '11', '0', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('74', '72', 'decimation', '', '5', '240', '0', '54', '5', '1', '11', '5', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('75', '75', 'bora_axe', '', '5', '290', '0', '57', '5', '1', '4', '6', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('76', '73', 'onslaught', '', '5', '300', '0', '55', '5', '1', '14', '9', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('77', '74', 'primal_rend', '', '5', '300', '128', '56', '5', '1', '9', '5', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('78', '76', 'cloudsplitter', '', '5', '300', '64', '58', '5', '1', '14', '12', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('79', '77', 'ruinator', '', '5', '357', '0', '59', '5', '1', '10', '6', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('80', '80', 'shield_break', '', '6', '5', '0', '91', '5', '1', '8', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('81', '81', 'iron_tempest', '', '6', '40', '0', '92', '5', '1', '4', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('82', '82', 'sturmwind', '', '6', '70', '0', '93', '5', '1', '5', '4', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('83', '83', 'armor_break', '', '6', '100', '0', '94', '5', '1', '8', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('84', '84', 'keen_edge', '', '6', '150', '0', '95', '5', '1', '2', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('85', '85', 'weapon_break', '', '6', '175', '0', '96', '5', '1', '8', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('86', '86', 'raging_rush', '', '6', '200', '0', '97', '5', '1', '7', '5', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('87', '87', 'full_break', '', '6', '225', '0', '98', '5', '1', '10', '0', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('88', '88', 'steel_cyclone', '', '6', '240', '0', '99', '5', '1', '10', '6', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('89', '89', 'metatron_torment', '', '6', '300', '0', '100', '5', '1', '13', '11', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('90', '90', 'kings_justice', '', '6', '300', '0', '101', '5', '1', '12', '4', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('91', '91', 'fell_cleave', '', '6', '300', '0', '102', '5', '2', '8', '6', '4', '0', '1');
INSERT INTO `weapon_skills` VALUES ('92', '92', 'ukkos_fury', '', '6', '300', '0', '103', '5', '1', '13', '12', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('93', '93', 'upheaval', '', '6', '357', '0', '104', '5', '1', '11', '2', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('94', '96', 'slice', '', '7', '5', '0', '61', '5', '1', '4', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('95', '97', 'dark_harvest', '', '7', '30', '255', '62', '5', '1', '5', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('96', '98', 'shadow_of_death', '', '7', '70', '255', '63', '5', '1', '7', '5', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('97', '99', 'nightmare_scythe', '', '7', '100', '0', '64', '5', '1', '2', '4', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('98', '100', 'spinning_scythe', '', '7', '125', '0', '65', '5', '2', '5', '4', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('99', '101', 'vorpal_scythe', '', '7', '150', '0', '66', '5', '1', '1', '4', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('100', '102', 'guillotine', '', '7', '200', '0', '67', '5', '1', '7', '0', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('101', '103', 'cross_reaper', '', '7', '225', '0', '68', '5', '1', '10', '0', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('102', '104', 'spiral_hell', '', '7', '240', '0', '69', '5', '1', '10', '4', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('103', '105', 'catastrophe', '', '7', '300', '0', '70', '5', '1', '14', '9', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('104', '106', 'insurgency', '', '7', '300', '0', '71', '5', '1', '11', '2', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('105', '107', 'infernal_scythe', '', '7', '300', '255', '72', '5', '1', '2', '5', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('106', '108', 'quietus', '', '7', '300', '0', '73', '5', '1', '14', '10', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('107', '109', 'entropy', '', '7', '357', '0', '74', '5', '1', '9', '5', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('108', '112', 'double_thrust', '', '8', '5', '0', '121', '5', '1', '1', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('109', '113', 'thunder_thrust', '', '8', '30', '64', '122', '5', '1', '1', '8', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('110', '114', 'raiden_thrust', '', '8', '70', '64', '123', '5', '1', '1', '8', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('111', '115', 'leg_sweep', '', '8', '100', '0', '124', '5', '1', '8', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('112', '116', 'penta_thrust', '', '8', '150', '0', '125', '5', '1', '2', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('113', '117', 'vorpal_thrust', '', '8', '175', '0', '126', '5', '1', '5', '1', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('114', '118', 'skewer', '', '8', '200', '0', '127', '5', '1', '1', '8', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('115', '119', 'wheeling_thrust', '', '8', '225', '0', '128', '5', '1', '11', '0', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('116', '120', 'impulse_drive', '', '8', '240', '0', '129', '5', '1', '9', '7', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('117', '121', 'geirskogul', '', '8', '300', '0', '130', '5', '1', '13', '10', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('118', '122', 'drakesbane', '', '8', '300', '0', '131', '5', '1', '11', '1', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('119', '123', 'sonic_thrust', '', '8', '300', '0', '132', '5', '2', '1', '4', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('120', '124', 'camlanns_torment', '', '8', '300', '0', '133', '5', '1', '13', '12', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('121', '125', 'stardiver', '', '8', '357', '255', '134', '5', '1', '9', '1', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('122', '128', 'blade_rin', '', '9', '5', '0', '151', '5', '1', '1', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('123', '129', 'blade_retsu', '', '9', '30', '0', '152', '5', '1', '4', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('124', '130', 'blade_teki', '', '9', '70', '8', '153', '5', '1', '5', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('125', '131', 'blade_to', '', '9', '100', '32', '154', '5', '1', '7', '6', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('126', '132', 'blade_chi', '', '9', '150', '4', '155', '5', '1', '1', '8', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('127', '133', 'blade_ei', '', '9', '175', '255', '156', '5', '1', '2', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('128', '134', 'blade_jin', '', '9', '200', '0', '157', '5', '1', '6', '8', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('129', '135', 'blade_ten', '', '9', '225', '0', '158', '5', '1', '9', '0', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('130', '136', 'blade_ku', '', '9', '250', '0', '159', '5', '1', '9', '1', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('131', '139', 'blade_yu', '', '9', '290', '8', '162', '5', '1', '5', '4', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('132', '137', 'blade_metsu', '', '9', '300', '0', '160', '5', '1', '14', '12', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('133', '138', 'blade_kamu', '', '9', '300', '0', '161', '5', '1', '12', '2', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('134', '140', 'blade_hi', '', '9', '300', '0', '163', '5', '1', '14', '9', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('135', '141', 'blade_shun', '', '9', '357', '0', '164', '5', '1', '11', '8', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('136', '144', 'tachi_enpi', '', '10', '5', '0', '166', '5', '1', '1', '4', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('137', '145', 'tachi_hobaku', '', '10', '30', '0', '167', '5', '1', '7', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('138', '146', 'tachi_goten', '', '10', '70', '64', '168', '5', '1', '1', '8', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('139', '147', 'tachi_kagero', '', '10', '100', '2', '169', '5', '1', '3', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('140', '148', 'tachi_jinpu', '', '10', '150', '16', '170', '5', '1', '4', '6', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('141', '149', 'tachi_koki', '', '10', '175', '128', '171', '5', '1', '5', '8', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('142', '150', 'tachi_yukikaze', '', '10', '200', '0', '172', '5', '1', '7', '6', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('143', '151', 'tachi_gekko', '', '10', '225', '0', '173', '5', '1', '10', '5', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('144', '152', 'tachi_kasha', '', '10', '250', '0', '174', '5', '1', '11', '2', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('145', '153', 'tachi_kaiten', '', '10', '300', '0', '175', '5', '1', '13', '12', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('146', '154', 'tachi_rana', '', '10', '300', '0', '176', '5', '1', '9', '7', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('147', '155', 'tachi_ageha', '', '10', '300', '0', '177', '5', '1', '2', '4', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('148', '156', 'tachi_fudo', '', '10', '300', '0', '178', '5', '1', '13', '10', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('149', '157', 'tachi_shoha', '', '10', '357', '0', '179', '5', '1', '12', '2', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('150', '160', 'shining_strike', '', '11', '5', '128', '76', '5', '1', '8', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('151', '161', 'seraph_strike', '', '11', '40', '128', '77', '5', '1', '8', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('152', '162', 'brainshaker', '', '11', '70', '0', '78', '5', '1', '5', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('153', '163', 'starlight', '', '11', '100', '0', '79', '5', '1', '0', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('154', '164', 'moonlight', '', '11', '125', '0', '80', '5', '1', '0', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('155', '165', 'skullbreaker', '', '11', '150', '0', '81', '5', '1', '7', '5', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('156', '166', 'true_strike', '', '11', '175', '0', '82', '5', '1', '6', '8', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('157', '167', 'judgment', '', '11', '200', '0', '83', '5', '1', '8', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('158', '168', 'hexa_strike', '', '11', '220', '0', '84', '5', '1', '11', '0', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('159', '169', 'black_halo', '', '11', '230', '0', '85', '5', '1', '12', '2', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('160', '172', 'flash_nova', '', '11', '290', '128', '88', '5', '1', '7', '5', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('161', '170', 'randgrith', '', '11', '300', '0', '86', '5', '1', '13', '12', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('162', '171', 'mystic_boon', '', '11', '300', '0', '87', '5', '1', '0', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('163', '173', 'dagan', '', '11', '300', '0', '89', '5', '1', '0', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('164', '174', 'realmrazer', '', '11', '357', '0', '90', '5', '1', '11', '8', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('165', '176', 'heavy_swing', '', '12', '5', '0', '136', '5', '1', '8', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('166', '177', 'rock_crusher', '', '12', '40', '4', '137', '5', '1', '8', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('167', '178', 'earth_crusher', '', '12', '70', '4', '138', '5', '2', '6', '8', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('168', '179', 'starburst', '', '12', '100', '255', '139', '5', '1', '2', '5', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('169', '180', 'sunburst', '', '12', '150', '0', '140', '5', '1', '2', '5', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('170', '181', 'shell_crusher', '', '12', '175', '0', '141', '5', '1', '6', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('171', '182', 'full_swing', '', '12', '200', '0', '142', '5', '1', '3', '8', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('172', '183', 'spirit_taker', '', '12', '215', '0', '143', '5', '1', '0', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('173', '184', 'retribution', '', '12', '230', '0', '144', '5', '1', '9', '5', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('174', '240', 'tartarus_torpor', '', '12', '240', '0', '149', '10', '2', '0', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('175', '189', 'cataclysm', '', '12', '290', '255', '231', '5', '2', '2', '5', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('176', '185', 'gate_of_tartarus', '', '12', '300', '0', '145', '5', '1', '14', '10', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('177', '186', 'vidohunir', '', '12', '300', '0', '146', '5', '1', '12', '10', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('178', '187', 'garland_of_bliss', '', '12', '300', '0', '147', '5', '1', '11', '5', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('179', '188', 'omniscience', '', '12', '300', '0', '148', '5', '1', '9', '1', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('180', '190', 'myrkr', '', '12', '300', '0', '150', '5', '1', '0', '0', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('181', '191', 'shattersoul', '', '12', '357', '0', '239', '5', '1', '9', '7', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('182', '192', 'flaming_arrow', '', '25', '5', '2', '191', '16', '1', '3', '1', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('183', '193', 'piercing_arrow', '', '25', '40', '0', '192', '16', '1', '5', '1', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('184', '194', 'dulling_arrow', '', '25', '80', '0', '193', '16', '1', '3', '1', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('185', '196', 'sidewinder', '', '25', '175', '0', '195', '16', '1', '5', '1', '6', '0', '1');
INSERT INTO `weapon_skills` VALUES ('186', '197', 'blast_arrow', '', '25', '200', '0', '219', '18', '1', '7', '1', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('187', '198', 'arching_arrow', '', '25', '225', '0', '220', '16', '1', '11', '0', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('188', '199', 'empyreal_arrow', '', '25', '250', '0', '221', '18', '1', '11', '1', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('189', '201', 'refulgent_arrow', '', '25', '290', '0', '232', '16', '1', '5', '1', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('190', '200', 'namas_arrow', '', '25', '300', '0', '225', '16', '1', '13', '10', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('191', '202', 'jishnus_radiance', '', '25', '357', '0', '234', '16', '1', '13', '11', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('192', '203', 'apex_arrow', '', '25', '357', '0', '240', '16', '1', '12', '1', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('193', '208', 'hot_shot', '', '26', '5', '2', '196', '16', '1', '3', '1', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('194', '209', 'split_shot', '', '26', '40', '0', '197', '16', '1', '5', '1', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('195', '210', 'sniper_shot', '', '26', '80', '0', '198', '16', '1', '3', '1', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('196', '212', 'slug_shot', '', '26', '175', '0', '200', '16', '1', '5', '1', '6', '0', '1');
INSERT INTO `weapon_skills` VALUES ('197', '213', 'blast_shot', '', '26', '200', '0', '222', '18', '1', '7', '1', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('198', '214', 'heavy_shot', '', '26', '225', '0', '223', '16', '1', '11', '0', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('199', '215', 'detonator', '', '26', '250', '0', '224', '18', '1', '11', '1', '0', '1', '1');
INSERT INTO `weapon_skills` VALUES ('200', '219', 'numbing_shot', '', '26', '290', '0', '229', '7', '1', '8', '6', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('201', '216', 'coronach', '', '26', '300', '0', '226', '16', '1', '14', '12', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('202', '217', 'trueflight', '', '26', '300', '128', '227', '16', '1', '12', '4', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('203', '218', 'leaden_salute', '', '26', '300', '255', '228', '16', '1', '9', '1', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('204', '220', 'wildfire', '', '26', '357', '2', '235', '16', '1', '14', '9', '0', '0', '1');
INSERT INTO `weapon_skills` VALUES ('205', '221', 'last_stand', '', '26', '357', '0', '241', '16', '1', '11', '5', '0', '0', '1');
