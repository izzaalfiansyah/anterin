import 'package:flutter/material.dart';

class FormGroup extends StatelessWidget {
  const FormGroup({
    super.key,
    this.label,
    required this.child,
  });

  final Widget? label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label ?? SizedBox(),
        SizedBox(height: 10),
        child,
      ],
    );
  }
}
