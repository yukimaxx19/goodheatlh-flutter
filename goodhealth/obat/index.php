<?php
include '../db.php'; 

$nama = $_GET['nama']?? null;
$query="SELECT * FROM obat";

if($nama != null){
    $query = $query." WHERE nama LIKE '%$nama%'";
}

$sql= $conn->query($query);
echo json_encode($sql->fetchAll(PDO::FETCH_ASSOC));
?>