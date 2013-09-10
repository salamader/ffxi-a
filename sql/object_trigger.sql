/*
MySQL Data Transfer
Source Host: localhost
Source Database: database
Target Host: localhost
Target Database: database
Date: 9/10/2013 3:08:36 AM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for object_trigger
-- ----------------------------
CREATE TABLE `object_trigger` (
  `id` int(255) NOT NULL DEFAULT '0',
  `npcid` int(255) NOT NULL DEFAULT '0',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'noname',
  `event_1` int(16) NOT NULL DEFAULT '-1',
  `inzone` int(255) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records 
-- ----------------------------
