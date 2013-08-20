/*
MySQL Data Transfer
Source Host: localhost
Source Database: database
Target Host: localhost
Target Database: database
Date: 8/19/2013 1:31:15 PM
*/

SET FOREIGN_KEY_CHECKS=0;
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
  `gmlevel` smallint(3) unsigned NOT NULL DEFAULT '0',
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
