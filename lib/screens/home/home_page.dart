import 'package:appcatering/screens/home/widgets/body.dart';
import 'package:appcatering/shopping_cart/widgets/body.dart';
import 'package:appcatering/themes/app_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePengguna(),
  ));
}

class HomePengguna extends StatelessWidget {
  const HomePengguna({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.light,
      body: BodyPengguna(),
    );
  }
}
