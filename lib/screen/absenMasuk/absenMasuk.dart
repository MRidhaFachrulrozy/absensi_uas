import 'dart:async';
import 'dart:io';

import 'package:absensi_uas/componets/customcontainer.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import '../../network/network.dart';
import 'package:http/http.dart' as http;

class AbsenMasuk extends StatefulWidget {
  const AbsenMasuk({Key? key}) : super(key: key);

  @override
  State<AbsenMasuk> createState() => _AbsenMasukState();
}

class _AbsenMasukState extends State<AbsenMasuk> {
  late CameraController camController;
  late List<CameraDescription> _cameras = [];
  XFile? capturedImage;
  final TextEditingController _namamhs = TextEditingController();
  final TextEditingController _nimmhs = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = '${picked.toLocal()}'.split(' ')[0];
      });
    }
  }

  void loading(Widget widget) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(content: widget);
        });
  }

  void absenkan() async {
    var req = await http.MultipartRequest(
        "POST", Uri.parse(networkUrl().absenmasuk()));
    req.fields['nama'] = _namamhs.text;
    req.fields['nim'] = _nimmhs.text;
    req.fields['tanggal'] = _dateController.text;
    req.fields['jam'] = _timeController.text;
    req.fields['statusKehadiran'] = "Masuk";
    if (capturedImage == null) {
    } else {
      var foto = await http.MultipartFile.fromPath('foto', capturedImage!.path);
      req.files.add(foto);
    }
    try {
      // ignore: unused_local_variable
      var res = await req.send();
      Navigator.of(context).pop();
      loading(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
        Icon(Icons.check_circle,size: 20,),
        Text(
          'Berhasil Absen',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )
      ]));
      Timer(Duration(seconds: 2), () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });
      // var respon = await res.stream.bytesToString();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCamera();
    getTime(context);
  }

  void getTime(BuildContext context) {
    DateTime timenow = DateTime.now();

    String waktu = "${timenow.hour}:${timenow.minute}";
    _timeController.text = waktu;
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    setState(() {});
  }

  Future<void> getCamera() async {
    var camStatus = await Permission.camera.status;
    if (camStatus.isDenied) {
      await Permission.camera.request();
    }

    _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      camController = CameraController(_cameras[1], ResolutionPreset.max);
      await camController.initialize();
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _namamhs.dispose();
    _nimmhs.dispose();
    _dateController.dispose();
    _timeController.dispose();
    camController.dispose();
    super.dispose();
  }

  Future<void> captureImage() async {
    try {
      XFile capturedFile = await camController.takePicture();
      if (mounted) {
        setState(() {
          capturedImage = capturedFile;
        });
      }
    } catch (e) {
      print("Error capturing image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Center(
        child: Stack(
          children: [
            const CustomContainer(
              warna: Colors.blue,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.person_2,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Absen Masuk',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_cameras.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CameraScreen(camController, captureImage),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.5))),
                      child: capturedImage != null
                          ? Image.file(
                              File(capturedImage!.path),
                              fit: BoxFit.cover,
                            )
                          : const Icon(
                              Icons.camera_alt,
                              size: 70,
                              color: Colors.grey,
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextField(
                      controller: _namamhs,
                      decoration: InputDecoration(label: Text('Nama')),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextField(
                      controller: _nimmhs,
                      decoration: InputDecoration(label: Text('NIM')),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                          child: TextField(
                            controller: _dateController,
                            onTap: () => _selectDate(context),
                            readOnly: true,
                            decoration:
                                const InputDecoration(label: Text('tanggal')),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                        child: TextField(
                          decoration: InputDecoration(label: Text('Waktu')),
                          controller: _timeController,
                        ),
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton.icon(
                          onPressed: () {
                            loading(const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [CircularProgressIndicator()],
                            ));
                            absenkan();
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          )))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CameraScreen extends StatelessWidget {
  final CameraController cameraController;
  final Function captureImage;

  CameraScreen(this.cameraController, this.captureImage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CameraPreview(cameraController),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.camera_alt),
        onPressed: () {
          captureImage();
          Timer(Duration(seconds: 1), () {
            Navigator.of(context).pop();
          });
        },
      ),
    );
  }
}
