<?php
include '../db.php';

$result=null;
$id_pasien=$_get['id_pasien'] ?? null;
$is_selesai=$_get['is_selesai'] ?? null;

$query="SELECT * FROM pesan_obat";

if($id_pasien != null){
    $query=$query." WHERE id_pasien = '$id_pasien'";
}

if($is_selesai!=null){
    $query=$query." WHERE is_pasien = '$is_pasien'";
}

$sql = $conn->query($query);
$result_pesan_obat=$sql->fetchAll(PDO::FETCH_ASSOC);

$result = $result_pesan_obat;
foreach($result as $i => $regis){
    $id_pasien = $regis['id_pasien'];
    $result_pasien=$conn->query("SELECT * FROM pasien WHERE id_pasien = '$id_pasien'")->fetch(PDO::FETCH_ASSOC);
    $result[$i]['id_pasien']=$result_pasien;
}

echo json_encode($result);
?>
