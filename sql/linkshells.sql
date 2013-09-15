/*
MySQL Data Transfer
Source Host: localhost
Source Database: database
Target Host: localhost
Target Database: database
Date: 9/14/2013 10:57:47 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for linkshells
-- ----------------------------
CREATE TABLE `linkshells` (
  `linkshellid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '',
  `color` smallint(5) unsigned NOT NULL DEFAULT '61440',
  `poster` varchar(15) NOT NULL DEFAULT '',
  `message` varchar(115) NOT NULL DEFAULT '',
  `messagetime` int(10) unsigned NOT NULL DEFAULT '0',
  `postrights` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`linkshellid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `linkshells` VALUES ('1', 'Crashnburn', '65440', '', '', '0', '0');
