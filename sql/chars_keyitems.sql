/*
MySQL Data Transfer
Source Host: localhost
Source Database: database
Target Host: localhost
Target Database: database
Date: 9/10/2013 12:55:34 AM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for chars_keyitems
-- ----------------------------
CREATE TABLE `chars_keyitems` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `charid` int(255) NOT NULL DEFAULT '0',
  `keyid` int(255) NOT NULL DEFAULT '0',
  `keyname` varchar(60) NOT NULL DEFAULT 'noname',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records 
-- ----------------------------
