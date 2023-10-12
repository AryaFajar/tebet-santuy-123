import 'package:flutter/material.dart';

class TopUp extends StatelessWidget {
  const TopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TOP UP'),
      ),
      body: Center(
        child: Text('Ini adalah halaman TOP UP'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TopUp(),
  ));
}