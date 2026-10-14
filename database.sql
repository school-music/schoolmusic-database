-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Paź 14, 2026 at 04:31 PM
-- Wersja serwera: 10.4.32-MariaDB
-- Wersja PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `schoolmusic`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `artists`
--

CREATE TABLE `artists` (
  `id` int(11) NOT NULL,
  `spotify_artist_id` varchar(255) DEFAULT NULL,
  `name` varchar(500) NOT NULL,
  `source` enum('spotify','youtube','local','other') NOT NULL DEFAULT 'spotify'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `artist_blacklist`
--

CREATE TABLE `artist_blacklist` (
  `id` int(11) NOT NULL,
  `artist_id` int(11) NOT NULL,
  `moderator_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `banned_users`
--

CREATE TABLE `banned_users` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `reason` text DEFAULT NULL,
  `moderator_id` int(11) NOT NULL,
  `banned_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `break`
--

CREATE TABLE `break` (
  `id` int(11) NOT NULL,
  `break_date` date NOT NULL,
  `break_number` tinyint(4) NOT NULL,
  `start_at` datetime NOT NULL,
  `ends_at` datetime NOT NULL,
  `vote_ends` datetime DEFAULT NULL,
  `music_enabled` tinyint(1) NOT NULL DEFAULT 1
) ;

--
-- Dumping data for table `break`
--

INSERT INTO `break` (`id`, `break_date`, `break_number`, `start_at`, `ends_at`, `vote_ends`, `music_enabled`) VALUES
(1, '2026-01-01', 1, '2026-01-01 07:45:00', '2026-01-01 07:55:00', '2026-01-01 07:45:00', 1),
(2, '2026-01-01', 2, '2026-01-01 08:40:00', '2026-01-01 08:50:00', '2026-01-01 08:40:00', 1),
(3, '2026-01-01', 3, '2026-01-01 09:35:00', '2026-01-01 09:45:00', '2026-01-01 09:35:00', 1),
(4, '2026-01-01', 4, '2026-01-01 10:30:00', '2026-01-01 10:50:00', '2026-01-01 10:30:00', 1),
(5, '2026-01-01', 5, '2026-01-01 11:35:00', '2026-01-01 11:45:00', '2026-01-01 11:35:00', 1),
(6, '2026-01-01', 6, '2026-01-01 12:30:00', '2026-01-01 12:40:00', '2026-01-01 12:30:00', 1),
(7, '2026-01-01', 7, '2026-01-01 13:25:00', '2026-01-01 13:35:00', '2026-01-01 13:25:00', 1),
(8, '2026-01-01', 8, '2026-01-01 14:20:00', '2026-01-01 14:25:00', '2026-01-01 14:20:00', 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `break_templates`
--

CREATE TABLE `break_templates` (
  `id` int(11) NOT NULL,
  `break_number` tinyint(4) NOT NULL,
  `starts_time` time NOT NULL,
  `ends_time` time NOT NULL
) ;

--
-- Dumping data for table `break_templates`
--

INSERT INTO `break_templates` (`id`, `break_number`, `starts_time`, `ends_time`) VALUES
(1, 1, '07:45:00', '07:55:00'),
(2, 2, '08:40:00', '08:50:00'),
(3, 3, '09:35:00', '09:45:00'),
(4, 4, '10:30:00', '10:50:00'),
(5, 5, '11:35:00', '11:45:00'),
(6, 6, '12:30:00', '12:40:00'),
(7, 7, '13:25:00', '13:35:00'),
(8, 8, '14:20:00', '14:25:00');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `default_songs`
--

CREATE TABLE `default_songs` (
  `id` int(11) NOT NULL,
  `song_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `exception_break`
--

CREATE TABLE `exception_break` (
  `id` int(11) NOT NULL,
  `break_date` date NOT NULL,
  `break_number` tinyint(4) NOT NULL,
  `music_enabled` tinyint(1) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `exception_day`
--

CREATE TABLE `exception_day` (
  `id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `day_type` enum('day_off','no_music') NOT NULL,
  `description` text DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `history`
--

CREATE TABLE `history` (
  `id` int(11) NOT NULL,
  `song_id` int(11) NOT NULL,
  `break_id` int(11) NOT NULL,
  `played_at` datetime NOT NULL DEFAULT current_timestamp(),
  `votes` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `moderators`
--

CREATE TABLE `moderators` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `artists_banned` int(11) NOT NULL DEFAULT 0,
  `songs_banned` int(11) NOT NULL DEFAULT 0,
  `songs_approved` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `moderators`
--

INSERT INTO `moderators` (`id`, `user_id`, `artists_banned`, `songs_banned`, `songs_approved`) VALUES
(1, 1, 0, 0, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `playback_state`
--

CREATE TABLE `playback_state` (
  `id` tinyint(1) NOT NULL DEFAULT 1,
  `current_queue_item_id` int(11) DEFAULT NULL,
  `started_at` datetime DEFAULT NULL,
  `is_paused` tinyint(1) NOT NULL DEFAULT 0,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

--
-- Dumping data for table `playback_state`
--

INSERT INTO `playback_state` (`id`, `current_queue_item_id`, `started_at`, `is_paused`, `updated_at`) VALUES
(1, NULL, NULL, 0, '2026-10-14 16:15:31');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `queue_items`
--

CREATE TABLE `queue_items` (
  `id` int(11) NOT NULL,
  `break_id` int(11) NOT NULL,
  `song_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `greenlist_id` int(11) DEFAULT NULL,
  `blacklist_id` int(11) DEFAULT NULL,
  `moderator_id` int(11) DEFAULT NULL,
  `moderation_status` enum('approved','rejected') DEFAULT NULL,
  `status` enum('queued','playing','played','skipped') NOT NULL DEFAULT 'queued',
  `order_index` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ranks`
--

CREATE TABLE `ranks` (
  `id` int(11) NOT NULL,
  `rank` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `ranks`
--

INSERT INTO `ranks` (`id`, `rank`) VALUES
(3, 'admin'),
(4, 'head_admin'),
(2, 'mod'),
(1, 'user');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `songs`
--

CREATE TABLE `songs` (
  `id` int(11) NOT NULL,
  `spotify_id` varchar(255) DEFAULT NULL,
  `source` enum('spotify','youtube','local','other') NOT NULL DEFAULT 'spotify',
  `title` varchar(500) NOT NULL,
  `artist_id` int(11) NOT NULL,
  `cover` text DEFAULT NULL,
  `song_url` text DEFAULT NULL,
  `genre` varchar(100) DEFAULT NULL,
  `duration_ms` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ;

--
-- Dumping data for table `songs`
--

INSERT INTO `songs` (`id`, `spotify_id`, `source`, `title`, `artist_id`, `cover`, `song_url`, `genre`, `duration_ms`, `is_active`, `created_at`) VALUES
(1, '4cOdK2wGLETKBW3PvgPWqT', 'spotify', "God\'s Plan", 1, 'https://i.scdn.co/image/ab67616d0000b273', NULL, NULL, 198973, 1, '2026-10-14 16:15:30');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `song_blacklist`
--

CREATE TABLE `song_blacklist` (
  `id` int(11) NOT NULL,
  `song_id` int(11) NOT NULL,
  `artist_id` int(11) NOT NULL,
  `mod_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `song_greenlist`
--

CREATE TABLE `song_greenlist` (
  `id` int(11) NOT NULL,
  `song_id` int(11) NOT NULL,
  `artist_id` int(11) NOT NULL,
  `mod_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `song_vote_counts`
-- (See below for the actual view)
--
CREATE TABLE `song_vote_counts` (
`song_id` int(11)
,`title` varchar(500)
,`total_votes` bigint(21)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `special_event`
--

CREATE TABLE `special_event` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `file_url` text NOT NULL,
  `starts_at` datetime NOT NULL DEFAULT current_timestamp(),
  `event_status` enum('pending','playing','done') NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `user_login` varchar(255) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `rank_id` int(11) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `password_changed_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;


-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user_favourites`
--

CREATE TABLE `user_favourites` (
  `user_id` int(11) NOT NULL,
  `song_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `votes`
--

CREATE TABLE `votes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `queue_item_id` int(11) NOT NULL,
  `voted_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `weekly_break_settings`
--

CREATE TABLE `weekly_break_settings` (
  `weekday` tinyint(1) NOT NULL,
  `break_number` tinyint(4) NOT NULL,
  `music_enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `weekly_schedule`
--

CREATE TABLE `weekly_schedule` (
  `weekday` tinyint(1) NOT NULL,
  `music_enabled` tinyint(1) NOT NULL DEFAULT 1
) ;

--
-- Dumping data for table `weekly_schedule`
--

INSERT INTO `weekly_schedule` (`weekday`, `music_enabled`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1);

-- --------------------------------------------------------

--
-- Struktura widoku `song_vote_counts`
--
DROP TABLE IF EXISTS `song_vote_counts`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `song_vote_counts`  AS SELECT `s`.`id` AS `song_id`, `s`.`title` AS `title`, count(`v`.`id`) AS `total_votes` FROM ((`songs` `s` left join `queue_items` `qi` on(`qi`.`song_id` = `s`.`id`)) left join `votes` `v` on(`v`.`queue_item_id` = `qi`.`id`)) WHERE `s`.`is_active` = 1 GROUP BY `s`.`id`, `s`.`title` ;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `artists`
--
ALTER TABLE `artists`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_spotify_artist` (`spotify_artist_id`),
  ADD KEY `idx_artists_name` (`name`(191));

--
-- Indeksy dla tabeli `artist_blacklist`
--
ALTER TABLE `artist_blacklist`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_black_artist` (`artist_id`),
  ADD KEY `idx_artist_black_mod` (`moderator_id`);

--
-- Indeksy dla tabeli `banned_users`
--
ALTER TABLE `banned_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_banned_user` (`user_id`),
  ADD KEY `idx_banned_mod` (`moderator_id`);

--
-- Indeksy dla tabeli `break`
--
ALTER TABLE `break`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_break_day` (`break_date`,`break_number`),
  ADD KEY `idx_break_start` (`start_at`);

--
-- Indeksy dla tabeli `break_templates`
--
ALTER TABLE `break_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_break_number` (`break_number`);

--
-- Indeksy dla tabeli `default_songs`
--
ALTER TABLE `default_songs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_default_song` (`song_id`);

--
-- Indeksy dla tabeli `exception_break`
--
ALTER TABLE `exception_break`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_exc_break` (`break_date`,`break_number`);

--
-- Indeksy dla tabeli `exception_day`
--
ALTER TABLE `exception_day`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_exc_day_range` (`start_date`,`end_date`);

--
-- Indeksy dla tabeli `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_history_song` (`song_id`),
  ADD KEY `idx_history_break` (`break_id`),
  ADD KEY `idx_history_played` (`played_at`);

--
-- Indeksy dla tabeli `moderators`
--
ALTER TABLE `moderators`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_mod_user` (`user_id`);

--
-- Indeksy dla tabeli `playback_state`
--
ALTER TABLE `playback_state`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_playback_queue` (`current_queue_item_id`);

--
-- Indeksy dla tabeli `queue_items`
--
ALTER TABLE `queue_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_break_song` (`break_id`,`song_id`),
  ADD UNIQUE KEY `uniq_break_order` (`break_id`,`order_index`),
  ADD KEY `idx_queue_song` (`song_id`),
  ADD KEY `idx_queue_user` (`user_id`),
  ADD KEY `idx_queue_green` (`greenlist_id`),
  ADD KEY `idx_queue_black` (`blacklist_id`),
  ADD KEY `idx_queue_mod` (`moderator_id`);

--
-- Indeksy dla tabeli `ranks`
--
ALTER TABLE `ranks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_rank_name` (`rank`);

--
-- Indeksy dla tabeli `songs`
--
ALTER TABLE `songs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_spotify_song` (`spotify_id`),
  ADD KEY `idx_songs_artist` (`artist_id`),
  ADD KEY `idx_songs_active` (`is_active`);

--
-- Indeksy dla tabeli `song_blacklist`
--
ALTER TABLE `song_blacklist`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_black_song` (`song_id`),
  ADD KEY `idx_black_artist` (`artist_id`),
  ADD KEY `idx_black_mod` (`mod_id`);

--
-- Indeksy dla tabeli `song_greenlist`
--
ALTER TABLE `song_greenlist`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_green_song` (`song_id`),
  ADD KEY `idx_green_artist` (`artist_id`),
  ADD KEY `idx_green_mod` (`mod_id`);

--
-- Indeksy dla tabeli `special_event`
--
ALTER TABLE `special_event`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_user_login` (`user_login`),
  ADD KEY `idx_users_rank` (`rank_id`);

--
-- Indeksy dla tabeli `user_favourites`
--
ALTER TABLE `user_favourites`
  ADD PRIMARY KEY (`user_id`,`song_id`),
  ADD KEY `idx_fav_song` (`song_id`);

--
-- Indeksy dla tabeli `votes`
--
ALTER TABLE `votes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_user_vote` (`user_id`,`queue_item_id`),
  ADD KEY `idx_votes_queue` (`queue_item_id`);

--
-- Indeksy dla tabeli `weekly_break_settings`
--
ALTER TABLE `weekly_break_settings`
  ADD PRIMARY KEY (`weekday`,`break_number`),
  ADD KEY `idx_wbs_break` (`break_number`);

--
-- Indeksy dla tabeli `weekly_schedule`
--
ALTER TABLE `weekly_schedule`
  ADD PRIMARY KEY (`weekday`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `artists`
--
ALTER TABLE `artists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `artist_blacklist`
--
ALTER TABLE `artist_blacklist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `banned_users`
--
ALTER TABLE `banned_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `break`
--
ALTER TABLE `break`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `break_templates`
--
ALTER TABLE `break_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `default_songs`
--
ALTER TABLE `default_songs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exception_break`
--
ALTER TABLE `exception_break`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exception_day`
--
ALTER TABLE `exception_day`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `moderators`
--
ALTER TABLE `moderators`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `queue_items`
--
ALTER TABLE `queue_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ranks`
--
ALTER TABLE `ranks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `songs`
--
ALTER TABLE `songs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `song_blacklist`
--
ALTER TABLE `song_blacklist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `song_greenlist`
--
ALTER TABLE `song_greenlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `special_event`
--
ALTER TABLE `special_event`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `votes`
--
ALTER TABLE `votes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `artist_blacklist`
--
ALTER TABLE `artist_blacklist`
  ADD CONSTRAINT `fk_artist_black_artist` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`),
  ADD CONSTRAINT `fk_artist_black_mod` FOREIGN KEY (`moderator_id`) REFERENCES `moderators` (`id`);

--
-- Constraints for table `banned_users`
--
ALTER TABLE `banned_users`
  ADD CONSTRAINT `fk_banned_mod` FOREIGN KEY (`moderator_id`) REFERENCES `moderators` (`id`),
  ADD CONSTRAINT `fk_banned_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `default_songs`
--
ALTER TABLE `default_songs`
  ADD CONSTRAINT `fk_default_song` FOREIGN KEY (`song_id`) REFERENCES `songs` (`id`);

--
-- Constraints for table `history`
--
ALTER TABLE `history`
  ADD CONSTRAINT `fk_history_break` FOREIGN KEY (`break_id`) REFERENCES `break` (`id`),
  ADD CONSTRAINT `fk_history_song` FOREIGN KEY (`song_id`) REFERENCES `songs` (`id`);

--
-- Constraints for table `moderators`
--
ALTER TABLE `moderators`
  ADD CONSTRAINT `fk_moderators_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `playback_state`
--
ALTER TABLE `playback_state`
  ADD CONSTRAINT `fk_playback_queue` FOREIGN KEY (`current_queue_item_id`) REFERENCES `queue_items` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `queue_items`
--
ALTER TABLE `queue_items`
  ADD CONSTRAINT `fk_queue_black` FOREIGN KEY (`blacklist_id`) REFERENCES `song_blacklist` (`id`),
  ADD CONSTRAINT `fk_queue_break` FOREIGN KEY (`break_id`) REFERENCES `break` (`id`),
  ADD CONSTRAINT `fk_queue_green` FOREIGN KEY (`greenlist_id`) REFERENCES `song_greenlist` (`id`),
  ADD CONSTRAINT `fk_queue_mod` FOREIGN KEY (`moderator_id`) REFERENCES `moderators` (`id`),
  ADD CONSTRAINT `fk_queue_song` FOREIGN KEY (`song_id`) REFERENCES `songs` (`id`),
  ADD CONSTRAINT `fk_queue_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `songs`
--
ALTER TABLE `songs`
  ADD CONSTRAINT `fk_songs_artist` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`);

--
-- Constraints for table `song_blacklist`
--
ALTER TABLE `song_blacklist`
  ADD CONSTRAINT `fk_black_artist` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`),
  ADD CONSTRAINT `fk_black_mod` FOREIGN KEY (`mod_id`) REFERENCES `moderators` (`id`),
  ADD CONSTRAINT `fk_black_song` FOREIGN KEY (`song_id`) REFERENCES `songs` (`id`);

--
-- Constraints for table `song_greenlist`
--
ALTER TABLE `song_greenlist`
  ADD CONSTRAINT `fk_green_artist` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`),
  ADD CONSTRAINT `fk_green_mod` FOREIGN KEY (`mod_id`) REFERENCES `moderators` (`id`),
  ADD CONSTRAINT `fk_green_song` FOREIGN KEY (`song_id`) REFERENCES `songs` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_rank` FOREIGN KEY (`rank_id`) REFERENCES `ranks` (`id`);

--
-- Constraints for table `user_favourites`
--
ALTER TABLE `user_favourites`
  ADD CONSTRAINT `fk_fav_song` FOREIGN KEY (`song_id`) REFERENCES `songs` (`id`),
  ADD CONSTRAINT `fk_fav_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `votes`
--
ALTER TABLE `votes`
  ADD CONSTRAINT `fk_votes_queue` FOREIGN KEY (`queue_item_id`) REFERENCES `queue_items` (`id`),
  ADD CONSTRAINT `fk_votes_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `weekly_break_settings`
--
ALTER TABLE `weekly_break_settings`
  ADD CONSTRAINT `fk_wbs_break` FOREIGN KEY (`break_number`) REFERENCES `break_templates` (`break_number`),
  ADD CONSTRAINT `fk_wbs_weekday` FOREIGN KEY (`weekday`) REFERENCES `weekly_schedule` (`weekday`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
