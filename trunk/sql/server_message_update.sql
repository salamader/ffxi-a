/*
MySQL Data Transfer
Source Host: localhost
Source Database: database
Target Host: localhost
Target Database: database
Date: 9/19/2013 9:29:35 AM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for server_message
-- ----------------------------
CREATE TABLE `server_message` (
  `server_message` varchar(80) NOT NULL DEFAULT 'Welcome To FFXI-A Alpha Development Server!',
  `id` int(1) unsigned NOT NULL DEFAULT '1',
  `lang_name` varchar(200) NOT NULL DEFAULT 'noname',
  PRIMARY KEY (`server_message`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `server_message` VALUES ('FFXI - Aplha開発プロジェクトへようこそ！', '1', 'Japanese');
INSERT INTO `server_message` VALUES ('Welcome To FFXI - A Aplha Development Project!', '2', 'English');
INSERT INTO `server_message` VALUES ('Welcome To FFXI - A Aplha Development Project!', '3', 'Englsih Japanese');
INSERT INTO `server_message` VALUES ('Willkommen bei FFXI - A Aplha Development Project!', '4', 'German');
INSERT INTO `server_message` VALUES ('Willkommen bei FFXI - A Aplha Development Project!', '5', 'German Japanese');
INSERT INTO `server_message` VALUES ('Welcome To FFXI - A Aplha Development Project!', '6', 'English German');
INSERT INTO `server_message` VALUES ('Bienvenue dans un FFXI - Projet de développement Aplha!', '8', 'French ');
INSERT INTO `server_message` VALUES ('FBienvenue dans un FFXI - Projet de développement Aplha!', '9', 'French Japanese ');
INSERT INTO `server_message` VALUES ('Welcome To FFXI - A Aplha Development Project!', '10', 'English French ');
INSERT INTO `server_message` VALUES ('Welcome To FFXI - A Aplha Development Project!', '11', 'Englsih French Japanese');
INSERT INTO `server_message` VALUES ('Bienvenue dans un FFXI - Projet de développement Aplha!', '12', 'French Greman');
INSERT INTO `server_message` VALUES ('Bienvenue dans un FFXI - Projet de développement Aplha!', '13', 'French German Japanese ');
INSERT INTO `server_message` VALUES ('Welcome To FFXI - A Aplha Development Project!', '14', 'Englsih French German');
INSERT INTO `server_message` VALUES ('Welcome To FFXI - A Aplha Development Project!', '15', 'Englsih French German Japanese');
INSERT INTO `server_message` VALUES (' ברוכים הבאים ל- FFXI פרויקט פיתוח Aplha!', '16', 'Other');
INSERT INTO `server_message` VALUES ('FFXI - Aplha開発プロジェクトへようこそ！', '17', 'Japanese Other');
INSERT INTO `server_message` VALUES ('Welcome To FFXI - A Aplha Development Project!', '18', 'Englsih Other');
INSERT INTO `server_message` VALUES ('Willkommen bei FFXI - A Aplha Development Project!', '20', 'German Other');
INSERT INTO `server_message` VALUES ('Willkommen bei FFXI - A Aplha Development Project!', '21', 'German Japanese Other');
INSERT INTO `server_message` VALUES ('Welcome To FFXI - A Aplha Development Project!', '23', 'English German Japanese Other');
INSERT INTO `server_message` VALUES ('Bienvenue dans un FFXI-Projet de développement Aplha!', '24', 'French Other');
INSERT INTO `server_message` VALUES ('Welcome To FFXI - A Aplha Development Project!', '26', 'Englsih French Other');
INSERT INTO `server_message` VALUES ('Welcome To FFXI - A Aplha Development Project!', '27', 'English French Japanese Other');
INSERT INTO `server_message` VALUES ('Bienvenue dans un FFXI-Projet de développement Aplha!', '28', 'French German Other');
INSERT INTO `server_message` VALUES ('Bienvenue dans un FFXI-Projet de développement Aplha!', '29', 'French German Japanese Other');
INSERT INTO `server_message` VALUES ('Welcome To FFXI - A Aplha Development Project!', '30', 'English French German Other');
INSERT INTO `server_message` VALUES ('Welcome To FFXI - A Aplha Development Project!', '31', 'English French German Japanese Other');
