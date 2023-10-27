import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:appcatering/homepage.dart';
import 'package:flutter/material.dart';

class SuccessAnimationPage extends StatelessWidget {
  final int totalHarga;
  final int updatedBalance;

  SuccessAnimationPage(
      {required this.totalHarga, required this.updatedBalance, super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Animated success checkmark icon
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100.0,
            ),
            SizedBox(height: 20.0),
            // Animated text
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText('Success!',
                      speed: Duration(milliseconds: 150)),
                ],

                isRepeatingAnimation: true,
                // Stops after one animation
              ),
            ),
            SizedBox(height: 20.0),

            Text(
              'Total Harga: \P$totalHarga',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 24.0),
            Text(
              'Saldo Anda Sekarang: \P$updatedBalance',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  )),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)))),
              child: Text(
                'Kembali ke Halaman Home',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
