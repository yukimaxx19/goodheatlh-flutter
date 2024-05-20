<?php
include '../db.php';

$response = null;
try {
    $id = $_GET['id'];
    $query = "DELETE FROM pesan_obat WHERE id_pesan_obat = '$id'";

    $stmt = $conn->prepare($query);
    $stmt->execute();
    $response['message'] = "Pesanan berhasil dihapus";
} catch (Exception $e) {
    $response['message'] = "Gagal :" . $e->getMessage();
}

echo json_encode($response);
