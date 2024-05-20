<?php
include '../db.php';

$response = null;
try {
    $id = $_GET['id'];
    $query = "UPDATE pesan_obat SET is_selesai = '1' WHERE id_pesan_obat = '$id'";

    $stmt = $conn->prepare($query);
    $stmt->execute();
    $response['message'] = "Pesanan berhasil diupdate";
} catch (Exception $e) {
    $response['message'] = "Gagal :" . $e->getMessage();
}

echo json_encode($response);
