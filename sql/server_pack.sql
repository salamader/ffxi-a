/*
MySQL Data Transfer
Source Host: localhost
Source Database: database
Target Host: localhost
Target Database: database
Date: 9/15/2013 12:37:28 AM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for server_message
-- ----------------------------
CREATE TABLE `server_message` (
  `server_message` varchar(80) CHARACTER SET utf8 NOT NULL DEFAULT 'Welcome To FFXI-A Alpha Development Server!',
  `id` int(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`server_message`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for server_variables
-- ----------------------------
CREATE TABLE `server_variables` (
  `name` varchar(50) NOT NULL,
  `value` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `server_message` VALUES ('Welcome To FFXI-A Alpha Development Server!', '1');
INSERT INTO `server_variables` VALUES ('[BF]Save_The_Children_record', '14');
INSERT INTO `server_variables` VALUES ('[BF]The_Holy_Crest_record', '600');
INSERT INTO `server_variables` VALUES ('[BF]Mission_2-3_Horlais_Peak_record', '600');
INSERT INTO `server_variables` VALUES ('[BF]Mission_2-3_Balgas_Dais_record', '18');
INSERT INTO `server_variables` VALUES ('[BF]Mission_2-3_Waughroon_record', '600');
INSERT INTO `server_variables` VALUES ('[BF]Shattering_Stars_job1_record', '600');
INSERT INTO `server_variables` VALUES ('[BF]Shattering_Stars_job2_record', '600');
INSERT INTO `server_variables` VALUES ('[BF]Shattering_Stars_job3_record', '600');
INSERT INTO `server_variables` VALUES ('[BF]Shattering_Stars_job4_record', '600');
INSERT INTO `server_variables` VALUES ('[BF]Shattering_Stars_job5_record', '600');
INSERT INTO `server_variables` VALUES ('[BF]Shattering_Stars_job6_record', '600');
INSERT INTO `server_variables` VALUES ('[BF]Shattering_Stars_job7_record', '600');
INSERT INTO `server_variables` VALUES ('[BF]Shattering_Stars_job8_record', '600');
INSERT INTO `server_variables` VALUES ('[BF]Shattering_Stars_job9_record', '600');
INSERT INTO `server_variables` VALUES ('[BF]Shattering_Stars_job10_record', '600');
INSERT INTO `server_variables` VALUES ('[BF]Shattering_Stars_job11_record', '600');
INSERT INTO `server_variables` VALUES ('[BF]Shattering_Stars_job12_record', '600');
INSERT INTO `server_variables` VALUES ('[BF]Shattering_Stars_job13_record', '600');
INSERT INTO `server_variables` VALUES ('[BF]Shattering_Stars_job14_record', '600');
INSERT INTO `server_variables` VALUES ('[BF]Shattering_Stars_job15_record', '600');
INSERT INTO `server_variables` VALUES ('[BF]Zilart_Mission_4_record', '600');
INSERT INTO `server_variables` VALUES ('[DynaXarcabard]Boss_Trigger', '2');
INSERT INTO `server_variables` VALUES ('[POP]Charybdis', '1377928473');
INSERT INTO `server_variables` VALUES ('[POP]Nidhogg', '1379325033');
INSERT INTO `server_variables` VALUES ('[PH]Swamfisk', '17191188');
INSERT INTO `server_variables` VALUES ('[POP]Mee_Deggi_the_Punisher', '1378410671');
INSERT INTO `server_variables` VALUES ('[POP]Aspidochelone', '1378126575');
INSERT INTO `server_variables` VALUES ('correctcoffer', '17002512');
INSERT INTO `server_variables` VALUES ('[PH]Jaggedy_Eared_Jack', '17187042');
INSERT INTO `server_variables` VALUES ('Bastok8-1LastClear', '1379219098');
INSERT INTO `server_variables` VALUES ('[TEMP]Respawn_qm1_for_curtana', '0');
INSERT INTO `server_variables` VALUES ('[TEMP]Respawn_qm1_for_rattle', '0');
INSERT INTO `server_variables` VALUES ('[TEMP]Respawn_qm2_for_offering', '0');
INSERT INTO `server_variables` VALUES ('[TEMP]Respawn_qm3_for_whistle', '0');
INSERT INTO `server_variables` VALUES ('[POP]Beryl-footed_Molberry', '0');
INSERT INTO `server_variables` VALUES ('[POP]Crimson-toothed_Pawberry', '0');
INSERT INTO `server_variables` VALUES ('[LANTERN]_rancor_nw_last_lit', '0');
INSERT INTO `server_variables` VALUES ('[LANTERN]_rancor_ne_last_lit', '0');
INSERT INTO `server_variables` VALUES ('[LANTERN]_rancor_sw_last_lit', '0');
INSERT INTO `server_variables` VALUES ('[LANTERN]_rancor_se_last_lit', '0');
INSERT INTO `server_variables` VALUES ('[ZM4]Fire_Headstone_Active', '0');
INSERT INTO `server_variables` VALUES ('[ZM4]Wind_Headstone_Active', '0');
INSERT INTO `server_variables` VALUES ('[ZM4]Lightning_Headstone_Active', '0');
INSERT INTO `server_variables` VALUES ('[ZM4]Light_Headstone_Active', '0');
INSERT INTO `server_variables` VALUES ('[BF]Mission_5-1_Enter', '0');
INSERT INTO `server_variables` VALUES ('[BF]Mission_5-1_QuBia_Arena_record', '15');
INSERT INTO `server_variables` VALUES ('[POP]Valkurm_Emperor', '1378031135');
INSERT INTO `server_variables` VALUES ('[PH]Nidhogg', '1');
INSERT INTO `server_variables` VALUES ('[POP]Quu_Domi_the_Gallant', '1378436461');
INSERT INTO `server_variables` VALUES ('[DynaValkurm]UniqueID', '5947');
INSERT INTO `server_variables` VALUES ('[DynaValkurm]Already_Received', '16');
INSERT INTO `server_variables` VALUES ('[POP]King_Behemoth', '1379451293');
