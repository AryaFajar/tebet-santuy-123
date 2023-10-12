import 'package:appcatering/screens/helpandsupport.dart';
import 'package:appcatering/screens/home/home_page.dart';
import 'package:appcatering/screens/topup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: const UserAccount(),
    theme: ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    ),
  ));
}

class UserAccount extends StatelessWidget {
  const UserAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PROFILE",
          style: TextStyle(
            color: Colors.black, // Change text color to black
            fontSize: 20.0, // You can adjust the font size as needed
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context); // Add navigation logic here
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Box
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://jkt48.com/profile/shani_indira_natio.jpg?v=20230116'),
                  ),
                  SizedBox(width: 16),
                  Text(
                    'JOKO ANWAR',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.monetization_on, // Use the appropriate icon
                        color: Colors.green, // Customize icon color
                        size: 30, // Adjust the icon size as needed
                      ),
                      SizedBox(
                          width: 8), // Add spacing between the icon and text
                      Text(
                        '1000 Points', // Replace with the actual user points
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TopUp()),
                      );
                    },
                    child: const Text('Top Up'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.logout, // Use the appropriate icon
                        color: Colors.black, // Customize icon color
                        size: 30, // Adjust the icon size as needed
                      ),
                      SizedBox(
                          width: 8), // Add spacing between the icon and text
                      Text(
                        'Log Out', // Replace with the actual user points
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_right,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Add navigation logic here
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Padding(
              padding: EdgeInsets.all(14.0),
              child: Row(
                children: [
                  Text(
                    "Lain nya",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons
                            .question_mark_outlined, // Use the appropriate icon
                        color: Colors.black, // Customize icon color
                        size: 30, // Adjust the icon size as needed
                      ),
                      SizedBox(
                          width: 8), // Add spacing between the icon and text
                      Text(
                        'Bantuan dan Dukungan', // Replace with the actual user points
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                      icon: const Icon(
                        Icons.arrow_right,
                        color: Colors.black,
                      ),
                      // Within the `FirstRoute` widget
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HelpSupport()),
                        );
                      }),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.info_outline, // Use the appropriate icon
                        color: Colors.black, // Customize icon color
                        size: 30, // Adjust the icon size as needed
                      ),
                      SizedBox(
                          width: 8), // Add spacing between the icon and text
                      Text(
                        'Tentang Aplikasi', // Replace with the actual user points
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_right,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Add navigation logic here
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
