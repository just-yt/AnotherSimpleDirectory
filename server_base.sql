-- Modele de base de données pour le serveur d'authentification
--

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `directory`;
CREATE TABLE `directory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(12) NOT NULL,
  `mdp` varchar(12) NOT NULL,
  `role` int(2) NOT NULL,
  `active` int(1) NOT NULL,
  `hash` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `directory` (`id`, `user`, `mdp`, `role`, `active`, `hash`) VALUES
(1,	'johndoe',	'azerty',	0,	1,	'NONE'),
(2,	'johndie',	'azerty',	0,	0,	'NONE');

DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `group_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(128) NOT NULL,
  PRIMARY KEY (`group_id`),
  UNIQUE KEY `group_name` (`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `groups` (`group_id`, `group_name`) VALUES
(1,	'mylogon');

DROP TABLE IF EXISTS `usergroup`;
CREATE TABLE `usergroup` (
  `group_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `usergroup` (`group_id`, `user_id`) VALUES
(1,	1);

-- 2022-01-09 17:59:20
