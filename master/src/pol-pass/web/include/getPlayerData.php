<?php

if (file_exists('config.inc')) include_once 'config.inc';

$dbh = new PDO("mysql:host=127.0.0.1;dbname=$db_name", $db_login, $db_password,
				array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8'));
$dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
if (!$dbh)
  {
  die('Could not connect: ' . mysql_error());
  }

function dbSel($query){
	global $dbh;
	try {
		$sth = $dbh->prepare($query);
		$sth->execute();
		while ($row = $sth->fetch(PDO::FETCH_ASSOC, PDO::FETCH_ORI_NEXT)) {
			$result[]=$row;
		}
	} catch (PDOException $e) {
		die('[]');
	}
	return $result;
}

$jobs = Array('','war','mnk','whm','blm','rdm','thf','pld','drk','bst','brd','rng','sam','nin','drg','smn','blu','cor','pup','dnc','sch');

$query = 'SELECT `charid`,`war`,`mnk`,`whm`,`blm`,`rdm`,`thf`,`pld`,`drk`,`bst`,`brd`,`rng`,`sam`,`nin`,`drg`,`smn`,`blu`,`cor`,`pup`,`dnc`,`sch` FROM `accounts_sessions` NATURAL LEFT JOIN `char_jobs`';
$result = dbSel($query);		
$playerJobLevel = array();
foreach	($result as $player)
	$playerJobLevel[$player['charid']] = $player;


$query = 'SELECT `charid`,`charname` AS `player`,`name` AS `area`,`mjob`,`sjob`,`bazaar_message`,`nameflags` FROM
			(SELECT `charid`,`charname`,`name` FROM 
				(SELECT `charid`,`charname`,`pos_zone` FROM `accounts_sessions` NATURAL LEFT JOIN `chars`) AS `J1`
				LEFT JOIN 
				`zone_settings` ON (`J1`.`pos_zone` = `zone_settings`.`zoneid`)) AS `J2`
			NATURAL LEFT JOIN `char_stats` ORDER BY `charname` ASC';
			
$result = dbSel($query);

foreach ($result as &$player)
{
	$player['mjoblvl'] = $playerJobLevel[$player['charid']][$jobs[$player['mjob']]];
	if ($player['sjob'] == '0')
		$player['sjoblvl'] =  '';
	else $player['sjoblvl'] = ($playerJobLevel[$player['charid']][$jobs[$player['sjob']]] < floor($player['mjoblvl'] / 2)) ? $playerJobLevel[$player['charid']][$jobs[$player['sjob']]] : floor($player['mjoblvl'] / 2);
	if ($player['sjoblvl']=='0')
		$player['sjoblvl']='1';
}
echo json_encode($result);

$dbh = null;
?>