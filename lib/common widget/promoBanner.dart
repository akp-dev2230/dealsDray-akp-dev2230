import 'package:flutter/material.dart';

Widget promoBanner({imagePath, onTap}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    width: 300,
    child: InkWell(
      onTap: onTap,
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    ),
  );
}