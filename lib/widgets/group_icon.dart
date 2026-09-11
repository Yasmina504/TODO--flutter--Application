import 'package:flutter/material.dart';

class GroupIcon extends StatelessWidget {
  final Color color;
  final Color iconColor;
  final IconData icon;

  const GroupIcon({
    super.key,
    required this.color,
    required this.iconColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: 20,
      ),
    );
  }
}