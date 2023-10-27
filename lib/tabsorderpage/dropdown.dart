import 'package:appcatering/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Ruangan {
  final int id;
  final String namaRuangan;

  Ruangan({
    required this.id,
    required this.namaRuangan,
  });
}

class DropDownRuangan extends StatefulWidget {
  final Function(Ruangan) onRoomSelected;
  const DropDownRuangan({
    Key? key,
    required this.onRoomSelected,
  }) : super(key: key);

  @override
  _DropDownRuanganState createState() => _DropDownRuanganState();
}

class _DropDownRuanganState extends State<DropDownRuangan> {
  Ruangan? valueChoose;
  List<Ruangan> listItem = [];
  Map<int, Ruangan> ruanganIdMap = {};

  @override
  void initState() {
    super.initState();
    fetchRuangan().then((ruangans) {
      if (mounted) {
        setState(() {
          listItem = ruangans;
          listItem.forEach((ruangan) {
            ruanganIdMap[ruangan.id] = ruangan;
          });
          valueChoose = listItem.first;
        });
      }
    });
  }

  void printSelectedRuanganId(Ruangan selectedRuangan) {
    final ruanganId = selectedRuangan.id;
    print('ID Ruangan yang dipilih: $ruanganId');
    widget.onRoomSelected(selectedRuangan);
  }

  Future<List<Ruangan>> fetchRuangan() async {
    final response = await http.get(Uri.parse('$apiUrl/ruang'));

    if (response.statusCode == 200) {
      final List<dynamic> ruangData = json.decode(response.body)['ruang'];
      return ruangData
          .map((ruang) => Ruangan(
                id: ruang['id'],
                namaRuangan: ruang['nama_ruang'].toString(),
              ))
          .toList();
    } else {
      throw Exception('Gagal mengambil data ruangan');
    }
  }

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
          hint: Text('Select Ruangan:'),
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
              valueChoose = newValue as Ruangan;
              printSelectedRuanganId(valueChoose!);
            });
          },
          items: listItem.map((valueItem) {
            return DropdownMenuItem(
              value: valueItem,
              child: Text(valueItem.namaRuangan),
            );
          }).toList(),
        ),
      ),
    );
  }
}
