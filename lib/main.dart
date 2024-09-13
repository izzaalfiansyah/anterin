import 'package:anterin/constant.dart';
import 'package:anterin/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: MainWidget()));
}

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    for (var route in allRoutes) {
      r.child(route.path, child: (context) => route.widget);
    }
  }
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.white,
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
      routerConfig: Modular.routerConfig,
    );
  }
}
