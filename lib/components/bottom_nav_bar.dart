import 'package:flutter/material.dart';

class MenuItem {
  final IconData icon;
  final String label;
  final String path;
  final Function(BuildContext context)? onTap;

  MenuItem(
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

  final List<MenuItem> menus = [
    MenuItem(
      icon: Icons.home,
      path: '/home',
      label: 'Beranda',
      onTap: (context) {
        Navigator.of(context).popUntil(ModalRoute.withName('/home'));
      },
    ),
    MenuItem(
      icon: Icons.bookmark,
      label: 'Pesanan',
      path: '/pesanan',
    ),
    MenuItem(
      icon: Icons.notifications,
      label: 'Inbox',
      path: '/inbox',
    ),
    MenuItem(
      icon: Icons.account_circle,
      label: 'Saya',
      path: '/saya',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final path = ModalRoute.of(context)?.settings.name;

    if (path != null) {
      final menuIndex =
          menus.indexOf(menus.firstWhere((menu) => menu.path == path));
      setState(() {
        activeIndex = menuIndex;
      });
    }

    return BottomNavigationBar(
      showUnselectedLabels: true,
      showSelectedLabels: true,
      currentIndex: activeIndex,
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
          Navigator.of(context).pushNamed(menu.path);
        }
      },
    );
  }
}
