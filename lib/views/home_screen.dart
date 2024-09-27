import 'package:dealsdray/auth/registration.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:dealsdray/common widget/promoBanner.dart';
import 'package:dealsdray/common widget/category_item.dart';
import 'package:dealsdray/common widget/exclusiveProduct.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            // menu action
          },
        ),
        title: SizedBox(
          height: context.screenHeight*0.08,
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search here",
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey[200],
              filled: true,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // notification action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Horizontal Banner Section
              SizedBox(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    promoBanner(imagePath: 'assets/images/shoes.jpeg', onTap: (){}),
                    promoBanner(imagePath: 'assets/images/cosmetics.jpeg', onTap: (){}),
                    promoBanner(imagePath: 'assets/images/perfume.jpeg', onTap: (){}),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // KYC Pending Section
              Container(
                color: Colors.blue[100],
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "KYC Pending",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "You need to provide the required documents for your account activation.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 5),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Registration()));
                      },
                      child: const Text(
                        "Click Here",
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Categories Section
              const Text(
                "Categories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  categoryItem(label: 'Mobile', icon: Icons.phone_android, onTap: (){}),
                  categoryItem(label: 'Laptop', icon: Icons.laptop, onTap: (){}),
                  categoryItem(label: 'Camera', icon: Icons.camera_alt, onTap: (){}),
                  categoryItem(label: 'LED', icon: Icons.tv, onTap: (){}),
                ],
              ),
              const SizedBox(height: 20),

              // Exclusive For You Section
              Container(
                color: Colors.blue.shade100,
                height: context.screenHeight*0.40,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Exclusive For You",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: context.screenHeight*0.30,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            exclusiveProduct(
                              imagePath: 'assets/images/oneplus.jpeg',
                              discount: '32% off',
                              productName: 'One Plus Nord CE2',
                              price: '₹15,000.00',
                            ),
                            exclusiveProduct(
                              imagePath: 'assets/images/samsung.jpeg',
                              discount: '14% Off',
                              productName: 'Samsung S23',
                              price: '₹45,000.00',
                            ),
                            exclusiveProduct(
                              imagePath: 'assets/images/Nothing.jpeg',
                              discount: '42% Off',
                              productName: 'Nothing Phone 2',
                              price: '₹30,000.00',
                            ),
                            exclusiveProduct(
                              imagePath: 'assets/images/Redmi.jpeg',
                              discount: '12% off',
                              productName: 'Redmi 12 Pro',
                              price: '₹15,000.00',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      // Chat Button at bottom right
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Handle chat action
        },
        label: const Text("Chat"),
        icon: const Icon(Icons.message_rounded),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
