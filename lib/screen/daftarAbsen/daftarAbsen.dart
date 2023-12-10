import 'dart:convert';

import 'package:absensi_uas/model/absen.dart';
import 'package:absensi_uas/network/network.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DaftarAbsen extends StatefulWidget {
  const DaftarAbsen({super.key});

  @override
  State<DaftarAbsen> createState() => _DaftarAbsenState();
}

class _DaftarAbsenState extends State<DaftarAbsen> {
  late List<Absensi> getdata = [];
  Future getAbsen() async {
    try {
      var res = await http.get(Uri.parse(networkUrl().getabsen()));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body) as List<dynamic>;

        print('terhubung');
        print(data);
        setState(() {
          getdata.clear();
          for (Map i in data) {
            getdata.add(Absensi.fromJson(i as Map<String, dynamic>));
          }
        });
        print(getdata[0].nama);
        return getdata;
      } else {
        print('gagal terhubung');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    getAbsen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
            future: getAbsen(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                    DataColumn(label: Text('nama')),
                    // DataColumn(label: Text('nim')),
                    DataColumn(label: Text('tanggal')),
                    // DataColumn(label: Text('jam')),
                    DataColumn(label: Text('status Kehadiran')),
                  ], rows:
                  List.generate(getdata.length, (i) => DataRow(cells: [
                    DataCell(Text('${getdata[i].nama}')),
                    // DataCell(Text('${getdata[i].nim}')),
                    DataCell(Text('${getdata[i].tanggal}')),
                    // DataCell(Text('${getdata[i].jam}')),
                    DataCell(Text('${getdata[i].statusKehadiran}')),
                  ]))
                  ),
                );
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
            ));
  }
}
