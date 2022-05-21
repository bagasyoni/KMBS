<?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Methods: PUT, GET, POST, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Origin, Content-Type, Authorization, Accept, X-Requested-With, x-xsrf-token");
header("Content-Type: application/json; charset=UTF-8");

include "config.php";

$postjson = json_decode(file_get_contents('php://input'), true);
$today = date('Y-m-d');
$PER = $_GET['PER'];
$TGL_1 = $_GET['TGL_1'];
$TGL_2 = $_GET['TGL_2'];

include('phpjasperxml/class/tcpdf/tcpdf.php');
include('phpjasperxml/class/PHPJasperXML.inc.php');
include('phpjasperxml/setting.php');
$PHPJasperXML = new \PHPJasperXML();
$PHPJasperXML->load_xml_file("phpjasperxml/Laporan_Stock_Bahan.jrxml");

$PHPJasperXML->transferDBtoArray(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
$PHPJasperXML->arraysqltable = array();
$query = "SELECT stocka.no_bukti AS NO_BUKTI, stockad.kd_bHN AS KD_BHN, stockad.na_bHN AS NA_BHN, stockad.satuan AS SATUAN, stockad.qty AS QTY, stockad.HARGA, stockad.TOTAL FROM stocka, stockad WHERE stocka.no_bukti = stockad.no_bukti AND stocka.PER = '$PER' AND stocka.TGL = '$TGL_1' AND stocka.TGL = '$TGL_2' AND stockad.flag='KA' ORDER BY stockad.no_bukti";
$result1 = mysqli_query($mysqli, $query);
while ($row1 = mysqli_fetch_assoc($result1)) {
	array_push($PHPJasperXML->arraysqltable, array(
		"NO_BUKTI" => $row1["NO_BUKTI"],
		"KD_BHN" => $row1["KD_BHN"],
		"NA_BHN" => $row1["NA_BHN"],
		"SATUAN" => $row1["SATUAN"],
		"QTY" => $row1["QTY"],
		"HARGA" => $row1["HARGA"],
		"TOTAL" => $row1["TOTAL"],
	));
}
ob_end_clean();
$PHPJasperXML->outpage("I");
