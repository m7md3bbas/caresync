import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String headline;
  final IconData icon;

  const CustomListTile({
    super.key,
    this.ontap,
    required this.headline,
    required this.icon,
  });
  final VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTileTheme(
        child: ListTile(
          onTap: ontap,
          leading: Icon(icon),
          title: Text(
            headline.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
