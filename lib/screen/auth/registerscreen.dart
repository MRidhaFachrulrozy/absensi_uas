import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Container(
            padding: EdgeInsets.all(40),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.green[200]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Register",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                TextField(
                  decoration: InputDecoration(label: Text('Username')),
                ),
                TextField(
                  decoration: InputDecoration(label: Text('Password')),
                  obscureText: true,
                ),
                TextField(
                  decoration: InputDecoration(label: Text('Confirm Password')),
                  obscureText: true,
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue),
                    child: Text("Register",style: TextStyle(color: Colors.white,fontSize: 17),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}