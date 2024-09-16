import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BottomNavBarItem {
  final IconData icon;
  final String label;
  final String path;
  final Function(BuildContext context)? onTap;

  BottomNavBarItem(
      {required this.icon,
      required this.label,
      required this.path,
      this.onTap});
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int activeIndex = 0;

  final List<BottomNavBarItem> menus = [
    BottomNavBarItem(
      icon: Icons.home,
      path: '/home',
      label: 'Beranda',
      onTap: (context) {
        Modular.to.popUntil((route) => route.isFirst);
      },
    ),
    BottomNavBarItem(
      icon: Icons.bookmark,
      label: 'Pesanan',
      path: '/pesanan',
    ),
    BottomNavBarItem(
      icon: Icons.notifications,
      label: 'Inbox',
      path: '/inbox',
    ),
    BottomNavBarItem(
      icon: Icons.account_circle,
      label: 'Saya',
      path: '/saya',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showUnselectedLabels: true,
      showSelectedLabels: true,
      currentIndex: menus
          .indexOf(menus.firstWhere((menu) => menu.path == Modular.to.path)),
      items: menus.map((item) {
        return BottomNavigationBarItem(
          icon: Icon(item.icon),
          label: item.label,
        );
      }).toList(),
      onTap: (val) {
        final menu = menus[val];

        if (menu.onTap != null) {
          menu.onTap!(context);
        } else {
          Modular.to.pushNamed(menu.path);
        }
      },
    );
  }
}
