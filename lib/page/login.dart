import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:good_health/model/user.dart';
import 'package:good_health/page/modul_pasien/index.dart' as IndexPasien;
import 'package:good_health/page/modul_pasien/signup.dart';
import 'package:good_health/page/modul_pegawai/index.dart' as IndexPegawai;
import 'package:good_health/util/session.dart';
import 'package:good_health/util/util.dart';

import 'dart:developer' as developer;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameCont = new TextEditingController();
  TextEditingController passCont = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green,
        body: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('GOOD HEALTH',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: _formWidget(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _formWidget() {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: usernameCont,
              decoration: InputDecoration(
                  icon: Icon(Icons.person), hintText: 'Username'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Tidak boleh kosong';
                }
                return null;
              },
            ),
            TextFormField(
              controller: passCont,
              obscureText: true,
              decoration: InputDecoration(
                  icon: Icon(Icons.vpn_key), hintText: 'Password'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Tidak boleh kosong';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            /*SizedBox(
                width: double.infinity,
                child: largetButton(
                    label: 'LOGIN',
                    iconData: Icons.subdirectory_arrow_right,
                    onPressed: () => (_formKey.currentState!.validate())
                        ? prosesLogin()
                        : null)),*/
            ElevatedButton(onPressed: tes_logn, child: Text('Login')),
            SizedBox(height: 20),
            GestureDetector(
                onTap: () async {
                  final result = await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignUpPage()));

                  if (result != null) {
                    dialog(context, result);
                  }
                },
                child: Text('Anda belum punya akun? Registrasi pasien baru')),
          ],
        ));
  }

  void tes_logn() async {
    try {
      // var idPasien = null;
      final response = await login(User(
          username: usernameCont.text,
          password: passCont.text,
          idUser: '',
          idPasien: '1'));
      // User(username: usernameCont.text, password: passCont.text));
      var jsonResp = json.decode(response!.body);
      if (response.statusCode == 200) {
        //  User user = User.fromJson(jsonResp['user']);

        developer.log(jsonResp['user']['username']);

        if (jsonResp['user']['id_pasien'] != null) {
          createPasienSessionx(
              jsonResp['user']['id_pasien']['id_pasien'].toString(),
              jsonResp['user']['id_pasien']['nama'],
              jsonResp['user']['id_pasien']['hp'],
              jsonResp['user']['id_pasien']['email']);

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => IndexPasien.IndexPage()));
        } else {
          createPegawaiSession(jsonResp['user']['username']);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => IndexPegawai.IndexPage()));
          dialog(context, jsonResp['user']['username']);
        }
      } else if (response.statusCode == 401) {
        dialog(context, jsonResp['message']);
      } else {
        dialog(context, response.body.toString());
      }
    } catch (e) {
      dialog(context, e.toString());
      //developer.log('tes tes');
    }
  }

  void prosesLogin() async {
    try {
      // var idPasien = null;
      final response = await login(User(
          username: usernameCont.text,
          password: passCont.text,
          idUser: '',
          idPasien: '1'));
      // User(username: usernameCont.text, password: passCont.text));
      var jsonResp = json.decode(response!.body);
      if (response.statusCode == 200) {
        User user = User.fromJson(jsonResp['user']);

        developer.log(jsonResp['user']['username']);

        // ignore: unnecessary_null_comparison

        if (user.idPasien != null) {
          // direct to home pasien
          createPasienSession(user.idPasien);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => IndexPasien.IndexPage()));
        } else {
          // direct to home pegawai here

          createPegawaiSession(jsonResp['user']['username']);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => IndexPegawai.IndexPage()));
          dialog(context, jsonResp['login berhasil']);
        }
      } else if (response.statusCode == 401) {
        dialog(context, jsonResp['message']);
      } else {
        dialog(context, response.body.toString());
      }
    } catch (e) {
      //dialog(context, e.toString());
      developer.log('tes tes');
    }
  }
}
