import 'package:anterin/screens/coming-soon/index.dart';
import 'package:anterin/screens/home/index.dart';
import 'package:anterin/screens/home/makan_minum/index.dart';
import 'package:anterin/screens/login/index.dart';
import 'package:anterin/screens/saya/index.dart';
import 'package:anterin/screens/splash/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Route {
  final String path;
  final Widget widget;
  final TransitionType? transition;

  Route({
    required this.path,
    required this.widget,
    this.transition,
  });
}

List<Route> allRoutes = [
  Route(path: '/splash', widget: SplashScreen()),
  Route(
    path: '/login',
    widget: LoginScreen(),
    transition: TransitionType.downToUp,
  ),
  Route(
    path: '/',
    widget: HomeScreen(),
    transition: TransitionType.downToUp,
  ),
  Route(path: '/saya', widget: SayaScreen()),
  Route(path: '/makan_minum', widget: MakanMinumScreen()),
  Route(path: '/coming_soon', widget: ComingSoonScreen()),
];
