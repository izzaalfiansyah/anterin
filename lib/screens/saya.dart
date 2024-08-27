import 'package:anterin/components/bottom_nav_bar.dart';
import 'package:anterin/constant.dart';
import 'package:flutter/material.dart';

class SayaScreen extends StatefulWidget {
  const SayaScreen({super.key});

  @override
  State<SayaScreen> createState() => _SayaScreenState();
}

class _SayaScreenState extends State<SayaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              // height: 200,
              width: double.infinity,
              color: cPrimary,
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 80,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Muhammad Izza Alfiansyah',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          'izzaalfiansyah7@gmail.com',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
