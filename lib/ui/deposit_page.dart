import 'package:dapps/ui/widgets/button.dart';
import 'package:flutter/material.dart';

class DebitPage extends StatelessWidget {
  const DebitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Deposit",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: "enter address"),
            ),
            TextField(
              decoration: InputDecoration(hintText: "enter amount"),
            ),
            TextField(
              decoration: InputDecoration(hintText: "enter reason"),
            ),
            SizedBox(
              height: 20,
            ),
            MyButton(
                text: "Deposit",
                width: MediaQuery.sizeOf(context).width,
                height: 50,
                warna: Colors.greenAccent)
          ],
        ),
      ),
    );
  }
}
