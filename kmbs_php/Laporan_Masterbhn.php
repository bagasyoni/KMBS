<?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Methods: PUT, GET, POST, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Origin, Content-Type, Authorization, Accept, X-Requested-With, x-xsrf-token");
header("Content-Type: application/json; charset=UTF-8");

include "config.php";

// $postjson = json_decode(file_get_contents('php://input'), true);
$TGL = date('dd/MM/YYYY');
$PER = $_GET['PER'];

include('phpjasperxml/class/tcpdf/tcpdf.php');
include('phpjasperxml/class/PHPJasperXML.inc.php');
include('phpjasperxml/setting.php');
$PHPJasperXML = new \PHPJasperXML();
$PHPJasperXML->load_xml_file("phpjasperxml/Laporan_Master_Bahan.jrxml");

$PHPJasperXML->transferDBtoArray(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
$PHPJasperXML->arraysqltable = array();
$query = "SELECT KD_BHN, NA_BHN, SATUAN, '02/2022' AS PER, '02/02/2022' AS TGL FROM bhn ORDER BY KD_BHN";
$result1 = mysqli_query($mysqli, $query);
while ($row1 = mysqli_fetch_assoc($result1)) {
	array_push($PHPJasperXML->arraysqltable, array(
		"KD_BHN" => $row1["KD_BHN"],
		"NA_BHN" => $row1["NA_BHN"],
		"SATUAN" => $row1["SATUAN"],
		"PER" => $row1["PER"],
		"TGL" => $row1["TGL"],
	));
}
ob_end_clean();
$PHPJasperXML->outpage("I");
