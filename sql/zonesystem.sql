/*
MySQL Data Transfer
Source Host: localhost
Source Database: database
Target Host: localhost
Target Database: database
Date: 9/5/2013 3:16:02 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for zonesystem
-- ----------------------------
DROP TABLE IF EXISTS `zonesystem`;
CREATE TABLE `zonesystem` (
  `zone` int(3) unsigned NOT NULL DEFAULT '0',
  `name` tinytext NOT NULL,
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `r` int(3) NOT NULL DEFAULT '0',
  `list` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`zone`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=20 PACK_KEYS=1 CHECKSUM=1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `zonesystem` VALUES ('0', 'Residential_Area', '0', '0', '0', '0', '1');
INSERT INTO `zonesystem` VALUES ('1', 'Phanauet_Channel', '0', '-2', '0', '0', '1');
INSERT INTO `zonesystem` VALUES ('2', 'Carpenters_Landing', '-139.409', '-1.983', '58.98', '97', '1');
INSERT INTO `zonesystem` VALUES ('3', 'Manaclipper', '0', '-3', '0', '0', '1');
INSERT INTO `zonesystem` VALUES ('4', 'Bibiki_Bay', '-393.114', '-3', '-390.818', '56', '1');
INSERT INTO `zonesystem` VALUES ('5', 'Uleguerand_Range', '-264.192', '-39.953', '-538.076', '227', '1');
INSERT INTO `zonesystem` VALUES ('6', 'Bearclaw_Pinnacle', '-197.867', '-110.561', '-100.424', '255', '1');
INSERT INTO `zonesystem` VALUES ('7', 'Attohwa_Chasm', '-320.631', '-4.334', '165.318', '57', '1');
INSERT INTO `zonesystem` VALUES ('8', 'Boneyard_Gully', '35.726', '0.969', '60.244', '174', '1');
INSERT INTO `zonesystem` VALUES ('9', 'PsoXja', '-20.259', '32', '-10.269', '191', '1');
INSERT INTO `zonesystem` VALUES ('10', 'The_Shrouded_Maw', '0', '0', '0', '0', '1');
INSERT INTO `zonesystem` VALUES ('11', 'Oldton_Movalpolos', '0', '0', '0', '0', '1');
INSERT INTO `zonesystem` VALUES ('12', 'Newton_Movalpolos', '0', '0', '0', '0', '1');
INSERT INTO `zonesystem` VALUES ('13', 'Mine_Shaft_2716', '0', '0', '0', '0', '1');
INSERT INTO `zonesystem` VALUES ('14', 'Hall_of_Transference', '0', '0', '0', '0', '1');
INSERT INTO `zonesystem` VALUES ('15', 'Abyssea-Konschtat', '34', '26', '100', '153', '1');
INSERT INTO `zonesystem` VALUES ('16', 'Promyvion-Holla', '0', '0', '0', '0', '1');
INSERT INTO `zonesystem` VALUES ('17', 'Spire_of_Holla', '0', '0', '0', '0', '1');
INSERT INTO `zonesystem` VALUES ('18', 'Promyvion-Dem', '0', '0', '0', '0', '1');
INSERT INTO `zonesystem` VALUES ('19', 'Spire_of_Dem', '0', '0', '0', '0', '1');
INSERT INTO `zonesystem` VALUES ('20', 'Promyvion-Mea', '0', '0', '0', '0', '1');
INSERT INTO `zonesystem` VALUES ('21', 'Spire_of_Mea', '0', '0', '0', '0', '1');
INSERT INTO `zonesystem` VALUES ('22', 'Promyvion-Vahzl', '0', '0', '0', '0', '1');
INSERT INTO `zonesystem` VALUES ('23', 'Spire_of_Vahzl', '0', '0', '0', '0', '1');
INSERT INTO `zonesystem` VALUES ('24', 'Lufaise_Meadows', '0', '0', '0', '0', '1');
INSERT INTO `zonesystem` VALUES ('25', 'Misareaux_Coast', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('26', 'Tavnazian_Safehold', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('27', 'Phomiuna_Aqueducts', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('28', 'Sacrarium', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('29', 'Riverne-Site_B01', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('30', 'Riverne-Site_A01', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('31', 'Monarch_Linn', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('32', 'Sealions_Den', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('33', 'AlTaieu', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('34', 'Grand_Palace_of_HuXzoi', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('35', 'The_Garden_of_RuHmet', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('36', 'Empyreal_Paradox', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('37', 'Temenos', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('38', 'Apollyon', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('39', 'Dynamis-Valkurm', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('40', 'Dynamis-Buburimu', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('41', 'Dynamis-Qufim', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('42', 'Dynamis-Tavnazia', '0', '-10', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('43', 'Diorama_Abdhaljs-Ghelsba', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('44', 'Abdhaljs_Isle-Purgonorgo', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('45', 'Abyssea-Tahrongi', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('46', 'Open_sea_route_to_Al_Zahbi', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('47', 'Open_sea_route_to_Mhaura', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('48', 'Al_Zahbi', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('49', 'noname', '0', '0', '0', '0', '2');
INSERT INTO `zonesystem` VALUES ('50', 'Aht_Urhgan_Whitegate', '0', '0', '0', '0', '3');
INSERT INTO `zonesystem` VALUES ('51', 'Wajaom_Woodlands', '0', '0', '0', '0', '3');
INSERT INTO `zonesystem` VALUES ('52', 'Bhaflau_Thickets', '0', '0', '0', '0', '3');
INSERT INTO `zonesystem` VALUES ('53', 'Nashmau', '0', '0', '0', '0', '3');
INSERT INTO `zonesystem` VALUES ('54', 'Arrapago_Reef', '0', '0', '0', '0', '3');
INSERT INTO `zonesystem` VALUES ('55', 'Ilrusi_Atoll', '97', '-10', '-41', '120', '3');
INSERT INTO `zonesystem` VALUES ('56', 'Periqia', '20', '-15', '20', '192', '3');
INSERT INTO `zonesystem` VALUES ('57', 'Talacca_Cove', '0', '0', '0', '0', '3');
INSERT INTO `zonesystem` VALUES ('58', 'Silver_Sea_route_to_Nashmau', '0', '-3', '0', '0', '3');
INSERT INTO `zonesystem` VALUES ('59', 'Silver_Sea_route_to_Al_Zahbi', '0', '-3', '0', '0', '3');
INSERT INTO `zonesystem` VALUES ('60', 'The_Ashu_Talif', '0', '-26', '-59', '193', '3');
INSERT INTO `zonesystem` VALUES ('61', 'Mount_Zhayolm', '0', '0', '0', '0', '3');
INSERT INTO `zonesystem` VALUES ('62', 'Halvung', '0', '0', '0', '0', '3');
INSERT INTO `zonesystem` VALUES ('63', 'Lebros_Cavern', '-222', '-29', '4', '224', '3');
INSERT INTO `zonesystem` VALUES ('64', 'Navukgo_Execution_Chamber', '0', '0', '0', '0', '3');
INSERT INTO `zonesystem` VALUES ('65', 'Mamook', '0', '0', '0', '0', '3');
INSERT INTO `zonesystem` VALUES ('66', 'Mamool_Ja_Training_Grounds', '18', '3', '-32', '36', '3');
INSERT INTO `zonesystem` VALUES ('67', 'Jade_Sepulcher', '0', '0', '0', '0', '3');
INSERT INTO `zonesystem` VALUES ('68', 'Aydeewa_Subterrane', '0', '0', '0', '0', '3');
INSERT INTO `zonesystem` VALUES ('69', 'Leujaoam_Sanctum', '0', '-3', '-5', '33', '3');
INSERT INTO `zonesystem` VALUES ('70', 'Chocobo_Circuit', '-14', '0', '-78', '135', '3');
INSERT INTO `zonesystem` VALUES ('71', 'The_Colosseum', '0', '0', '0', '0', '3');
INSERT INTO `zonesystem` VALUES ('72', 'Alzadaal_Undersea_Ruins', '0', '0', '0', '0', '3');
INSERT INTO `zonesystem` VALUES ('73', 'Zhayolm_Remnants', '-337', '0', '-88', '5', '3');
INSERT INTO `zonesystem` VALUES ('74', 'Arrapago_Remnants', '-285', '0', '-73', '43', '3');
INSERT INTO `zonesystem` VALUES ('75', 'Bhaflau_Remnants', '11', '0', '22', '13', '4');
INSERT INTO `zonesystem` VALUES ('76', 'Silver_Sea_Remnants', '11', '0', '9', '218', '4');
INSERT INTO `zonesystem` VALUES ('77', 'Nyzul_Isle', '7', '0', '5', '223', '4');
INSERT INTO `zonesystem` VALUES ('78', 'Hazhalm_Testing_Grounds', '0', '0', '0', '0', '4');
INSERT INTO `zonesystem` VALUES ('79', 'Caedarva_Mire', '0', '0', '0', '0', '4');
INSERT INTO `zonesystem` VALUES ('80', 'Southern_San_dOria_[S]', '0', '0', '0', '0', '4');
INSERT INTO `zonesystem` VALUES ('81', 'East_Ronfaure_[S]', '0', '0', '0', '0', '4');
INSERT INTO `zonesystem` VALUES ('82', 'Jugner_Forest_[S]', '0', '0', '0', '0', '4');
INSERT INTO `zonesystem` VALUES ('83', 'Vunkerl_Inlet_[S]', '0', '0', '0', '0', '4');
INSERT INTO `zonesystem` VALUES ('84', 'Batallia_Downs_[S]', '0', '0', '0', '0', '4');
INSERT INTO `zonesystem` VALUES ('85', 'La_Vaule_[S]', '0', '0', '0', '0', '4');
INSERT INTO `zonesystem` VALUES ('86', 'Everbloom_Hollow', '22', '0', '8', '209', '4');
INSERT INTO `zonesystem` VALUES ('87', 'Bastok_Markets_[S]', '0', '0', '0', '0', '4');
INSERT INTO `zonesystem` VALUES ('88', 'North_Gustaberg_[S]', '0', '0', '0', '0', '4');
INSERT INTO `zonesystem` VALUES ('89', 'Grauberg_[S]', '0', '0', '0', '0', '4');
INSERT INTO `zonesystem` VALUES ('90', 'Pashhow_Marshlands_[S]', '0', '0', '0', '0', '4');
INSERT INTO `zonesystem` VALUES ('91', 'Rolanberry_Fields_[S]', '0', '0', '0', '0', '4');
INSERT INTO `zonesystem` VALUES ('92', 'Beadeaux_[S]', '0', '0', '0', '0', '4');
INSERT INTO `zonesystem` VALUES ('93', 'Ruhotz_Silvermines', '-1', '1', '-43', '85', '4');
INSERT INTO `zonesystem` VALUES ('94', 'Windurst_Waters_[S]', '0', '0', '0', '0', '4');
INSERT INTO `zonesystem` VALUES ('95', 'West_Sarutabaruta_[S]', '0', '0', '0', '0', '4');
INSERT INTO `zonesystem` VALUES ('96', 'Fort_Karugo-Narugo_[S]', '0', '0', '0', '0', '4');
INSERT INTO `zonesystem` VALUES ('97', 'Meriphataud_Mountains_[S]', '0', '0', '0', '0', '4');
INSERT INTO `zonesystem` VALUES ('98', 'Sauromugue_Champaign_[S]', '0', '0', '0', '0', '4');
INSERT INTO `zonesystem` VALUES ('99', 'Castle_Oztroja_[S]', '0', '0', '0', '0', '4');
INSERT INTO `zonesystem` VALUES ('100', 'West_Ronfaure', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('101', 'East_Ronfaure', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('102', 'La_Theine_Plateau', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('103', 'Valkurm_Dunes', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('104', 'Jugner_Forest', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('105', 'Batallia_Downs', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('106', 'North_Gustaberg', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('107', 'South_Gustaberg', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('108', 'Konschtat_Highlands', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('109', 'Pashhow_Marshlands', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('110', 'Rolanberry_Fields', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('111', 'Beaucedine_Glacier', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('112', 'Xarcabard', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('113', 'Cape_Teriggan', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('114', 'Eastern_Altepa_Desert', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('115', 'West_Sarutabaruta', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('116', 'East_Sarutabaruta', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('117', 'Tahrongi_Canyon', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('118', 'Buburimu_Peninsula', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('119', 'Meriphataud_Mountains', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('120', 'Sauromugue_Champaign', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('121', 'The_Sanctuary_of_ZiTah', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('122', 'RoMaeve', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('123', 'Yuhtunga_Jungle', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('124', 'Yhoator_Jungle', '0', '0', '0', '0', '5');
INSERT INTO `zonesystem` VALUES ('125', 'Western_Altepa_Desert', '0', '0', '0', '0', '6');
INSERT INTO `zonesystem` VALUES ('126', 'Qufim_Island', '0', '0', '0', '0', '6');
INSERT INTO `zonesystem` VALUES ('127', 'Behemoths_Dominion', '0', '0', '0', '0', '6');
INSERT INTO `zonesystem` VALUES ('128', 'Valley_of_Sorrows', '0', '0', '0', '0', '6');
INSERT INTO `zonesystem` VALUES ('129', 'Ghoyus_Reverie', '6', '-10', '10', '219', '6');
INSERT INTO `zonesystem` VALUES ('130', 'RuAun_Gardens', '0', '0', '0', '0', '6');
INSERT INTO `zonesystem` VALUES ('131', 'Mordion_Gaol', '0', '0', '0', '0', '6');
INSERT INTO `zonesystem` VALUES ('132', 'Abyssea-La_Theine', '0', '0', '0', '0', '6');
INSERT INTO `zonesystem` VALUES ('133', 'noname', '0', '0', '0', '0', '6');
INSERT INTO `zonesystem` VALUES ('134', 'Dynamis-Beaucedine', '0', '0', '0', '0', '6');
INSERT INTO `zonesystem` VALUES ('135', 'Dynamis-Xarcabard', '0', '0', '0', '0', '6');
INSERT INTO `zonesystem` VALUES ('136', 'Beaucedine_Glacier_[S]', '0', '0', '0', '0', '6');
INSERT INTO `zonesystem` VALUES ('137', 'Xarcabard_[S]', '0', '0', '0', '0', '6');
INSERT INTO `zonesystem` VALUES ('138', 'Castle_Zvahl_Baileys_[S]', '-160', '-24', '20', '254', '6');
INSERT INTO `zonesystem` VALUES ('139', 'Horlais_Peak', '0', '0', '0', '0', '6');
INSERT INTO `zonesystem` VALUES ('140', 'Ghelsba_Outpost', '0', '0', '0', '0', '6');
INSERT INTO `zonesystem` VALUES ('141', 'Fort_Ghelsba', '0', '0', '0', '0', '6');
INSERT INTO `zonesystem` VALUES ('142', 'Yughott_Grotto', '0', '0', '0', '0', '6');
INSERT INTO `zonesystem` VALUES ('143', 'Palborough_Mines', '0', '0', '0', '0', '6');
INSERT INTO `zonesystem` VALUES ('144', 'Waughroon_Shrine', '0', '0', '0', '0', '6');
INSERT INTO `zonesystem` VALUES ('145', 'Giddeus', '0', '0', '0', '0', '6');
INSERT INTO `zonesystem` VALUES ('146', 'Balgas_Dais', '0', '0', '0', '0', '6');
INSERT INTO `zonesystem` VALUES ('147', 'Beadeaux', '0', '0', '0', '0', '6');
INSERT INTO `zonesystem` VALUES ('148', 'Qulun_Dome', '0', '0', '0', '0', '6');
INSERT INTO `zonesystem` VALUES ('149', 'Davoi', '0', '0', '0', '0', '6');
INSERT INTO `zonesystem` VALUES ('150', 'Monastic_Cavern', '0', '0', '0', '0', '7');
INSERT INTO `zonesystem` VALUES ('151', 'Castle_Oztroja', '0', '0', '0', '0', '7');
INSERT INTO `zonesystem` VALUES ('152', 'Altar_Room', '0', '0', '0', '0', '7');
INSERT INTO `zonesystem` VALUES ('153', 'The_Boyahda_Tree', '0', '0', '0', '0', '7');
INSERT INTO `zonesystem` VALUES ('154', 'Dragons_Aery', '0', '0', '0', '0', '7');
INSERT INTO `zonesystem` VALUES ('155', 'Castle_Zvahl_Keep_[S]', '-550', '-70', '59', '0', '7');
INSERT INTO `zonesystem` VALUES ('156', 'Throne_Room_[S]', '109', '-6', '0', '128', '7');
INSERT INTO `zonesystem` VALUES ('157', 'Middle_Delkfutts_Tower', '0', '0', '0', '0', '7');
INSERT INTO `zonesystem` VALUES ('158', 'Upper_Delkfutts_Tower', '0', '0', '0', '0', '7');
INSERT INTO `zonesystem` VALUES ('159', 'Temple_of_Uggalepih', '0', '0', '0', '0', '7');
INSERT INTO `zonesystem` VALUES ('160', 'Den_of_Rancor', '0', '0', '0', '0', '7');
INSERT INTO `zonesystem` VALUES ('161', 'Castle_Zvahl_Baileys', '0', '0', '0', '0', '7');
INSERT INTO `zonesystem` VALUES ('162', 'Castle_Zvahl_Keep', '0', '0', '0', '0', '7');
INSERT INTO `zonesystem` VALUES ('163', 'Sacrificial_Chamber', '0', '0', '0', '0', '7');
INSERT INTO `zonesystem` VALUES ('164', 'Garlaige_Citadel_[S]', '0', '0', '0', '0', '7');
INSERT INTO `zonesystem` VALUES ('165', 'Throne_Room', '0', '0', '0', '0', '7');
INSERT INTO `zonesystem` VALUES ('166', 'Ranguemont_Pass', '0', '0', '0', '0', '7');
INSERT INTO `zonesystem` VALUES ('167', 'Bostaunieux_Oubliette', '0', '0', '0', '0', '7');
INSERT INTO `zonesystem` VALUES ('168', 'Chamber_of_Oracles', '0', '0', '0', '0', '7');
INSERT INTO `zonesystem` VALUES ('169', 'Toraimarai_Canal', '0', '0', '0', '0', '7');
INSERT INTO `zonesystem` VALUES ('170', 'Full_Moon_Fountain', '0', '0', '0', '0', '7');
INSERT INTO `zonesystem` VALUES ('171', 'Crawlers_Nest_[S]', '0', '0', '0', '0', '7');
INSERT INTO `zonesystem` VALUES ('172', 'Zeruhn_Mines', '0', '0', '0', '0', '7');
INSERT INTO `zonesystem` VALUES ('173', 'Korroloka_Tunnel', '0', '0', '0', '0', '7');
INSERT INTO `zonesystem` VALUES ('174', 'Kuftal_Tunnel', '0', '0', '0', '0', '7');
INSERT INTO `zonesystem` VALUES ('175', 'The_Eldieme_Necropolis_[S]', '0', '0', '0', '0', '8');
INSERT INTO `zonesystem` VALUES ('176', 'Sea_Serpent_Grotto', '0', '0', '0', '0', '8');
INSERT INTO `zonesystem` VALUES ('177', 'VeLugannon_Palace', '0', '0', '0', '0', '8');
INSERT INTO `zonesystem` VALUES ('178', 'The_Shrine_of_RuAvitau', '0', '0', '0', '0', '8');
INSERT INTO `zonesystem` VALUES ('179', 'Stellar_Fulcrum', '0', '0', '0', '194', '8');
INSERT INTO `zonesystem` VALUES ('180', 'LaLoff_Amphitheater', '0', '0', '0', '0', '8');
INSERT INTO `zonesystem` VALUES ('181', 'The_Celestial_Nexus', '0', '0', '0', '0', '8');
INSERT INTO `zonesystem` VALUES ('182', 'Walk_of_Echoes', '323', '0', '327', '105', '8');
INSERT INTO `zonesystem` VALUES ('183', 'Maquette_Abdhaljs_Legion', '12', '10', '-11', '165', '8');
INSERT INTO `zonesystem` VALUES ('184', 'Lower_Delkfutts_Tower', '0', '0', '0', '0', '8');
INSERT INTO `zonesystem` VALUES ('185', 'Dynamis-San_dOria', '0', '0', '0', '0', '8');
INSERT INTO `zonesystem` VALUES ('186', 'Dynamis-Bastok', '10', '0', '0', '0', '8');
INSERT INTO `zonesystem` VALUES ('187', 'Dynamis-Windurst', '0', '0', '0', '0', '8');
INSERT INTO `zonesystem` VALUES ('188', 'Dynamis-Jeuno', '0', '0', '0', '0', '8');
INSERT INTO `zonesystem` VALUES ('189', 'noname', '0', '0', '0', '0', '8');
INSERT INTO `zonesystem` VALUES ('190', 'King_Ranperres_Tomb', '0', '0', '0', '0', '8');
INSERT INTO `zonesystem` VALUES ('191', 'Dangruf_Wadi', '0', '0', '0', '0', '8');
INSERT INTO `zonesystem` VALUES ('192', 'Inner_Horutoto_Ruins', '0', '0', '0', '0', '8');
INSERT INTO `zonesystem` VALUES ('193', 'Ordelles_Caves', '0', '0', '0', '0', '8');
INSERT INTO `zonesystem` VALUES ('194', 'Outer_Horutoto_Ruins', '0', '0', '0', '0', '8');
INSERT INTO `zonesystem` VALUES ('195', 'The_Eldieme_Necropolis', '0', '0', '0', '0', '8');
INSERT INTO `zonesystem` VALUES ('196', 'Gusgen_Mines', '0', '0', '0', '0', '8');
INSERT INTO `zonesystem` VALUES ('197', 'Crawlers_Nest', '0', '0', '0', '0', '8');
INSERT INTO `zonesystem` VALUES ('198', 'Maze_of_Shakhrami', '0', '0', '0', '0', '8');
INSERT INTO `zonesystem` VALUES ('199', 'noname', '0', '0', '0', '0', '8');
INSERT INTO `zonesystem` VALUES ('200', 'Garlaige_Citadel', '0', '0', '0', '0', '9');
INSERT INTO `zonesystem` VALUES ('201', 'Cloister_of_Gales', '0', '0', '0', '0', '9');
INSERT INTO `zonesystem` VALUES ('202', 'Cloister_of_Storms', '0', '0', '0', '0', '9');
INSERT INTO `zonesystem` VALUES ('203', 'Cloister_of_Frost', '0', '0', '0', '0', '9');
INSERT INTO `zonesystem` VALUES ('204', 'FeiYin', '0', '0', '0', '0', '9');
INSERT INTO `zonesystem` VALUES ('205', 'Ifrits_Cauldron', '0', '0', '0', '0', '9');
INSERT INTO `zonesystem` VALUES ('206', 'QuBia_Arena', '0', '0', '0', '0', '9');
INSERT INTO `zonesystem` VALUES ('207', 'Cloister_of_Flames', '0', '0', '0', '0', '9');
INSERT INTO `zonesystem` VALUES ('208', 'Quicksand_Caves', '0', '0', '0', '0', '9');
INSERT INTO `zonesystem` VALUES ('209', 'Cloister_of_Tremors', '-635', '-14', '-498', '16', '9');
INSERT INTO `zonesystem` VALUES ('210', 'noname', '0', '0', '0', '0', '9');
INSERT INTO `zonesystem` VALUES ('211', 'Cloister_of_Tides', '0', '0', '0', '0', '9');
INSERT INTO `zonesystem` VALUES ('212', 'Gustav_Tunnel', '0', '0', '0', '0', '9');
INSERT INTO `zonesystem` VALUES ('213', 'Labyrinth_of_Onzozo', '0', '0', '0', '0', '9');
INSERT INTO `zonesystem` VALUES ('214', 'Residential_Area', '0', '0', '0', '0', '9');
INSERT INTO `zonesystem` VALUES ('215', 'Abyssea-Attohwa', '-30', '11', '-45', '122', '9');
INSERT INTO `zonesystem` VALUES ('216', 'Abyssea-Misareaux', '13', '-18', '0', '249', '9');
INSERT INTO `zonesystem` VALUES ('217', 'Abyssea-Vunkerl', '59', '-40', '-87', '223', '9');
INSERT INTO `zonesystem` VALUES ('218', 'Abyssea-Altepa', '2', '0', '0', '0', '9');
INSERT INTO `zonesystem` VALUES ('219', 'noname', '0', '0', '0', '0', '9');
INSERT INTO `zonesystem` VALUES ('220', 'Ship_bound_for_Selbina', '0', '0', '0', '0', '9');
INSERT INTO `zonesystem` VALUES ('221', 'Ship_bound_for_Mhaura', '0', '-2', '8', '65', '9');
INSERT INTO `zonesystem` VALUES ('222', 'Provenance', '-213', '-20', '-211', '22', '9');
INSERT INTO `zonesystem` VALUES ('223', 'San_dOria-Jeuno_Airship', '0', '0', '0', '0', '9');
INSERT INTO `zonesystem` VALUES ('224', 'Bastok-Jeuno_Airship', '0', '0', '0', '0', '9');
INSERT INTO `zonesystem` VALUES ('225', 'Windurst-Jeuno_Airship', '0', '0', '0', '0', '10');
INSERT INTO `zonesystem` VALUES ('226', 'Kazham-Jeuno_Airship', '0', '0', '0', '0', '10');
INSERT INTO `zonesystem` VALUES ('227', 'Ship_bound_for_Selbina', '0', '0', '0', '0', '10');
INSERT INTO `zonesystem` VALUES ('228', 'Ship_bound_for_Mhaura', '0', '0', '0', '0', '10');
INSERT INTO `zonesystem` VALUES ('229', 'noname', '0', '0', '0', '0', '10');
INSERT INTO `zonesystem` VALUES ('230', 'Southern_San_dOria', '156', '-2', '152', '52', '10');
INSERT INTO `zonesystem` VALUES ('231', 'Northern_San_dOria', '121', '0', '-1', '121', '10');
INSERT INTO `zonesystem` VALUES ('232', 'Port_San_dOria', '74', '-16', '-130', '155', '10');
INSERT INTO `zonesystem` VALUES ('233', 'Chateau_dOraguille', '0', '0', '0', '0', '10');
INSERT INTO `zonesystem` VALUES ('234', 'Bastok_Mines', '108', '0', '-72', '121', '10');
INSERT INTO `zonesystem` VALUES ('235', 'Bastok_Markets', '-184', '-8', '-29', '127', '10');
INSERT INTO `zonesystem` VALUES ('236', 'Port_Bastok', '61', '8', '-231', '183', '10');
INSERT INTO `zonesystem` VALUES ('237', 'Metalworks', '0', '0', '0', '0', '10');
INSERT INTO `zonesystem` VALUES ('238', 'Windurst_Waters', '159', '0', '-31', '192', '10');
INSERT INTO `zonesystem` VALUES ('239', 'Windurst_Walls', '-226', '0', '-119', '1', '10');
INSERT INTO `zonesystem` VALUES ('240', 'Port_Windurst', '197', '-13', '234', '63', '10');
INSERT INTO `zonesystem` VALUES ('241', 'Windurst_Woods', '-107', '-5', '40', '1', '10');
INSERT INTO `zonesystem` VALUES ('242', 'Heavens_Tower', '0', '0', '-23', '198', '10');
INSERT INTO `zonesystem` VALUES ('243', 'RuLude_Gardens', '-32', '3', '-7', '74', '10');
INSERT INTO `zonesystem` VALUES ('244', 'Upper_Jeuno', '6', '0', '-6', '174', '10');
INSERT INTO `zonesystem` VALUES ('245', 'Lower_Jeuno', '3', '0', '16', '89', '10');
INSERT INTO `zonesystem` VALUES ('246', 'Port_Jeuno', '-110', '0', '0', '255', '10');
INSERT INTO `zonesystem` VALUES ('247', 'Rabao', '0', '0', '0', '0', '10');
INSERT INTO `zonesystem` VALUES ('248', 'Selbina', '0', '0', '0', '0', '10');
INSERT INTO `zonesystem` VALUES ('249', 'Mhaura', '0', '0', '0', '0', '10');
INSERT INTO `zonesystem` VALUES ('250', 'Kazham', '0', '0', '0', '0', '11');
INSERT INTO `zonesystem` VALUES ('251', 'Hall_of_the_Gods', '0', '0', '0', '0', '11');
INSERT INTO `zonesystem` VALUES ('252', 'Norg', '0', '0', '0', '0', '11');
INSERT INTO `zonesystem` VALUES ('253', 'Abyssea-Uleguerand', '283', '16', '-298', '124', '11');
INSERT INTO `zonesystem` VALUES ('254', 'Abyssea-Grauberg', '-73', '-8', '-321', '69', '11');
INSERT INTO `zonesystem` VALUES ('255', 'Abyssea-Empyreal_Paradox', '-469', '0', '515', '163', '11');
INSERT INTO `zonesystem` VALUES ('256', 'Western_Adoulin', '177', '4', '-23', '256', '11');
INSERT INTO `zonesystem` VALUES ('257', 'Eastern_Adoulin', '-155', '0', '-19', '250', '11');
INSERT INTO `zonesystem` VALUES ('258', 'Rala_Waterways', '-586.549', '-7.5', '20.047', '258', '11');
INSERT INTO `zonesystem` VALUES ('259', 'Rala_Waterways_U', '-586.549', '-7.5', '20.047', '258', '11');
INSERT INTO `zonesystem` VALUES ('260', 'Yahse_Hunting_Grounds', '-375.141', '0.198', '132.739', '81', '11');
INSERT INTO `zonesystem` VALUES ('261', 'Ceizak_Battlegrounds', '-4.36', '0', '-36.806', '32', '11');
INSERT INTO `zonesystem` VALUES ('262', 'Foret_de_Hennetiel', '-4.491', '-2.032', '114.201', '226', '11');
INSERT INTO `zonesystem` VALUES ('263', 'Yorcia_Weald', '14.958', '-2.492', '-60.662', '212', '11');
INSERT INTO `zonesystem` VALUES ('264', 'Yorcia_Weald_U', '14.958', '-2.492', '-60.662', '212', '11');
INSERT INTO `zonesystem` VALUES ('265', 'Morimar_Basalt_Fields', '108.929', '-15.716', '-191.515', '255', '11');
INSERT INTO `zonesystem` VALUES ('266', 'Marjami_Ravine', '25.725', '0.773', '-10.179', '13', '11');
INSERT INTO `zonesystem` VALUES ('267', 'noname', '0', '0', '0', '0', '11');
INSERT INTO `zonesystem` VALUES ('268', 'Sih_Gates', '-108.886', '-10', '-249.676', '155', '11');
INSERT INTO `zonesystem` VALUES ('269', 'Moh_Gates', '83.122', '20', '-0.456', '106', '11');
INSERT INTO `zonesystem` VALUES ('270', 'Cirdas_Caverns', '43.075', '20', '0', '255', '11');
INSERT INTO `zonesystem` VALUES ('271', 'Cirdas_Caverns_U', '43.075', '20', '0', '255', '11');
INSERT INTO `zonesystem` VALUES ('272', 'Dho_Gates', '-25.183', '-10.472', '105.668', '155', '11');
INSERT INTO `zonesystem` VALUES ('273', 'noname', '0', '0', '0', '0', '11');
INSERT INTO `zonesystem` VALUES ('274', 'noname', '0', '0', '0', '0', '11');
INSERT INTO `zonesystem` VALUES ('275', 'noname', '0', '0', '0', '0', '12');
INSERT INTO `zonesystem` VALUES ('276', 'noname', '0', '0', '0', '0', '12');
INSERT INTO `zonesystem` VALUES ('277', 'noname', '0', '0', '0', '0', '12');
INSERT INTO `zonesystem` VALUES ('278', 'noname', '0', '0', '0', '0', '12');
INSERT INTO `zonesystem` VALUES ('279', 'noname', '0', '0', '0', '0', '12');
INSERT INTO `zonesystem` VALUES ('280', 'Mog_Garden', '9.147', '0.981', '-14.882', '247', '12');
INSERT INTO `zonesystem` VALUES ('281', 'noname', '0', '0', '0', '0', '12');
INSERT INTO `zonesystem` VALUES ('282', 'noname', '0', '0', '0', '0', '12');
INSERT INTO `zonesystem` VALUES ('283', 'Silver_Knife', '0', '0', '0', '0', '12');
INSERT INTO `zonesystem` VALUES ('284', 'Celennia_Wexworth_Memorial_Library', '0', '0', '0', '0', '12');
