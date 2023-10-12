// import 'package:flutter/material.dart';

// class DropDownRuangan extends StatefulWidget {
//   const DropDownRuangan({super.key});

//   @override
//   State<DropDownRuangan> createState() => _DropDownRuanganState();
// }

// class _DropDownRuanganState extends State<DropDownRuangan> {
//   String dropdownValue = "One";
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: DropdownButton<String>(
//         value: dropdownValue,
//         icon: const Icon(Icons.menu),
//         style: const TextStyle(color: Colors.black),
//         underline: Container(
//           height: 2,
//           color: Colors.black,
//         ),
//         onChanged: (String? newValue) {
//           setState(() {
//             dropdownValue = newValue!;
//           });
//         },
//         items: const [
//           DropdownMenuItem<String>(
//             value: 'One',
//             child: Text('One'),
//           ),
//           DropdownMenuItem<String>(
//             value: 'Two',
//             child: Text('Two'),
//           ),
//           DropdownMenuItem<String>(
//             value: 'Three',
//             child: Text('Three'),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class DropDownRuangan extends StatefulWidget {
  const DropDownRuangan({super.key});

  @override
  State<DropDownRuangan> createState() => _DropDownRuanganState();
}

class _DropDownRuanganState extends State<DropDownRuangan> {
  String valueChoose = "Ruang 1";

  List listItem = [
    "Ruang 1",
    "Ruang 2",
    "Ruang 3",
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: DropdownButton(
          hint: Text('Select Items :'),
          dropdownColor: Colors.white,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 36,
          isExpanded: true,
          underline: SizedBox(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
          value: valueChoose,
          onChanged: (newValue) {
            setState(() {
              valueChoose = newValue.toString();
            });
          },
          items: listItem.map((valueItem) {
            return DropdownMenuItem(
              value: valueItem,
              child: Text(valueItem),
            );
          }).toList(),
        ),
      ),
    );
  }
}
