import 'package:flutter/material.dart';

Widget exclusiveProduct({imagePath, discount, productName, price}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    width: 150,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.asset(imagePath, fit: BoxFit.cover, width: 150, height: 180,),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                color: Colors.green,
                child: Text(discount, style: const TextStyle(color: Colors.white, fontSize: 12),),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(productName, style: const TextStyle(fontSize: 16)),
        Text(price, style: const TextStyle(fontSize: 14, color: Colors.red)),
      ],
    ),
  );
}