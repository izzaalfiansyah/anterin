import 'package:anterin/components/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Anterin'.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        leading: SizedBox(),
        leadingWidth: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: Text('home page'),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
