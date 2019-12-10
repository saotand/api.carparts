-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-12-2019 a las 16:26:34
-- Versión del servidor: 5.6.20
-- Versión de PHP: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `turepuesto`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ResetAdmin`()
    MODIFIES SQL DATA
UPDATE `turepuesto`.`users` SET `email` = 'admin@turepuesto.com', `pass` = '9YKr3RKqOFTXAxbNXDk5P.' WHERE `users`.`ID` = '100000000000000000000000000001'$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `ask_data`
--
CREATE TABLE IF NOT EXISTS `ask_data` (
`ID` varchar(30)
,`image` text
,`userID` varchar(30)
,`brandID` varchar(30)
,`modelID` varchar(30)
,`spartID` varchar(30)
,`partID` varchar(30)
,`year` int(11)
,`details` text
,`startdate` timestamp
,`enddate` timestamp
,`active` tinyint(1)
,`username` varchar(100)
,`userlast` varchar(100)
,`useremail` varchar(100)
,`subpart` varchar(100)
,`part` varchar(100)
,`brand` varchar(100)
,`model` varchar(100)
);
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `car_brands`
--

CREATE TABLE IF NOT EXISTS `car_brands` (
  `ID` varchar(30) CHARACTER SET latin1 NOT NULL,
  `name` varchar(100) CHARACTER SET latin1 NOT NULL,
  `image` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `count` int(11) DEFAULT '0',
  `active` int(11) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `car_brands`
--

INSERT INTO `car_brands` (`ID`, `name`, `image`, `count`, `active`) VALUES
('03a20e86de71a816d5ebf40253f0a3', 'Howo', NULL, 0, 1),
('0c442e5dbe9bd85946263ef7adb6ad', 'Mini', NULL, 0, 1),
('0eac36a2150eb12872a5511579259b', 'Rolls Royce', NULL, 0, 1),
('0fc60e1c20d1c1f444c8b94bca0aef', 'Tesla', NULL, 0, 1),
('1034f831d1c632492a9ea06de4bf5e', 'Yutong', NULL, 4, 1),
('1aa1b4e0f9ae9c0192212d10699c9d', 'Seat', NULL, 0, 1),
('1ab545c4e484ba4bdcf9e1e3706937', 'Pegaso', NULL, 0, 1),
('27283bf6d86d9aaaf1302ed094c7d5', 'Mazda', NULL, 0, 1),
('288d75a1a61d76c4bab27497f1b822', 'Saturn', NULL, 0, 1),
('2c2875b65021eb41f6f5550b7bc3f8', 'Pontiac', NULL, 0, 1),
('2c4bd929a85da5d903b8583e50b887', 'Land Rover', NULL, 0, 1),
('2d0c3287873fd9a2cabe279c6130d7', 'Lada', NULL, 0, 1),
('2f716b47b527679f39b287a697bf37', 'Rover', NULL, 0, 1),
('312c379dde93a2140d4ca950a676a6', 'Zotye', NULL, 75, 1),
('34ce2f5b46848027926967af75949b', 'Nissan', NULL, 0, 1),
('385a8e09699e0d14234e4cb9812537', 'Autogago', NULL, 0, 1),
('3cd01a0a63ed3b8a9329caf036ee8a', 'Alfa Romeo ', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAgAAAAIACAAAAADRE4smAAAtXUlEQVR42u2d918UxxvHv3/OHEc5RCyggg0LKsQoarBgIxpjDBZMYopYo9iwYC/EiERRgwUbGjtqbNhQQSM2LGdD5BQO5vu6vn1n93bvFub5/AR7uzN787xvd+aZZ575HwJRrf9BEwAAIAAABACAAAAQAAACAEAAAAgAAAEAIAAABACAAAAQAAACA', 0, 1),
('3cf55c6fae531701fa8f2efe3dabef', 'Chery', NULL, 0, 1),
('3fd11d8793c65a13b2bc49ca63a00c', 'Dongfeng', NULL, 0, 1),
('3fe1abdcce8f25d90112c34c81e315', 'Maserati', NULL, 0, 1),
('43497f5a3342769496e6f950af0a3b', 'Bugatti', NULL, 0, 1),
('45dcae54f5f742797671069bae651b', 'Saic Wuling', NULL, 0, 1),
('4ee0c6ed32ed944b87aede00b96d97', 'Hyundai', NULL, 0, 1),
('500bdc31815280e39d1b1b494bd0fa', 'Chevrolet', NULL, 0, 1),
('50ad56da0eea7acb5bf0bf2cb002bb', 'Renault', NULL, 0, 1),
('52e56def1c87c108d639a8958660d3', 'Isuzu', NULL, 0, 1),
('5a093997965df9e415cdeda705f597', 'Pagani', NULL, 0, 1),
('6294785878771f334321a048b1c919', 'Hino', NULL, 0, 1),
('63b4e0431ff8bbd97f1554c32cec69', 'Guri', NULL, 0, 1),
('63c78b09292f595f19fffd066363cb', 'GMC', NULL, 0, 1),
('659d8cdd77053d1910e92a5202463d', 'Calto', NULL, 0, 1),
('67cb27b0167052439a9862b0f5fa48', 'Iveco', NULL, 0, 1),
('69750d861feb70b2d75937ca11c04c', 'Kia', NULL, 0, 1),
('6ae5d5804c5f7e9c34aa9ada785195', 'Skoda', NULL, 0, 1),
('6b6594040680265fc9c662db70f19c', 'Encava', NULL, 0, 1),
('6ce6116e73509db161e9a9392dd030', 'Tata Motors', NULL, 0, 1),
('7202d4d744acfaf297c0fe72ebf4d9', 'BMW', NULL, 0, 1),
('72dea830f65f86f49bb416f76c04b7', 'Zhongxing', NULL, 20, 1),
('76f99348508d2915c143e5f01303e2', 'Chana', NULL, 0, 1),
('78ae5309fcf6e2e905c1c1c5251dcd', 'Citroen', NULL, 0, 1),
('7aa950a0f73724a7cb3d525e59dd50', 'Foton', NULL, 0, 1),
('7c5031e7a050e20fa2345de496ddd3', 'Bentley', NULL, 0, 1),
('80c9df180b451cf55955fd26d306c4', 'Audi', NULL, 0, 1),
('81b2dc09517da3dc3f68d4b5c60e8e', 'Smart', NULL, 0, 1),
('81c10e613d0234473d1b7a76671abd', 'Mitsubishi', NULL, 0, 1),
('843f5ce274b3c95ccfee5a9f0d915b', 'Toyota', NULL, 0, 1),
('85a7a0b38c625179d6b93c9bd951d2', 'International', NULL, 0, 1),
('85d71f207a2ecfcbbb97769499ec50', 'Cadillac', NULL, 0, 1),
('8695909a6bae1e9afef41751f70f87', 'Sany', NULL, 0, 1),
('87557d046c2a675e782b1eb7b0fc1f', 'Jeep', NULL, 0, 1),
('8e0fb942d665c48a5df9a2abbb3247', 'Hafei', NULL, 0, 1),
('8e79b1199efc68a7c0356d3464b3a0', 'Geely', NULL, 0, 1),
('8e883574777efdf7fdf2f74c17cd2d', 'EBRO', NULL, 0, 1),
('900131645b1d77f123c480b346e4c2', 'Lexus', NULL, 0, 1),
('91a333b25b8ead3e5ba4dc386475f0', 'AMC', 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAgAAAQABAAD/7QCcUGhvdG9zaG9wIDMuMAA4QklNBAQAAAAAAIAcAigAYkZCTUQwMTAwMGFjMzAzMDAwMGI0MGMwMDAwNTQxNTAwMDBhYjE3MDAwMGVmMTkwMDAwNWQyMDAwMDA3ZTJiMDAwMDJhMmUwMDAwNTYzMDAwMDBiYzMyMDAwMDRkNDgwMDAwHAJnABRJUlR0LWpWNHlIcVJiYy1B', 0, 1),
('91eff905e98abbf311821ca28c5233', 'Honda', NULL, 0, 1),
('92136631d817d694f68521b3154ada', 'ARO', NULL, 0, 1),
('952dd671c40d04d06eda88fcd31fa6', 'JAC', NULL, 0, 1),
('985b249942cd9e4ad28bb4ae388e30', 'Daewoo', NULL, 0, 1),
('98a739fc3295eac3ae21b7fcb9fb23', 'Dacia', NULL, 0, 1),
('992de4c8c22d5e0fd7533c78950ff5', 'Venirauto', NULL, 0, 1),
('9b3bcca408fe28eba5e5a8011680fd', 'General Motors', NULL, 0, 1),
('9dcc0cc9f488be02bd993792079bb0', 'Fiat', NULL, 0, 1),
('a1d5e9ce2135baf03244320496c5fc', 'Volkswagen', NULL, 10, 1),
('a30bbff3f12d4128cdd779f1decc66', 'Lifan', NULL, 0, 1),
('a5c30500818e508e0890fcb5642680', 'Peugeot', NULL, 0, 1),
('a65a5ecec4558bdbfb738b52151b2f', 'JMC', NULL, 0, 1),
('a818c5ece87da85851ebf8cedcfa87', 'Aston Martin', NULL, 0, 1),
('a98dd0e1269d717398b464eae2c70f', 'Volvo', NULL, 0, 1),
('ac6103d34de00a32763e75eba4b167', 'Conquistador', NULL, 0, 1),
('accfcbd0a53482e59dff0a8b2a799a', 'Koenigsegg', NULL, 0, 1),
('aee53ba1d887270333a4fe396ac1ee', 'Minicooper', NULL, 0, 1),
('b318ec1c1db80f06ee1754b9c1408f', 'Titan', NULL, 0, 1),
('b3d2bfa1c92556a0848f0495998ce5', 'Itarca', NULL, 0, 1),
('b95b792ac1c76d83548bdeb4696e05', 'Chrysler', NULL, 0, 1),
('bb233559b0d12791ec954dbe82d19e', 'Ram', NULL, 0, 1),
('bd96d7ff9ac6507f12469f02ba913d', 'MAZ', NULL, 0, 1),
('bf3c1d020eae89e32c5092d3b9c3a9', 'Infiniti', NULL, 0, 1),
('bf400a6d21138f80eb39e8b9408fc1', 'Great Wall', NULL, 0, 1),
('c22779d07a200d1222c1053fee4856', 'Subaru', NULL, 0, 1),
('c4aeb35d3bd7e199f8a54bc5488a05', 'Ford', NULL, 0, 1),
('caeffc161d38803c691d2f85c4acdf', 'Agrale', 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAgAAAQABAAD/7QCcUGhvdG9zaG9wIDMuMAA4QklNBAQAAAAAAIAcAigAYkZCTUQwMTAwMGFjMzAzMDAwMGI0MGMwMDAwNTQxNTAwMDBhYjE3MDAwMGVmMTkwMDAwNWQyMDAwMDA3ZTJiMDAwMDJhMmUwMDAwNTYzMDAwMDBiYzMyMDAwMDRkNDgwMDAwHAJnABRJUlR0LWpWNHlIcVJiYy1B', 2, 1),
('cf20875450e31a1ea7ce7c1030958b', 'BYD', NULL, 0, 1),
('d0aa5970c3540b67535612a395f17f', 'Saab', NULL, 0, 1),
('d175a7e410f935b98a900a9d08e018', 'Dodge', NULL, 0, 1),
('d2ce9aeb47075324ad47fa557e485b', 'Sangyong', NULL, 0, 1),
('d6682ef6de92635148181f33529c3a', 'Changhe', NULL, 0, 1),
('d845e7b94c6bca2a8d18a1bfd5b1a5', 'Porsche', NULL, 0, 1),
('da6d2e47a3d15bb5d795116c20fbf4', 'Scania', NULL, 0, 1),
('dbc6121a80b8d3c4c61161eb9dce0b', 'Mercedes Benz', NULL, 0, 1),
('e2db424158b70725af4f66d798f902', 'Daihatsu', NULL, 0, 1),
('e83f0d61c4599ddfd1d9a27d0f6362', 'Jaguar', NULL, 0, 1),
('e906aae620b2a81a7ab816e599bf8b', 'Suzuki', NULL, 0, 1),
('efe4de0a5b351ba4c02ef6d7bd1b24', 'Ferrari', NULL, 0, 1),
('f353212c4a3f372bd5b4480cf4ef5d', 'Mack', NULL, 0, 1),
('f55ac2406e2fb60df38c9633606ad9', 'OPEL', NULL, 0, 1),
('f5b219e5fa1d019f4947ac1d83e9ee', 'Buick', NULL, 0, 1),
('f657684e14bd182c29ff02241302c2', 'McLaren', NULL, 0, 1),
('f98884ee520758a4b3fbf430adfcd4', 'Hummer', NULL, 0, 1),
('fac079e47f73f47d8276c1c1e6fe54', 'Freightliner', NULL, 0, 1),
('fc8f4b4c454ea0b1d0d7c165485a9a', 'Lamborghini', NULL, 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `car_models`
--

CREATE TABLE IF NOT EXISTS `car_models` (
  `ID` varchar(30) CHARACTER SET latin1 NOT NULL,
  `brandID` varchar(30) CHARACTER SET latin1 NOT NULL,
  `name` varchar(100) CHARACTER SET latin1 NOT NULL,
  `image` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `count` int(11) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `car_models`
--

INSERT INTO `car_models` (`ID`, `brandID`, `name`, `image`, `created`, `count`, `active`) VALUES
('01fc23c961e17f0f7ac1e87d1387f3', '312c379dde93a2140d4ca950a676a6', 'V10 [1.2L]', '', '2019-08-17 23:10:35', 6, 1),
('13cfb5e946c7ad034e6ea89924cd18', 'a1d5e9ce2135baf03244320496c5fc', 'Beetle [1.6L]', '', '2019-08-18 11:35:51', 3, 1),
('13e1f8fe0a69fef34e16dc17de4ce2', 'a1d5e9ce2135baf03244320496c5fc', '15-180 [6.0L]', '', '2019-08-18 10:53:01', 1, 1),
('17654c453344086501f370332cd6c8', 'a1d5e9ce2135baf03244320496c5fc', '17-210 [6.0L]', '', '2019-08-18 10:53:17', 2, 1),
('1be354c10f601d4f1600b5198576c1', 'a1d5e9ce2135baf03244320496c5fc', 'AMAROK [2.0L]', '', '2019-08-18 11:16:47', 2, 1),
('1d1d852c1b7a0841d24da805ef9044', 'a1d5e9ce2135baf03244320496c5fc', 'GOL [1.6L]', '', '2019-08-18 11:38:27', 0, 1),
('1ef582700154122234803c10aadd95', 'a1d5e9ce2135baf03244320496c5fc', 'MULTIVAN [2.5L]', '', '2019-08-18 11:44:05', 0, 1),
('23004dca4f7e75b764e925504bc8ff', '72dea830f65f86f49bb416f76c04b7', 'Landmark [2.7L]', '', '2019-08-17 23:25:25', 1, 1),
('26ced647cb996799bbb138c9d5457e', 'a1d5e9ce2135baf03244320496c5fc', 'GOLF [2.0L]', '', '2019-08-18 11:39:32', 0, 1),
('291a20736cee9f5dc4b31e5972a526', 'a1d5e9ce2135baf03244320496c5fc', 'Beetle [1.3L]', '', '2019-08-18 11:34:48', 0, 1),
('3648836535014008a3ef2753a41da2', '1034f831d1c632492a9ea06de4bf5e', 'ZK6852HG [9.0L]', '', '2019-08-18 10:52:03', 0, 1),
('3a393a555e16236e81730ef54473b1', 'a1d5e9ce2135baf03244320496c5fc', 'CABRIOLET [1.8L]', '', '2019-08-18 11:24:03', 0, 1),
('41bfef8372731ac8d250bf1418d8c1', 'a1d5e9ce2135baf03244320496c5fc', 'GTi [2.0L]', '', '2019-08-18 11:41:34', 0, 1),
('42c6d1b09a2f2a3e87e5fb35ba6021', 'a1d5e9ce2135baf03244320496c5fc', 'BORA [1.8L]', '', '2019-08-18 11:23:34', 0, 1),
('434617f90f40037c909ac881e73b82', 'a1d5e9ce2135baf03244320496c5fc', 'CONSTELLATION [8.0L]', '', '2019-08-18 11:24:44', 0, 1),
('5a2849c85fca61c1a8c93e8bb10431', 'a1d5e9ce2135baf03244320496c5fc', 'VENTO [2.0L]', '', '2019-08-18 11:52:51', 0, 1),
('5cb662f1ad8a497efbb6b0d8fec291', '1034f831d1c632492a9ea06de4bf5e', 'C896 [5.0L]', '', '2019-08-18 10:48:07', 1, 1),
('61058252cb3b3f181618b7c528812d', 'a1d5e9ce2135baf03244320496c5fc', 'T5 [2.0L]', '', '2019-08-18 11:50:28', 0, 1),
('62f3c3575ad8967498f37ec9572ab2', 'a1d5e9ce2135baf03244320496c5fc', 'PARATI [1.8L]', '', '2019-08-18 11:45:11', 0, 1),
('6420366f067de09a104922271d9555', '1034f831d1c632492a9ea06de4bf5e', 'ZK6118HGA [8.9L]', '', '2019-08-18 10:49:23', 2, 1),
('64d0f896222db41b6b05082b7bf99d', 'a1d5e9ce2135baf03244320496c5fc', 'JETTA [2.0L]', '', '2019-08-18 11:42:09', 0, 1),
('64f9db8bce427bcc8afe41da16dd38', 'a1d5e9ce2135baf03244320496c5fc', 'FOX [1.6L]', '', '2019-08-18 11:36:46', 0, 1),
('66bd5e677bcca577904d8eac690b84', 'a1d5e9ce2135baf03244320496c5fc', 'POLO [2.0L]', '', '2019-08-18 11:47:47', 0, 1),
('6998744b3dbb1362b7e3f3285a144a', 'caeffc161d38803c691d2f85c4acdf', '_prueba', '', '2019-09-08 15:24:33', 2, 1),
('717fcec2aa8afadc768e94c8457296', 'a1d5e9ce2135baf03244320496c5fc', 'JETTA [2.5L]', '', '2019-08-18 11:42:34', 0, 1),
('722d9ad90655194fc76864ce4af118', 'a1d5e9ce2135baf03244320496c5fc', 'PASSAT [1.8L]', '', '2019-08-18 11:45:41', 0, 1),
('743582dd996a4d875d3b3105f63e66', 'a1d5e9ce2135baf03244320496c5fc', 'BORA [2.0L]', '', '2019-08-18 11:22:04', 0, 1),
('7fef6d8a9a9b67c42abaf6801324e8', 'a1d5e9ce2135baf03244320496c5fc', '18-310 [8.2L]', '', '2019-08-18 11:13:40', 0, 1),
('842cd84f61891c0f723ace231b2fdd', 'a1d5e9ce2135baf03244320496c5fc', 'SANTANA [1.8L]', '', '2019-08-18 11:49:12', 0, 1),
('8e372831cb9635d238e21eeb8dc383', 'a1d5e9ce2135baf03244320496c5fc', 'Beetle [1.2L]', '', '2019-08-18 11:35:30', 0, 1),
('91ff9e063fc69f9c8ed34278f71d93', 'a1d5e9ce2135baf03244320496c5fc', '9150 [4.3L]', '', '2019-08-18 11:16:22', 0, 1),
('92e67088538a1a61bbbe7dc2e2afa9', '1034f831d1c632492a9ea06de4bf5e', 'ZK6180HGC [11.0L]', '', '2019-08-18 10:50:03', 1, 1),
('931323c73693ac2f2778856a7290bc', 'a1d5e9ce2135baf03244320496c5fc', 'PASSAT [2.8L]', '', '2019-08-18 11:46:31', 0, 1),
('940c2a0002f4fd969b34a67217a616', 'a1d5e9ce2135baf03244320496c5fc', 'GOL [1.8L]', '', '2019-08-18 11:38:51', 0, 1),
('949caee2ef08690ef6a44ac6b962ba', 'a1d5e9ce2135baf03244320496c5fc', '17-240 [6.5L]', '', '2019-08-18 11:13:09', 0, 1),
('9829aaf8e4ede01f81f88a0c2e48c6', 'a1d5e9ce2135baf03244320496c5fc', 'KOMBI [2.5L]', '', '2019-08-18 11:43:15', 0, 1),
('983a7f0080118642296599f297a9de', '1034f831d1c632492a9ea06de4bf5e', 'ZK6831HE [5.0L]', '', '2019-08-18 10:50:55', 0, 1),
('9a35b0d1ead9d9e6e1650f712eb77b', 'a1d5e9ce2135baf03244320496c5fc', 'VOLKBUS [8.3L]', '', '2019-08-18 11:53:14', 0, 1),
('9c10c611643ca70b526bed24f44d25', 'a1d5e9ce2135baf03244320496c5fc', 'MAXI-TAXI [1.7L]', '', '2019-08-18 11:43:51', 0, 1),
('9ff0c56d8e244c0c1d1ab9c7db28ee', 'a1d5e9ce2135baf03244320496c5fc', 'SPACE FOX [1.6L]', '', '2019-08-18 11:49:56', 0, 1),
('a1606625c7b4a65b90501961f8363d', 'a1d5e9ce2135baf03244320496c5fc', 'CROSS FOX [1.6L]', '', '2019-08-18 11:29:27', 0, 1),
('a9752b96d73f02c2ddad381c40631c', '1034f831d1c632492a9ea06de4bf5e', 'ZK6737D [5.0L]', '', '2019-08-18 10:50:32', 0, 1),
('afdae967936284571a3e718eb096ef', 'a1d5e9ce2135baf03244320496c5fc', 'PASSAT [3.2L]', '', '2019-08-18 11:46:13', 0, 1),
('b157664f6e7f2d84707b5001c163c6', 'a1d5e9ce2135baf03244320496c5fc', 'TOUAREG [3.2L]', '', '2019-08-18 11:51:05', 0, 1),
('b230a21873fa652ea54e4f8b16b13d', '1034f831d1c632492a9ea06de4bf5e', 'ZK6129H [10.0L]', '', '2019-08-18 10:49:43', 0, 1),
('b3bc4b509eb351d7ed5e0b09159f72', 'a1d5e9ce2135baf03244320496c5fc', 'CRAFTER [2.5L]', '', '2019-08-18 11:28:27', 0, 1),
('b6ff0ed3e6746ec85538f2c178fbf3', 'a1d5e9ce2135baf03244320496c5fc', 'POLO [1.6L]', '', '2019-08-18 11:47:28', 0, 1),
('b77adcd9c8fd960c86c352ee1a2c3c', 'a1d5e9ce2135baf03244320496c5fc', 'GOLF [1.8L]', '', '2019-08-18 11:41:01', 1, 1),
('b7dec5d1c03ec8620617b472aa0af1', 'a1d5e9ce2135baf03244320496c5fc', '17-220 [6.0L]', '', '2019-08-18 10:53:41', 0, 1),
('ba376d2849556c47a314de17743ff2', 'a1d5e9ce2135baf03244320496c5fc', 'PASSAT [2.0L]', '', '2019-08-18 11:47:00', 0, 1),
('c1dae604008bb7e6cc77d0af2a1eb0', 'a1d5e9ce2135baf03244320496c5fc', 'SAVEIRO [1.8L]', '', '2019-08-18 11:49:36', 0, 1),
('c911bf674df34600ab0694a7b08ea8', 'a1d5e9ce2135baf03244320496c5fc', '24-250E [5.9L]', '', '2019-08-18 11:14:37', 0, 1),
('ca1891930e199a1ddb1ba40fc76fbe', 'a1d5e9ce2135baf03244320496c5fc', 'CORRADO [2.8L]', '', '2019-08-18 11:27:23', 0, 1),
('cad7da3e96721df67bfa1f1adf6c0e', 'a1d5e9ce2135baf03244320496c5fc', 'BRASILIA [1.6L]', '', '2019-08-18 11:23:48', 0, 1),
('cca4bcf2a9e3dbcfc9a025710ae324', '312c379dde93a2140d4ca950a676a6', 'Nomad [1.3L]', '', '2019-08-17 23:09:59', 66, 1),
('ccaf6d5169594cb8037b5ea4de7ddf', 'a1d5e9ce2135baf03244320496c5fc', '31-310 [9.0L]', '', '2019-08-18 11:16:00', 0, 1),
('cd9a7dbab4897a1f7d16d59ef67f9d', 'a1d5e9ce2135baf03244320496c5fc', 'KOMBI [1.6L]', '', '2019-08-18 11:42:57', 0, 1),
('cf541d8525bf0d5d8fae63dcd2546d', 'a1d5e9ce2135baf03244320496c5fc', 'TOURAN [2.0L]', '', '2019-08-18 11:52:12', 0, 1),
('cfe1bc05725b4432fbf8b6cb4395b7', 'a1d5e9ce2135baf03244320496c5fc', 'CADDY [2.0L]', '', '2019-08-18 11:24:18', 0, 1),
('d2767b0574d542d6c19bf7a3829125', '312c379dde93a2140d4ca950a676a6', 'Nomad [1.6L]', '', '2019-08-17 23:09:12', 2, 1),
('d3c962b7aafaae4150aa9642e22f14', '1034f831d1c632492a9ea06de4bf5e', '6118 [8.9L]', '', '2019-08-17 23:26:14', 0, 1),
('d8c56c23afa0096b761007e81c063f', '72dea830f65f86f49bb416f76c04b7', 'GrandTiger [2.7L]', '', '2019-08-17 23:16:50', 7, 1),
('dc9b7f87f21180197f51af152ffb33', 'a1d5e9ce2135baf03244320496c5fc', 'TOUAREG [4.2L]', '', '2019-08-18 11:51:23', 0, 1),
('e0bdadb98efe537080a208eef3253c', 'a1d5e9ce2135baf03244320496c5fc', 'VENTO [1.8L]', '', '2019-08-18 11:52:32', 0, 1),
('e20383828873ce2216824a42077463', 'a1d5e9ce2135baf03244320496c5fc', 'Beetle [1.5L]', '', '2019-08-18 11:35:10', 0, 1),
('e3997bc203153db7ea499491d73c60', 'a1d5e9ce2135baf03244320496c5fc', '24-220 [8.3L]', '', '2019-08-18 11:14:15', 0, 1),
('e5b59dfd22d9f19f1c38a725c7f55a', '72dea830f65f86f49bb416f76c04b7', 'Admiral [2.2L]', '', '2019-08-17 23:14:55', 12, 1),
('e7795ae0ce5c568bf0fe66cfdc94d9', 'a1d5e9ce2135baf03244320496c5fc', 'BEETLE [2.5L ]', '', '2019-08-18 11:19:59', 0, 1),
('ec2e2679b36c1db054848e02896f81', '1034f831d1c632492a9ea06de4bf5e', 'YTZ5507TQZ40 [9.0L]', '', '2019-08-18 10:48:45', 0, 1),
('f122b3e1d91b839cb0e59d7829f6b9', '312c379dde93a2140d4ca950a676a6', 'Z300 [1.5L]', '', '2019-08-17 23:11:16', 1, 1),
('f1240cbaefaac26a9cfd0479a8eddb', 'a1d5e9ce2135baf03244320496c5fc', 'TIGUAN [2.0L]', '', '2019-08-18 11:50:48', 0, 1),
('f2d3776d35450e3a6ebc48d931249b', '1034f831d1c632492a9ea06de4bf5e', '6121 [9.0L]', '', '2019-08-18 10:47:41', 0, 1),
('f644ebd81c3d8622853520482ac7c2', 'a1d5e9ce2135baf03244320496c5fc', 'GOLF [1.6L]', '', '2019-08-18 11:40:17', 0, 1),
('ffd2f97b7e6750120623e7153d025f', 'a1d5e9ce2135baf03244320496c5fc', 'BEETLE [2.0L]', '', '2019-08-18 11:20:27', 1, 1);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `car_models_full`
--
CREATE TABLE IF NOT EXISTS `car_models_full` (
`ID` varchar(30)
,`image` varchar(255)
,`name` varchar(100)
,`brandID` varchar(30)
,`created` timestamp
,`active` tinyint(1)
,`brand` varchar(100)
,`brand_image` varchar(255)
);
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `car_models_img`
--

CREATE TABLE IF NOT EXISTS `car_models_img` (
  `ID` varchar(30) CHARACTER SET latin1 NOT NULL,
  `car_model` varchar(30) CHARACTER SET latin1 NOT NULL,
  `path` varchar(255) CHARACTER SET latin1 NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `edited` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `car_parts`
--

CREATE TABLE IF NOT EXISTS `car_parts` (
  `ID` varchar(30) CHARACTER SET latin1 NOT NULL,
  `name` varchar(100) CHARACTER SET latin1 NOT NULL,
  `image` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `classID` varchar(30) CHARACTER SET latin1 DEFAULT '0',
  `count` int(11) NOT NULL DEFAULT '0',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` int(11) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `car_parts`
