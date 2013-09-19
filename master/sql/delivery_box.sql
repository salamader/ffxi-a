/*
MySQL Data Transfer
Source Host: localhost
Source Database: database
Target Host: localhost
Target Database: database
Date: 9/14/2013 10:56:06 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for delivery_box
-- ----------------------------
CREATE TABLE `delivery_box` (
  `charid` int(10) unsigned NOT NULL,
  `charname` varchar(15) DEFAULT NULL,
  `box` tinyint(1) unsigned NOT NULL,
  `slot` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `itemid` smallint(5) unsigned NOT NULL,
  `itemsubid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `quantity` int(10) unsigned NOT NULL,
  `senderid` int(10) unsigned NOT NULL DEFAULT '0',
  `sender` varchar(15) DEFAULT NULL,
  `received` bit(1) NOT NULL DEFAULT b'0',
  `sent` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`charid`,`box`,`slot`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------

-- ----------------------------
-- Trigger structure for delivery_box_insert
-- ----------------------------
DELIMITER ;;
CREATE TRIGGER `delivery_box_insert` BEFORE INSERT ON `delivery_box` FOR EACH ROW BEGIN
	SET @slot := 0;
	SELECT MAX(slot) INTO @slot FROM delivery_box WHERE box = NEW.box AND charid = NEW.charid;
	IF NEW.box = 1 THEN
	IF @slot IS NULL OR @slot < 10 THEN SET NEW.slot := 10; ELSE SET NEW.slot := @slot + 1; END IF;
	END IF;
END;;
DELIMITER ;
