import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class CustomMenu extends StatefulWidget {
  final String namamenu;
  final Color warna;
  final VoidCallback tujuan;
  const CustomMenu(
      {super.key,
      required this.namamenu,
      required this.warna,
      required this.tujuan});

  @override
  State<CustomMenu> createState() => _CustomMenuState();
}

class _CustomMenuState extends State<CustomMenu> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.tujuan,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        height: MediaQuery.of(context).size.height / 8,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(10, 30, 50, 30),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [widget.warna, Colors.white],
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.namamenu,
            style: const TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
