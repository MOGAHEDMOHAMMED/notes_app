import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final String pagetitle;
  const MyAppBar({super.key, required this.pagetitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        pagetitle,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
