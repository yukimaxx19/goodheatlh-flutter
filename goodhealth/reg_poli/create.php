<?php
include '../db.php';

$response = null;
try {
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        $data = json_decode(file_get_contents("php://input"));

        $id_pasien = $data->id_pasien;
        $id_dokter = $data->id_dokter;
        $tgl_booking = $data->tgl_booking;
        $poli = $data->poli;

        $query = "INSERT INTO regis_poli (id_pasien, id_dokter, tgl_booking, poli) VALUES (?,?,?,?)";

        $stmt = $conn->prepare($query);

        $stmt->execute([$id_pasien, $id_dokter, $tgl_booking, $poli]);

        $response['message'] = "Booking registrasi berhasil dibuat";
        $response['id_regis_poli'] = $conn->lastInsertId();
    }
} catch (Exception $e) {
    $response['message'] = "Gagal : " . $e->getMessage();
    $response['id_regis_poli'] = null;
}

echo json_encode($response);
