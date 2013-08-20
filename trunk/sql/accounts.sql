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
-- Records 
-- ----------------------------
INSERT INTO `accounts` VALUES ('0', 'Guest', '', '', '0000-00-00 00:00:00', '2013-08-17 10:52:12', '0', '1', '1', '0', 'clean', '0', '0');
INSERT INTO `accounts` VALUES ('2', 'Wiistream', '*6BB4837EB74329105EE4568DDA7DC67ED2CA2AD9', 'wiistreamcom@gmail.com', '0000-00-00 00:00:00', '2013-08-19 13:40:18', '4', '1', '1', '0', '123456', '0', '427318248');
INSERT INTO `accounts` VALUES ('3', 'steervame', '*67D7884344750983A9281E9A29FE5E0250D3E329', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', 'k88rv8wkAA', '0', '0');
INSERT INTO `accounts` VALUES ('4', 'Lisko', '*9F2E1B1EA7DB464EB3E860CEEBEED451491907E2', '', '0000-00-00 00:00:00', '2013-08-19 00:19:48', '4', '1', '1', '0', 'littlebig1', '0', '0');
INSERT INTO `accounts` VALUES ('5', 'ACFalcon', '*3195C5FA1D96DBD76646032E2D08E63842EADEBF', '', '0000-00-00 00:00:00', '2013-08-19 19:23:34', '4', '1', '1', '0', 'clean', '0', '427295128');
INSERT INTO `accounts` VALUES ('6', 'goorpFutt', '*15713A4ED17BAF68EA1B5031CACDD5FC4E5591BB', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', 'y8zP17nopO', '0', '0');
INSERT INTO `accounts` VALUES ('7', 'Saraphina', '*4396EA8220EB2D7A6191893D22A0E8AA50078917', '', '0000-00-00 00:00:00', '2013-08-17 00:24:56', '4', '1', '1', '0', 'clean', '0', '0');
INSERT INTO `accounts` VALUES ('8', 'ibaxn', '*24BB4FBF2EA9BC69DDF8F347C96E964198EDD135', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', 'lb82eoN2nE', '0', '0');
INSERT INTO `accounts` VALUES ('9', 'xPlaykey', '*A3FC60049179312A5AFC5F73F20580E32B0BFE4B', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', 'tristan1999', '0', '0');
INSERT INTO `accounts` VALUES ('10', 'markidong', '*A3FC60049179312A5AFC5F73F20580E32B0BFE4B', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', 'tristan1999', '0', '0');
INSERT INTO `accounts` VALUES ('11', 'Weapseter', '*1B5079C1B63F081A0F5EB2AF45B82BE4BB14BE09', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', 's8krIl9u4F', '0', '0');
INSERT INTO `accounts` VALUES ('12', 'Fagboasuata', '*15713A4ED17BAF68EA1B5031CACDD5FC4E5591BB', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', 'y8zP17nopO', '0', '0');
INSERT INTO `accounts` VALUES ('13', 'etheddymect', '*D741653919A2C45BFBA7A5FF5210D402B5F32082', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', '375PrnzyrT', '0', '0');
INSERT INTO `accounts` VALUES ('14', 'avkdt', '*24BB4FBF2EA9BC69DDF8F347C96E964198EDD135', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', 'lb82eoN2nE', '0', '0');
INSERT INTO `accounts` VALUES ('15', 'Artoneliis', '*22315830B726B181F24ADA3DF5E2D190E7AE6EB2', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', 'good1478963', '0', '0');
INSERT INTO `accounts` VALUES ('16', 'Pandapena', '*0D7C7E2148CEFF89CE28D8DEEC2E7D16E3F64582', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', 'xt9A39uekP', '0', '0');
INSERT INTO `accounts` VALUES ('17', 'EscoffShoft', '*2A98ED5786E00CF680B2618F29321D564CA75630', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', '9Utft3c7iZ', '0', '0');
INSERT INTO `accounts` VALUES ('18', 'Danny6748', '*8C685876AF5793B6265BBB17A602697831E2DABE', '', '0000-00-00 00:00:00', '2013-08-18 23:29:45', '4', '1', '1', '0', 'a226559419', '0', '0');
INSERT INTO `accounts` VALUES ('19', 'addelfjam', '*1C43980FB3D5259CE3572F9561BFB7E2D981AD6A', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', '2dgdI9wi6T', '0', '0');
INSERT INTO `accounts` VALUES ('20', 'Brandoman', '*A0C81C613D4F1772165385A6521CB028275CC4F5', '', '0000-00-00 00:00:00', '2013-08-18 14:33:38', '4', '1', '1', '0', 'Phatty1', '0', '0');
INSERT INTO `accounts` VALUES ('21', 'FraNnacon', '*612FE369E45CCA433B2875A2DF61039C4DFDE58C', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', '1Wb8p5gsyS', '0', '0');
INSERT INTO `accounts` VALUES ('22', 'Oakboyz', '*202CE1DFFB69FF1F4DCB532E143F541980A9A4F8', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', '23pokerz', '0', '0');
INSERT INTO `accounts` VALUES ('23', 'runaway', '*36F86641B95C580D19982CB2BD9BDFD891100C13', '', '0000-00-00 00:00:00', '2013-08-18 11:14:49', '4', '1', '1', '0', 'runaway', '0', '0');
INSERT INTO `accounts` VALUES ('24', 'Ashlynn', '*6A7A490FB9DC8C33C2B025A91737077A7E9CC5E5', '', '0000-00-00 00:00:00', '2013-08-19 13:41:54', '4', '1', '1', '0', '1234567', '0', '427323400');
INSERT INTO `accounts` VALUES ('25', 'EnvessyUser', '*EA97F3162AE009146D9A096F2B22A84C303A1317', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', 'clean', '0', '0');
INSERT INTO `accounts` VALUES ('26', 'Kenpeki', '*0EB7940FABD5196EB72E56AA9E9F1F26FEAB91D8', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', 'newport', '0', '0');
INSERT INTO `accounts` VALUES ('27', 'blolichielt', '*2A98ED5786E00CF680B2618F29321D564CA75630', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', '9Utft3c7iZ', '0', '0');
INSERT INTO `accounts` VALUES ('28', 'zerocause', '*EFFCE7FE1CB4622C3193164425F3D23C000CBFFA', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', 'freeom1', '0', '0');
INSERT INTO `accounts` VALUES ('29', 'shader236', '*85E817C14DBFF0970723BE0F92A02F6D93F7A5E2', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', 'skillet35', '0', '0');
INSERT INTO `accounts` VALUES ('30', 'aidwc', '*24BB4FBF2EA9BC69DDF8F347C96E964198EDD135', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', 'lb82eoN2nE', '0', '0');
INSERT INTO `accounts` VALUES ('31', 'Brock83', '*FB0167657E90006E75318B149E55509FC9D9E64B', '', '0000-00-00 00:00:00', '2013-08-19 14:10:18', '4', '1', '1', '0', 'agr198324', '0', '427409704');
INSERT INTO `accounts` VALUES ('32', 'Apocolyptik', '*1E3022095022151066BB8112D9285379BA58C6D7', '', '0000-00-00 00:00:00', '2013-08-19 13:45:50', '4', '1', '1', '0', 'dragon123', '0', '427356504');
INSERT INTO `accounts` VALUES ('33', 'Ironvak', '*58360CEBE2E0281A968900D865A8CCC5D10B8081', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', 'Aegis0517', '0', '0');
INSERT INTO `accounts` VALUES ('34', 'Tenzen', '*7660F56AC7C3FBC2522AD6B1AD2FECA80E06CF95', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', 'interpey', '0', '0');
INSERT INTO `accounts` VALUES ('35', 'Sirleonard', '*CA34FBBBB6F2EB104B37A5B3645432D195960800', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', 'vikings6', '0', '0');
INSERT INTO `accounts` VALUES ('36', 'couturemid', '*99919B17D66C23F66DFB07689F4122CBA65023E8', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', '123hfjdk147', '0', '0');
INSERT INTO `accounts` VALUES ('37', 'techdude', '*B4F97994608474FA75EBF89446CCF654623A746D', '', '0000-00-00 00:00:00', '2013-08-19 20:08:33', '4', '1', '1', '0', 'dubsday', '0', '427432056');
INSERT INTO `accounts` VALUES ('38', 'skinsak', '*63635BE19A55F67C172A7D2C394EBA13FC0BB6BF', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', 'whynot12', '0', '0');
INSERT INTO `accounts` VALUES ('39', 'TiggrotoDet', '*9DE75482C75F2D9B3926A03E0E10F2609D87933F', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', '3C1rikkf6C', '0', '0');
INSERT INTO `accounts` VALUES ('40', 'Cailet', '*910C12DE14D692AE83E4539F64E7AFF84947E5FE', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '4', '1', '1', '0', 'dragon1', '0', '0');

-- ----------------------------
-- Trigger structure for account_delete
-- ----------------------------
DELIMITER ;;
CREATE TRIGGER `account_delete` BEFORE DELETE ON `accounts` FOR EACH ROW BEGIN
	DELETE FROM `accounts_banned` WHERE `accid` = OLD.id;
	DELETE FROM `chars` WHERE `accid` = OLD.id;     
END;;
DELIMITER ;
