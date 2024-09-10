import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final double width;
  final double height;
  final Color warna;
  final String text;
  const MyButton(
      {super.key,
      required this.text,
      required this.width,
      required this.height,
      required this.warna});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration:
          BoxDecoration(color: warna, borderRadius: BorderRadius.circular(15)),
      child: LayoutBuilder(
        builder: (context, p1) => Center(
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: p1.maxHeight * 0.3),
          ),
        ),
      ),
    );
  }
}
