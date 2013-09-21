/*
MySQL Data Transfer
Source Host: localhost
Source Database: database
Target Host: localhost
Target Database: database
Date: 9/14/2013 10:55:42 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for chat
-- ----------------------------
CREATE TABLE `chat` (
  `message_id` int(255) NOT NULL AUTO_INCREMENT,
  `user_id` int(255) NOT NULL,
  `message` varchar(80) NOT NULL,
  `count` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`message_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------