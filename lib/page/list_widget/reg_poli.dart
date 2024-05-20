import 'package:flutter/material.dart';
import 'package:good_health/model/reg_poli.dart';
import 'package:good_health/util/util.dart';

class RegisPoliList extends StatefulWidget {
  final List<RegisPoli> regisPolis;
  RegisPoliList({required this.regisPolis});

  @override
  _RegisPoliListState createState() => _RegisPoliListState();
}

class _RegisPoliListState extends State<RegisPoliList> {
  @override
  Widget build(BuildContext context) {
    return (widget.regisPolis.length != 0)
        ? ListView.builder(
            itemCount:
                // ignore: unnecessary_null_comparison
                (widget.regisPolis == null ? 0 : widget.regisPolis.length),
            itemBuilder: (context, i) {
              return Container(
                child: GestureDetector(
                  onTap: null,
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.assignment),
                          isThreeLine: true,
                          title: Text("${widget.regisPolis[i].idDokter.nama}"),
                          subtitle: Text("${widget.regisPolis[i].tglBooking}"),
                          trailing: Text("${widget.regisPolis[i].poli}"),
                        ),
                        ButtonBar(
                          children: <Widget>[
                            TextButton(
                                onPressed: () async {
                                  final result = await deleteRegisPoli(
                                      widget.regisPolis[i].idRegisPoli);
                                  dialog(context, result);
                                  setState(() {
                                    widget.regisPolis.removeAt(i);
                                  });
                                },
                                child: Text('HAPUS'))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            })
        : Text('Tidak ada riwayat registrasi');
  }
}
