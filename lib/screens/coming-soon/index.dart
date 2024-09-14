import 'package:anterin/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Coming Soon...',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 20,
              width: double.infinity,
            ),
            Text(
              'Platform anterin masih dalam pengembangan nih.\nSupport terus yaa!',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                Modular.to.popUntil((route) => route.isFirst);
              },
              style: FilledButton.styleFrom(
                backgroundColor: cPrimary,
              ),
              child: Text('Kembali ke Beranda'.toUpperCase()),
            ),
          ],
        ),
      ),
    );
  }
}
