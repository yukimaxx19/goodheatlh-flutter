import 'package:flutter/material.dart';

class HomeContent extends StatefulWidget {
  static String title = 'Home Pasien';

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Selamat Datang \nAplikasi GOOD HEALTH',
        style: TextStyle(fontSize: 30),
        textAlign: TextAlign.center,
      ),
    );
  }
}
