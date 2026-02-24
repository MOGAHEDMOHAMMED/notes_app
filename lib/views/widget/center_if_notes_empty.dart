import 'package:flutter/material.dart';

class CenterIfNotesEmpty extends StatelessWidget {
  final IconData icon;
  final String message;
  const CenterIfNotesEmpty({
    super.key,
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 150, color: Colors.amberAccent.withOpacity(0.7)),
          const SizedBox(height: 20),
          Text(message),
        ],
      ),
    );
  }
}
