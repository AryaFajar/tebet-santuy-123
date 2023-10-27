import 'package:flutter/material.dart';

class HelpSupport extends StatelessWidget {
  const HelpSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BANTUAN DAN DUKUNGAN",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "BANTUAN",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              thickness: 2.0,
              color: Colors.black,
              height: 30.0,
            ),
            Text(
              "Selamat datang di aplikasi catering kami!",
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              "Panduan Penggunaan Aplikasi:",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "1. Unduh aplikasi dari Play Store atau App Store.",
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              "2. Daftar atau masuk dengan akun Anda.",
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              "3. Jelajahi menu kami dan pilih makanan yang Anda suka.",
              style: TextStyle(fontSize: 16.0),
            ),
            // Tambahkan panduan penggunaan aplikasi lainnya di sini

            SizedBox(height: 16.0),

            Text(
              "Kontak Dukungan Pelanggan:",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Jika Anda memiliki pertanyaan atau masalah, silakan hubungi tim dukungan pelanggan kami.",
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              "Email: support@example.com",
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              "Telepon: +1234567890",
              style: TextStyle(fontSize: 16.0),
            ),

            SizedBox(height: 16.0),

            Text(
              "Pertanyaan Umum:",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "1. Bagaimana cara memesan makanan?",
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              "2. Berapa lama waktu pengiriman?",
              style: TextStyle(fontSize: 16.0),
            ),
            // Tambahkan pertanyaan umum lainnya di sini

            SizedBox(height: 16.0),

            Text(
              "Tentang Kami:",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Kami adalah perusahaan catering yang berkomitmen untuk menyajikan makanan berkualitas tinggi kepada pelanggan kami.",
              style: TextStyle(fontSize: 16.0),
            ),

            SizedBox(height: 16.0),

            Center(
              child: Text(
                "Copyright © 2023 Catering App",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
