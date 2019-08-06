/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50547
Source Host           : localhost:3306
Source Database       : jplecture_20180517

Target Server Type    : MYSQL
Target Server Version : 50547
File Encoding         : 65001

Date: 2018-08-18 19:12:01
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_answer
-- ----------------------------
DROP TABLE IF EXISTS `t_answer`;
CREATE TABLE `t_answer` (
  `mcq_id` int(6) NOT NULL,
  `quiz_id` int(6) NOT NULL,
  `attempt_id` int(6) NOT NULL,
  `optionA_count` int(3) DEFAULT NULL,
  `optionB_count` int(3) DEFAULT NULL,
  `optionC_count` int(3) DEFAULT NULL,
  `optionD_count` int(3) DEFAULT NULL,
  PRIMARY KEY (`mcq_id`,`attempt_id`,`quiz_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_answer
-- ----------------------------
INSERT INTO `t_answer` VALUES ('206586', '337639', '265465', '20', '40', '6', '6');
INSERT INTO `t_answer` VALUES ('251945', '337639', '265465', '31', '10', '10', '20');
INSERT INTO `t_answer` VALUES ('362570', '337639', '265465', '21', '7', '4', '10');
INSERT INTO `t_answer` VALUES ('464152', '337639', '265465', '9', '20', '30', '50');
INSERT INTO `t_answer` VALUES ('524369', '337639', '265465', '31', '20', '5', '19');

-- ----------------------------
-- Table structure for t_class
-- ----------------------------
DROP TABLE IF EXISTS `t_class`;
CREATE TABLE `t_class` (
  `class_id` int(6) NOT NULL,
  `class_name` varchar(255) DEFAULT NULL,
  `module_id` varchar(255) DEFAULT NULL,
  `lecturer_id` int(11) DEFAULT NULL,
  `class_createtime` varchar(255) DEFAULT NULL,
  `class_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_class
-- ----------------------------
INSERT INTO `t_class` VALUES ('174640', 'tc2', 'EBU5016', '100002', '2018-08-18 10:29:17', 'class174640');
INSERT INTO `t_class` VALUES ('408682', 'Copyright Law May 18th', 'EBU5016', '100002', '2018-05-17 20:17:39', 'class408682');
INSERT INTO `t_class` VALUES ('488288', 'testclass', 'EBU5016', '100002', '2018-08-18 10:09:10', 'class488288');

-- ----------------------------
-- Table structure for t_lecturer
-- ----------------------------
DROP TABLE IF EXISTS `t_lecturer`;
CREATE TABLE `t_lecturer` (
  `lecturer_id` int(11) NOT NULL,
  `loginname` varchar(255) NOT NULL,
  `loginpsw` varchar(255) NOT NULL,
  `portraitpath` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`lecturer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_lecturer
-- ----------------------------
INSERT INTO `t_lecturer` VALUES ('100002', 'bchib', 'copylaw', null);

-- ----------------------------
-- Table structure for t_lecturerhasmodule
-- ----------------------------
DROP TABLE IF EXISTS `t_lecturerhasmodule`;
CREATE TABLE `t_lecturerhasmodule` (
  `relation_id` int(6) NOT NULL,
  `lecturer_id` int(6) DEFAULT NULL,
  `module_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`relation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_lecturerhasmodule
-- ----------------------------
INSERT INTO `t_lecturerhasmodule` VALUES ('1', '100000', 'EBU5502');
INSERT INTO `t_lecturerhasmodule` VALUES ('2', '100000', 'EBU714U');
INSERT INTO `t_lecturerhasmodule` VALUES ('3', '100001', 'EBU5502');
INSERT INTO `t_lecturerhasmodule` VALUES ('4', '100001', 'EBU714U');
INSERT INTO `t_lecturerhasmodule` VALUES ('5', '100001', 'EBU4202');
INSERT INTO `t_lecturerhasmodule` VALUES ('6', '100002', 'EBU5016');

-- ----------------------------
-- Table structure for t_mcq
-- ----------------------------
DROP TABLE IF EXISTS `t_mcq`;
CREATE TABLE `t_mcq` (
  `mcq_id` int(6) NOT NULL,
  `mcq_title` longtext,
  `mcq_optionA` longtext,
  `mcq_optionB` longtext,
  `mcq_optionC` longtext,
  `mcq_optionD` longtext,
  `mcq_answer` longtext,
  `lecturer_id` int(11) DEFAULT NULL,
  `url` longtext COMMENT '图片地址路径',
  PRIMARY KEY (`mcq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_mcq
-- ----------------------------
INSERT INTO `t_mcq` VALUES ('100004', 'In terms of works of copyright, which one of the following statements is not correct? \r\nFEEDBACK: The requirement for the original works to be recorded in writing or otherwise does not apply in the case of artistic works (the requirement is that for copyright to protect any work, it must be reproduced in tangible form)', 'A dramatic or musical work cannot also be a literary work', 'Copyright does not subsist in a literary, dramatic or musical work unless and until it is recorded in writing or otherwise', 'Copyright is a property right', 'Copyright does not subsist in a literary, dramatic, musical or artistic work unless and until it is recorded in writing or otherwise', 'D', '100002', '/jplecture_mcqImg/20180815/1534343255275042389.png');
INSERT INTO `t_mcq` VALUES ('100005', 'W lives in Spain and, whilst there, he sent an email to his sister, Y, who lives in China. Attached to the email was a photograph of the Sagrada Familia (Gaudi\'s Cathedral in Barcelona) which W had scanned in from a postcard he had purchased in Spain. The email asked Y to forward copies of the attachment to her friends in China, which she did. The photograph had been taken by a Chinese citizen 60 years ago. Neither W nor Y had permission to copy the photograph on the postcard. \r\n\r\nWhich one of the following statements is correct?', 'As the photograph is more than 50 years old, it no longer attracts UK copyright: therefore neither W nor Y have infringed copyright', 'Y has infringed the Chinese copyright in the photograph by forwarding copies to her friends and W has also infringed the Chinese copyright by authorising Y to forward copies', 'Y has infringed the Chinese copyright in the photograph by forwarding copies to her friends but W has not infringed the Chinese copyright by asking Y to forward copies to her friends as he was outside the jurisdiction of the Chinese courts when he did so', 'Neither W nor Y have infringed the copyright in the photograph as it is not an infringement of copyright to copy a photograph depicting a work of architecture', 'B', '100002', '/jplecture_mcqImg/20180815/1534343255275043905.png');
INSERT INTO `t_mcq` VALUES ('100006', 'Which one of the following is the correct test for subsistence of copyright in a database?', 'By reason of the selection or arrangement of the contents, the database constitutes the author\'s own intellectual creation', 'The database must be the result of skill and judgment and be new even if the constituent elements in the database are themselves not new or original', 'The database must be original, meaning that it originated from the author and was not copied from another work', 'The making of the database must have resulted from a substantial investment in terms of human, technical or financial resources', 'A', '100002', '/jplecture_mcqImg/20180815/1534343255275059058.png');
INSERT INTO `t_mcq` VALUES ('161293', 'tbank3', '3', '3', '3', '3', 'A', '100002', null);
INSERT INTO `t_mcq` VALUES ('206586', 'W lives in Spain and, whilst there, he sent an email to his sister, Y, who lives in China. Attached to the email was a photograph of the Sagrada Familia (Gaudi\'s Cathedral in Barcelona) which W had scanned in from a postcard he had purchased in Spain. The email asked Y to forward copies of the attachment to her friends in China, which she did. The photograph had been taken by a Chinese citizen 60 years ago. Neither W nor Y had permission to copy the photograph on the postcard. ', 'As the photograph is more than 50 years old, it no longer attracts UK copyright: therefore neither W nor Y have infringed copyright', 'Y has infringed the Chinese copyright in the photograph by forwarding copies to her friends and W has also infringed the Chinese copyright by authorising Y to forward copies', 'Y has infringed the Chinese copyright in the photograph by forwarding copies to her friends but W has not infringed the Chinese copyright by asking Y to forward copies to her friends as he was outside the jurisdiction of the Chinese courts when he did so', 'Neither W nor Y have infringed the copyright in the photograph as it is not an infringement of copyright to copy a photograph depicting a work of architecture', 'B', '100002', '/jplecture_mcqImg/20180816/1534351567461061382.png');
INSERT INTO `t_mcq` VALUES ('251945', 'Which one of the following is the correct test for subsistence of copyright in a database?', 'By reason of the selection or arrangement of the contents, the database constitutes the author\'s own intellectual creation', 'The database must be the result of skill and judgment and be new even if the constituent elements in the database are themselves not new or original', 'The database must be original, meaning that it originated from the author and was not copied from another work', 'The making of the database must have resulted from a substantial investment in terms of human, technical or financial resources', 'A', '100002', '/jplecture_mcqImg/20180816/1534351742442054008.png');
INSERT INTO `t_mcq` VALUES ('362570', 'nana', 'a', 'b', 'c', 'd', 'A', '100002', '/jplecture_mcqImg/20180815/1534343255275042796.png');
INSERT INTO `t_mcq` VALUES ('464152', 'In terms of works of copyright, which one of the following statements is not correct? \r\nFEEDBACK: The requirement for the original works to be recorded in writing or otherwise does not apply in the case of artistic works (the requirement is that for copyright to protect any work, it must be reproduced in tangible form)', 'A dramatic or musical work cannot also be a literary work', 'Copyright does not subsist in a literary, dramatic or musical work unless and until it is recorded in writing or otherwise', 'Copyright is a property right', 'Copyright does not subsist in a literary, dramatic, musical or artistic work unless and until it is recorded in writing or otherwise', 'D', '100002', '/jplecture_mcqImg/20180816/1534350435383056318.png');
INSERT INTO `t_mcq` VALUES ('524369', 'gagaga', 'ga\'ga', 'gaaga', 'gaga', 'g', 'A', '100002', '/jplecture_mcqImg/20180815/1534343661715052605.png');
INSERT INTO `t_mcq` VALUES ('578512', 'tbank2', 'y', 'b', 't', 'e', 'A', '100002', null);
INSERT INTO `t_mcq` VALUES ('750912', 'testmcq', 'a', 'ab', 'b', 'd', 'A', '100002', null);

-- ----------------------------
-- Table structure for t_message
-- ----------------------------
DROP TABLE IF EXISTS `t_message`;
CREATE TABLE `t_message` (
  `msg_id` int(6) NOT NULL AUTO_INCREMENT,
  `class_id` int(6) DEFAULT NULL,
  `msg_content` varchar(2000) DEFAULT NULL,
  `msg_createtime` varchar(255) DEFAULT NULL,
  `ip_addr` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`msg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=111028 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_message
-- ----------------------------
INSERT INTO `t_message` VALUES ('111023', '408682', 'Hi', '2018-05-24 01:39:40', '10.211.55.3');
INSERT INTO `t_message` VALUES ('111024', '408682', 'haha', '2018-07-23 13:42:30', '192.168.0.102');
INSERT INTO `t_message` VALUES ('111025', '408682', 'OKAY', '2018-07-23 13:42:44', '192.168.0.102');
INSERT INTO `t_message` VALUES ('111026', '408682', 'sasa', '2018-08-17 14:52:13', '172.21.160.58');
INSERT INTO `t_message` VALUES ('111027', '408682', 'åå', '2018-08-17 16:29:22', '172.21.160.58');

-- ----------------------------
-- Table structure for t_module
-- ----------------------------
DROP TABLE IF EXISTS `t_module`;
CREATE TABLE `t_module` (
  `module_id` varchar(255) NOT NULL,
  `module_name` varchar(255) NOT NULL,
  PRIMARY KEY (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_module
-- ----------------------------
INSERT INTO `t_module` VALUES ('EBU5016', 'EBU5016 Copyright Law');

-- ----------------------------
-- Table structure for t_quiz
-- ----------------------------
DROP TABLE IF EXISTS `t_quiz`;
CREATE TABLE `t_quiz` (
  `quiz_id` int(6) NOT NULL,
  `attempt_id` int(6) NOT NULL,
  `quiz_name` varchar(255) DEFAULT NULL,
  `class_id` int(6) DEFAULT NULL,
  `lecturer_id` int(6) DEFAULT NULL,
  `attempt_createtime` varchar(255) DEFAULT NULL,
  `attempt_comment` varchar(255) DEFAULT NULL,
  `attempt_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`quiz_id`,`attempt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_quiz
-- ----------------------------
INSERT INTO `t_quiz` VALUES ('337639', '265465', 'Copyright Law MCQ', '408682', '100002', '2018-05-17 20:18:59', 'Friday 3:30pm-5:30pm', 'attempt265465');
INSERT INTO `t_quiz` VALUES ('825631', '273007', 'jjjj', null, '100002', '2018-08-18 10:35:17', 'jjj', 'attempt273007');

-- ----------------------------
-- Table structure for t_quizhasmcq
-- ----------------------------
DROP TABLE IF EXISTS `t_quizhasmcq`;
CREATE TABLE `t_quizhasmcq` (
  `relation_id` int(6) NOT NULL AUTO_INCREMENT,
  `quiz_id` int(6) DEFAULT NULL,
  `mcq_id` int(6) DEFAULT NULL,
  PRIMARY KEY (`relation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_quizhasmcq
-- ----------------------------
INSERT INTO `t_quizhasmcq` VALUES ('59', '337639', '183410');
INSERT INTO `t_quizhasmcq` VALUES ('60', '337639', '642698');
INSERT INTO `t_quizhasmcq` VALUES ('61', '337639', '987022');
INSERT INTO `t_quizhasmcq` VALUES ('62', '337639', '427819');
INSERT INTO `t_quizhasmcq` VALUES ('63', '337639', '900690');
INSERT INTO `t_quizhasmcq` VALUES ('64', '337639', '122768');
INSERT INTO `t_quizhasmcq` VALUES ('65', '337639', '334382');
INSERT INTO `t_quizhasmcq` VALUES ('66', '337639', '658380');
INSERT INTO `t_quizhasmcq` VALUES ('67', '337639', '296820');
INSERT INTO `t_quizhasmcq` VALUES ('68', '337639', '168491');
INSERT INTO `t_quizhasmcq` VALUES ('69', '337639', '747640');
INSERT INTO `t_quizhasmcq` VALUES ('70', '337639', '983290');
INSERT INTO `t_quizhasmcq` VALUES ('71', '337639', '279529');
INSERT INTO `t_quizhasmcq` VALUES ('72', '337639', '542718');
INSERT INTO `t_quizhasmcq` VALUES ('73', '337639', '369870');
INSERT INTO `t_quizhasmcq` VALUES ('74', '337639', '264975');
INSERT INTO `t_quizhasmcq` VALUES ('75', '337639', '102055');
INSERT INTO `t_quizhasmcq` VALUES ('76', '337639', '821365');
INSERT INTO `t_quizhasmcq` VALUES ('77', '337639', '455122');
INSERT INTO `t_quizhasmcq` VALUES ('78', '337639', '674828');
INSERT INTO `t_quizhasmcq` VALUES ('79', '337639', '410771');
INSERT INTO `t_quizhasmcq` VALUES ('80', '337639', '259243');
INSERT INTO `t_quizhasmcq` VALUES ('81', '337639', '793728');
INSERT INTO `t_quizhasmcq` VALUES ('82', '337639', '110645');
INSERT INTO `t_quizhasmcq` VALUES ('83', '337639', '315344');
INSERT INTO `t_quizhasmcq` VALUES ('84', '337639', '246819');
INSERT INTO `t_quizhasmcq` VALUES ('85', '337639', '928950');
INSERT INTO `t_quizhasmcq` VALUES ('86', '337639', '558885');
INSERT INTO `t_quizhasmcq` VALUES ('87', '337639', '943155');
INSERT INTO `t_quizhasmcq` VALUES ('88', '337639', '739040');
INSERT INTO `t_quizhasmcq` VALUES ('89', '337639', '818118');
INSERT INTO `t_quizhasmcq` VALUES ('90', '337639', '106165');
INSERT INTO `t_quizhasmcq` VALUES ('91', '337639', '566079');
INSERT INTO `t_quizhasmcq` VALUES ('92', '337639', '362570');
INSERT INTO `t_quizhasmcq` VALUES ('93', '337639', '524369');
INSERT INTO `t_quizhasmcq` VALUES ('94', '337639', '464152');
INSERT INTO `t_quizhasmcq` VALUES ('95', '337639', '206586');
INSERT INTO `t_quizhasmcq` VALUES ('96', '337639', '251945');
INSERT INTO `t_quizhasmcq` VALUES ('97', '530427', '750912');
INSERT INTO `t_quizhasmcq` VALUES ('98', '705568', '578512');
INSERT INTO `t_quizhasmcq` VALUES ('99', '105002', '161293');

-- ----------------------------
-- Table structure for t_student
-- ----------------------------
DROP TABLE IF EXISTS `t_student`;
CREATE TABLE `t_student` (
  `serial` int(11) NOT NULL AUTO_INCREMENT,
  `ip_addr` varchar(30) NOT NULL,
  `attempt_id` int(6) NOT NULL,
  `answer_createtime` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`serial`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_student
-- ----------------------------
INSERT INTO `t_student` VALUES ('1', '127.0.0.1', '265465', '2018-08-17 16:29:17');
