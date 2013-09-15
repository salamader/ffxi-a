<?php
class Core {
protected $db, $result;
private $rows;

public function __construct() {
$this->db = new mysqli('127.0.0.1','Wiistream','pass','database');	
}

public function query($sql) {
$this->result = $this->db->query($sql);	
}

public function rows() {
	for($x = 1; $x <= $this->db->affected_rows; $x++){ 
	$this->rows[] = $this->result->fetch_assoc();
	}
	return $this->rows;
}
}