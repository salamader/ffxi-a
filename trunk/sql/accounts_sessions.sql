/*
MySQL Data Transfer
Source Host: localhost
Source Database: database
Target Host: localhost
Target Database: database
Date: 8/21/2013 9:20:11 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for accounts_sessions
-- ----------------------------
DROP TABLE IF EXISTS `accounts_sessions`;
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
  `client_port` smallint(5) NOT NULL DEFAULT '0',
  `sessions` int(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`charid`),
  UNIQUE KEY `accid` (`accid`)
) ENGINE=MyISAM AUTO_INCREMENT=1024 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- ----------------------------
-- Records 
-- ----------------------------
