import 'package:appcatering/auth/chooseauth.dart';
import 'package:appcatering/auth/login_screen.dart';
import 'package:appcatering/homepage.dart';
import 'package:appcatering/hometest.dart';
import 'package:appcatering/screens/orderpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final token = snapshot.data!.getString('token');
            if (token != null) {
              return HomePage();
            } else {
              return Login();
            }
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }
}
