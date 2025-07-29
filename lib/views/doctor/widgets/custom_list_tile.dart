import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String headline;
  final String text;
  final IconData icon;

  const CustomListTile({
    super.key,
    required this.headline,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Text(headline, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 2),
          Text(text),
        ],
      ),
      leading: Icon(icon, color: Colors.blue),
    );
  }
}
