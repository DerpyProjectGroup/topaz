SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for blue_traits
-- ----------------------------
DROP TABLE IF EXISTS `blue_traits`;
CREATE TABLE `blue_traits` (
  `trait_category` smallint(2) unsigned NOT NULL,
  `trait_points_needed` smallint(2) unsigned NOT NULL,
  `traitid` tinyint(3) unsigned NOT NULL,
  `modifier` smallint(5) unsigned NOT NULL,
  `value` smallint(5) NOT NULL,
  PRIMARY KEY (`trait_category`,`trait_points_needed`,`modifier`)
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records
-- ----------------------------

-- Beast Killer
INSERT INTO `blue_traits` VALUES (1,2,32,230,8);
INSERT INTO `blue_traits` VALUES (1,4,32,230,10);

-- Regen
INSERT INTO `blue_traits` VALUES (2,2,9,370,1);

-- Lizard Killer
INSERT INTO `blue_traits` VALUES (3,2,35,227,8);

-- Clear Mind
INSERT INTO `blue_traits` VALUES (4,2,24,295,1);
INSERT INTO `blue_traits` VALUES (4,4,24,295,2);
INSERT INTO `blue_traits` VALUES (4,6,24,295,3);
INSERT INTO `blue_traits` VALUES (4,8,24,295,4);
INSERT INTO `blue_traits` VALUES (4,10,24,295,5);

-- Sleep Resist
INSERT INTO `blue_traits` VALUES (5,2,48,240,10);
INSERT INTO `blue_traits` VALUES (5,4,48,240,15);

-- Magic Attack Bonus
INSERT INTO `blue_traits` VALUES (6,2,5,28,20);
INSERT INTO `blue_traits` VALUES (6,4,5,28,24);
INSERT INTO `blue_traits` VALUES (6,6,5,28,28);

-- Undead Killer
INSERT INTO `blue_traits` VALUES (7,2,39,231,8);

-- Attack Bonus
INSERT INTO `blue_traits` VALUES (8,2,3,23,10);
INSERT INTO `blue_traits` VALUES (8,2,3,24,10);
INSERT INTO `blue_traits` VALUES (8,4,3,23,22);
INSERT INTO `blue_traits` VALUES (8,4,3,24,22);
INSERT INTO `blue_traits` VALUES (8,6,3,23,35);
INSERT INTO `blue_traits` VALUES (8,6,3,24,35);

-- Rapid Shot
INSERT INTO `blue_traits` VALUES (9,2,11,359,10);

-- MP
INSERT INTO `blue_traits` VALUES (10,2,8,5,10);
INSERT INTO `blue_traits` VALUES (10,4,8,5,30);

-- DEF
INSERT INTO `blue_traits` VALUES (11,2,4,1,10);
INSERT INTO `blue_traits` VALUES (11,4,4,1,22);

-- Plantoid Killer
INSERT INTO `blue_traits` VALUES (12,2,33,229,8);

-- MDEF
INSERT INTO `blue_traits` VALUES (13,2,6,29,10);

-- Refresh
INSERT INTO `blue_traits` VALUES (14,8,10,369,1);
INSERT INTO `blue_traits` VALUES (14,16,10,369,2);

-- HP
INSERT INTO `blue_traits` VALUES (15,2,7,2,30);
INSERT INTO `blue_traits` VALUES (15,4,7,2,90);

-- ACC
INSERT INTO `blue_traits` VALUES (16,2,1,25,10);
INSERT INTO `blue_traits` VALUES (16,2,1,26,10);

-- Conserve MP
INSERT INTO `blue_traits` VALUES (17,2,13,296,25);
INSERT INTO `blue_traits` VALUES (17,4,13,296,28);

-- EVA
INSERT INTO `blue_traits` VALUES (18,2,2,68,10);

-- Gravity Resist
INSERT INTO `blue_traits` VALUES (19,2,58,249,10);

-- Store TP
INSERT INTO `blue_traits` VALUES (20,2,14,73,10);
INSERT INTO `blue_traits` VALUES (20,4,14,73,25);

-- Counter
INSERT INTO `blue_traits` VALUES (21,2,17,291,10);

-- Fast Cast
INSERT INTO `blue_traits` VALUES (22,2,12,170,5);
INSERT INTO `blue_traits` VALUES (22,4,12,170,15);

-- Skill Chain Bonus
INSERT INTO `blue_traits` VALUES (23,2,106,174,8);

-- Double Attack
INSERT INTO `blue_traits` VALUES (24,2,15,288,7);

-- Triple Attack
INSERT INTO `blue_traits` VALUES (24,4,16,302,5);

-- Dual Wield
INSERT INTO `blue_traits` VALUES (25,2,18,259,10);
INSERT INTO `blue_traits` VALUES (25,4,18,259,15);
INSERT INTO `blue_traits` VALUES (25,6,18,259,25);

-- Zanshin
INSERT INTO `blue_traits` VALUES (26,2,70,306,15);

-- Magic Burst Bonus
INSERT INTO `blue_traits` VALUES (27,2,110,487,5);

-- Gilfinder
INSERT INTO `blue_traits` VALUES (28,2,20,897,50);

-- Treasure Hunter
INSERT INTO `blue_traits` VALUES (28,3,19,303,1);
