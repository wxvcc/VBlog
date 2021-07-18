/*
 Navicat Premium Data Transfer

 Source Server         : conn
 Source Server Type    : MySQL
 Source Server Version : 80025
 Source Host           : localhost:3306
 Source Schema         : vueblog2

 Target Server Type    : MySQL
 Target Server Version : 80025
 File Encoding         : 65001

 Date: 18/07/2021 17:44:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mdContent` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'md文件源码',
  `htmlContent` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'html源码',
  `summary` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `cid` int NULL DEFAULT NULL,
  `uid` int NULL DEFAULT NULL,
  `publishDate` datetime NULL DEFAULT NULL,
  `editTime` datetime NULL DEFAULT NULL,
  `state` int NULL DEFAULT NULL COMMENT '0表示草稿箱，1表示已发表，2表示已删除',
  `pageView` int NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  CONSTRAINT `article_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `article_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 126 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES (123, 'SpringBoot', 'come on spring boot', '<p>come on spring boot</p>\n', 'come on spring boot\n', 66, 17, '2021-07-16 21:41:18', '2021-07-16 21:41:18', 1, 5);
INSERT INTO `article` VALUES (124, 'Spring', 'spring yes', '<p>spring yes</p>\n', 'spring yes\n', 67, 18, '2021-07-16 21:55:25', '2021-07-16 21:55:25', 1, 2);
INSERT INTO `article` VALUES (125, 'SpringBoot', 'SpringBoot yes', '<p>SpringBoot yes</p>\n', 'SpringBoot yes\n', 66, 18, '2021-07-16 21:59:11', '2021-07-16 21:59:11', 1, 2);

-- ----------------------------
-- Table structure for article_tags
-- ----------------------------
DROP TABLE IF EXISTS `article_tags`;
CREATE TABLE `article_tags`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `aid` int NULL DEFAULT NULL,
  `tid` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tid`(`tid`) USING BTREE,
  INDEX `article_tags_ibfk_1`(`aid`) USING BTREE,
  CONSTRAINT `article_tags_ibfk_1` FOREIGN KEY (`aid`) REFERENCES `article` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `article_tags_ibfk_2` FOREIGN KEY (`tid`) REFERENCES `tags` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_tags
-- ----------------------------

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `cateName` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `date` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 70 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (66, 'SpringBoot', '2021-07-16');
INSERT INTO `category` VALUES (67, 'Spring', '2021-07-16');
INSERT INTO `category` VALUES (68, 'Mybatis', '2021-07-16');
INSERT INTO `category` VALUES (69, 'Vue', '2021-07-16');

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `aid` int NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `publishDate` datetime NULL DEFAULT NULL,
  `parentId` int NULL DEFAULT NULL COMMENT '-1表示正常回复，其他值表示是评论的回复',
  `uid` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `aid`(`aid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `parentId`(`parentId`) USING BTREE,
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`aid`) REFERENCES `article` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comments_ibfk_3` FOREIGN KEY (`parentId`) REFERENCES `comments` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------

-- ----------------------------
-- Table structure for pv
-- ----------------------------
DROP TABLE IF EXISTS `pv`;
CREATE TABLE `pv`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `countDate` date NULL DEFAULT NULL,
  `pv` int NULL DEFAULT NULL,
  `uid` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pv_ibfk_1`(`uid`) USING BTREE,
  CONSTRAINT `pv_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pv
-- ----------------------------
INSERT INTO `pv` VALUES (2, '2017-12-24', 14, 7);
INSERT INTO `pv` VALUES (5, '2017-12-25', 23, 7);
INSERT INTO `pv` VALUES (7, '2017-12-26', 32, 7);
INSERT INTO `pv` VALUES (27, '2017-12-23', 77, 7);

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, '超级管理员');
INSERT INTO `roles` VALUES (2, '普通用户');
INSERT INTO `roles` VALUES (3, '测试角色1');
INSERT INTO `roles` VALUES (4, '测试角色2');
INSERT INTO `roles` VALUES (5, '测试角色3');

-- ----------------------------
-- Table structure for roles_user
-- ----------------------------
DROP TABLE IF EXISTS `roles_user`;
CREATE TABLE `roles_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `rid` int NULL DEFAULT 2,
  `uid` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `rid`(`rid`) USING BTREE,
  INDEX `roles_user_ibfk_2`(`uid`) USING BTREE,
  CONSTRAINT `roles_user_ibfk_1` FOREIGN KEY (`rid`) REFERENCES `roles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `roles_user_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 131 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles_user
-- ----------------------------
INSERT INTO `roles_user` VALUES (8, 2, 7);
INSERT INTO `roles_user` VALUES (9, 1, 7);
INSERT INTO `roles_user` VALUES (17, 5, 7);
INSERT INTO `roles_user` VALUES (108, 2, 16);
INSERT INTO `roles_user` VALUES (109, 2, 17);
INSERT INTO `roles_user` VALUES (110, 2, 18);
INSERT INTO `roles_user` VALUES (128, 2, 10);
INSERT INTO `roles_user` VALUES (129, 5, 10);

-- ----------------------------
-- Table structure for tags
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `tagName` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `tagName`(`tagName`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 66 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tags
-- ----------------------------
INSERT INTO `tags` VALUES (66, '666');
INSERT INTO `tags` VALUES (35, 'Ajax');
INSERT INTO `tags` VALUES (36, 'Dubbo');
INSERT INTO `tags` VALUES (40, 'git');
INSERT INTO `tags` VALUES (33, 'Linux');
INSERT INTO `tags` VALUES (45, 'mongodb');
INSERT INTO `tags` VALUES (42, 'spring');
INSERT INTO `tags` VALUES (44, 'SpringSecurity');
INSERT INTO `tags` VALUES (37, 'websocket');
INSERT INTO `tags` VALUES (34, 'Zookeeper');
INSERT INTO `tags` VALUES (50, '图片上传');
INSERT INTO `tags` VALUES (51, '图片预览');
INSERT INTO `tags` VALUES (41, '学习资料');
INSERT INTO `tags` VALUES (65, '杂谈');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nickname` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `enabled` tinyint(1) NULL DEFAULT 1,
  `email` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `userface` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `regTime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (7, 'sang', 'Angus', '202cb962ac59075b964b07152d234b70', 1, 'sang123@qq.com', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1514093920321&di=913e88c23f382933ef430024afd9128a&imgtype=0&src=http%3A%2F%2Fp.3761.com%2Fpic%2F9771429316733.jpg', '2017-12-21 13:30:29');
INSERT INTO `user` VALUES (10, 'qiaofeng', '乔峰', '202cb962ac59075b964b07152d234b70', 1, 'qiaofeng@qq.com', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1514093920321&di=913e88c23f382933ef430024afd9128a&imgtype=0&src=http%3A%2F%2Fp.3761.com%2Fpic%2F9771429316733.jpg', '2017-12-24 06:30:46');
INSERT INTO `user` VALUES (16, 'chuliuxiang', '楚留香', '202cb962ac59075b964b07152d234b70', 1, 'chuliuxiang@qq.com', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1514093920321&di=913e88c23f382933ef430024afd9128a&imgtype=0&src=http%3A%2F%2Fp.3761.com%2Fpic%2F9771429316733.jpg', '2017-12-24 06:30:46');
INSERT INTO `user` VALUES (17, 'baizhantang', '白展堂', '202cb962ac59075b964b07152d234b70', 1, 'baizhantang@qq.com', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1514093920321&di=913e88c23f382933ef430024afd9128a&imgtype=0&src=http%3A%2F%2Fp.3761.com%2Fpic%2F9771429316733.jpg', '2017-12-24 06:30:46');
INSERT INTO `user` VALUES (18, 'renwoxing', '任我行', '202cb962ac59075b964b07152d234b70', 1, 'renwoxing@qq.com', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1514093920321&di=913e88c23f382933ef430024afd9128a&imgtype=0&src=http%3A%2F%2Fp.3761.com%2Fpic%2F9771429316733.jpg', '2017-12-24 06:30:46');

-- ----------------------------
-- View structure for pvview
-- ----------------------------
DROP VIEW IF EXISTS `pvview`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `pvview` AS select sum(`pv`.`pv`) AS `pv`,`pv`.`uid` AS `uid` from `pv` group by `pv`.`uid`;

-- ----------------------------
-- View structure for totalpvview
-- ----------------------------
DROP VIEW IF EXISTS `totalpvview`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `totalpvview` AS select sum(`a`.`pageView`) AS `totalPv`,`a`.`uid` AS `uid` from `article` `a` group by `a`.`uid`;

SET FOREIGN_KEY_CHECKS = 1;
