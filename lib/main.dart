import 'package:anterin/constant.dart';
import 'package:anterin/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anterin',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade50,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: cPrimary,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 18,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey,
          selectedItemColor: cPrimary,
          selectedLabelStyle: TextStyle(
            fontSize: 13.5,
          ),
        ),
        useMaterial3: true,
        colorSchemeSeed: cPrimary,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: routes,
    );
  }
}