--

INSERT INTO `car_parts` (`ID`, `name`, `image`, `classID`, `count`, `updated`, `active`) VALUES
('0089880f627098cdb66cba6629922b', 'Electro Ventilador', NULL, '70f4d8e0c2e4106e8d3a058e156f19', 0, '2019-08-13 09:54:28', 1),
('02f5a22e07a56eb39818565c05ebd8', 'Punta de Tripoide', NULL, '61827b41dcf5e8924c353899ed4d64', 0, '2019-08-13 09:48:37', 1),
('036fe567e1c78b025a7a6ae5a72608', 'Valvulas', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-13 09:44:09', 1),
('07e2db5377700ae11e84816611d606', 'Balancín', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-02 22:22:27', 1),
('080a156f2ea586513b82f0b9b441e8', 'Compresor', NULL, '37b4903df0cf43e45449c86a8e25a3', 67, '2019-12-08 04:23:19', 1),
('0ae5bd4b122eb8060ed6badf69fac4', 'Banda', NULL, '05500b7c2b622e3f553e2a1677b73b', 0, '2019-08-04 22:03:20', 1),
('0b80fe8027d1099d9d32c67b408fed', 'Plato', NULL, 'e2167b2169617d4a91e0ab7b139546', 0, '2019-08-13 09:47:54', 1),
('0e762c37972b9f67f0d8d61e729c37', 'Aceite Motor', NULL, 'cc0d01ef8838ec169b9864999c6158', 0, '2019-08-04 22:02:19', 1),
('11dd4c0776bddc4ba5211aa41628ed', 'Condensador', NULL, '37b4903df0cf43e45449c86a8e25a3', 1, '2019-11-02 16:29:49', 1),
('12ba53d4f6e8958e68c47b19d1d2a6', 'Tanque Radiador', NULL, '5e335f40575568aaf2faee12fbac2e', 0, '2019-08-13 09:44:35', 1),
('12e477ad149f6acf64ff6eb297c2d0', 'Computadora', NULL, '70f4d8e0c2e4106e8d3a058e156f19', 0, '2019-08-13 09:55:27', 1),
('131ad09bd9507971f471ba1a756586', 'Brazo Pitman', NULL, '61827b41dcf5e8924c353899ed4d64', 0, '2019-08-13 09:57:04', 1),
('19b640b43ff8066391b050e739112e', 'Master Kit', NULL, '05500b7c2b622e3f553e2a1677b73b', 0, '2019-08-13 09:51:38', 1),
('1c8f6c82f14ff05a5d29ff7ce1fea5', 'Sensor', NULL, '05500b7c2b622e3f553e2a1677b73b', 0, '2019-08-13 09:47:17', 1),
('1cb6506358d9ad92af170fdf331202', 'Capot', NULL, 'e048a7356237aaa0da9dab603e1ff8', 0, '2019-08-13 09:56:22', 1),
('1cef3fa3b7ac73e2374ac491806033', 'Puerta Trasera', NULL, 'e048a7356237aaa0da9dab603e1ff8', 0, '2019-08-13 09:48:29', 1),
('20562ba04820089709d0e8aaabbf89', 'Mozo', NULL, '61827b41dcf5e8924c353899ed4d64', 0, '2019-08-13 09:51:11', 1),
('21e7f7b00e5ec739292e4f28719b43', 'Cauchos', NULL, 'e048a7356237aaa0da9dab603e1ff8', 0, '2019-08-13 09:59:18', 1),
('2573c8ddcbcbfa80b9a7756b15cf61', 'Tapa de Reservorio Refrigerante', NULL, '5e335f40575568aaf2faee12fbac2e', 0, '2019-08-13 09:44:56', 1),
('2704828fe5b847a6c442844671264e', 'Rapa de Rin', NULL, 'e048a7356237aaa0da9dab603e1ff8', 0, '2019-08-13 09:45:05', 1),
('284c4731e5227c50905114839eae4c', 'Otros', NULL, '5e335f40575568aaf2faee12fbac2e', 0, '2019-08-10 20:57:28', 1),
('299e340c5ddd9b155e97ee2c45ffaf', 'Amortiguador', NULL, '61827b41dcf5e8924c353899ed4d64', 0, '2019-08-04 22:02:33', 1),
('29de976cd416e96e1c05921f45d891', 'Parachoque Delantero', NULL, 'e048a7356237aaa0da9dab603e1ff8', 0, '2019-08-13 09:49:21', 1),
('2ae42419b264b03a7626d5635c44d2', 'Otros', NULL, 'e2167b2169617d4a91e0ab7b139546', 0, '2019-08-10 20:57:34', 1),
('360ae8293d8b5edae679f534703b0c', 'Corneta', NULL, '70f4d8e0c2e4106e8d3a058e156f19', 0, '2019-08-13 09:55:13', 1),
('3ba32c50fd07cf20a6eccb9be8671c', 'Tambor', NULL, 'e2167b2169617d4a91e0ab7b139546', 0, '2019-08-13 09:46:04', 1),
('3ce706ce339f63b574d2a8581f2ad9', 'Tapa Valvulas', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-13 09:45:22', 1),
('3d2bf66300cab7255e7a546630eb31', 'Bombillo', NULL, '70f4d8e0c2e4106e8d3a058e156f19', 0, '2019-08-13 09:57:17', 1),
('3de2193f1e5117678468f12fa2fcbb', 'Guardapolvo', NULL, 'e048a7356237aaa0da9dab603e1ff8', 0, '2019-08-13 09:53:31', 1),
('3f28f11ffeedf11df131d77776f0d2', 'Otros', NULL, '70f4d8e0c2e4106e8d3a058e156f19', 0, '2019-08-10 20:57:41', 1),
('4046ca2bf1a5a5a3a87535df3a840f', 'Pastilla', NULL, 'e2167b2169617d4a91e0ab7b139546', 0, '2019-08-13 09:49:43', 1),
('4084417b60ffa442812457952a21f3', 'Cilindro', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-13 09:56:03', 1),
('4171ee3b75fbad1e22069c5cfab8a0', 'Bomba de Gasolina', NULL, '70f4d8e0c2e4106e8d3a058e156f19', 0, '2019-08-13 09:57:23', 1),
('449a0d3c6af62593d34802d5cee7f8', 'Pila de Gasolina', NULL, '70f4d8e0c2e4106e8d3a058e156f19', 0, '2019-08-13 09:49:59', 1),
('47e940cd9432acd5c716d475561059', 'Otros', NULL, 'cc0d01ef8838ec169b9864999c6158', 0, '2019-08-10 20:57:47', 1),
('4acadf0a818084f13500b6543a1d03', 'Electroventilador', NULL, '5e335f40575568aaf2faee12fbac2e', 0, '2019-08-13 09:54:21', 1),
('4bba47e7ac61813d34e527aec69a17', 'Otros', NULL, '37b4903df0cf43e45449c86a8e25a3', 0, '2019-08-13 09:50:36', 1),
('5283de7aaf54ab6675eca3604bc39f', 'Bomba de Agua', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-13 09:57:31', 1),
('56c23e23c0a897bb1cf67d1981b44c', 'Bujes', NULL, '61827b41dcf5e8924c353899ed4d64', 1, '2019-09-02 06:06:20', 1),
('576940ff01414f732a604a12697853', 'Radiador', NULL, '5e335f40575568aaf2faee12fbac2e', 0, '2019-08-13 09:48:50', 1),
('58592308982c50cd816cd8c93cc1d3', 'Culata', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-13 09:55:04', 1),
('587a1f72a422858dffc539c10150f6', 'Estopera', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-13 09:53:59', 1),
('590add6cb5fe32cc38802c875e6062', 'Bomba de Aceite', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-13 09:57:41', 1),
('5ab66895b632c171b152379f28d008', 'Kit de Sello', NULL, '05500b7c2b622e3f553e2a1677b73b', 0, '2019-08-13 09:52:19', 1),
('5bb8c254eb0a985d2782d828bf2e07', 'Correa', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-13 09:55:08', 1),
('5e5a6f37186e1b6131a576c31ab3b8', 'Bomba', NULL, 'e2167b2169617d4a91e0ab7b139546', 0, '2019-08-13 09:57:46', 1),
('5f12a4df111dc9c22d62030ac396b6', 'Anti Ruido', NULL, 'e2167b2169617d4a91e0ab7b139546', 0, '2019-08-04 22:02:46', 1),
('60299485ea1ada7c28631862aa58ec', 'Puerta Delantera', NULL, 'e048a7356237aaa0da9dab603e1ff8', 0, '2019-08-13 09:48:20', 1),
('6443f1e72c1d9a9320ca8893147ccb', 'Kit de Direccion', NULL, '05500b7c2b622e3f553e2a1677b73b', 0, '2019-08-13 09:52:27', 1),
('6466f71ea54b31c8e4ad7cf1d225d7', 'Faro', NULL, 'e048a7356237aaa0da9dab603e1ff8', 0, '2019-08-13 09:52:48', 1),
('64a60bcca04e9fbae1a8bbb4123034', 'Piston de Servo', NULL, 'e2167b2169617d4a91e0ab7b139546', 0, '2019-08-13 09:47:48', 1),
('654baf57836c03799f56249a2ee214', 'Empacadura', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-13 09:54:12', 1),
('6a30dd687ef6785964a8a9b404be2a', 'Emblema', NULL, 'e048a7356237aaa0da9dab603e1ff8', 0, '2019-08-13 09:54:16', 1),
('6c110ac807d0ededc307674fe449ef', 'Copa Caja', NULL, '61827b41dcf5e8924c353899ed4d64', 0, '2019-08-13 09:55:19', 1),
('6e231e7ba41ed6ebaa47c66c8ea850', 'Estopera', NULL, '05500b7c2b622e3f553e2a1677b73b', 0, '2019-08-13 09:52:36', 1),
('6ff54de929a5b6fb4e01c2c916f8fd', 'Bocina', NULL, '05500b7c2b622e3f553e2a1677b73b', 0, '2019-08-13 09:57:50', 1),
('7071420083ee89f70b4a4dd9ce1de2', 'Piston', NULL, '05500b7c2b622e3f553e2a1677b73b', 0, '2019-08-13 09:50:06', 1),
('719594d12d9d91fe9acb759e7c9f56', 'Medio Kit', NULL, '05500b7c2b622e3f553e2a1677b73b', 0, '2019-08-13 09:51:29', 1),
('7207630399f6478cc0f796eeca9d72', 'Reservorio Pote de Refrigerante', NULL, '5e335f40575568aaf2faee12fbac2e', 0, '2019-08-13 09:46:27', 1),
('72eba9703d00496ea32d1b19a0390a', 'Filtro', NULL, '37b4903df0cf43e45449c86a8e25a3', 5, '2019-10-09 04:32:19', 1),
('732c5d2533f032506068c0223b7b20', 'Bujia', NULL, 'b3f433efd4f3e613b4eb816834156c', 2, '2019-10-09 18:20:02', 1),
('745903a64f9d1792c795dc05bf2c16', 'Cocha de Cojinete', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-13 09:55:40', 1),
('759e7a27b61f63934468bc2f34c416', 'Manilla Puerta', NULL, 'e048a7356237aaa0da9dab603e1ff8', 0, '2019-08-13 09:51:47', 1),
('775ffa10ebee6cd5a1016eede01514', 'Parabrisa', NULL, 'e048a7356237aaa0da9dab603e1ff8', 0, '2019-08-13 09:49:12', 1),
('78635912b996ab2730afbb5ef03bbf', 'Banda', NULL, 'e2167b2169617d4a91e0ab7b139546', 0, '2019-08-04 22:03:26', 1),
('7866626e97b73024f069bffc068228', 'Presostato', NULL, '37b4903df0cf43e45449c86a8e25a3', 0, '2019-08-13 09:48:12', 1),
('794cbb889455bb8ffebd9082513867', 'Otros', NULL, '05500b7c2b622e3f553e2a1677b73b', 0, '2019-08-13 09:50:28', 1),
('7b158003090e8984f375bb6df33330', 'Calefactor', NULL, '5e335f40575568aaf2faee12fbac2e', 0, '2019-08-13 09:56:31', 1),
('7c73b4570dc9806c2087f8e835ae50', 'Filtro aire', NULL, 'cc0d01ef8838ec169b9864999c6158', 0, '2019-08-13 09:52:57', 1),
('7d887b10726e40317e70346acd43d8', 'Biela', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-13 09:57:58', 1),
('7e15395d47425a041089f015240cd8', 'Disco', NULL, 'e2167b2169617d4a91e0ab7b139546', 0, '2019-08-13 09:54:59', 1),
('7ef2f5ee721f85c4075c1b6a69ab45', 'Mesetas', NULL, '61827b41dcf5e8924c353899ed4d64', 0, '2019-08-13 09:51:21', 1),
('82212f53cec61b9d2612246483b3e8', 'Arbol de Leva', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-04 22:03:01', 1),
('879bcd18a0ed056b1dde4952061945', 'Piston', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-13 09:47:40', 1),
('884ea9c9f9343af5b16f5fbda02c74', 'Barra Central', NULL, '61827b41dcf5e8924c353899ed4d64', 0, '2019-08-04 22:04:01', 1),
('8a83b82658bb30243d750140f5c03f', 'Rele', NULL, '70f4d8e0c2e4106e8d3a058e156f19', 0, '2019-08-13 09:46:16', 1),
('8b153fd178db14efd5dba98a9d029d', 'Rodamientos', NULL, '61827b41dcf5e8924c353899ed4d64', 0, '2019-08-13 09:46:44', 1),
('9020282e4bcdd0210c42b7838b6e5a', 'Disco de Hierro', NULL, '05500b7c2b622e3f553e2a1677b73b', 0, '2019-08-13 09:54:51', 1),
('9348de476846b44956fed0fae562f6', 'Cerradura', NULL, 'e048a7356237aaa0da9dab603e1ff8', 0, '2019-08-13 09:56:12', 1),
('940ebcdf0d7b52b3eb7887736adb7a', 'Rotula', NULL, '61827b41dcf5e8924c353899ed4d64', 0, '2019-08-13 09:47:12', 1),
('94ed5e1f0dc311ce3543455fbf8c1c', 'Otros', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-13 09:50:23', 1),
('9553bf6f15fdfcf2604746d2d24033', 'Termostato', NULL, '5e335f40575568aaf2faee12fbac2e', 0, '2019-08-13 09:45:45', 1),
('9e2c5802832e678093b92d43e20bd8', 'Carter', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-13 09:56:17', 1),
('a03957a473ba06f85f280701c47888', 'Cadena', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-13 09:56:39', 1),
('a7a4a9e7b214641f64200bef25aecb', 'Tapa de Aceite', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-13 09:44:44', 1),
('a8f0202c26a8dc50c606621e4f1d53', 'Aceite de Refrigeracion', NULL, '37b4903df0cf43e45449c86a8e25a3', 8, '2019-10-21 00:06:20', 1),
('aaadf56aaad391a99c8c3d0cc4b725', 'Aceite de Caja', NULL, 'cc0d01ef8838ec169b9864999c6158', 0, '2019-11-03 17:31:55', 1),
('ae75d8d4c7bf2e393b02c85c27b38a', 'Manguera', NULL, '5e335f40575568aaf2faee12fbac2e', 0, '2019-08-13 09:51:59', 1),
('b2c5af39c4b557aadcff4df445fc39', 'Bobina', NULL, '70f4d8e0c2e4106e8d3a058e156f19', 0, '2019-08-13 09:57:54', 1),
('b38567af59e3419ad26c066f491a77', 'Resorte', NULL, 'e2167b2169617d4a91e0ab7b139546', 0, '2019-08-13 09:46:33', 1),
('b3eeb1611f6662248abe8abd788666', 'Maleta', NULL, 'e048a7356237aaa0da9dab603e1ff8', 0, '2019-08-13 09:52:12', 1),
('b4b91b387858b5c91dab9357c28951', 'Cigueñal', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-13 09:56:08', 1),
('b5898005558fcad6885312b49291b6', 'Otros', NULL, 'e048a7356237aaa0da9dab603e1ff8', 0, '2019-08-13 09:50:16', 1),
('b62dd049601f2b6837c6849f2cbbd2', 'Guardafango', NULL, 'e048a7356237aaa0da9dab603e1ff8', 0, '2019-08-13 09:53:25', 1),
('b68f9277f85c192283fa62d66e2681', 'Mandos', NULL, '70f4d8e0c2e4106e8d3a058e156f19', 0, '2019-08-13 09:52:06', 1),
('b6c8ffca25aa1b69d0aaa797365f9a', 'Fusibles', NULL, '70f4d8e0c2e4106e8d3a058e156f19', 0, '2019-08-13 09:53:12', 1),
('bbeab479c2b34aa400e110fe8b97b7', 'Taquete', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-13 09:45:13', 1),
('bdb0a40e13ceef3561da9cdd0040e0', 'Tensor', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-13 09:45:32', 1),
('be6818399fccc30abf9a4add04f658', 'Valvula', NULL, '37b4903df0cf43e45449c86a8e25a3', 0, '2019-08-13 09:44:20', 1),
('c1cd3277798338698c19e20a55ecf7', 'Manguera', NULL, 'e2167b2169617d4a91e0ab7b139546', 0, '2019-08-13 09:51:53', 1),
('c49cd8339453e50650a85d3d14ddb9', 'Rache', NULL, '05500b7c2b622e3f553e2a1677b73b', 0, '2019-08-13 09:48:43', 1),
('c525154df7d2fb976e170c4b452061', 'Otros', NULL, '61827b41dcf5e8924c353899ed4d64', 0, '2019-08-13 09:49:05', 1),
('c7bb009825e212e2c6fd39277758ac', 'Disco de Pasta', NULL, '05500b7c2b622e3f553e2a1677b73b', 1, '2019-11-23 18:08:24', 1),
('c7f886e1ac909eac72f694ca0621b6', 'Rin', NULL, 'e048a7356237aaa0da9dab603e1ff8', 0, '2019-08-13 09:46:39', 1),
('c865ef8fb15044fe06e0109ea8b081', 'Cable', NULL, '70f4d8e0c2e4106e8d3a058e156f19', 0, '2019-08-13 09:56:50', 1),
('c906257dcb7caf491c55802f0501bd', 'Terminal', NULL, '61827b41dcf5e8924c353899ed4d64', 0, '2019-08-13 09:45:39', 1),
('c9e5fac7880a19a17d9a195d09deac', 'Caliper', NULL, 'e2167b2169617d4a91e0ab7b139546', 0, '2019-08-13 09:56:26', 1),
('cb305066547370daa3446ab9e540db', 'Muñon', NULL, '61827b41dcf5e8924c353899ed4d64', 0, '2019-08-13 09:51:06', 1),
('cc02b871331b7ef4fe7338011c39e5', 'Cable de Bujia', NULL, '70f4d8e0c2e4106e8d3a058e156f19', 0, '2019-08-13 09:56:45', 1),
('ccb381be4a563d8189b15bb92735d2', 'Aceite Direccion', NULL, 'cc0d01ef8838ec169b9864999c6158', 0, '2019-08-04 22:02:08', 1),
('ce8c950284dd9455a4ed9a8801b26a', 'Barra Estabilizadora', NULL, '61827b41dcf5e8924c353899ed4d64', 0, '2019-08-13 09:58:03', 1),
('cf9d2df0281d083b2f054e8a1a7470', 'Parachoque Trasero', NULL, 'e048a7356237aaa0da9dab603e1ff8', 0, '2019-08-13 09:49:31', 1),
('cfde0c34e069101f86a7e01a82f818', 'Arranque', NULL, '70f4d8e0c2e4106e8d3a058e156f19', 0, '2019-08-04 22:03:08', 1),
('d4213c63c19e2798d1c68cadfc4a7d', 'Parilla', NULL, 'e048a7356237aaa0da9dab603e1ff8', 0, '2019-08-13 09:49:37', 1),
('d5bf4b8abd2d4f801ae177c85a5842', 'Vidrio', NULL, 'e048a7356237aaa0da9dab603e1ff8', 0, '2019-08-13 09:44:14', 1),
('d680355e3da6877e2895e5c2dd9676', 'Tornillo', NULL, 'e048a7356237aaa0da9dab603e1ff8', 0, '2019-08-13 09:45:51', 1),
('d825b3a5a7fdad9331ffaaf8622bba', 'Pernos', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-13 09:49:49', 1),
('d9d0f87b6cd740bfd6c5ab61f028bf', 'Stop', NULL, 'e048a7356237aaa0da9dab603e1ff8', 0, '2019-08-13 09:47:29', 1),
('dd189f62ae68c14d113723909fe6ad', 'Sensores', NULL, '70f4d8e0c2e4106e8d3a058e156f19', 0, '2019-08-13 09:47:23', 1),
('deb77d6ef880fc2607e11df043f042', 'Evaporador', NULL, '37b4903df0cf43e45449c86a8e25a3', 2, '2019-10-30 04:44:20', 1),
('dfab36ffc0f019660d9b888d438037', 'Cilindro', NULL, 'e2167b2169617d4a91e0ab7b139546', 0, '2019-08-13 09:55:56', 1),
('e19652167f7d8ce28c403bfab348d1', 'Alternador', NULL, '70f4d8e0c2e4106e8d3a058e156f19', 0, '2019-08-04 22:02:26', 1),
('e2546a1f58b135d38001f104a4228e', 'Empacadura', NULL, '05500b7c2b622e3f553e2a1677b73b', 0, '2019-08-13 09:54:09', 1),
('e3811402a7cfcefcdd35ba9d4f58e8', 'Polea Cigüeñal', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-13 09:48:06', 1),
('e50b1b9e0409ce21f1a06ef084278e', 'Cocha de Biela', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-13 09:55:51', 1),
('e7d417c313c05173c65354f44d6e10', 'Baner Kit', NULL, '05500b7c2b622e3f553e2a1677b73b', 0, '2019-08-04 22:03:43', 1),
('ecf45e11b64feaf4a8a4b208a100c5', 'Filtro gasolina', NULL, 'cc0d01ef8838ec169b9864999c6158', 1, '2019-10-06 16:10:46', 1),
('eebcb51534f12b266447499445c74d', 'Turbina', NULL, '05500b7c2b622e3f553e2a1677b73b', 0, '2019-08-13 09:44:25', 1),
('f011108707b82131abe472f459b3fc', 'Kit de bocina', NULL, '05500b7c2b622e3f553e2a1677b73b', 0, '2019-08-13 09:53:37', 1),
('f1be5d53fab92bf4e0f05e78ec41e8', 'Engranaje de Distribucion', NULL, 'b3f433efd4f3e613b4eb816834156c', 0, '2019-08-13 09:54:05', 1),
('f49364261981a3b053431ac84459ba', 'Compuerta', NULL, 'e048a7356237aaa0da9dab603e1ff8', 1, '2019-10-21 00:06:56', 1),
('f58704cff82e56d4bcc48ccced5c5d', 'Distribuidor', NULL, '70f4d8e0c2e4106e8d3a058e156f19', 0, '2019-08-13 09:54:34', 1),
('fb91962382c53e1d4b1c775c970050', 'Brazo Loco', NULL, '61827b41dcf5e8924c353899ed4d64', 0, '2019-08-13 09:57:11', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `car_parts_class`
--

CREATE TABLE IF NOT EXISTS `car_parts_class` (
  `ID` varchar(30) CHARACTER SET latin1 NOT NULL,
  `name` varchar(100) CHARACTER SET latin1 NOT NULL,
  `count` int(11) NOT NULL DEFAULT '0',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `car_parts_class`
--

INSERT INTO `car_parts_class` (`ID`, `name`, `count`, `updated`, `active`) VALUES
('05500b7c2b622e3f553e2a1677b73b', 'Caja', 4, '2019-11-23 18:08:24', 1),
('37b4903df0cf43e45449c86a8e25a3', 'Aire Acondicionado', 113, '2019-12-08 04:23:19', 1),
('5e335f40575568aaf2faee12fbac2e', 'Sistema de Refrigeracion', 0, '2019-08-10 17:48:42', 1),
('61827b41dcf5e8924c353899ed4d64', 'Suspension', 4, '2019-09-02 06:06:20', 1),
('70f4d8e0c2e4106e8d3a058e156f19', 'Partes Electricas', 1, '2019-08-23 20:10:18', 1),
('b3f433efd4f3e613b4eb816834156c', 'Motor', 4, '2019-10-09 18:20:02', 1),
('cc0d01ef8838ec169b9864999c6158', 'Servicio General', 1, '2019-10-06 16:10:47', 1),
('e048a7356237aaa0da9dab603e1ff8', 'Carroceria', 1, '2019-10-21 00:06:56', 1),
('e2167b2169617d4a91e0ab7b139546', 'Freno', 0, '2019-08-10 17:47:47', 1);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `car_parts_full`
--
CREATE TABLE IF NOT EXISTS `car_parts_full` (
`ID` varchar(30)
,`name` varchar(100)
,`classID` varchar(30)
,`image` varchar(255)
,`count` int(11)
,`updated` timestamp
,`active` int(11)
,`subpart` varchar(100)
);
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `car_parts_ref`
--

CREATE TABLE IF NOT EXISTS `car_parts_ref` (
  `ID` int(11) NOT NULL,
  `ref` varchar(30) CHARACTER SET latin1 NOT NULL,
  `name` int(11) NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `car_years`
--

CREATE TABLE IF NOT EXISTS `car_years` (
  `ID` varchar(30) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `model_ref` varchar(30) CHARACTER SET latin1 DEFAULT NULL,
  `year` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notifications`
--

CREATE TABLE IF NOT EXISTS `notifications` (
`ID` int(11) NOT NULL,
  `userID` varchar(30) CHARACTER SET latin1 NOT NULL,
  `action` int(11) NOT NULL,
  `module` int(11) DEFAULT NULL,
  `item` varchar(30) CHARACTER SET latin1 DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `auth` int(11) NOT NULL DEFAULT '0',
  `view` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `requests`
--

CREATE TABLE IF NOT EXISTS `requests` (
  `ID` varchar(30) CHARACTER SET latin1 NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Activo; 1 = Pausado; 2 = Eliminado; 3 = Finalizado',
  `userID` varchar(30) CHARACTER SET latin1 NOT NULL,
  `details` text CHARACTER SET latin1 NOT NULL,
  `model` varchar(30) CHARACTER SET latin1 NOT NULL,
  `year` int(11) NOT NULL,
  `part` varchar(30) CHARACTER SET latin1 NOT NULL,
  `image` text CHARACTER SET latin1,
  `startdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `enddate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `requests`
--

INSERT INTO `requests` (`ID`, `status`, `userID`, `details`, `model`, `year`, `part`, `image`, `startdate`, `enddate`, `active`) VALUES
('7f197a8d7ebc07b50bd62f046f1f6a', 0, '100000000000000000000000000001', '-----', 'd8c56c23afa0096b761007e81c063f', 2017, '080a156f2ea586513b82f0b9b441e8', NULL, '2019-12-08 04:23:19', '0000-00-00 00:00:00', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `responses`
--

CREATE TABLE IF NOT EXISTS `responses` (
  `ID` varchar(30) CHARACTER SET latin1 NOT NULL,
  `requestID` varchar(30) CHARACTER SET latin1 NOT NULL,
  `reuserID` varchar(30) CHARACTER SET latin1 NOT NULL,
  `status` tinyint(11) NOT NULL DEFAULT '0' COMMENT '0 = Pendiente, 1 = Visto, 2 = Confirmado',
  `details` text CHARACTER SET latin1 NOT NULL,
  `price` double NOT NULL DEFAULT '0',
  `currency` int(11) NOT NULL DEFAULT '0',
  `image` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `recreated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reedited` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `ID` varchar(30) CHARACTER SET latin1 NOT NULL,
  `email` varchar(100) CHARACTER SET latin1 NOT NULL,
  `pass` varchar(100) CHARACTER SET latin1 NOT NULL,
  `image` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `doc` varchar(20) CHARACTER SET latin1 NOT NULL,
  `doctype` varchar(1) CHARACTER SET latin1 NOT NULL DEFAULT 'C',
  `nac` varchar(1) CHARACTER SET latin1 NOT NULL DEFAULT 'V',
  `name` varchar(100) CHARACTER SET latin1 NOT NULL,
  `last` varchar(100) CHARACTER SET latin1 NOT NULL,
  `level` int(1) DEFAULT '0',
  `phone` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `birth` date NOT NULL,
  `location` varchar(30) CHARACTER SET latin1 DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint(1) DEFAULT '1',
  `verified` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`ID`, `email`, `pass`, `image`, `doc`, `doctype`, `nac`, `name`, `last`, `level`, `phone`, `birth`, `location`, `created`, `active`, `verified`) VALUES
('100000000000000000000000000001', 'admin@turepuesto.com', '9YKr3RKqOFTXAxbNXDk5P.', NULL, '00000000', 'C', 'V', 'Admin', 'System', 5, '00000000001', '0000-00-00', NULL, '2019-07-19 08:03:03', 1, 1),
('267bbfffa03c7bc6f45ea4e946b05c', 'andres@gmail.com', 'JmTvthzXfObkbo4Q5sV6T/', 'images/storefiles/users/267bbfffa03c7bc6f45ea4e946b05c.jpeg', '11111111', 'C', 'V', 'Andres', 'Salinas', 1, '04163231121', '1969-09-10', NULL, '2019-11-22 00:46:14', 1, 0),
('38d7a626dc974b92d8e55846e45b17', 'saotand@gmail.com', 'Hnuw5YQAsceZ45MeWLAWQ/', 'images/storefiles/users/38d7a626dc974b92d8e55846e45b17.jpeg', '15879381', 'C', 'V', 'David', 'Salinas', 1, '04163231120', '2001-10-24', NULL, '2019-10-25 20:32:10', 1, 0),
('ed8013cbbfadf5a14379405cfe90e3', 'saotand@gmail2.com', 'nsE/OX00wMq0d0gy5uyq4/', NULL, '15879382', 'C', 'V', 'David', 'Salinas', 0, '04163231120', '1985-11-26', NULL, '2019-11-28 21:14:02', 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users_ban`
--

CREATE TABLE IF NOT EXISTS `users_ban` (
  `ID` int(11) NOT NULL,
  `ban_start` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ban_end` timestamp NULL DEFAULT NULL,
  `ban_details` text CHARACTER SET latin1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users_config`
--

CREATE TABLE IF NOT EXISTS `users_config` (
  `ID` varchar(30) CHARACTER SET latin1 NOT NULL,
  `login_count` int(11) NOT NULL,
  `ip` int(11) NOT NULL,
  `config` text CHARACTER SET latin1,
  `theme` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `users_config`
--

INSERT INTO `users_config` (`ID`, `login_count`, `ip`, `config`, `theme`) VALUES
('100000000000000000000000000001', 78, 192168, NULL, 1),
('267bbfffa03c7bc6f45ea4e946b05c', 1, 192168, NULL, 1),
('38d7a626dc974b92d8e55846e45b17', 20, 192168, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users_data`
--

CREATE TABLE IF NOT EXISTS `users_data` (
`ID` int(11) NOT NULL,
  `udir1` text CHARACTER SET latin1,
  `udir2` text CHARACTER SET latin1,
  `uphone1` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `uphone2` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `ucountryID` int(11) NOT NULL,
  `edited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `udetails` text CHARACTER SET latin1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users_seller`
--

CREATE TABLE IF NOT EXISTS `users_seller` (
`ID` int(11) NOT NULL,
  `userID` varchar(30) CHARACTER SET latin1 NOT NULL,
  `name` varchar(100) CHARACTER SET latin1 NOT NULL,
  `image` varchar(255) CHARACTER SET latin1 NOT NULL,
  `rif` int(11) NOT NULL,
  `nac` varchar(2) CHARACTER SET latin1 NOT NULL,
  `phone` varchar(15) CHARACTER SET latin1 NOT NULL,
  `city` varchar(30) CHARACTER SET latin1 NOT NULL,
  `address` text CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `users_seller`
--

INSERT INTO `users_seller` (`ID`, `userID`, `name`, `image`, `rif`, `nac`, `phone`, `city`, `address`) VALUES
(1, '267bbfffa03c7bc6f45ea4e946b05c', 'Empresa XXX', '', 123123123, 'J', '12311231212', 'Somewhere Somehow', '123');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users_sell_profile`
--

CREATE TABLE IF NOT EXISTS `users_sell_profile` (
`ID` int(11) NOT NULL,
  `userID` varchar(30) CHARACTER SET latin1 NOT NULL,
  `sell` varchar(30) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci AUTO_INCREMENT=149 ;

--
-- Volcado de datos para la tabla `users_sell_profile`
--

INSERT INTO `users_sell_profile` (`ID`, `userID`, `sell`) VALUES
(97, 'a44e175d3ed8ea376002b28389408e', '000000000000000000000000000000'),
(98, 'a44e175d3ed8ea376002b28389408e', '37b4903df0cf43e45449c86a8e25a3'),
(99, 'a44e175d3ed8ea376002b28389408e', '05500b7c2b622e3f553e2a1677b73b'),
(100, 'a44e175d3ed8ea376002b28389408e', 'e048a7356237aaa0da9dab603e1ff8'),
(101, 'a44e175d3ed8ea376002b28389408e', 'e2167b2169617d4a91e0ab7b139546'),
(102, 'a44e175d3ed8ea376002b28389408e', 'b3f433efd4f3e613b4eb816834156c'),
(103, 'a44e175d3ed8ea376002b28389408e', '70f4d8e0c2e4106e8d3a058e156f19'),
(104, 'a44e175d3ed8ea376002b28389408e', 'cc0d01ef8838ec169b9864999c6158'),
(105, 'a44e175d3ed8ea376002b28389408e', '5e335f40575568aaf2faee12fbac2e'),
(106, 'a44e175d3ed8ea376002b28389408e', '61827b41dcf5e8924c353899ed4d64'),
(107, 'a31a53eb9dd7fa8e7b005ff292b517', '000000000000000000000000000000'),
(108, 'a31a53eb9dd7fa8e7b005ff292b517', '37b4903df0cf43e45449c86a8e25a3'),
(109, 'a31a53eb9dd7fa8e7b005ff292b517', '05500b7c2b622e3f553e2a1677b73b'),
(110, 'a31a53eb9dd7fa8e7b005ff292b517', 'e048a7356237aaa0da9dab603e1ff8'),
(111, 'a31a53eb9dd7fa8e7b005ff292b517', 'e2167b2169617d4a91e0ab7b139546'),
(112, 'a31a53eb9dd7fa8e7b005ff292b517', 'b3f433efd4f3e613b4eb816834156c'),
(113, 'a31a53eb9dd7fa8e7b005ff292b517', '70f4d8e0c2e4106e8d3a058e156f19'),
(114, 'a31a53eb9dd7fa8e7b005ff292b517', 'cc0d01ef8838ec169b9864999c6158'),
(115, 'a31a53eb9dd7fa8e7b005ff292b517', '5e335f40575568aaf2faee12fbac2e'),
(116, 'a31a53eb9dd7fa8e7b005ff292b517', '61827b41dcf5e8924c353899ed4d64'),
(117, '268734a7d538f5cbc7deddb5c4d2cf', '000000000000000000000000000000'),
(118, '268734a7d538f5cbc7deddb5c4d2cf', '37b4903df0cf43e45449c86a8e25a3'),
(119, '268734a7d538f5cbc7deddb5c4d2cf', '05500b7c2b622e3f553e2a1677b73b'),
(120, '268734a7d538f5cbc7deddb5c4d2cf', 'e048a7356237aaa0da9dab603e1ff8'),
(121, '268734a7d538f5cbc7deddb5c4d2cf', 'e2167b2169617d4a91e0ab7b139546'),
(122, '268734a7d538f5cbc7deddb5c4d2cf', 'b3f433efd4f3e613b4eb816834156c'),
(123, '268734a7d538f5cbc7deddb5c4d2cf', '70f4d8e0c2e4106e8d3a058e156f19'),
(124, '268734a7d538f5cbc7deddb5c4d2cf', 'cc0d01ef8838ec169b9864999c6158'),
(125, '268734a7d538f5cbc7deddb5c4d2cf', '5e335f40575568aaf2faee12fbac2e'),
(126, '268734a7d538f5cbc7deddb5c4d2cf', '61827b41dcf5e8924c353899ed4d64'),
(127, '38d7a626dc974b92d8e55846e45b17', '000000000000000000000000000000'),
(128, '38d7a626dc974b92d8e55846e45b17', '37b4903df0cf43e45449c86a8e25a3'),
(129, '38d7a626dc974b92d8e55846e45b17', '05500b7c2b622e3f553e2a1677b73b'),
(130, '38d7a626dc974b92d8e55846e45b17', 'e048a7356237aaa0da9dab603e1ff8'),
(131, '38d7a626dc974b92d8e55846e45b17', 'e2167b2169617d4a91e0ab7b139546'),
(132, '38d7a626dc974b92d8e55846e45b17', 'b3f433efd4f3e613b4eb816834156c'),
(133, '38d7a626dc974b92d8e55846e45b17', '70f4d8e0c2e4106e8d3a058e156f19'),
(134, '38d7a626dc974b92d8e55846e45b17', 'cc0d01ef8838ec169b9864999c6158'),
(135, '38d7a626dc974b92d8e55846e45b17', '5e335f40575568aaf2faee12fbac2e'),
(136, '38d7a626dc974b92d8e55846e45b17', '61827b41dcf5e8924c353899ed4d64'),
(137, '453f4166a7c8c5c81300ab77b02f5c', '000000000000000000000000000000'),
(138, '453f4166a7c8c5c81300ab77b02f5c', '37b4903df0cf43e45449c86a8e25a3'),
(139, '267bbfffa03c7bc6f45ea4e946b05c', '000000000000000000000000000000'),
(140, '267bbfffa03c7bc6f45ea4e946b05c', '37b4903df0cf43e45449c86a8e25a3'),
(141, '267bbfffa03c7bc6f45ea4e946b05c', '05500b7c2b622e3f553e2a1677b73b'),
(142, '267bbfffa03c7bc6f45ea4e946b05c', 'e048a7356237aaa0da9dab603e1ff8'),
(143, '267bbfffa03c7bc6f45ea4e946b05c', 'e2167b2169617d4a91e0ab7b139546'),
(144, '267bbfffa03c7bc6f45ea4e946b05c', 'b3f433efd4f3e613b4eb816834156c'),
(145, '267bbfffa03c7bc6f45ea4e946b05c', '70f4d8e0c2e4106e8d3a058e156f19'),
(146, '267bbfffa03c7bc6f45ea4e946b05c', 'cc0d01ef8838ec169b9864999c6158'),
(147, '267bbfffa03c7bc6f45ea4e946b05c', '5e335f40575568aaf2faee12fbac2e'),
(148, '267bbfffa03c7bc6f45ea4e946b05c', '61827b41dcf5e8924c353899ed4d64');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `user_data`
--
CREATE TABLE IF NOT EXISTS `user_data` (
`ID` varchar(30)
,`email` varchar(100)
,`pass` varchar(100)
,`doc` varchar(20)
,`doctype` varchar(1)
,`nac` varchar(1)
,`name` varchar(100)
,`last` varchar(100)
,`level` int(1)
,`phone` varchar(50)
,`birth` date
,`created` timestamp
,`active` tinyint(1)
,`verified` tinyint(1)
,`login_count` int(11)
,`ip` int(11)
,`config` text
,`theme` int(11)
,`users_ban_start` timestamp
,`users_ban_end` timestamp
,`users_ban_details` text
);
-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `zone`
--
CREATE TABLE IF NOT EXISTS `zone` (
`ID` varchar(30)
,`ciudad` varchar(128)
,`estado` varchar(128)
,`pais` varchar(128)
);
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_location`
--

CREATE TABLE IF NOT EXISTS `_location` (
  `ID` varchar(30) COLLATE utf8_spanish2_ci NOT NULL,
  `item` varchar(128) COLLATE utf8_spanish2_ci NOT NULL,
  `parentID` varchar(30) COLLATE utf8_spanish2_ci NOT NULL DEFAULT '0',
  `typez` int(1) NOT NULL DEFAULT '0',
  `livein` int(11) DEFAULT '0',
  `search` int(11) DEFAULT '0',
  `active` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `_location`
--

INSERT INTO `_location` (`ID`, `item`, `parentID`, `typez`, `livein`, `search`, `active`) VALUES
('05e0d5fd55d6ee289e41a8d0744d1a', 'San Carlos', 'b9cb8b2c769d080a71175b0acc83db', 2, 0, 0, 1),
('065ff6a4a69bc07461e84e4714d42c', 'Escuque', '5a606edb271e6622906b8fcfa18315', 2, 0, 0, 1),
('06975e8c135d326339aa061bbeed5b', 'San Francisco de Yare', '29bf1c7b528e49b6791ec5682d68a8', 2, 0, 0, 1),
('07f639bd051489e75fb7d55b503fda', 'Santa Catalina', 'aa0cb384dbad02c48246a42bce5ecf', 2, 0, 0, 1),
('0a016338a87a8392ce1b46d417f0ae', 'Turmero', 'dd5fe75e7cc8523d69d5e12a4df2c8', 2, 0, 0, 1),
('0b08ec22754b6f102eb3d69b510fc3', 'El Tocuyo', '6a65ea57693b7ca7647972941d75b7', 2, 0, 0, 1),
('0cb86011d63392693bea1f26b9479f', 'Caracas', '27537918fc5ec72f68fd0db4617d24', 2, 0, 0, 1),
('0d3ca4249618e5ae29470f1aa720f5', 'Achaguas', 'd0336db64617fcfe8f4a4363470785', 2, 0, 0, 1),
('0e18576fac5c8dfb34307e8cb9c7f2', 'Coro', 'c760b866f16079f9fea7adcb62d405', 2, 0, 0, 1),
('0f070d2a654788c68a84ad5c2dfa37', 'Albarico', '9b329b755d311a48226d74e3c3a39f', 2, 0, 0, 1),
('17ae7beef25aeeb3561f3d015d3f27', 'El Pao', 'b9cb8b2c769d080a71175b0acc83db', 2, 0, 0, 1),
('18a7515e96c9eeb5dc0b991cb93ca0', 'Betijoque', '5a606edb271e6622906b8fcfa18315', 2, 0, 0, 1),
('18e43d28122136dbe11ae579af02f5', 'Tumeremo', '8efa4d4e3712890aa44da566bff4af', 2, 0, 0, 1),
('19b47995e28c7a8236bd212d736f9f', 'Rubio', 'f4e9cf2482459cae443fc281548232', 2, 0, 0, 1),
('19d2b32994466d3c3050f085bad0a1', 'El Baúl', 'b9cb8b2c769d080a71175b0acc83db', 2, 0, 0, 1),
('1d4db1e36525432752fc228e7e848f', 'Tucupido', 'b6f941dff49dafb3c45510be1fe894', 2, 0, 0, 1),
('1d676990333bef5543d0e849f39a2a', 'La Guaira', 'ad5ed6d5abff50bd2ec4ab3b73f8ea', 2, 0, 0, 1),
('1f4cc91136c15687c5a6c6e3c227d8', 'Táriba', 'f4e9cf2482459cae443fc281548232', 2, 0, 0, 1),
('2184e0c22566751a8a7bf04bbe167b', 'Guainia', 'd60f320a907e7a9646490da1e77189', 2, 0, 0, 1),
('21b8a899015d8f3f60ea016b7d4a1b', 'Calabozo', 'b6f941dff49dafb3c45510be1fe894', 2, 0, 0, 1),
('223103f0a6a457c464e93281ccca7b', 'Petare', '29bf1c7b528e49b6791ec5682d68a8', 2, 0, 0, 1),
('223190c195920402feb54445ac9fcc', 'Villa Bruzual', '694e8ed33f343f5cb7d201d2fdb6ca', 2, 0, 0, 1),
('267ba284a0a275bcae0ef4c9bcb0a7', 'San Antonio del Táchira', 'f4e9cf2482459cae443fc281548232', 2, 0, 0, 1),
('27537918fc5ec72f68fd0db4617d24', 'Distrito Capital', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('28a74ef35764c8190cffff120bed65', 'Pedernales', 'aa0cb384dbad02c48246a42bce5ecf', 2, 0, 0, 1),
('29aca8abde64793fa721d2c022a8fe', 'Santa Barbara', 'a0e7d449ff4f51e109d590764a595f', 2, 0, 0, 1),
('29bf1c7b528e49b6791ec5682d68a8', 'Miranda', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('2ae5368d69a0c0647c1a30b108f45d', 'Anaco', 'df316ac250b33e1afb57626df69099', 2, 0, 0, 1),
('2c170cda4992246a2685491793e196', 'Juan Griego', '3b8fe7c1ada74c3409efc9ead2f739', 2, 0, 0, 1),
('2c810cc8065d46f5ded5ba8f843174', 'Mirimire', 'c760b866f16079f9fea7adcb62d405', 2, 0, 0, 1),
('2cd74959b8020943a2a12cde0a0480', 'El Tigre', 'df316ac250b33e1afb57626df69099', 2, 0, 0, 1),
('2d10ebd23d17d8ab796ea6af63e83e', 'Santa Elena de Uairén', '8efa4d4e3712890aa44da566bff4af', 2, 0, 0, 1),
('2da80b300b62858f3551146af7b7a3', 'La Grita', 'f4e9cf2482459cae443fc281548232', 2, 0, 0, 1),
('2eef5d95095388eb091e1ec48cb97a', 'Guacara', '8ff3a4db3a1ff6f019c5eb42a83dfe', 2, 0, 0, 1),
('303b283062463c87c0ab0f828abeef', 'Villa Rosa', '3b8fe7c1ada74c3409efc9ead2f739', 2, 0, 0, 1),
('30b6b76435fdb0f52ea15dfa2ed214', 'Villa de Cura', 'dd5fe75e7cc8523d69d5e12a4df2c8', 2, 0, 0, 1),
('312547b1f89bfcb5c0fa05dc9dba36', 'Monay', '5a606edb271e6622906b8fcfa18315', 2, 0, 0, 1),
('338013f440d1ce62c7bb6fe44cc3b7', 'Mérida', 'a076c1e62420793d3fdd6b31d84a81', 2, 0, 0, 1),
('35a62ed29bf6e9d45ef355cec272c6', 'Punta Mata', 'ead0d7f0e8ff594e09e065b30b41dc', 2, 0, 0, 1),
('370a5ed55b2069bc1b337859d0a97a', 'La Victoria', 'dd5fe75e7cc8523d69d5e12a4df2c8', 2, 0, 0, 1),
('37d2d9370599873483060e1943ac41', 'Puerto La Cruz', 'df316ac250b33e1afb57626df69099', 2, 0, 0, 1),
('39a8873c02c0dcc1641af21a64d7b9', 'San Carlos de Rio Negro', 'd60f320a907e7a9646490da1e77189', 2, 0, 0, 1),
('39e694497a71e2cd8fcaf6100fe001', 'Píritu', '694e8ed33f343f5cb7d201d2fdb6ca', 2, 0, 0, 1),
('3b8fe7c1ada74c3409efc9ead2f739', 'Nueva Esparta', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('3de24a18c7ffbb521b8edc747d5a4e', 'Güiria', '492243a010da8cd1ef2112b8a49135', 2, 0, 0, 1),
('3ea0078e21c778df0b611006d72e2d', 'Tovar', 'a076c1e62420793d3fdd6b31d84a81', 2, 0, 0, 1),
('3efaa568d34823d2c14daea8ad45bf', 'Machiques de Perijá', '50cecb93bf79dd34d150eb2101a58b', 2, 0, 0, 1),
('3f5d5d7142420210f676ea0137aa38', 'Urachiche', '9b329b755d311a48226d74e3c3a39f', 2, 0, 0, 1),
('42e446636a898736c944c23b1c3552', 'Pampán', '5a606edb271e6622906b8fcfa18315', 2, 0, 0, 1),
('444d22a5d3eec3dc5d301e570178ab', 'San Fernando de Apure', 'd0336db64617fcfe8f4a4363470785', 2, 0, 0, 1),
('45fb70602ad9c990f1167560c6003a', 'Cabimas', '50cecb93bf79dd34d150eb2101a58b', 2, 0, 0, 1),
('492243a010da8cd1ef2112b8a49135', 'Sucre', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('49aa134cfb4f54403ddbb71ab87d42', 'Tinaquillo', 'b9cb8b2c769d080a71175b0acc83db', 2, 0, 0, 1),
('4bb1632cb5a8f24dbf4ff0f03dac96', 'Quibor', '6a65ea57693b7ca7647972941d75b7', 2, 0, 0, 1),
('4c3ba15f407f7ddd607b6f7798cf51', 'Ciudad Guayana', '8efa4d4e3712890aa44da566bff4af', 2, 0, 0, 1),
('4d26e83c98b5cd79fcea4775466fff', 'Baruta', '29bf1c7b528e49b6791ec5682d68a8', 2, 0, 0, 1),
('4da09a7086c5566f236203a7f338fa', 'Punta Cardón', 'c760b866f16079f9fea7adcb62d405', 2, 0, 0, 1),
('4dd010b5947e04abecb900ccb4571f', 'Puerto Cabello', '8ff3a4db3a1ff6f019c5eb42a83dfe', 2, 0, 0, 1),
('4e35d5a85bdcd42a319c9050ef3fbf', 'Punta de Piedras', '3b8fe7c1ada74c3409efc9ead2f739', 2, 0, 0, 1),
('50cecb93bf79dd34d150eb2101a58b', 'Zulia', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('51a194f47ce9a64f5c8f5bfeca1371', 'Elorza', 'd0336db64617fcfe8f4a4363470785', 2, 0, 0, 1),
('54ed0c8a6f9d73b04479930c90f359', 'Cubiro', '6a65ea57693b7ca7647972941d75b7', 2, 0, 0, 1),
('58f9d6bf029553ac1dce8a6b3e46b8', 'Santa Ana', 'c760b866f16079f9fea7adcb62d405', 2, 0, 0, 1),
('597d11710f05859b9b19ec4ea0ab09', 'Porlamar', '3b8fe7c1ada74c3409efc9ead2f739', 2, 0, 0, 1),
('5a606edb271e6622906b8fcfa18315', 'Trujillo', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('5f1e96b7753d7d71aa5e2b78be9491', 'Barquisimeto', '6a65ea57693b7ca7647972941d75b7', 2, 0, 0, 1),
('638bf86ce55413fd71692155d3d082', 'Barcelona', 'df316ac250b33e1afb57626df69099', 2, 0, 0, 1),
('677ab5574b18413e80cbf8968abc06', 'Ejido', 'a076c1e62420793d3fdd6b31d84a81', 2, 0, 0, 1),
('67da7ff17b67caeef12e76320b85a1', 'Caraballeda', 'ad5ed6d5abff50bd2ec4ab3b73f8ea', 2, 0, 0, 1),
('694e8ed33f343f5cb7d201d2fdb6ca', 'Portuguesa', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('6967e990ecd0678db19de192386063', 'Michelena', 'f4e9cf2482459cae443fc281548232', 2, 0, 0, 1),
('69b6fb0cec0d73b06517534294877a', 'Zaraza', 'b6f941dff49dafb3c45510be1fe894', 2, 0, 0, 1),
('6a65ea57693b7ca7647972941d75b7', 'Lara', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('6a9eb0c2e29cc3c23488c6a78d3481', 'Araure', '694e8ed33f343f5cb7d201d2fdb6ca', 2, 0, 0, 1),
('6ca1de10d834452192ed3ef11900ea', 'Charallave', '29bf1c7b528e49b6791ec5682d68a8', 2, 0, 0, 1),
('6f09aac6ae3f6d1f6dff7b45e32ff3', 'Caucagua', '29bf1c7b528e49b6791ec5682d68a8', 2, 0, 0, 1),
('709c0cf6f1175d2ad24cf7d8ac57ee', 'Chichiriviche', 'c760b866f16079f9fea7adcb62d405', 2, 0, 0, 1),
('740135142dd4d08d3c9ae3a615c4d1', 'La Fría', 'f4e9cf2482459cae443fc281548232', 2, 0, 0, 1),
('74d935b2b9541fe7aac7e18abbb2d0', 'Churuguara', 'c760b866f16079f9fea7adcb62d405', 2, 0, 0, 1),
('755801ac81bcaa01e71a5368541fa3', 'Ciudad Bolívar', '8efa4d4e3712890aa44da566bff4af', 2, 0, 0, 1),
('75b42c97d471f595943d526b176d63', 'La Horqueta', 'aa0cb384dbad02c48246a42bce5ecf', 2, 0, 0, 1),
('77bb49d6e34206723a4621c7d93082', 'Santa María de Ipire', 'b6f941dff49dafb3c45510be1fe894', 2, 0, 0, 1),
('78775831200a3cf1012c743d2909f5', 'Carúpano', '492243a010da8cd1ef2112b8a49135', 2, 0, 0, 1),
('78f76379d71894b5a95c837196684e', 'Caruao', 'ad5ed6d5abff50bd2ec4ab3b73f8ea', 2, 0, 0, 1),
('792eff9fbcbf811e9a8967344eb1ef', 'Caripito', 'ead0d7f0e8ff594e09e065b30b41dc', 2, 0, 0, 1),
('7bde909655a204fd6131688d6c85ea', 'El Vigia', 'a076c1e62420793d3fdd6b31d84a81', 2, 0, 0, 1),
('7c5b718fe62a6cd6ad9d783e95529d', 'El Valle del Espíritu Santo', '3b8fe7c1ada74c3409efc9ead2f739', 2, 0, 0, 1),
('7cbaf522f033b3daab6e75125eba8c', 'Sabaneta', 'a0e7d449ff4f51e109d590764a595f', 2, 0, 0, 1),
('7d1961838ad8bbb2e0450f38a48e3e', 'Macuto', 'ad5ed6d5abff50bd2ec4ab3b73f8ea', 2, 0, 0, 1),
('81724bf8033c9052e9d794e08f3719', 'Chivacoa', '9b329b755d311a48226d74e3c3a39f', 2, 0, 0, 1),
('871304b0ef4282eaa7e676a7ccde6b', 'San Felipe', '9b329b755d311a48226d74e3c3a39f', 2, 0, 0, 1),
('89d90a37dddae6ddf6a4169f6488eb', 'Los Teques', '29bf1c7b528e49b6791ec5682d68a8', 2, 0, 0, 1),
('8c045a714a69b8558d3f5cf6f10a62', 'El Callao', '8efa4d4e3712890aa44da566bff4af', 2, 0, 0, 1),
('8c9c72821423c7f23ae40c668e0d7f', 'Venezuela', '0', 0, 0, 0, 1),
('8d25c583b8976c3947d8ebdadb6145', 'San Cristóbal', 'f4e9cf2482459cae443fc281548232', 2, 0, 0, 1),
('8ed783ace8c4423f6ae2cb2a8fe1e8', 'Cúa', '29bf1c7b528e49b6791ec5682d68a8', 2, 0, 0, 1),
('8efa4d4e3712890aa44da566bff4af', 'Bolívar', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('8ff3a4db3a1ff6f019c5eb42a83dfe', 'Carabobo', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('922c9903b1bf3eaeef599294ec9e00', 'Bruzual', 'd0336db64617fcfe8f4a4363470785', 2, 0, 0, 1),
('9a583366e9e7322911c2455a07552e', 'Lagunillas', '50cecb93bf79dd34d150eb2101a58b', 2, 0, 0, 1),
('9b329b755d311a48226d74e3c3a39f', 'Yaracuy', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('9e69db21a7026bbb8f0756463f2cc1', 'Cumaná', '492243a010da8cd1ef2112b8a49135', 2, 0, 0, 1),
('9f8afc331eb8ec23babffb5509025c', 'Ciudad Ojeda', '50cecb93bf79dd34d150eb2101a58b', 2, 0, 0, 1),
('a076c1e62420793d3fdd6b31d84a81', 'Mérida', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('a0e7d449ff4f51e109d590764a595f', 'Barinas', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('a16c45b0bf8ce8d74ea4c775ba42da', 'Mariara', '8ff3a4db3a1ff6f019c5eb42a83dfe', 2, 0, 0, 1),
('a1c8d2d4760c34841706e0805fa16d', 'Camaguán', 'b6f941dff49dafb3c45510be1fe894', 2, 0, 0, 1),
('a79a85cd18eb21d4dc6bbe8c6f6f98', 'Lechería', 'df316ac250b33e1afb57626df69099', 2, 0, 0, 1),
('a7c5e13e091408767aa7f28aad518f', 'Mara', '50cecb93bf79dd34d150eb2101a58b', 2, 0, 0, 1),
('a85182b6d0762cfa08c1a2028fee55', 'Capacho', 'f4e9cf2482459cae443fc281548232', 2, 0, 0, 1),
('a89d190fc54a52300165be84c90651', 'Catia La Mar', 'ad5ed6d5abff50bd2ec4ab3b73f8ea', 2, 0, 0, 1),
('aa0cb384dbad02c48246a42bce5ecf', 'Delta Amacuro', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('ab37254ce68cee8dd13c32f5c9eee3', 'Boconoíto', '694e8ed33f343f5cb7d201d2fdb6ca', 2, 0, 0, 1),
('ab8c5771661730a35e1e1e996ea482', 'Yaritagua', '9b329b755d311a48226d74e3c3a39f', 2, 0, 0, 1),
('ab9ddf1bfd9f3f9844981089e276d2', 'Queniquea', 'f4e9cf2482459cae443fc281548232', 2, 0, 0, 1),
('ad5ed6d5abff50bd2ec4ab3b73f8ea', 'Vargas', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('aecc2ac8c4bdd8299b534644834536', 'Bejuma', '8ff3a4db3a1ff6f019c5eb42a83dfe', 2, 0, 0, 1),
('b1954d53efc8ef5672391e2438ba33', 'Guatire', '29bf1c7b528e49b6791ec5682d68a8', 2, 0, 0, 1),
('b429ea86e94c60b045fba381edfb27', 'Acarigua', '694e8ed33f343f5cb7d201d2fdb6ca', 2, 0, 0, 1),
('b5268b74dc285593a875ec5f554252', 'Agua Blanca', '694e8ed33f343f5cb7d201d2fdb6ca', 2, 0, 0, 1),
('b5cc87829a1c39a1ef9f66734986ae', 'La Asunción', '3b8fe7c1ada74c3409efc9ead2f739', 2, 0, 0, 1),
('b6f941dff49dafb3c45510be1fe894', 'Guárico', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('b9753b597842e9d91c7bdee0537585', 'Cumanacoa', '492243a010da8cd1ef2112b8a49135', 2, 0, 0, 1),
('b9a4cf5457bb8f44698d774b3e2e57', 'Barinitas', 'a0e7d449ff4f51e109d590764a595f', 2, 0, 0, 1),
('b9cb8b2c769d080a71175b0acc83db', 'Cojedes', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('be6e4ca722a0ffbc3bcdb365214ab4', 'Socopó', 'a0e7d449ff4f51e109d590764a595f', 2, 0, 0, 1),
('bf30e64a16c83f36d1fcb277071762', 'Curiapo', 'aa0cb384dbad02c48246a42bce5ecf', 2, 0, 0, 1),
('c2d17c7b7e6157305e77677d74514f', 'Tucupita', 'aa0cb384dbad02c48246a42bce5ecf', 2, 0, 0, 1),
('c3070290d2a87c2d59a90bac1836b4', 'Maracay', 'dd5fe75e7cc8523d69d5e12a4df2c8', 2, 0, 0, 1),
('c3a2e3771474727bf63e5660fe22b2', 'San Juan de los Morros', 'b6f941dff49dafb3c45510be1fe894', 2, 0, 0, 1),
('c3e298266d9d9404442e591806c12d', 'Carayaca', 'ad5ed6d5abff50bd2ec4ab3b73f8ea', 2, 0, 0, 1),
('c45d18cd7a42f5abe0808c2e472759', 'Barinas', 'a0e7d449ff4f51e109d590764a595f', 2, 0, 0, 1),
('c53962dc53f28efc2c44aff55dca76', 'Higuerote', '29bf1c7b528e49b6791ec5682d68a8', 2, 0, 0, 1),
('c760b866f16079f9fea7adcb62d405', 'Falcón', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('c919e49e5730a9ad9092fb8f6de21d', 'Nirgua', '9b329b755d311a48226d74e3c3a39f', 2, 0, 0, 1),
('cb8dff4f6751ea1b85442d66cb3155', 'Guigue', '8ff3a4db3a1ff6f019c5eb42a83dfe', 2, 0, 0, 1),
('cba10495c07f2cf3cfdc299ea74592', 'Puerto Ayacucho', 'd60f320a907e7a9646490da1e77189', 1, 0, 0, 1),
('cba404896af8f006d3989f7ca487d3', 'Valle de la Pascua', 'b6f941dff49dafb3c45510be1fe894', 2, 0, 0, 1),
('cc889e62ac0dee458cd247b8bc4d44', 'Upata', '8efa4d4e3712890aa44da566bff4af', 2, 0, 0, 1),
('ce4286d400f01fed709bd5d15a4b69', 'San Juan Bautista', '3b8fe7c1ada74c3409efc9ead2f739', 2, 0, 0, 1),
('cf3dac4e4457e9bb60e29393cd56f1', 'Pampatar', '3b8fe7c1ada74c3409efc9ead2f739', 2, 0, 0, 1),
('d00cfda811e364bae3454628deb384', 'Caicara del Orinoco', '8efa4d4e3712890aa44da566bff4af', 2, 0, 0, 1),
('d02960a7f438f6533c36d33c2f6915', 'Río Caribe', '492243a010da8cd1ef2112b8a49135', 2, 0, 0, 1),
('d0336db64617fcfe8f4a4363470785', 'Apure', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('d1860bc211c29955e94c07db0b9c0e', 'Guarenas', '29bf1c7b528e49b6791ec5682d68a8', 2, 0, 0, 1),
('d2c4bdfb0be9da64fbfff4a1eeae4b', 'Guanare', '694e8ed33f343f5cb7d201d2fdb6ca', 2, 0, 0, 1),
('d60f320a907e7a9646490da1e77189', 'Amazonas', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('d6f35a89ceb29f99151f798f84b6d2', 'Santa Teresa', '29bf1c7b528e49b6791ec5682d68a8', 2, 0, 0, 1),
('d7b2ac2a53eb6f8ebe0b1e0b6067d5', 'Maiquetía', 'ad5ed6d5abff50bd2ec4ab3b73f8ea', 2, 0, 0, 1),
('d81e42718cb33a80a3f5f650d392b8', 'Valera', '5a606edb271e6622906b8fcfa18315', 2, 0, 0, 1),
('d88818857eca459eeb7f416c8bf011', 'Las Mercedes', 'b6f941dff49dafb3c45510be1fe894', 2, 0, 0, 1),
('d8938cb66b496c4af5323cb396a4d5', 'Biruaca', 'd0336db64617fcfe8f4a4363470785', 2, 0, 0, 1),
('dd5fe75e7cc8523d69d5e12a4df2c8', 'Aragua', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('df316ac250b33e1afb57626df69099', 'Anzoategui', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('df4acda694210d4fdeddc00dc538a0', 'Guanarito', '694e8ed33f343f5cb7d201d2fdb6ca', 2, 0, 0, 1),
('e0e7b732c81f431d5837a4359eb830', 'Biscucuy', '694e8ed33f343f5cb7d201d2fdb6ca', 2, 0, 0, 1),
('e1c649d5f23d772770d91f30afa5e1', 'Cariaco', '492243a010da8cd1ef2112b8a49135', 2, 0, 0, 1),
('e24e25bc4bf5ac462dbb467a940079', 'Guanta', 'df316ac250b33e1afb57626df69099', 2, 0, 0, 1),
('e3537b46821bd8a3c7a0b6c67ff8ad', 'Ocumare del Tuy', '29bf1c7b528e49b6791ec5682d68a8', 2, 0, 0, 1),
('e5edc59ea3ac2d9f5b7912782e004c', 'Carora', '6a65ea57693b7ca7647972941d75b7', 2, 0, 0, 1),
('e65de9bd3834ca03ca346476217a1e', 'Chaguaramas', 'b6f941dff49dafb3c45510be1fe894', 2, 0, 0, 1),
('e7792d34034c01aa6e351f85b4a1b6', 'Cabudare', '6a65ea57693b7ca7647972941d75b7', 2, 0, 0, 1),
('e81a26d95cb71bc81e0edc434edccd', 'Morichal', 'ead0d7f0e8ff594e09e065b30b41dc', 2, 0, 0, 1),
('e8f69db51725a5fbbcaa7e77621c25', 'San Fernando de Atabapo', 'd60f320a907e7a9646490da1e77189', 2, 0, 0, 1),
('e99c36d03fc9ca6dd2ec88ff1a1fa2', 'Cagua', 'dd5fe75e7cc8523d69d5e12a4df2c8', 2, 0, 0, 1),
('e9de9c2af016883001e2f67e20466b', 'Valencia', '8ff3a4db3a1ff6f019c5eb42a83dfe', 2, 0, 0, 1),
('ea815dadc3cb46278a9e56d4dc2c1a', 'Maturín', 'ead0d7f0e8ff594e09e065b30b41dc', 2, 0, 0, 1),
('ead0d7f0e8ff594e09e065b30b41dc', 'Monagas', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('eb3e7d7567ae61bbb0db43593b5cdf', 'Maracaibo', '50cecb93bf79dd34d150eb2101a58b', 2, 0, 0, 1),
('ed42624d8da0498660df00eae03ed1', 'Río Chico', '29bf1c7b528e49b6791ec5682d68a8', 2, 0, 0, 1),
('ee910feed53ecda31a81794a66ba1f', 'Punto Fijo', 'c760b866f16079f9fea7adcb62d405', 2, 0, 0, 1),
('f1f3ec380990512edadb4376385e1e', 'Piacoa', 'aa0cb384dbad02c48246a42bce5ecf', 2, 0, 0, 1),
('f4e9cf2482459cae443fc281548232', 'Táchira', '8c9c72821423c7f23ae40c668e0d7f', 1, 0, 0, 1),
('f4fd3220102edec0da11a681656a5a', 'Tinaco', 'b9cb8b2c769d080a71175b0acc83db', 2, 0, 0, 1),
('fa2feb06519e4af4dedef4df1f7ebc', 'Santa Lucía', '29bf1c7b528e49b6791ec5682d68a8', 2, 0, 0, 1),
('fa44c395134f8d728cd1982f74a133', 'Boconó', '5a606edb271e6622906b8fcfa18315', 2, 0, 0, 1),
('fc335e97c202e58ff7eca6c16f32d7', 'Duaca', '6a65ea57693b7ca7647972941d75b7', 2, 0, 0, 1),
('ff0477b26bf6cb92e6ba49e83d15b6', 'Naiguatá', 'ad5ed6d5abff50bd2ec4ab3b73f8ea', 2, 0, 0, 1),
('ff20f56006777c9dc39f46008110f8', 'Cocorote', '9b329b755d311a48226d74e3c3a39f', 2, 0, 0, 1);

-- --------------------------------------------------------

--
-- Estructura para la vista `ask_data`
--
DROP TABLE IF EXISTS `ask_data`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ask_data` AS (select `r`.`ID` AS `ID`,`r`.`image` AS `image`,`r`.`userID` AS `userID`,`b`.`ID` AS `brandID`,`r`.`model` AS `modelID`,`s`.`ID` AS `spartID`,`r`.`part` AS `partID`,`r`.`year` AS `year`,`r`.`details` AS `details`,`r`.`startdate` AS `startdate`,`r`.`enddate` AS `enddate`,`r`.`active` AS `active`,`u`.`name` AS `username`,`u`.`last` AS `userlast`,`u`.`email` AS `useremail`,`s`.`name` AS `subpart`,`p`.`name` AS `part`,`b`.`name` AS `brand`,`m`.`name` AS `model` from (((((`requests` `r` join `users` `u` on((`r`.`userID` = `u`.`ID`))) join `car_models` `m` on((`r`.`model` = `m`.`ID`))) join `car_brands` `b` on((`m`.`brandID` = `b`.`ID`))) join `car_parts` `p` on((`r`.`part` = `p`.`ID`))) join `car_parts_class` `s` on((`p`.`classID` = `s`.`ID`))));

-- --------------------------------------------------------

--
-- Estructura para la vista `car_models_full`
--
DROP TABLE IF EXISTS `car_models_full`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `car_models_full` AS (select `m`.`ID` AS `ID`,`m`.`image` AS `image`,`m`.`name` AS `name`,`m`.`brandID` AS `brandID`,`m`.`created` AS `created`,`m`.`active` AS `active`,`b`.`name` AS `brand`,`b`.`image` AS `brand_image` from (`car_models` `m` join `car_brands` `b` on((`m`.`brandID` = `b`.`ID`))));

-- --------------------------------------------------------

--
-- Estructura para la vista `car_parts_full`
--
DROP TABLE IF EXISTS `car_parts_full`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `car_parts_full` AS (select `p`.`ID` AS `ID`,`p`.`name` AS `name`,`p`.`classID` AS `classID`,`p`.`image` AS `image`,`p`.`count` AS `count`,`p`.`updated` AS `updated`,`p`.`active` AS `active`,`s`.`name` AS `subpart` from (`car_parts` `p` join `car_parts_class` `s` on((`p`.`classID` = `s`.`ID`))));

-- --------------------------------------------------------

--
-- Estructura para la vista `user_data`
--
DROP TABLE IF EXISTS `user_data`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `user_data` AS (select `users`.`ID` AS `ID`,`users`.`email` AS `email`,`users`.`pass` AS `pass`,`users`.`doc` AS `doc`,`users`.`doctype` AS `doctype`,`users`.`nac` AS `nac`,`users`.`name` AS `name`,`users`.`last` AS `last`,`users`.`level` AS `level`,`users`.`phone` AS `phone`,`users`.`birth` AS `birth`,`users`.`created` AS `created`,`users`.`active` AS `active`,`users`.`verified` AS `verified`,`users_config`.`login_count` AS `login_count`,`users_config`.`ip` AS `ip`,`users_config`.`config` AS `config`,`users_config`.`theme` AS `theme`,`users_ban`.`ban_start` AS `users_ban_start`,`users_ban`.`ban_end` AS `users_ban_end`,`users_ban`.`ban_details` AS `users_ban_details` from ((`users` left join `users_config` on((`users`.`ID` = `users_config`.`ID`))) left join `users_ban` on((`users`.`ID` = `users_ban`.`ID`))));

-- --------------------------------------------------------

--
-- Estructura para la vista `zone`
--
DROP TABLE IF EXISTS `zone`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `zone` AS (select `ciudad`.`ID` AS `ID`,`ciudad`.`item` AS `ciudad`,`estado`.`item` AS `estado`,`pais`.`item` AS `pais` from ((`_location` `ciudad` join `_location` `estado` on(((`ciudad`.`parentID` = `estado`.`ID`) and (`estado`.`active` = '1')))) join `_location` `pais` on(((`estado`.`parentID` = `pais`.`ID`) and (`pais`.`active` = '1')))) where (`ciudad`.`active` = '1') order by `pais`.`item`,`estado`.`item`,`ciudad`.`item`);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `car_brands`
--
ALTER TABLE `car_brands`
 ADD PRIMARY KEY (`ID`), ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `car_models`
--
ALTER TABLE `car_models`
 ADD PRIMARY KEY (`ID`), ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `car_models_img`
--
ALTER TABLE `car_models_img`
 ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `car_parts`
--
ALTER TABLE `car_parts`
 ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `car_parts_class`
--
ALTER TABLE `car_parts_class`
 ADD PRIMARY KEY (`ID`), ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `car_parts_ref`
--
ALTER TABLE `car_parts_ref`
 ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `car_years`
--
ALTER TABLE `car_years`
 ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `notifications`
--
ALTER TABLE `notifications`
 ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `requests`
--
ALTER TABLE `requests`
 ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `responses`
--
ALTER TABLE `responses`
 ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`ID`), ADD UNIQUE KEY `email` (`email`), ADD UNIQUE KEY `doc` (`doc`);

--
-- Indices de la tabla `users_ban`
--
ALTER TABLE `users_ban`
 ADD UNIQUE KEY `ID` (`ID`);

--
-- Indices de la tabla `users_config`
--
ALTER TABLE `users_config`
 ADD UNIQUE KEY `ID` (`ID`);

--
-- Indices de la tabla `users_data`
--
ALTER TABLE `users_data`
 ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `users_seller`
--
ALTER TABLE `users_seller`
 ADD PRIMARY KEY (`ID`), ADD KEY `userID` (`userID`), ADD KEY `rif` (`rif`);

--
-- Indices de la tabla `users_sell_profile`
--
ALTER TABLE `users_sell_profile`
 ADD PRIMARY KEY (`ID`), ADD KEY `userID` (`userID`);

--
-- Indices de la tabla `_location`
--
ALTER TABLE `_location`
 ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `notifications`
--
ALTER TABLE `notifications`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `users_data`
--
ALTER TABLE `users_data`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `users_seller`
--
ALTER TABLE `users_seller`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `users_sell_profile`
--
ALTER TABLE `users_sell_profile`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=149;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
