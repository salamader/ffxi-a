/*
MySQL Data Transfer
Source Host: localhost
Source Database: database
Target Host: localhost
Target Database: database
Date: 9/14/2013 10:53:46 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for accounts
-- ----------------------------
CREATE TABLE `accounts` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `login` varchar(16) NOT NULL DEFAULT '',
  `password` varchar(64) NOT NULL DEFAULT '',
  `email` varchar(64) NOT NULL DEFAULT '',
  `timecreate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `timelastmodify` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `content_ids` tinyint(2) NOT NULL DEFAULT '4',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `priv` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `security` int(1) NOT NULL DEFAULT '0',
  `clean_password` varchar(16) NOT NULL DEFAULT 'clean',
  `online` int(1) NOT NULL DEFAULT '0',
  `sessions` int(255) NOT NULL DEFAULT '0',
  `server_type` int(1) NOT NULL DEFAULT '0',
  `expansions` int(255) NOT NULL DEFAULT '4094',
  `pic` varchar(255) NOT NULL DEFAULT 'http://ffxi-a.com/images/user.jpg',
  `map_time` int(255) NOT NULL DEFAULT '0',
  `lobby_time` int(255) NOT NULL DEFAULT '0',
  `on_map` int(1) NOT NULL DEFAULT '0',
  `ip` varchar(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for accounts_banned
-- ----------------------------
CREATE TABLE `accounts_banned` (
  `accid` int(10) unsigned NOT NULL DEFAULT '0',
  `timebann` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `timeunbann` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `banncomment` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`accid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for accounts_profile_pics
-- ----------------------------
CREATE TABLE `accounts_profile_pics` (
  `id` int(255) NOT NULL DEFAULT '0',
  `pic` varchar(255) NOT NULL,
  `list` int(255) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`list`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for accounts_sessions
-- ----------------------------
CREATE TABLE `accounts_sessions` (
  `accid` int(10) NOT NULL DEFAULT '0',
  `charid` int(10) NOT NULL DEFAULT '0',
  `targid` smallint(5) NOT NULL DEFAULT '1024',
  `partyid` int(10) NOT NULL DEFAULT '0',
  `linkshellid` int(10) NOT NULL DEFAULT '0',
  `linkshellrank` smallint(5) NOT NULL DEFAULT '0',
  `session_key` binary(255) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `server_addr` int(255) NOT NULL DEFAULT '0',
  `server_port` smallint(5) NOT NULL DEFAULT '0',
  `client_addr` int(10) NOT NULL DEFAULT '0',
  `client_port` int(255) NOT NULL DEFAULT '0',
  `sessions` int(255) NOT NULL DEFAULT '0',
  `lobby_session` int(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`charid`),
  UNIQUE KEY `accid` (`accid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;


-- ----------------------------
-- Trigger structure for account_delete
-- ----------------------------
DELIMITER ;;
CREATE TRIGGER `account_delete` BEFORE DELETE ON `accounts` FOR EACH ROW BEGIN
	DELETE FROM `accounts_banned` WHERE `accid` = OLD.id;
	DELETE FROM `chars` WHERE `accid` = OLD.id;     
END;;
DELIMITER ;
