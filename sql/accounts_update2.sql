ALTER TABLE `accounts`
ADD `expansions` int(255) NOT NULL DEFAULT '4094',
ADD `pic` varchar(255) NOT NULL DEFAULT 'http://ffxi-a.com/images/user.jpg',
ADD`map_time` int(255) NOT NULL DEFAULT '0',
ADD `lobby_time` int(255) NOT NULL DEFAULT '0',
ADD `on_map` int(1) NOT NULL DEFAULT '0'

