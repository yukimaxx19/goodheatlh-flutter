<?php
include '../db.php';

$response = null;
try {
    $id = $_GET['id'];
    $query = "DELETE FROM regis_poli WHERE id_regis_poli = '$id'";

    $stmt = $conn->prepare($query);
    $stmt->execute();
    $response['message'] = "Registrasi berhasil dihapus";
} catch (Exception $e) {
    $response['message'] = "Gagal :" . $e->getMessage();
}

echo json_encode($response);
