import 'package:anterin/screens/home.dart';
import 'package:anterin/screens/saya.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  '/home': (context) => HomeScreen(),
  '/saya': (context) => SayaScreen(),
};
