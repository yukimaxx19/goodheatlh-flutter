import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:good_health/util/config.dart';

class Dokter {
  final String idDokter, nama, hp;

  Dokter({required this.idDokter, required this.nama, required this.hp});

  factory Dokter.fromJson(Map<String, dynamic> json) {
    return Dokter(
        idDokter: json['id_dokter'].toString(),
        nama: json['nama'],
        hp: json['hp']);
  }
}

List<Dokter> dokterFromJson(jsonData) {
  List<Dokter> result =
      List<Dokter>.from(jsonData.map((item) => Dokter.fromJson(item)));

  return result;
}

// index
Future<List<Dokter>> fetchDokters() async {
  //String route = AppConfig.API_ENDPOINT + "dokter/index.php";
  final response =
      await http.get(Uri.parse('http://10.0.2.2/goodhealth/dokter/index.php'));

  if (response.statusCode == 200) {
    var jsonResp = json.decode(response.body);
    return dokterFromJson(jsonResp);
  } else {
    //throw Exception('Failed load $route, status : ${response.statusCode}');
    throw Exception('Failed load, status : ${response.statusCode}');
  }
}
