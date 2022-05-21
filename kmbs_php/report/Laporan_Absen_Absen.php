<?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Methods: PUT, GET, POST, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Origin, Content-Type, Authorization, Accept, X-Requested-With, x-xsrf-token");
header("Content-Type: application/json; charset=UTF-8");

include "config.php";

$postjson = json_decode(file_get_contents('php://input'), true);
$today = date('Y-m-d');

// if ($postjson['kodea'] != '') $kodea = $postjson['kodea'];
// else $kodea = $_GET['kodea'];

// if ($postjson['kodeb'] != '') $kodeb = $postjson['kodeb'];
// else $kodeb = $_GET['kodeb'];

// $KD_BAG = $postjson['KD_BAG'];
$PER = $_GET['PER'];
$KD_BAG = $_GET['KD_BAG'];

include('phpjasperxml/class/tcpdf/tcpdf.php');
include('phpjasperxml/class/PHPJasperXML.inc.php');
include('phpjasperxml/setting.php');
$PHPJasperXML = new \PHPJasperXML();
$PHPJasperXML->load_xml_file("phpjasperxml/Laporan_DaftarAbsen_Absen.jrxml");

$PHPJasperXML->transferDBtoArray(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
$PHPJasperXML->arraysqltable = array();
// $result1 = mysqli_query($mysqli, "SELECT KD_BRG,NA_BRG,SATUAN FROM BRG WHERE SATUAN = 'PS.'");
$query = "SELECT hrd_peg.nm_peg AS NM_PEG,
					CONCAT(hrd_peg.kd_bag,' - ',hrd_peg.nm_bag) AS BAGIAN,
					hrd_peg.kd_bag AS KD_BAG,
					hrd_peg.nm_grup AS NM_GRUP,
					'$PER' AS PER
				FROM hrd_peg, hrd_bag
				WHERE hrd_peg.kd_bag=hrd_bag.kd_bag 
				AND hrd_peg.kd_bag='$KD_BAG'
				-- AND hrd_peg.aktif='1'
				-- AND hrd_peg.pt='1'
				-- AND hrd_peg.dr='II'
				ORDER BY hrd_peg.kd_peg";
$result1 = mysqli_query($mysqli, $query);
while ($row1 = mysqli_fetch_assoc($result1)) {
	array_push($PHPJasperXML->arraysqltable, array(
		"BAGIAN" => $row1["BAGIAN"],
		"TGL_CETAK" => $row1["TGL_CETAK"],
		"NM_GRUP" => $row1["NM_GRUP"],
		"KD_BAG" => $row1["KD_BAG"],
		"PER" => $row1["PER"],
		"NM_PEG" => $row1["NM_PEG"],
	));
}
ob_end_clean();
$PHPJasperXML->outpage("I");
