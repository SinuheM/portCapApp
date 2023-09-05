import 'package:flutter/material.dart';
import 'package:presentation/styles/theme.dart';

class FloatingOptionButton extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;
  const FloatingOptionButton(
      {super.key, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x4C000000),
              blurRadius: 3,
              offset: Offset(0, 1),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 8,
              offset: Offset(0, 4),
              spreadRadius: 3,
            )
          ],
          border: Border.all(color: red,width:1)
        ),
        width: 48,
        height: 48,
        child: Icon(icon),
      ),
    );
  }
}
