import 'package:appcatering/shopping_cart/cart.dart';
import 'package:flutter/material.dart';

class bottomOrderpage extends StatelessWidget {
  const bottomOrderpage({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.attach_money),
                Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "0K",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (context) => const UserCart()),
                // );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                minimumSize: MaterialStateProperty.all(
                    Size(200, 50)), // Adjust the size as needed
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      25.0), // Adjust the borderRadius to make it oval
                )),
              ),
              child: Text(
                "Pesan",
                style: TextStyle(fontSize: 18, color: Colors.black),
                // Adjust the text size as needed
              ),
            )
          ],
        ),
      ),
    );
  }
}
