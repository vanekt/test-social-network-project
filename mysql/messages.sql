CREATE DATABASE /*!32312 IF NOT EXISTS*/ `test-social-network` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `test-social-network`;

-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Хост: db
-- Время создания: Авг 16 2018 г., 21:12
-- Версия сервера: 5.7.22-22
-- Версия PHP: 7.2.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

--
-- База данных: `test-social-network`
--

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `dialogs`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `dialogs` (
`uid` int(11)
,`peer` int(11)
,`last_message_datetime` int(11)
,`has_new_messages` int(1)
);

-- --------------------------------------------------------

--
-- Структура таблицы `messages`
--

CREATE TABLE `messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `datetime` int(11) NOT NULL,
  `text` text NOT NULL,
  `author_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `messages`
--

INSERT INTO `messages` (`id`, `datetime`, `text`, `author_id`) VALUES
(1, 1534366063, 'Hello!', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `message_entries`
--

CREATE TABLE `message_entries` (
  `uid` int(11) NOT NULL,
  `peer` int(11) NOT NULL,
  `message_id` int(11) NOT NULL,
  `browsed` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `message_entries`
--

INSERT INTO `message_entries` (`uid`, `peer`, `message_id`, `browsed`, `deleted`) VALUES
(1, 3, 1, 0, 0),
(3, 1, 1, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(10) NOT NULL,
  `login` varchar(255) NOT NULL,
  `password` varchar(60) NOT NULL,
  `fullname` text NOT NULL,
  `image` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `login`, `password`, `fullname`, `image`, `created`) VALUES
(1, 'alex', '$2a$10$B4bIX6ckOzRqVA3r82ZuXe8NNryiWjm6ZPLBO/2dRzAX2KmHO3Ona', 'Alex N.', 'https://pickaface.net/gallery/avatar/63313158_161105_0454_yld7e.png', '2018-08-09 20:57:32'),
(2, 'robin', '$2a$10$B4bIX6ckOzRqVA3r82ZuXe8NNryiWjm6ZPLBO/2dRzAX2KmHO3Ona', 'Robin B.', 'https://pickaface.net/gallery/avatar/20130205_094954_4302_JW.png', '2018-08-09 20:57:32'),
(3, 'mark', '$2a$10$B4bIX6ckOzRqVA3r82ZuXe8NNryiWjm6ZPLBO/2dRzAX2KmHO3Ona', 'Mark J.', 'https://pickaface.net/gallery/avatar/20160115_183805_1115_jas.png', '2018-08-09 20:57:32');

-- --------------------------------------------------------

--
-- Структура для представления `dialogs`
--
DROP TABLE IF EXISTS `dialogs`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `dialogs`  AS  (select `message_entries`.`uid` AS `uid`,`message_entries`.`peer` AS `peer`,max(`messages`.`datetime`) AS `last_message_datetime`,(case max((case when (`message_entries`.`browsed` <> TRUE) then 1 else 0 end)) when 0 then FALSE else TRUE end) AS `has_new_messages` from (`message_entries` left join `messages` on((`messages`.`id` = `message_entries`.`message_id`))) where (`message_entries`.`deleted` = FALSE) group by `message_entries`.`uid`,`message_entries`.`peer`) ;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Индексы таблицы `message_entries`
--
ALTER TABLE `message_entries`
  ADD PRIMARY KEY (`deleted`,`uid`,`peer`,`message_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `messages`
--
ALTER TABLE `messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;
