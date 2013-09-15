/*
MySQL Data Transfer
Source Host: localhost
Source Database: database
Target Host: localhost
Target Database: database
Date: 9/14/2013 10:55:13 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for char_effects
-- ----------------------------
CREATE TABLE `char_effects` (
  `charid` int(10) unsigned NOT NULL,
  `effectid` smallint(5) unsigned NOT NULL,
  `icon` smallint(5) unsigned NOT NULL DEFAULT '0',
  `power` smallint(5) unsigned NOT NULL DEFAULT '0',
  `tick` int(10) unsigned NOT NULL DEFAULT '0',
  `duration` int(10) unsigned NOT NULL DEFAULT '0',
  `subid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `subpower` smallint(5) NOT NULL DEFAULT '0',
  `tier` smallint(5) unsigned NOT NULL DEFAULT '0',
  KEY `charid` (`charid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for char_equip
-- ----------------------------
CREATE TABLE `char_equip` (
  `charid` int(10) unsigned NOT NULL,
  `main` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `sub` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ranged` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ammo` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `head` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `body` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `hands` tinyint(2) unsigned NOT NULL DEFAULT '2',
  `legs` tinyint(2) unsigned NOT NULL DEFAULT '3',
  `feet` tinyint(2) unsigned NOT NULL DEFAULT '4',
  `neck` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `waist` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ear1` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ear2` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ring1` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ring2` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `back` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `link` tinyint(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`charid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=41;

-- ----------------------------
-- Table structure for char_exp
-- ----------------------------
CREATE TABLE `char_exp` (
  `charid` int(10) unsigned NOT NULL,
  `mode` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `war` smallint(5) unsigned NOT NULL DEFAULT '0',
  `mnk` smallint(5) unsigned NOT NULL DEFAULT '0',
  `whm` smallint(5) unsigned NOT NULL DEFAULT '0',
  `blm` smallint(5) unsigned NOT NULL DEFAULT '0',
  `rdm` smallint(5) unsigned NOT NULL DEFAULT '0',
  `thf` smallint(5) unsigned NOT NULL DEFAULT '0',
  `pld` smallint(5) unsigned NOT NULL DEFAULT '0',
  `drk` smallint(5) unsigned NOT NULL DEFAULT '0',
  `bst` smallint(5) unsigned NOT NULL DEFAULT '0',
  `brd` smallint(5) unsigned NOT NULL DEFAULT '0',
  `rng` smallint(5) unsigned NOT NULL DEFAULT '0',
  `sam` smallint(5) unsigned NOT NULL DEFAULT '0',
  `nin` smallint(5) unsigned NOT NULL DEFAULT '0',
  `drg` smallint(5) unsigned NOT NULL DEFAULT '0',
  `smn` smallint(5) unsigned NOT NULL DEFAULT '0',
  `blu` smallint(5) unsigned NOT NULL DEFAULT '0',
  `cor` smallint(5) unsigned NOT NULL DEFAULT '0',
  `pup` smallint(5) unsigned NOT NULL DEFAULT '0',
  `dnc` smallint(5) unsigned NOT NULL DEFAULT '0',
  `sch` smallint(5) unsigned NOT NULL DEFAULT '0',
  `geo` smallint(5) unsigned NOT NULL DEFAULT '0',
  `run` smallint(5) unsigned NOT NULL DEFAULT '0',
  `merits` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `limits` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`charid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=85;

-- ----------------------------
-- Table structure for char_inventory
-- ----------------------------
CREATE TABLE `char_inventory` (
  `charid` int(10) unsigned NOT NULL,
  `location` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `slot` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `itemId` smallint(5) unsigned NOT NULL DEFAULT '65535',
  `quantity` int(10) unsigned NOT NULL DEFAULT '0',
  `locked` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `col` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `row` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `level` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `rotation` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `bazaar` int(8) unsigned NOT NULL DEFAULT '0',
  `signature` varchar(20) NOT NULL DEFAULT '',
  `currCharges` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `lastUseTime` int(10) unsigned NOT NULL DEFAULT '0',
  `worn` tinyint(1) NOT NULL DEFAULT '0',
  `augment0` smallint(5) unsigned NOT NULL DEFAULT '0',
  `augment1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `augment2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `augment3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `trialNumber` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`charid`,`location`,`slot`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=28;

-- ----------------------------
-- Table structure for char_jobs
-- ----------------------------
CREATE TABLE `char_jobs` (
  `charid` int(10) unsigned NOT NULL,
  `unlocked` int(10) unsigned NOT NULL DEFAULT '126',
  `genkai` tinyint(2) unsigned NOT NULL DEFAULT '50',
  `war` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `mnk` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `whm` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `blm` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `rdm` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `thf` tinyint(2) unsigned NOT NULL DEFAULT '1',
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
  PRIMARY KEY (`charid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=95;

-- ----------------------------
-- Table structure for char_look
-- ----------------------------
CREATE TABLE `char_look` (
  `charid` int(10) unsigned NOT NULL,
  `face` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `race` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `size` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `head` smallint(4) unsigned NOT NULL DEFAULT '0',
  `body` smallint(4) unsigned NOT NULL DEFAULT '8',
  `hands` smallint(4) unsigned NOT NULL DEFAULT '8',
  `legs` smallint(4) unsigned NOT NULL DEFAULT '8',
  `feet` smallint(4) unsigned NOT NULL DEFAULT '8',
  `main` smallint(4) unsigned NOT NULL DEFAULT '0',
  `sub` smallint(4) unsigned NOT NULL DEFAULT '0',
  `ranged` smallint(4) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`charid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=24;

-- ----------------------------
-- Table structure for char_pet
-- ----------------------------
CREATE TABLE `char_pet` (
  `charid` int(10) unsigned NOT NULL,
  `wyvernid` smallint(3) unsigned NOT NULL DEFAULT '0',
  `automatonid` smallint(3) unsigned NOT NULL DEFAULT '0',
  `unlocked_attachments` blob,
  `equipped_attachments` blob,
  `adventuringfellowid` smallint(3) unsigned NOT NULL DEFAULT '0',
  `chocoboid` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`charid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for char_pet_name
-- ----------------------------
CREATE TABLE `char_pet_name` (
  `charid` int(10) unsigned NOT NULL,
  `wyvernid` smallint(3) unsigned NOT NULL DEFAULT '0',
  `automatonid` smallint(3) unsigned NOT NULL DEFAULT '0',
  `adventuringfellowid` smallint(3) unsigned NOT NULL DEFAULT '0',
  `chocoboid` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`charid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for char_points
-- ----------------------------
CREATE TABLE `char_points` (
  `charid` int(10) NOT NULL,
  `sandoria_cp` int(15) NOT NULL DEFAULT '0',
  `bastok_cp` int(15) NOT NULL DEFAULT '0',
  `windurst_cp` int(15) NOT NULL DEFAULT '0',
  `sandoria_supply` int(10) NOT NULL DEFAULT '0',
  `bastok_supply` int(10) NOT NULL DEFAULT '0',
  `windurst_supply` int(10) NOT NULL DEFAULT '0',
  `imperial_standing` int(15) NOT NULL DEFAULT '0',
  `runic_portal` tinyint(3) NOT NULL DEFAULT '0',
  `leujaoam_assault_point` int(10) NOT NULL DEFAULT '0',
  `mamool_assault_point` int(10) NOT NULL DEFAULT '0',
  `lebros_assault_point` int(10) NOT NULL DEFAULT '0',
  `periqia_assault_point` int(10) NOT NULL DEFAULT '0',
  `ilrusi_assault_point` int(10) NOT NULL DEFAULT '0',
  `nyzul_isle_assault_point` int(10) NOT NULL DEFAULT '0',
  `zeni_point` int(15) NOT NULL DEFAULT '0',
  `maw` int(10) NOT NULL DEFAULT '0',
  `past_sandoria_tp` int(10) NOT NULL DEFAULT '0',
  `past_bastok_tp` int(10) NOT NULL DEFAULT '0',
  `past_windurst_tp` int(10) NOT NULL DEFAULT '0',
  `allied_notes` int(15) NOT NULL DEFAULT '0',
  `tabs` int(15) NOT NULL DEFAULT '0',
  `bayld` int(15) NOT NULL DEFAULT '0',
  PRIMARY KEY (`charid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for char_profile
-- ----------------------------
CREATE TABLE `char_profile` (
  `charid` int(10) unsigned NOT NULL,
  `rank_points` int(10) unsigned NOT NULL DEFAULT '0',
  `rank_sandoria` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `rank_bastok` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `rank_windurst` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `fame_sandoria` smallint(5) unsigned NOT NULL DEFAULT '0',
  `fame_bastok` smallint(5) unsigned NOT NULL DEFAULT '0',
  `fame_windurst` smallint(5) unsigned NOT NULL DEFAULT '0',
  `fame_norg` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`charid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for char_skills
-- ----------------------------
CREATE TABLE `char_skills` (
  `charid` int(10) unsigned NOT NULL,
  `skillid` tinyint(2) unsigned NOT NULL,
  `value` smallint(4) unsigned NOT NULL DEFAULT '0',
  `rank` tinyint(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`charid`,`skillid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=10;

-- ----------------------------
-- Table structure for char_stats
-- ----------------------------
CREATE TABLE `char_stats` (
  `charid` int(10) unsigned NOT NULL,
  `hp` smallint(4) unsigned NOT NULL DEFAULT '50',
  `mp` smallint(4) unsigned NOT NULL DEFAULT '50',
  `nameflags` int(10) unsigned NOT NULL DEFAULT '0',
  `mhflag` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mjob` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `sjob` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `death` int(10) unsigned NOT NULL DEFAULT '0',
  `2h` int(10) unsigned NOT NULL DEFAULT '0',
  `title` smallint(4) unsigned NOT NULL DEFAULT '0',
  `bazaar_message` varchar(120) NOT NULL DEFAULT '\0',
  `dex` int(3) NOT NULL DEFAULT '0',
  `vit` int(3) NOT NULL DEFAULT '0',
  `agi` int(3) NOT NULL DEFAULT '0',
  `ini` int(3) NOT NULL DEFAULT '0',
  `mnd` int(3) NOT NULL DEFAULT '0',
  `chr` int(3) NOT NULL DEFAULT '0',
  `str` int(3) NOT NULL DEFAULT '0',
  `prev_nameflags` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`charid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for char_storage
-- ----------------------------
CREATE TABLE `char_storage` (
  `charid` int(10) unsigned NOT NULL,
  `inventory` tinyint(2) unsigned NOT NULL DEFAULT '30',
  `safe` tinyint(2) unsigned NOT NULL DEFAULT '50',
  `locker` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `satchel` tinyint(2) unsigned NOT NULL DEFAULT '30',
  `sack` tinyint(2) unsigned NOT NULL DEFAULT '30',
  PRIMARY KEY (`charid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for char_vars
-- ----------------------------
CREATE TABLE `char_vars` (
  `charid` int(10) unsigned NOT NULL,
  `varname` varchar(30) NOT NULL,
  `value` int(11) NOT NULL,
  PRIMARY KEY (`charid`,`varname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for char_weapon_skill_points
-- ----------------------------
CREATE TABLE `char_weapon_skill_points` (
  `itemindex` int(10) NOT NULL,
  `charid` int(10) NOT NULL,
  `points` int(10) NOT NULL,
  PRIMARY KEY (`itemindex`,`charid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for chars
-- ----------------------------
CREATE TABLE `chars` (
  `charid` int(10) unsigned NOT NULL,
  `accid` int(10) unsigned NOT NULL,
  `charname` varchar(15) NOT NULL,
  `nation` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `pos_zone` smallint(1) NOT NULL DEFAULT '0',
  `pos_prevzone` smallint(1) NOT NULL DEFAULT '0',
  `pos_rot` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `pos_x` float(7,3) NOT NULL DEFAULT '0.000',
  `pos_y` float(7,3) NOT NULL DEFAULT '0.000',
  `pos_z` float(7,3) NOT NULL DEFAULT '0.000',
  `boundary` smallint(5) unsigned NOT NULL DEFAULT '0',
  `home_zone` smallint(3) NOT NULL DEFAULT '0',
  `home_rot` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `home_x` float(7,3) NOT NULL DEFAULT '0.000',
  `home_y` float(7,3) NOT NULL DEFAULT '0.000',
  `home_z` float(7,3) NOT NULL DEFAULT '0.000',
  `merits` blob,
  `missions` blob,
  `quests` blob,
  `keyitems` blob,
  `spells` blob,
  `set_blue_spells` blob,
  `abilities` blob,
  `titles` blob,
  `zones` blob,
  `playtime` int(10) unsigned NOT NULL DEFAULT '0',
  `unlocked_weapons` blob,
  `gmlevel` smallint(3) NOT NULL DEFAULT '4',
  `online` int(1) NOT NULL DEFAULT '0',
  `shutdown` int(1) NOT NULL DEFAULT '0',
  `zoning` int(1) NOT NULL DEFAULT '-1',
  `returning` int(1) NOT NULL DEFAULT '0',
  `first_login` int(1) NOT NULL DEFAULT '0',
  `godmode` int(1) NOT NULL DEFAULT '0',
  `setexprates` int(2) NOT NULL DEFAULT '1',
  `ragemode` int(1) NOT NULL DEFAULT '0',
  `inevent` int(1) NOT NULL DEFAULT '0',
  `eventid` int(10) NOT NULL DEFAULT '-1',
  `deathstate` int(1) NOT NULL DEFAULT '0',
  `speed` int(3) NOT NULL DEFAULT '0',
  `death_zone` smallint(1) DEFAULT '0',
  `death_x` float(7,3) DEFAULT '0.000',
  `death_y` float(7,3) DEFAULT '0.000',
  `death_z` float(7,3) DEFAULT '0.000',
  `death_rot` tinyint(3) DEFAULT '0',
  `sessions` int(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`charid`),
  FULLTEXT KEY `charname` (`charname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for chars_chat_config
-- ----------------------------
CREATE TABLE `chars_chat_config` (
  `charid` int(255) unsigned NOT NULL DEFAULT '0',
  `unk0` int(255) NOT NULL DEFAULT '0',
  `unk1` int(255) NOT NULL DEFAULT '0',
  `unk2` int(255) NOT NULL DEFAULT '0',
  `unk3` int(255) NOT NULL DEFAULT '0',
  `unk4` int(255) NOT NULL DEFAULT '0',
  `unk5` int(255) NOT NULL DEFAULT '0',
  `unk6` int(255) NOT NULL DEFAULT '0',
  `unk7` int(255) NOT NULL DEFAULT '0',
  `unk8` int(255) NOT NULL DEFAULT '0',
  `unk9` int(255) NOT NULL DEFAULT '0',
  `unk10` int(255) NOT NULL DEFAULT '0',
  `unk11` int(255) NOT NULL DEFAULT '0',
  `unk12` int(255) NOT NULL DEFAULT '0',
  `unk13` int(255) NOT NULL DEFAULT '0',
  `unk14` int(255) NOT NULL DEFAULT '0',
  `unk15` int(255) NOT NULL DEFAULT '0',
  `unk16` int(255) NOT NULL DEFAULT '0',
  `unk17` int(255) NOT NULL DEFAULT '0',
  `unk18` int(255) NOT NULL DEFAULT '0',
  `unk19` int(255) NOT NULL DEFAULT '0',
  `unk20` int(255) NOT NULL DEFAULT '0',
  `unk21` int(255) NOT NULL DEFAULT '0',
  `unk22` int(255) NOT NULL DEFAULT '0',
  `unk23` int(255) NOT NULL DEFAULT '0',
  `unk24` int(255) NOT NULL DEFAULT '0',
  `unk25` int(255) NOT NULL DEFAULT '0',
  `unk26` int(255) NOT NULL DEFAULT '0',
  `unk27` int(255) NOT NULL DEFAULT '0',
  `unk28` int(255) NOT NULL DEFAULT '0',
  `unk29` int(255) NOT NULL DEFAULT '0',
  `unk30` int(255) NOT NULL DEFAULT '0',
  `unk31` int(255) NOT NULL DEFAULT '0',
  `unk32` int(255) NOT NULL DEFAULT '0',
  `unk33` int(255) NOT NULL DEFAULT '0',
  `unk34` int(255) NOT NULL DEFAULT '0',
  `unk35` int(255) NOT NULL DEFAULT '0',
  `unk36` int(255) NOT NULL DEFAULT '36',
  PRIMARY KEY (`charid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for chars_keyitems
-- ----------------------------
CREATE TABLE `chars_keyitems` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `charid` int(255) NOT NULL DEFAULT '0',
  `keyid` int(255) NOT NULL DEFAULT '0',
  `keyname` varchar(60) NOT NULL DEFAULT 'noname',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Trigger structure for char_insert
-- ----------------------------
DELIMITER ;;
CREATE TRIGGER `char_insert` BEFORE INSERT ON `chars` FOR EACH ROW BEGIN
	INSERT INTO `char_equip`     SET `charid` = NEW.charid;
	INSERT INTO `char_exp`       SET `charid` = NEW.charid;
	INSERT INTO `char_jobs`      SET `charid` = NEW.charid;
	INSERT INTO `char_pet_name`  SET `charid` = NEW.charid;
	INSERT INTO `char_points`    SET `charid` = NEW.charid;
	INSERT INTO `char_profile`   SET `charid` = NEW.charid;
	INSERT INTO `char_storage`   SET `charid` = NEW.charid;
	INSERT INTO `char_inventory` SET `charid` = NEW.charid;
END;;
DELIMITER ;

-- ----------------------------
-- Trigger structure for char_delete
-- ----------------------------
DELIMITER ;;
CREATE TRIGGER `char_delete` BEFORE DELETE ON `chars` FOR EACH ROW BEGIN
	DELETE FROM `char_effects`   WHERE `charid` = OLD.charid;
	DELETE FROM `char_equip`     WHERE `charid` = OLD.charid;
	DELETE FROM `char_exp`       WHERE `charid` = OLD.charid;
	DELETE FROM `char_inventory` WHERE `charid` = OLD.charid;
	DELETE FROM `char_jobs`      WHERE `charid` = OLD.charid;
	DELETE FROM `char_look`      WHERE `charid` = OLD.charid;
	DELETE FROM `char_pet_name`  WHERE `charid` = OLD.charid;
	DELETE FROM `char_points`    WHERE `charid` = OLD.charid;
	DELETE FROM `char_profile`   WHERE `charid` = OLD.charid;
	DELETE FROM `char_skills`    WHERE `charid` = OLD.charid;
	DELETE FROM `char_stats`     WHERE `charid` = OLD.charid;
	DELETE FROM `char_storage`   WHERE `charid` = OLD.charid;
	DELETE FROM `char_vars`      WHERE `charid` = OLD.charid;
	DELETE FROM `char_weapon_skill_points` WHERE `charid` = OLD.charid;
	DELETE FROM `auction_house`  WHERE `seller` = OLD.charid;
	DELETE FROM `delivery_box`   WHERE `charid` = OLD.charid;
END;;
DELIMITER ;
