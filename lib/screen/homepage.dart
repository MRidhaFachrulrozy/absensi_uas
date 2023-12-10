import 'dart:io';

import 'package:absensi_uas/componets/custommenu1.dart';
import 'package:absensi_uas/screen/absenKeluar/absenKeluar.dart';
import 'package:absensi_uas/screen/absenMasuk/absenMasuk.dart';
import 'package:absensi_uas/screen/daftarAbsen/daftarAbsen.dart';
import 'package:absensi_uas/screen/perizinan/perizinan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              exit(0);
            },
            icon: const Icon(
              Icons.exit_to_app,
              size: 30,
            ))
      ]),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
              child: Column(
                children: [
                  Text(
                    'Aplikasi Absensi',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Absensi membutuhkan info lokasi dan hanya bisa dilakukan  jika kamu foto selfie',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            CustomMenu(
              namamenu: 'ABSEN MASUK',
              warna: Colors.green,
              tujuan: () {
                Get.to(const AbsenMasuk());
              },
            ),
            CustomMenu(
              namamenu: 'ABSEN KELUAR',
              warna: Colors.red,
              tujuan: () {
                Get.to(const AbsenKeluar());
              },
            ),
            CustomMenu(
              namamenu: 'PERIZINAN',
              warna: Colors.blue,
              tujuan: () {
                Get.to(const Perizinan());
              },
            ),
            CustomMenu(
              namamenu: 'DAFTAR ABSEN',
              warna: Colors.orange,
              tujuan: () {
                Get.to(const DaftarAbsen());
              },
            ),
          ],
        )),
      ),
    );
  }
}
