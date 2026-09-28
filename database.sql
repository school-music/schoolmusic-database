

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `school_music_final`
--

-- --------------------------------------------------------

--
-- Table structure for table `artists`
--

CREATE TABLE `artists` (
  `id` int(11) NOT NULL,
  `spotify_artist_id` text NOT NULL,
  `name` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `artist_blacklist`
--

CREATE TABLE `artist_blacklist` (
  `id` int(11) NOT NULL,
  `artist_id` int(11) NOT NULL,
  `moderator_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `banned_users`
--

CREATE TABLE `banned_users` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `reason` text DEFAULT NULL,
  `moderator_id` int(11) NOT NULL,
  `banned_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `break`
--

CREATE TABLE `break` (
  `id` int(11) NOT NULL,
  `start_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ends_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `vote_ends` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `break_number` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `default_songs`
--

CREATE TABLE `default_songs` (
  `id` int(11) NOT NULL,
  `song_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exception_day`
--

CREATE TABLE `exception_day` (
  `id` int(11) NOT NULL,
  `start_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ends_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `id` int(11) NOT NULL,
  `song_id` int(11) NOT NULL,
  `played_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `break_id` int(11) NOT NULL,
  `votes` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `moderators`
--

CREATE TABLE `moderators` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `artists_banned` int(11) DEFAULT NULL,
  `songs_baned` int(11) DEFAULT NULL,
  `songs_approved` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `queue_items`
--

CREATE TABLE `queue_items` (
  `id` int(11) NOT NULL,
  `break_id` int(11) NOT NULL,
  `song_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `greenlist_id` int(11) NOT NULL,
  `blacklist_id` int(11) NOT NULL,
  `moderator_id` int(11) NOT NULL,
  `moderation_status` enum('approved','rejected') DEFAULT NULL,
  `order_index` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ranks`
--

CREATE TABLE `ranks` (
  `id` int(11) NOT NULL,
  `rank` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ranks`
--

INSERT INTO `ranks` (`id`, `rank`) VALUES
(1, 'user'),
(2, 'mod'),
(3, 'admin'),
(4, 'head_admin');

-- --------------------------------------------------------

--
-- Table structure for table `songs`
--

CREATE TABLE `songs` (
  `id` int(11) NOT NULL,
  `spotify_id` text NOT NULL,
  `title` text NOT NULL,
  `artist_id` int(11) NOT NULL,
  `cover` text NOT NULL,
  `duration_ms` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `song_blacklist`
--

CREATE TABLE `song_blacklist` (
  `id` int(11) NOT NULL,
  `song_id` int(11) NOT NULL,
  `artist_id` int(11) NOT NULL,
  `mod_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `song_greenlist`
--

CREATE TABLE `song_greenlist` (
  `id` int(11) NOT NULL,
  `song_id` int(11) NOT NULL,
  `artist_id` int(11) NOT NULL,
  `mod_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `special_event`
--

CREATE TABLE `special_event` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `file_url` text NOT NULL,
  `starts_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `event_status` enum('pending','playing','done') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `user_login` varchar(255) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `rank_id` int(11) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `password_changed_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_favourites`
--

CREATE TABLE `user_favourites` (
  `user_id` int(11) NOT NULL,
  `song_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `votes`
--

CREATE TABLE `votes` (
  `id` int(11) NOT NULL,
  `queue_item_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `artists`
--
ALTER TABLE `artists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `artist_blacklist`
--
ALTER TABLE `artist_blacklist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `artist_id` (`artist_id`),
  ADD KEY `moderator_id` (`moderator_id`);

--
-- Indexes for table `banned_users`
--
ALTER TABLE `banned_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `moderator_id` (`moderator_id`);

--
-- Indexes for table `break`
--
ALTER TABLE `break`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `default_songs`
--
ALTER TABLE `default_songs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `song_id` (`song_id`);

--
-- Indexes for table `exception_day`
--
ALTER TABLE `exception_day`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `song_id` (`song_id`),
  ADD KEY `break_id` (`break_id`);

--
-- Indexes for table `moderators`
--
ALTER TABLE `moderators`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `queue_items`
--
ALTER TABLE `queue_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `break_id` (`break_id`),
  ADD KEY `song_id` (`song_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `greenlist_id` (`greenlist_id`),
  ADD KEY `blacklist_id` (`blacklist_id`),
  ADD KEY `moderator_id` (`moderator_id`);

--
-- Indexes for table `ranks`
--
ALTER TABLE `ranks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `songs`
--
ALTER TABLE `songs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `artist_id` (`artist_id`);

--
-- Indexes for table `song_blacklist`
--
ALTER TABLE `song_blacklist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `song_id` (`song_id`),
  ADD KEY `artist_id` (`artist_id`),
  ADD KEY `mod_id` (`mod_id`);

--
-- Indexes for table `song_greenlist`
--
ALTER TABLE `song_greenlist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `song_id` (`song_id`),
  ADD KEY `artist_id` (`artist_id`),
  ADD KEY `mod_id` (`mod_id`);

--
-- Indexes for table `special_event`
--
ALTER TABLE `special_event`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_login` (`user_login`),
  ADD KEY `rank_id` (`rank_id`);

--
-- Indexes for table `user_favourites`
--
ALTER TABLE `user_favourites`
  ADD PRIMARY KEY (`user_id`,`song_id`),
  ADD KEY `song_id` (`song_id`);

--
-- Indexes for table `votes`
--
ALTER TABLE `votes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `queue_item_id` (`queue_item_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `artists`
--
ALTER TABLE `artists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
-- AUTO_INCREMENT for table `default_songs`
--
ALTER TABLE `default_songs`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  ADD CONSTRAINT `artist_blacklist_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`),
  ADD CONSTRAINT `artist_blacklist_ibfk_2` FOREIGN KEY (`moderator_id`) REFERENCES `moderators` (`id`);

--
-- Constraints for table `banned_users`
--
ALTER TABLE `banned_users`
  ADD CONSTRAINT `banned_users_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `banned_users_ibfk_2` FOREIGN KEY (`moderator_id`) REFERENCES `moderators` (`id`);

--
-- Constraints for table `default_songs`
--
ALTER TABLE `default_songs`
  ADD CONSTRAINT `default_songs_ibfk_1` FOREIGN KEY (`song_id`) REFERENCES `songs` (`id`);

--
-- Constraints for table `history`
--
ALTER TABLE `history`
  ADD CONSTRAINT `history_ibfk_1` FOREIGN KEY (`song_id`) REFERENCES `songs` (`id`),
  ADD CONSTRAINT `history_ibfk_2` FOREIGN KEY (`break_id`) REFERENCES `break` (`id`);

--
-- Constraints for table `moderators`
--
ALTER TABLE `moderators`
  ADD CONSTRAINT `moderators_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `queue_items`
--
ALTER TABLE `queue_items`
  ADD CONSTRAINT `queue_items_ibfk_1` FOREIGN KEY (`break_id`) REFERENCES `break` (`id`),
  ADD CONSTRAINT `queue_items_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `songs` (`id`),
  ADD CONSTRAINT `queue_items_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `queue_items_ibfk_4` FOREIGN KEY (`greenlist_id`) REFERENCES `song_greenlist` (`id`),
  ADD CONSTRAINT `queue_items_ibfk_5` FOREIGN KEY (`blacklist_id`) REFERENCES `song_blacklist` (`id`),
  ADD CONSTRAINT `queue_items_ibfk_6` FOREIGN KEY (`moderator_id`) REFERENCES `moderators` (`id`);

--
-- Constraints for table `songs`
--
ALTER TABLE `songs`
  ADD CONSTRAINT `songs_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`);

--
-- Constraints for table `song_blacklist`
--
ALTER TABLE `song_blacklist`
  ADD CONSTRAINT `song_blacklist_ibfk_1` FOREIGN KEY (`song_id`) REFERENCES `songs` (`id`),
  ADD CONSTRAINT `song_blacklist_ibfk_2` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`),
  ADD CONSTRAINT `song_blacklist_ibfk_3` FOREIGN KEY (`mod_id`) REFERENCES `moderators` (`id`);

--
-- Constraints for table `song_greenlist`
--
ALTER TABLE `song_greenlist`
  ADD CONSTRAINT `song_greenlist_ibfk_1` FOREIGN KEY (`song_id`) REFERENCES `songs` (`id`),
  ADD CONSTRAINT `song_greenlist_ibfk_2` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`),
  ADD CONSTRAINT `song_greenlist_ibfk_3` FOREIGN KEY (`mod_id`) REFERENCES `moderators` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`rank_id`) REFERENCES `ranks` (`id`);

--
-- Constraints for table `user_favourites`
--
ALTER TABLE `user_favourites`
  ADD CONSTRAINT `user_favourites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_favourites_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `songs` (`id`);

--
-- Constraints for table `votes`
--
ALTER TABLE `votes`
  ADD CONSTRAINT `votes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `votes_ibfk_2` FOREIGN KEY (`queue_item_id`) REFERENCES `queue_items` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
-- database.sql
