import 'package:flutter/material.dart';

class Perizinan extends StatefulWidget {
  const Perizinan({super.key});

  @override
  State<Perizinan> createState() => _PerizinanState();
}

class _PerizinanState extends State<Perizinan> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('ini halaman perizinan')),
    );
  }
}