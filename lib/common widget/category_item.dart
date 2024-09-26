import 'package:flutter/material.dart';

Widget categoryItem({label, icon, onTap}) {
  return Column(
    children: [
      InkWell(
        onTap: onTap,
        child: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[200],
          child: Icon(icon, size: 30, color: Colors.black),
        ),
      ),
      const SizedBox(height: 5),
      Text(label),
    ],
  );
}