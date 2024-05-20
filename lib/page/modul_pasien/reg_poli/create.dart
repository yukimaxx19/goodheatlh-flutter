import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:good_health/model/dokter.dart';
import 'package:good_health/model/pasien.dart';
import 'package:good_health/model/reg_poli.dart';
//import 'package:good_health/util/util.dart';

import 'dart:developer' as developer;

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  late Dokter _selectedDokter;
  late Future<List<Dokter>> dokters;
  late String _selectedPoli;
  TextEditingController _tglBookCont = new TextEditingController();
  List<String> polis = ["Poli Umum", "Poli Anak", "Poli Gigi", "Poli Syaraf"];

  @override
  void initState() {
    super.initState();
    dokters = fetchDokters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registrasi Baru'),
        ),
        body: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                _dropPoli(),
                SizedBox(height: 20),
                _dropDownDokter(),
                SizedBox(height: 20),
                _textTanggalBook()
              ],
            ),
          ),
        ),
        //bottomNavigationBar:
           // largetButton(label: "SIMPAN", onPressed: save_poli_tes()));
          bottomNavigationBar: ElevatedButton(onPressed: saveRegisPoli, child: Text('Simpan'),));
  }

  void save_poli_tes() async
  {
    developer.log('tes button');
  }

  void saveRegisPoli() async {
    RegisPoli regisPoli = new RegisPoli(
        idPasien: Pasien(idPasien: "5", nama: '', hp: '', email: ''),
        idDokter: _selectedDokter,
        tglBooking: _tglBookCont.text,
        poli: _selectedPoli, idRegisPoli: '');

    // ignore: unnecessary_null_comparison
    if (_selectedPoli == null) {
      print("Poli belum dipilih");
    } else {
      final response = await regisPoliCreate(regisPoli);
      if (response != null) {
        print(response.body.toString());
        if (response.statusCode == 200) {
          var jsonResp = json.decode(response.body);
          Navigator.pop(context, jsonResp['message']);
        } else {
          print(response.statusCode);
          print(response.body.toString());
        }
      }
    }
  }

  Widget _dropDownDokter() {
    return FutureBuilder(
        future: dokters,
        builder: (BuildContext context, AsyncSnapshot<List<Dokter>> snapshot) {
          if (snapshot.hasData) {
            return DropdownButtonFormField(
              hint: Text("Pilih Dokter"),
              items:
                  snapshot.data?.map<DropdownMenuItem<Dokter>>((Dokter value) {
                return DropdownMenuItem<Dokter>(
                    value: value, child: Text(value.nama));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDokter = value!;
                });
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        });
  }

  Widget _textTanggalBook() {
    return TextFormField(
      keyboardType: TextInputType.datetime,
      controller: _tglBookCont,
      decoration: const InputDecoration(
        icon: Icon(Icons.date_range),
        hintText: 'Tanggal Booking Registrasi',
      ),
      onTap: () async {
        DateTime now = new DateTime.now();
        final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: now,
            firstDate: DateTime(2015, 8),
            lastDate: DateTime(2101));
        if (picked != null && picked != now)
          setState(() {
            now = picked;
            _tglBookCont.text = "${now.year}-${now.month}-${now.day}";
          });
      },
      onSaved: (newValue) {
        setState(() {});
      },
    );
  }

  Widget _dropPoli() {
    return DropdownButtonFormField(
      hint: Text("Pilih Poli"),
      items: polis.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedPoli = value!;
        });
      },
    );
  }
}
