<?php
include '../db.php';

$response = null;
try {
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        $data = json_decode(file_get_contents("php://input"));

        $id_pasien = $data->id_pasien;
        $waktu = date('Y-m-d H:i:s');
        $alamat = $data->alamat;
        $lat = $data->lat;
        $lng = $data->lng;
        $list_pesanan = $data->list_pesanan;
        $total_biaya = $data->total_biaya;
        $ket = $data->ket;

        $query = "INSERT INTO pesan_obat (id_pasien, waktu, alamat, lat, lng, list_pesanan, total_biaya, ket) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        $stmt = $conn->prepare($query);

        $stmt->execute([$id_pasien, $waktu, $alamat, $lat, $lng, $list_pesanan, $total_biaya, $ket]);

        $response['message'] = "Berhasil melakukan pemesanan obat, silahkan tunggu driver mengantarkan obat anda";
        $response['id_pesan_obat'] = $conn->lastInsertId();
    }
} catch (Exception $e) {
    $response['message'] = "Gagal : " . $e->getMessage();
    $response['id_pesan_obat'] = null;
}

echo json_encode($response);
?>
