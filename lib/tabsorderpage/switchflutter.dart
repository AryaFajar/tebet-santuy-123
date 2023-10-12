import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

// class Arya extends StatefulWidget {
//   const Arya({super.key});

//   @override
//   State<Arya> createState() => _AryaState();
// }

// class _AryaState extends State<Arya> {
//   bool status = false;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       // Menggunakan InkWell sebagai parent
//       onTap: () {
//         // Tambahkan aksi ketika ListTile diklik (jika diperlukan)
//       },
//       child: ListTile(
//         title: Text("Judul List Tile"),
//         trailing: FlutterSwitch(
//           width: 100.0,
//           height: 55.0,
//           toggleSize: 45.0,
//           value: status,
//           borderRadius: 30.0,
//           padding: 2.0,
//           activeToggleColor: Color(0xFF0082C8),
//           inactiveToggleColor: Color(0xFF01579B),
//           activeSwitchBorder: Border.all(
//             color: Color(0xFF00D2B8),
//             width: 6.0,
//           ),
//           inactiveSwitchBorder: Border.all(
//             color: Color(0xFF29B6F6),
//             width: 6.0,
//           ),
//           activeColor: Color(0xFF55DDCA),
//           inactiveColor: Color(0xFF54C5F8),
//           activeIcon: Image.network(
//             "https://jkt48.com/profile/shani_indira_natio.jpg?v=20230116",
//           ),
//           inactiveIcon: Image.network(
//             "https://jkt48.com/profile/shani_indira_natio.jpg?v=20230116",
//           ),
//           onToggle: (val) {
//             setState(() {
//               status = val;
//             });
//           },
//         ),
//       ),
//     );
//   }
// }

class Arya extends StatefulWidget {
  const Arya({super.key});
  @override
  _AryaState createState() => _AryaState();
}

class _AryaState extends State<Arya> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: 125.0,
      height: 55.0,
      valueFontSize: 25.0,
      toggleSize: 45.0,
      value: status,
      borderRadius: 30.0,
      padding: 8.0,
      showOnOff: true,
      onToggle: (val) {
        setState(() {
          status = val;
        });
      },
    );
  }
}
