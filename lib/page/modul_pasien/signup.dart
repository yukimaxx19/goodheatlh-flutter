import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:good_health/model/pasien.dart';
import 'package:good_health/page/login.dart';
import 'package:good_health/util/util.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namaCont = new TextEditingController();
  TextEditingController hpCont = new TextEditingController();
  TextEditingController emailCont = new TextEditingController();

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
              controller: namaCont,
              decoration: InputDecoration(
                  icon: Icon(Icons.person), hintText: 'Nama Lengkap'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Tidak boleh kosong';
                }
                return null;
              },
            ),
            TextFormField(
              controller: hpCont,
              decoration: InputDecoration(
                  icon: Icon(Icons.phone_android), hintText: 'Nomor HP'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Tidak boleh kosong';
                }
                return null;
              },
            ),
            TextFormField(
              controller: emailCont,
              decoration: InputDecoration(
                  icon: Icon(Icons.alternate_email), hintText: 'Email'),
            ),
            SizedBox(height: 16),
            /*SizedBox(
                width: double.infinity,
                child: largetButton(
                    label: 'REGISTRASI PASIEN',
                    onPressed: () async => (_formKey.currentState!.validate())
                        ? prosesRegistrasi()
                        : null)),*/
            ElevatedButton(onPressed: prosesRegistrasi, child: Text('Register')),
            SizedBox(height: 20),
            GestureDetector(
                onTap: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage())),
                child: Text('Anda sudah punya akun? Login')),
          ],
        ));
  }

  void prosesRegistrasi() async {
    final response = await pasienCreate(Pasien(
        nama: namaCont.text, hp: hpCont.text, email: emailCont.text, idPasien: ''));

    if (response != null) {
      print(response.body.toString());
      if (response.statusCode == 200) {
        var jsonResp = json.decode(response.body);
        Navigator.pop(context, jsonResp['message']);
      } else {
        dialog(context, "${response.body.toString()}");
      }
    }
  }
}
