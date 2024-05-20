<?php
include '../db.php';

$result = null;
$id_pasien = $_GET['id_pasien'] ?? null;
$id_dokter = $_GET['id_dokter'] ?? null;
$poli = $_GET['poli'] ?? null;
$tgl_booking_start = $_GET['tgl_booking_start'] ?? null;
$tgl_booking_end = $_GET['tgl_booking_end'] ?? null;

$query = "SELECT * FROM regis_poli";

if ($id_pasien != null) {
    $query = $query . " WHERE id_pasien = '$id_pasien'";
}

if ($id_dokter != null) {
    $query = $query . " WHERE id_dokter = '$id_dokter'";
}
if ($poli != null) {
    $query = $query . " WHERE poli = '$poli'";
}
if ($tgl_booking_start !== null && $tgl_booking_end != null) {
    $tgl_booking_start = $tgl_booking_start . "AND WHERE tgl_booking BETWEEN '$tgl_booking_start' AND 'tgl_booking_end'";
}
$sql = $conn->query($query);
$result_regis_poli = $sql->fetchAll(PDO::FETCH_ASSOC);

$result = $result_regis_poli;
foreach ($result as $i => $regis) {
    $id_pasien = $regis['id_pasien'];
    $result_pasien = $conn->query("SELECT * FROM pasien WHERE id_pasien = '$id_pasien'")->fetch(PDO::FETCH_ASSOC);
    $result[$i]['id_pasien'] = $result_pasien;

    $id_dokter = $regis['id_dokter'];
    $result_dokter = $conn->query("SELECT * FROM dokter WHERE id_dokter = '$id_dokter'")->fetch(PDO::FETCH_ASSOC);
    $result[$i]['id_dokter'] = $result_dokter;
}
echo json_encode($result);
