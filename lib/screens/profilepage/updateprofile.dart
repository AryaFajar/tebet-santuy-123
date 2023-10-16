import 'dart:convert';
import 'package:appcatering/screens/profilepage/account.dart';
import 'package:flutter/material.dart';
import 'package:appcatering/networks/api.dart';
import 'package:appcatering/widget/input_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  final int userId;
  final Function onProfileUpdated;

  EditProfile({Key? key, required this.userId, required this.onProfileUpdated})
      : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void updateProfile() async {
    final data = {
      'name': nameController.text.toString(),
      'password': passwordController.text,
      // Tambahkan properti lain yang ingin diubah
    };

    final result = await API().postRequest(
      route: '/customer/update${widget.userId}',
      data: data,
    );
    final response = jsonDecode(result.body);
    print(jsonDecode(result.body));

    if (response != null &&
        response['success'] == "Data berhasil diperbarui.") {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString(
          'name', nameController.text.toString()); // Update nama pengguna
      // Anda dapat menambahkan kode untuk mengupdate properti lain jika diperlukan.

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['success']),
        ),
      );

      widget.onProfileUpdated();
      // Kembali ke halaman sebelumnya (biasanya halaman account.dart)
      Navigator.pop(context);
    } else {
      // Handle jika respon tidak sesuai dengan pesan kesuksesan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memperbarui data.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputField(
              controller: nameController,
              hintText: 'Nama Baru',
            ),
            InputField(
              controller: passwordController,
              hintText: 'Kata Sandi Baru',
              isObscure: true,
            ),
            // Tambahkan input field dan widget lain sesuai kebutuhan
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                updateProfile();
              },
              child: Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}
