import 'package:flutter/material.dart';

class CustomContainer extends StatefulWidget {
  final Color warna;
  const CustomContainer({super.key, required this.warna});

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3))
        ], borderRadius: BorderRadius.circular(10), color: widget.warna),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: Container(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
