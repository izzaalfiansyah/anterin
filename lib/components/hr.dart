import 'package:flutter/material.dart';

class Hr extends StatelessWidget {
  const Hr({
    super.key,
    this.color = Colors.black,
    this.width = 1,
  });

  final Color color;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width,
      color: color,
    );
  }
}
