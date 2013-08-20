/*
MySQL Data Transfer
Source Host: localhost
Source Database: database
Target Host: localhost
Target Database: database
Date: 8/20/2013 11:08:20 AM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for accounts_sessions
-- ----------------------------
CREATE TABLE `accounts_sessions` (
  `accid` int(10) unsigned NOT NULL DEFAULT '0',
  `charid` int(10) unsigned NOT NULL DEFAULT '0',
  `targid` smallint(5) NOT NULL AUTO_INCREMENT,
  `partyid` int(10) unsigned NOT NULL DEFAULT '0',
  `linkshellid` int(10) unsigned NOT NULL DEFAULT '0',
  `linkshellrank` smallint(5) unsigned NOT NULL DEFAULT '0',
  `session_key` binary(20) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `server_addr` int(10) unsigned zerofill NOT NULL DEFAULT '0000000000',
  `server_port` smallint(5) unsigned NOT NULL DEFAULT '0',
  `client_addr` int(10) unsigned zerofill NOT NULL DEFAULT '0000000000',
  `client_port` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`charid`,`targid`),
  UNIQUE KEY `accid` (`accid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `accounts_sessions` VALUES ('0', '0', '1024', '0', '0', '0', '', '0000000000', '0', '0000000000', '0');
