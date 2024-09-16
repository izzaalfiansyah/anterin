import 'package:anterin/blocs/auth.dart';
import 'package:anterin/components/bottom_nav_bar.dart';
import 'package:anterin/components/hr.dart';
import 'package:anterin/constants/app.dart';
import 'package:anterin/models/user.dart';
import 'package:anterin/utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SayaScreen extends StatefulWidget {
  const SayaScreen({super.key});

  @override
  State<SayaScreen> createState() => _SayaScreenState();
}

class _SayaScreenState extends State<SayaScreen> {
  User user = User(name: '', email: '', phone: '');

  @override
  void initState() {
    setState(() {
      user = BlocProvider.of<AuthBloc>(context).state.user!;
    });
    super.initState();
  }

  handleLogout(BuildContext context) {
    showConfirmModal(
      context,
      child: Text('Anda yakin akan keluar? Sesi anda akan terhapus!'),
      onConfirmed: () async {
        await BlocProvider.of<AuthBloc>(context).logout();
      },
    );
  }

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
                          user.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          user.email,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: shadowSm,
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.grey,
                    ),
                    title: Text('Manajemen Profil'),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: cPrimary,
                    ),
                  ),
                  Hr(color: Colors.grey.shade100),
                  ListTile(
                    leading: Icon(
                      Icons.shopping_bag,
                      color: Colors.grey,
                    ),
                    title: Text('Pesanan Saya'),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: cPrimary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: shadowSm,
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text('Logout'),
                    leading: Icon(
                      Icons.logout,
                      color: Colors.grey,
                    ),
                    onTap: () => handleLogout(context),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
