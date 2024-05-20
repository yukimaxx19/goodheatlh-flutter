import 'package:flutter/material.dart';
import 'package:good_health/model/pesan_obat.dart';
import 'package:good_health/util/util.dart';


class PesanObatList extends StatefulWidget {
  final List<PesanObat> pesanObats;
  PesanObatList({required this.pesanObats});
  
  get _widget => null;

  @override
  _PesanObatListState createState() => _PesanObatListState();
}

class _PesanObatListState extends State<PesanObatList> {
  @override
  Widget build(BuildContext context) {
    return (widget.pesanObats.length != 0)
        ? ListView.builder(
            itemCount:
                // ignore: unnecessary_null_comparison
                (widget.pesanObats == null ? 0 : widget.pesanObats.length),
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
                          leading: Icon(Icons.local_hospital),
                          isThreeLine: true,
                          //title: Text("${widget.pesanObats[i].waktu}"),
                          subtitle: Text(
                              "${widget.pesanObats[i].listPesanan} \n${widget.pesanObats[i].alamat} \n${widget.pesanObats[i].ket}"),
                          /*trailing: Text(toRupiah(
                              int.parse(widget.pesanObats[i].totalBiaya))),*/
                        ),
                        ButtonBar(
                          children: <Widget>[
                            Visibility(
                              //visible: !widget._widget[i].isSelesai,
                              child: TextButton(
                                  onPressed: () async {
                                    final result = await deletePesanObat(
                                        widget.pesanObats[i].idPesanObat);
                                    dialog(context, result);
                                    setState(() {
                                      widget.pesanObats.removeAt(i);
                                    });
                                  },
                                  child: Text('HAPUS')),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            })
        : Text('Tidak ada riwayat pesanan');
  }
}
