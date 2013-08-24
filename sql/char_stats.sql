/*
MySQL Data Transfer
Source Host: localhost
Source Database: database
Target Host: localhost
Target Database: database
Date: 8/24/2013 2:45:08 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for char_stats
-- ----------------------------
DROP TABLE IF EXISTS `char_stats`;
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
  PRIMARY KEY (`charid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

