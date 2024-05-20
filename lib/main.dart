import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:good_health/page/login.dart';
import 'package:good_health/page/modul_pasien/index.dart' as IndexPasien;
import 'package:good_health/page/modul_pegawai/index.dart' as IndexPegawai;
import 'package:good_health/util/session.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: FutureBuilder(
        future: _loadSession(),
        builder: (context, snapshot) {
          late final SharedPreferences prefs = snapshot.data;
          late Widget result;
          if (snapshot.connectionState == ConnectionState.waiting) {
            result = Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              if (prefs.getBool(IS_LOGIN) ?? false) {
                if (prefs.getString(JENIS_LOGIN) ==
                    jenisLogin.PASIEN.toString()) {
                  result = IndexPasien.IndexPage();
                } else {
                  // result home pegawai
                  result = IndexPegawai.IndexPage();
                }
              } else {
                result = LoginPage();
              }
            } else {
              return Container(child: Text('Error..'));
            }
          }

          return result;
        },
      ),
    );
  }

  Future _loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}
