<?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Methods: PUT, GET, POST, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Origin, Content-Type, Authorization, Accept, X-Requested-With, x-xsrf-token");
header("Content-Type: application/json; charset=UTF-8");

include "config.php";

// $postjson = json_decode(file_get_contents('php://input'), true);
$TGL = date('d/M/Y');
$PER = $_GET['PER'];

include('phpjasperxml/class/tcpdf/tcpdf.php');
include('phpjasperxml/class/PHPJasperXML.inc.php');
include('phpjasperxml/setting.php');
$PHPJasperXML = new \PHPJasperXML();
$PHPJasperXML->load_xml_file("phpjasperxml/Laporan_Master_Customer.jrxml");

$PHPJasperXML->transferDBtoArray(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
$PHPJasperXML->arraysqltable = array();
$query = "SELECT KODEC, NAMAC, ALAMAT, KOTA, '$PER' AS PER, '$TGL' AS TGL FROM cust ORDER BY KODEC";
$result1 = mysqli_query($mysqli, $query);
while ($row1 = mysqli_fetch_assoc($result1)) {
	array_push($PHPJasperXML->arraysqltable, array(
		"KODEC" => $row1["KODEC"],
		"NAMAC" => $row1["NAMAC"],
		"ALAMAT" => $row1["ALAMAT"],
		"KOTA" => $row1["KOTA"],
		"PER" => $row1["PER"],
		"TGL" => $row1["TGL"],
	));
}
ob_end_clean();
$PHPJasperXML->outpage("I");
