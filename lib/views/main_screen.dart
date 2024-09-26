import 'package:dealsdray/views/cart_screen.dart';
import 'package:dealsdray/views/category_screen.dart';
import 'package:dealsdray/views/deals_screen.dart';
import 'package:dealsdray/views/home_screen.dart';
import 'package:dealsdray/views/profile_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  var currentNavIndex = 0;
  var navBody = [const HomeScreen(), const CategoryScreen(), const DealsScreen(),
    const CartScreen(), const ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(child: navBody.elementAt(currentNavIndex)),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentNavIndex,
        selectedItemColor: Colors.redAccent,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories',),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Deals',),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart',),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile',),
        ],
        onTap: (value){
          setState(() {
            currentNavIndex = value;
          });
        },
      ),
    );
  }
}






