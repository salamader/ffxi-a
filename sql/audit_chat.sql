/*
MySQL Data Transfer
Source Host: localhost
Source Database: database
Target Host: localhost
Target Database: database
Date: 9/14/2013 10:55:28 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for audit_chat
-- ----------------------------
CREATE TABLE `audit_chat` (
  `lineID` int(10) NOT NULL AUTO_INCREMENT,
  `speaker` tinytext NOT NULL,
  `type` tinytext NOT NULL,
  `recipient` tinytext,
  `message` tinytext NOT NULL,
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`lineID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
