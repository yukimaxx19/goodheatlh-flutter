<?php
include 'db.php';

$data=json_decode(file_get_contents("php://input"));
$username = $data-$username;
$password=sha1($data->$password);

$query_user = "SELECT * FROM user WHERE username = '$username' AND password = '$password'";

$sql = $conn->query($query_user);
$result=$sql->fetch(PDO::FETCH_ASSOC);
$response=null;
if($result != false){
    $id_pasien=$result['id_pasien'];

    $query_pasien = "SELECT * FROM pasien WHERE id_pasien = '$id_pasien'";
    $result_pasien = $conn->query($query_pasien)->fetch(PDO::FETCH_ASSOC);
    $result_pasien = ($result_pasien!=false) ? $result_pasien : null;

    $response['message']="Selamat Datang".$result['username'];
    $response['user']=$result;
    $response['user']['id_pasien']=$result_pasien;
} else{
    http_response_code(401);
    $response['message']="Username atau Password salah";
    $response['user']=null;
}

echo json_encode($response);