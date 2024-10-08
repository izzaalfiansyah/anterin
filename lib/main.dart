import 'package:anterin/blocs/auth.dart';
import 'package:anterin/blocs/loader.dart';
import 'package:anterin/blocs/order.dart';
import 'package:anterin/constants/app.dart';
import 'package:anterin/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: MainWidget()));
}

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    for (var route in allRoutes) {
      r.child(route.path,
          child: (context) => route.widget, transition: route.transition);
    }
  }
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/splash');

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OrderBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => LoaderBloc(),
        ),
      ],
      child: MaterialApp.router(
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
          inputDecorationTheme: InputDecorationTheme(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: cPrimary, width: 1),
            ),
          ),
          filledButtonTheme: FilledButtonThemeData(
              style: FilledButton.styleFrom(
            backgroundColor: cPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          )),
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: Modular.routerConfig,
      ),
    );
  }
}
