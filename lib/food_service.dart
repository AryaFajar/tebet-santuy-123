// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class TestApi extends StatelessWidget {
//   const TestApi({super.key});

//   final String url = 'http://10.254.127.221:8000/api/menu';
//   Future getProducts() async {
//     var response = await http.get(Uri.parse(url));
//     print(json.decode(response.body));
//     return json.decode(response.body);
//   }

//   @override
//   Widget build(BuildContext context) {
//     getProducts();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('TEST API'),
//       ),
//       body: Container(),
//     );
//   }
// }
