import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:good_health/util/config.dart';
import 'package:good_health/util/session.dart';
import 'pasien.dart';

class PesanObat {
  String idPesanObat, waktu, alamat, lat, lng, listPesanan, totalBiaya, ket;
  bool? isSelesai;

  Pasien? idPasien;

  PesanObat(
      {required this.idPesanObat,
      required this.idPasien,
      required this.waktu,
      required this.alamat,
      required this.lat,
      required this.lng,
      required this.listPesanan,
      required this.totalBiaya,
      required this.ket,
      this.isSelesai});

  factory PesanObat.fromJson(Map<String, dynamic> json) {
    return PesanObat(
        idPesanObat: json['id_pesan_obat'].toString(),
        idPasien: Pasien.fromJson(json['id_pasien']),
        waktu: json['waktu'],
        alamat: json['alamat'],
        lat: json['lat'].toString(),
        lng: json['lng'].toString(),
        listPesanan: json['list_pesanan'],
        totalBiaya: json['total_biaya'].toString(),
        ket: json['ket'] ?? "",
        isSelesai: (json['is_selesai'] == "1") ? true : false);
  }
}

List<PesanObat> pesanObatFromJson(jsonData) {
  List<PesanObat> result =
      List<PesanObat>.from(jsonData.map((item) => PesanObat.fromJson(item)));

  return result;
}

// index
// String route = AppConfig.API_ENDPOINT + "pesan_obat/index.php?id_pasien=$idPasien&is_selesai=$isSelesai";

Future<List<PesanObat>> fetchPesanObats({isSelesai}) async {
  isSelesai = isSelesai ?? "";
  final prefs = await SharedPreferences.getInstance();
  String idPasien = prefs.getString(ID_PASIEN) ?? "";

  final response = await http.get(Uri.parse(
      'http://10.0.2.2/goodhealth/pesan_obat/index.php?id_pasien=$idPasien&is_selesai=$isSelesai'));

  if (response.statusCode == 200) {
    var jsonResp = json.decode(response.body);
    return pesanObatFromJson(jsonResp);
  } else {
    throw Exception('Failed load, status : ${response.statusCode}');
  }
}

/*Future<List<PesanObat>> fetchPesanObats({isSelesai}) async {
  isSelesai = isSelesai ?? "";
  final prefs = await SharedPreferences.getInstance();
  String idPasien = prefs.getString(ID_PASIEN) ?? "";
 

  final response = await http.get(Uri.parse('http://10.0.2.2/goodhealth/pesan_obat/index.php?id_pasien=$idPasien')); 

  if (response.statusCode == 200) {
    var jsonResp = json.decode(response.body);
    return pesanObatFromJson(jsonResp);
  } else {
    throw Exception('Failed load, status : ${response.statusCode}');
  }
}*/

// create (POST)
Future pesanObatCreate(PesanObat pesanObat) async {
  final prefs = await SharedPreferences.getInstance();
  //String route = AppConfig.API_ENDPOINT + "pesan-obat/create.php";
  try {
    final response = await http.post(
        Uri.parse('http://10.0.2.2/goodhealth/pesan_obat/create.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'id_pasien': prefs.getString(ID_PASIEN),
          'alamat': pesanObat.alamat,
          'lat': pesanObat.lat,
          'lng': pesanObat.lng,
          'list_pesanan': pesanObat.listPesanan,
          'total_biaya': pesanObat.totalBiaya,
          'ket': pesanObat.ket
        }));

    return response;
  } catch (e) {
    print("Error : ${e.toString()}");
    return null;
  }
}

// delete (GET)
Future deletePesanObat(id) async {
  //String route = AppConfig.API_ENDPOINT + "pesan-obat/delete.php?id=$id";
  final response = await http.get(
      Uri.parse('http://10.0.2.2/goodhealth/pesan_obat/delete.php?id=$id"'));

  if (response.statusCode == 200) {
    var jsonResp = json.decode(response.body);
    return jsonResp['message'];
  } else {
    return response.body.toString();
  }
}

// update (GET)
Future updatePesanObat(id) async {
  //String route = AppConfig.API_ENDPOINT + "pesan-obat/update.php?id=$id";
  final response = await http.get(
      Uri.parse('http://10.0.2.2/goodhealth/pesan_obat/update.php?id=$id'));

  if (response.statusCode == 200) {
    var jsonResp = json.decode(response.body);
    return jsonResp['message'];
  } else {
    return response.body.toString();
  }
}
