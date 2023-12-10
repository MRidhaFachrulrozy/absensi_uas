import 'package:absensi_uas/screen/auth/registerscreen.dart';
import 'package:absensi_uas/screen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  String username = 'admin';
  String Password = 'admin';
  bool flslogin = false;

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    print(username);
    // TODO: implement initState
    super.initState();
  }

  void login() {
    if (_username.text == username && _password.text == Password) {
      Get.off(() => const HomePage());
    } else {
      setState(() {
        flslogin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                padding: EdgeInsets.all(40),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green[200]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    flslogin == false
                        ? Container()
                        : Text(
                            "username atau password anda salah",
                            style: TextStyle(fontSize: 10, color: Colors.red),
                          ),
                    TextField(
                      decoration: InputDecoration(label: Text('Username')),
                      controller: _username,
                    ),
                    TextField(
                      controller: _password,
                      decoration: InputDecoration(label: Text('Password')),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        login();
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue),
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text('belum punya akun?'),
                            TextButton(onPressed: () {
                              Get.to(()=>RegisterScreen());
                            }, child: Text('Register'))
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
