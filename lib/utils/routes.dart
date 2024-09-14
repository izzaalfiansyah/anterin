import 'package:anterin/screens/coming-soon/index.dart';
import 'package:anterin/screens/home/index.dart';
import 'package:anterin/screens/home/makan_minum/index.dart';
import 'package:anterin/screens/saya/index.dart';
import 'package:flutter/material.dart';

class Route {
  final String path;
  final Widget widget;

  Route({required this.path, required this.widget});
}

List<Route> allRoutes = [
  Route(path: '/', widget: HomeScreen()),
  Route(path: '/saya', widget: SayaScreen()),
  Route(path: '/makan_minum', widget: MakanMinumScreen()),
  Route(path: '/coming_soon', widget: ComingSoonScreen()),
];
