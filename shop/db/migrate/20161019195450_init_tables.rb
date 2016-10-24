class InitTables < ActiveRecord::Migration
  def up
    sql_query =  <<SQL
CREATE TABLE `ms_category` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `parentId` smallint(5) unsigned NOT NULL DEFAULT '0',
  `children` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `parentId` (`parentId`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

SQL

  execute sql_query

  sql_query = <<SQL
CREATE TABLE `ms_product` (
  `categoryId` smallint(5) unsigned NOT NULL DEFAULT '0',
  `sale` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `rating` int(11) DEFAULT NULL,
  `series` varchar(255) NOT NULL,
  `cover` varchar(50) NOT NULL,
  `ISBN` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `producer` varchar(255) NOT NULL,
  `new` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `picture` varchar(255) NOT NULL,
  `visible` enum('Y','N') NOT NULL DEFAULT 'Y',
  `volume` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `availabilityCode` tinyint(1) unsigned NOT NULL DEFAULT '2',
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `topCategoryId` smallint(5) unsigned NOT NULL DEFAULT '0',
  `book` enum('Y','N') NOT NULL DEFAULT 'Y',
  `price` decimal(8,2) unsigned NOT NULL DEFAULT '0.00',
  `md5` varchar(32) NOT NULL,
  `year` varchar(4) DEFAULT NULL,
  `pages` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categoryId` (`categoryId`),
  KEY `topCategoryId` (`topCategoryId`)
 ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
SQL
  execute sql_query
  end

  def down
     execute 'DROP TABLE `ms_product`'
     execute 'DROP TABLE `ms_category`'
  end
end
