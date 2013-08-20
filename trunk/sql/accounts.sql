/*
MySQL Data Transfer
Source Host: ffxi-a.com
Source Database: database
Target Host: ffxi-a.com
Target Database: database
Date: 8/20/2013 8:58:19 AM
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
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Trigger structure for account_delete
-- ----------------------------
DELIMITER ;;
CREATE TRIGGER `account_delete` BEFORE DELETE ON `accounts` FOR EACH ROW BEGIN
	DELETE FROM `accounts_banned` WHERE `accid` = OLD.id;
	DELETE FROM `chars` WHERE `accid` = OLD.id;     
END;;
DELIMITER ;
