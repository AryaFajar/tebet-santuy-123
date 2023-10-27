// import 'package:appcatering/screens/orderpage.dart';
// import 'package:flutter/material.dart';
// import 'package:date_picker_timeline/date_picker_widget.dart';

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: UserHome(),
//   ));
// }

// class UserHome extends StatefulWidget {
//   const UserHome({Key? key});

//   @override
//   State<UserHome> createState() => _UserHomeState();
// }

// class _UserHomeState extends State<UserHome> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(top: 40.0, left: 16, right: 16),
//             child: Container(
//               height: 100,
//               child: Stack(
//                 alignment: Alignment.centerLeft,
//                 children: [
//                   Positioned(
//                     left: 0,
//                     child: Text(
//                       'Pilih Paket\nMakananmu!',
//                       style: TextStyle(
//                         fontSize: 36,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     right: 0,
//                     top: 0,
//                     child: IconButton(
//                       icon: Icon(
//                         Icons.notifications,
//                         color: Colors.black,
//                       ),
//                       onPressed: () {},
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: DatePicker(
//               DateTime.now(),
//               height: 100,
//               width: 80,
//               initialSelectedDate: DateTime.now(),
//               selectionColor: Colors.black,
//               selectedTextColor: Colors.white,
//               dateTextStyle: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   FoodCategoryHeader(
//                     title: "Snack Pagi",
//                     icon: Icons.wb_sunny,
//                     iconColor: Colors.orange,
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                     height: 250,
//                     child: GridView.count(
//                       crossAxisCount: 2,
//                       childAspectRatio: 2 / 2,
//                       children: [
//                         FoodCard(
//                           imageUrl: 'https://via.placeholder.com/150',
//                           foodName: 'Snack 1',
//                           price: 5.99,
//                         ),
//                         FoodCard(
//                           imageUrl: 'https://via.placeholder.com/150',
//                           foodName: 'Snack 2',
//                           price: 6.49,
//                         ),
//                         FoodCard(
//                           imageUrl: 'https://via.placeholder.com/150',
//                           foodName: 'Snack 3',
//                           price: 6.49,
//                         ),
//                       ],
//                     ),
//                   ),
//                   FoodCategoryHeader(
//                       title: "Makan Siang",
//                       icon: Icons.restaurant_menu,
//                       iconColor: Colors.red),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                     height: 250,
//                     child: GridView.count(
//                       crossAxisCount: 2,
//                       childAspectRatio: 2 / 2,
//                       children: [
//                         FoodCard(
//                           imageUrl:
//                               'https://cdn1-production-images-kly.akamaized.net/EjwV7j3Y4JrlqUFuavke4NtRWtM=/1200x675/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/3108566/original/079979700_1587487794-Sajiku_1.jpg',
//                           foodName: 'Nasi Goreng',
//                           price: 10,
//                         ),
//                         FoodCard(
//                           imageUrl:
//                               'https://cdn1-production-images-kly.akamaized.net/EjwV7j3Y4JrlqUFuavke4NtRWtM=/1200x675/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/3108566/original/079979700_1587487794-Sajiku_1.jpg',
//                           foodName: 'Nasi Goreng 2',
//                           price: 6.49,
//                         ),
//                         FoodCard(
//                           imageUrl:
//                               'https://cdn1-production-images-kly.akamaized.net/EjwV7j3Y4JrlqUFuavke4NtRWtM=/1200x675/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/3108566/original/079979700_1587487794-Sajiku_1.jpg',
//                           foodName: 'Nasi Goreng 3',
//                           price: 6.49,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FoodCategoryHeader extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final Color iconColor;

//   FoodCategoryHeader(
//       {required this.title, required this.icon, required this.iconColor});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//       child: Row(
//         children: [
//           Icon(icon, color: iconColor, size: 36),
//           SizedBox(width: 16),
//           Text(
//             title,
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FoodCard extends StatelessWidget {
//   final String imageUrl;
//   final String foodName;
//   final double price;

//   FoodCard({
//     required this.imageUrl,
//     required this.foodName,
//     required this.price,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       child: InkWell(
//         onTap: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => OrderPage(),
//             ),
//           );
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 100.0,
//               width: 170.0,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.vertical(
//                   top: Radius.circular(12.0),
//                 ),
//                 child: Image.network(
//                   imageUrl,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(foodName, style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text('\$${price.toStringAsFixed(2)}'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
