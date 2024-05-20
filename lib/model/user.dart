import 'dart:convert';

import 'package:http/http.dart';
//import 'package:good_health/model/pasien.dart';
//import 'package:good_health/util/config.dart';
import 'package:http/http.dart' as http;

class User {
  //final String idUser, username, password;
  //final Pasien idPasien;

  final String username, password;

  //User( {required this.idUser, required this.username, required this.password, required this.idPasien});
   User( {required this.username, required this.password, required String idUser, required var idPasien});
  

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        idUser: json['id_user'],
        username: json['username'],
        password: json['password'],
        idPasien: json['id_pasien']);
  }

  /*factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['username'],
        password: json['password'],
    );
  }*/

  get idPasien => null;
}

// login (POST)
Future<Response?> login(User user) async {
  //String route = AppConfig.API_ENDPOINT + "/login.php";
  try {
    final response = await http.post(Uri.parse('http://10.0.2.2/goodhealth/login.php'),
        headers: {"Content-Type": "application/json"},
        body:
            jsonEncode({'username': user.username, 'password': user.password, 'idPasien': user.idPasien}));

    print(response.body.toString());

    return response;
  } catch (e) {
    print("Error : ${e.toString()}");
    return null;
  }
}


