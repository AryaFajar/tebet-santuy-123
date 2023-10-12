import 'package:appcatering/rounded_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';

  loginPressed(){
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Login',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Masukkan Email Anda',
              ),
              onChanged: (value) {
                _email = value;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Masukkan Password Anda',
              ),
              onChanged: (value) {
                _password = value;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            RoundedButton(btnText: 'LOG IN', onBtnPressed: ()=>loginPressed(), )
          ]
          ),
      ),
    );
  }
}
