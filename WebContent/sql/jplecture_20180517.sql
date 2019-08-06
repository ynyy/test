/*
Navicat MySQL Data Transfer

Source Server         : myconnection
Source Server Version : 50537
Source Host           : localhost:3306
Source Database       : jplecture_20180517

Target Server Type    : MYSQL
Target Server Version : 50537
File Encoding         : 65001

Date: 2018-05-24 14:48:25
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_answer`
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
INSERT INTO `t_answer` VALUES ('100004', '337639', '265465', '0', '0', '0', '0');
INSERT INTO `t_answer` VALUES ('100005', '337639', '265465', '0', '0', '0', '0');
INSERT INTO `t_answer` VALUES ('100006', '337639', '265465', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for `t_class`
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
INSERT INTO `t_class` VALUES ('408682', 'Copyright Law May 18th', 'EBU5016', '100002', '2018-05-17 20:17:39', 'class408682');

-- ----------------------------
-- Table structure for `t_lecturer`
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
-- Table structure for `t_lecturerhasmodule`
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
-- Table structure for `t_mcq`
-- ----------------------------
DROP TABLE IF EXISTS `t_mcq`;
CREATE TABLE `t_mcq` (
  `mcq_id` int(6) NOT NULL,
  `mcq_title` varchar(2000) DEFAULT NULL,
  `mcq_optionA` varchar(1000) DEFAULT NULL,
  `mcq_optionB` varchar(1000) DEFAULT NULL,
  `mcq_optionC` varchar(1000) DEFAULT NULL,
  `mcq_optionD` varchar(1000) DEFAULT NULL,
  `mcq_answer` varchar(255) DEFAULT NULL,
  `lecturer_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`mcq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_mcq
-- ----------------------------
INSERT INTO `t_mcq` VALUES ('100004', 'In terms of works of copyright, which one of the following statements is not correct? \r\nFEEDBACK: The requirement for the original works to be recorded in writing or otherwise does not apply in the case of artistic works (the requirement is that for copyright to protect any work, it must be reproduced in tangible form)', 'A dramatic or musical work cannot also be a literary work', 'Copyright does not subsist in a literary, dramatic or musical work unless and until it is recorded in writing or otherwise', 'Copyright is a property right', 'Copyright does not subsist in a literary, dramatic, musical or artistic work unless and until it is recorded in writing or otherwise', 'D', '100002');
INSERT INTO `t_mcq` VALUES ('100005', 'W lives in Spain and, whilst there, he sent an email to his sister, Y, who lives in China. Attached to the email was a photograph of the Sagrada Familia (Gaudi\'s Cathedral in Barcelona) which W had scanned in from a postcard he had purchased in Spain. The email asked Y to forward copies of the attachment to her friends in China, which she did. The photograph had been taken by a Chinese citizen 60 years ago. Neither W nor Y had permission to copy the photograph on the postcard. \r\n\r\nWhich one of the following statements is correct?', 'As the photograph is more than 50 years old, it no longer attracts UK copyright: therefore neither W nor Y have infringed copyright', 'Y has infringed the Chinese copyright in the photograph by forwarding copies to her friends and W has also infringed the Chinese copyright by authorising Y to forward copies', 'Y has infringed the Chinese copyright in the photograph by forwarding copies to her friends but W has not infringed the Chinese copyright by asking Y to forward copies to her friends as he was outside the jurisdiction of the Chinese courts when he did so', 'Neither W nor Y have infringed the copyright in the photograph as it is not an infringement of copyright to copy a photograph depicting a work of architecture', 'B', '100002');
INSERT INTO `t_mcq` VALUES ('100006', 'Which one of the following is the correct test for subsistence of copyright in a database?', 'By reason of the selection or arrangement of the contents, the database constitutes the author\'s own intellectual creation', 'The database must be the result of skill and judgment and be new even if the constituent elements in the database are themselves not new or original', 'The database must be original, meaning that it originated from the author and was not copied from another work', 'The making of the database must have resulted from a substantial investment in terms of human, technical or financial resources', 'A', '100002');

-- ----------------------------
-- Table structure for `t_message`
-- ----------------------------
DROP TABLE IF EXISTS `t_message`;
CREATE TABLE `t_message` (
  `msg_id` int(6) NOT NULL AUTO_INCREMENT,
  `class_id` int(6) DEFAULT NULL,
  `msg_content` varchar(2000) DEFAULT NULL,
  `msg_createtime` varchar(255) DEFAULT NULL,
  `ip_addr` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`msg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=111024 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_message
-- ----------------------------
INSERT INTO `t_message` VALUES ('111023', '408682', 'Hi', '2018-05-24 01:39:40', '10.211.55.3');

-- ----------------------------
-- Table structure for `t_module`
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
-- Table structure for `t_quiz`
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

-- ----------------------------
-- Table structure for `t_quizhasmcq`
-- ----------------------------
DROP TABLE IF EXISTS `t_quizhasmcq`;
CREATE TABLE `t_quizhasmcq` (
  `relation_id` int(6) NOT NULL AUTO_INCREMENT,
  `quiz_id` int(6) DEFAULT NULL,
  `mcq_id` int(6) DEFAULT NULL,
  PRIMARY KEY (`relation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=611 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_quizhasmcq
-- ----------------------------
INSERT INTO `t_quizhasmcq` VALUES ('56', '337639', '100004');
INSERT INTO `t_quizhasmcq` VALUES ('57', '337639', '100005');
INSERT INTO `t_quizhasmcq` VALUES ('58', '337639', '100006');

-- ----------------------------
-- Table structure for `t_student`
-- ----------------------------
DROP TABLE IF EXISTS `t_student`;
CREATE TABLE `t_student` (
  `serial` int(11) NOT NULL AUTO_INCREMENT,
  `ip_addr` varchar(30) NOT NULL,
  `attempt_id` int(6) NOT NULL,
  `answer_createtime` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`serial`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_student
-- ----------------------------
