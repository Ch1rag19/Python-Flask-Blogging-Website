-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 18, 2020 at 10:18 AM
-- Server version: 10.1.32-MariaDB
-- PHP Version: 5.6.36

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `flask_website_bootstrap_python`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(50) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `ph_num` varchar(50) NOT NULL,
  `mes` text NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `ph_num`, `mes`, `date`) VALUES
(1, 'First Post', 'firstpost@gmail.com', '123456789', 'I am the first post to start the value of sno.', '2019-10-21 17:39:11'),
(2, 'Tester', 'tester@gmail.com', '1234578412', 'This is a tester message.', '2019-10-21 23:44:15'),
(3, 'HEmant KApoooror', 'Hmntjdlqkfna@gmail.com', '23265451322', 'This is a message', '2019-10-21 23:45:48'),
(4, 'Testing2', 'tester@gmail.com', '215152515', 'This is again testing.:)', '2019-10-21 23:54:01'),
(5, 'tester', 't@gmail.com', '123457402', 'HEllo Tester.', '2019-10-22 00:01:40'),
(6, 'Testering', 'Test@gmail.com', '1234745525', 'Testing again bro.', '2019-10-22 00:18:26'),
(7, 'Kapoor', 'divyaarora131294@gmail.com', '123456789', 'Testing Mail', '2019-10-23 09:51:01'),
(8, 'Divya Arora', 'tester@gmail.com', '123456789', 'hello i am hemant kapoor', '2019-12-09 16:02:11'),
(9, 'Divya Arora', 'tester@gmail.com', '123456789', 'hello i am hemant kapoor', '2019-12-09 16:06:28'),
(10, 'Testering', 't@gmail.com', '1234745525', 'liougifuhgjlk;oilukhgyjhfvbnjkml,;.', '2019-12-09 16:07:15'),
(11, 'Hemant Kapoor', 'hmntkpr723@gmail.com', '9529670265', 'hello hemant', '2020-04-11 09:57:08'),
(12, 'Hemant Kapoor', 'hmntkpr723@gmail.com', '9529670265', 'hello sir ', '2020-04-19 17:42:00'),
(13, 'Hemant Kapoor', 'hmntkpr723@gmail.com', '9529670265', 'hello sir ', '2020-04-19 17:54:35'),
(14, 'Hemant Kapoor', 'hmntkpr723@gmail.com', '9529670265', 'hello sir ', '2020-04-19 18:01:10'),
(15, 'Hemant Kapoor', 'hmntkpr723@gmail.com', '9529670265', 'hello hemant', '2020-04-24 17:26:46'),
(16, 'Hemant Kapoor', 'hmntkpr723@gmail.com', '9529670265', 'hello hemant', '2020-04-24 17:27:57'),
(17, 'Hemant Kapoor', 'hmntkpr723@gmail.com', '9529670265', 'hello hemant', '2020-04-24 17:28:12'),
(18, 'Hemant Kapoor', 'hmntkpr723@gmail.com', '9529670265', 'Hi beti kaisa h?', '2020-11-17 09:54:45');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `tagline` text NOT NULL,
  `slug` varchar(40) NOT NULL,
  `content` text NOT NULL,
  `img_file` varchar(30) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `tagline`, `slug`, `content`, `img_file`, `date`) VALUES
(1, 'MAHNDRA FIRST CHOICE-ANY BIKE SERVICE', 'We Provide service for all 2-Wheeler of any company in the market.', 'first-post', 'We are the First Two Wheeler Workshop in Bharatpur (Rajasthan) that provide service of any 2-Wheeler with the Brand Satisfaction of Mahindra Group.', 'MFC2.png', '2019-11-03 18:22:51'),
(2, 'NEXZU-FORMERLY KNOWN AS AVAN MOTORS.', 'Nexzu is a cutting-edge mobility solution\r\nbrand driven by innovation and technology.\r\nEase your mobility experience with our incredible 2-Wheeler products.', 'second-slug', 'NEXZU is a Brand known for its Electric 2-Wheelers.A creative and enthusiastic team of Nexzu always strives to improve user experience in the best possible way and consequently becomes the most prominent mobility solution brand. Our work efficiency and commitment have been getting appreciation by the customers as well as critics and our credibility is reflected by the recognition we received.', 'Nexzu.jpg', '2019-10-25 08:48:13'),
(3, 'MAHINDRA 2-WHEELERS', 'Mahindra & Mahindra Two Wheelers Division products are as distinctive as they are thoughtful. Explore our range and discover the delight of riding high on trust, reliability and innovation.', 'third-post', 'Like all Mahindra companies, Mahindra & Mahindra Two Wheelers Division is guided by the three tenets of Rise i.e., Accepting No Limits, Alternative Thinking and Driving Positive Change. With these three guiding principles, we have built a range of scooters and motorcycles that offer distinctive styling, solid performance, great mileage and superior ride quality on tough Indian roads. ', 'mh22.jpg', '2019-10-26 18:12:14'),
(4, 'Adding from Admin panel', 'checking via admin post', 'fourth-post', 'Content', 'image.png', '2019-11-03 17:58:12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
