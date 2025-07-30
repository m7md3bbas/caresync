import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String headline;
  final IconData icon;

  const CustomListTile({super.key, required this.headline, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              headline,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
