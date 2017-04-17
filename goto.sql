-- phpMyAdmin SQL Dump
-- version 4.4.15.5
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1:3306
-- Время создания: Апр 17 2017 г., 12:39
-- Версия сервера: 5.5.48
-- Версия PHP: 7.0.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `goto`
--

-- --------------------------------------------------------

--
-- Структура таблицы `carriage_type`
--

CREATE TABLE IF NOT EXISTS `carriage_type` (
  `id` int(11) NOT NULL,
  `name` varchar(20) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `carriage_type`
--

INSERT INTO `carriage_type` (`id`, `name`) VALUES
(1, 'Автобус'),
(2, 'Трамвая'),
(3, 'Тролейбус');

-- --------------------------------------------------------

--
-- Структура таблицы `route`
--

CREATE TABLE IF NOT EXISTS `route` (
  `id` int(11) NOT NULL,
  `name_start` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `name_end` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `number` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `carriage_id` int(11) NOT NULL,
  `id_stations_start` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `id_stations_end` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `delta_time_start` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `delta_time_end` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `station`
--

CREATE TABLE IF NOT EXISTS `station` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `is_real` tinyint(1) NOT NULL,
  `neighboring_stop` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `map_x` double NOT NULL,
  `map_y` double NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `timetable`
--

CREATE TABLE IF NOT EXISTS `timetable` (
  `id` int(11) NOT NULL,
  `transport_id` int(11) NOT NULL,
  `time_route_start_id` int(11) NOT NULL,
  `carriage_id` int(11) NOT NULL,
  `route_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `is_rest_day` int(11) NOT NULL,
  `time_arrive` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `time_route_start`
--

CREATE TABLE IF NOT EXISTS `time_route_start` (
  `id` int(11) NOT NULL,
  `transport_id` int(11) NOT NULL,
  `way` tinyint(1) NOT NULL,
  `time_start` time NOT NULL,
  `depo` int(11) DEFAULT NULL,
  `is_rest_day` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `transport`
--

CREATE TABLE IF NOT EXISTS `transport` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `carriage_id` int(11) NOT NULL,
  `route_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `carriage_type`
--
ALTER TABLE `carriage_type`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `route`
--
ALTER TABLE `route`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type_id` (`carriage_id`),
  ADD KEY `type_id_2` (`carriage_id`);

--
-- Индексы таблицы `station`
--
ALTER TABLE `station`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `timetable`
--
ALTER TABLE `timetable`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transport_id` (`transport_id`),
  ADD KEY `time_route_start_id` (`time_route_start_id`),
  ADD KEY `carriage_id` (`carriage_id`),
  ADD KEY `station_id` (`station_id`);

--
-- Индексы таблицы `time_route_start`
--
ALTER TABLE `time_route_start`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transport_id` (`transport_id`),
  ADD KEY `depo` (`depo`);

--
-- Индексы таблицы `transport`
--
ALTER TABLE `transport`
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `carriage_id` (`carriage_id`),
  ADD KEY `route_id` (`route_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `carriage_type`
--
ALTER TABLE `carriage_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `route`
--
ALTER TABLE `route`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `station`
--
ALTER TABLE `station`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `timetable`
--
ALTER TABLE `timetable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `time_route_start`
--
ALTER TABLE `time_route_start`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `transport`
--
ALTER TABLE `transport`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `route`
--
ALTER TABLE `route`
  ADD CONSTRAINT `route_ibfk_1` FOREIGN KEY (`carriage_id`) REFERENCES `carriage_type` (`id`);

--
-- Ограничения внешнего ключа таблицы `timetable`
--
ALTER TABLE `timetable`
  ADD CONSTRAINT `timetable_ibfk_4` FOREIGN KEY (`station_id`) REFERENCES `station` (`id`),
  ADD CONSTRAINT `timetable_ibfk_1` FOREIGN KEY (`transport_id`) REFERENCES `transport` (`id`),
  ADD CONSTRAINT `timetable_ibfk_2` FOREIGN KEY (`time_route_start_id`) REFERENCES `time_route_start` (`id`),
  ADD CONSTRAINT `timetable_ibfk_3` FOREIGN KEY (`carriage_id`) REFERENCES `carriage_type` (`id`);

--
-- Ограничения внешнего ключа таблицы `time_route_start`
--
ALTER TABLE `time_route_start`
  ADD CONSTRAINT `time_route_start_ibfk_2` FOREIGN KEY (`depo`) REFERENCES `station` (`id`),
  ADD CONSTRAINT `time_route_start_ibfk_1` FOREIGN KEY (`transport_id`) REFERENCES `transport` (`id`);

--
-- Ограничения внешнего ключа таблицы `transport`
--
ALTER TABLE `transport`
  ADD CONSTRAINT `transport_ibfk_2` FOREIGN KEY (`route_id`) REFERENCES `route` (`id`),
  ADD CONSTRAINT `transport_ibfk_1` FOREIGN KEY (`carriage_id`) REFERENCES `carriage_type` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
