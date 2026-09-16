import 'package:flutter/material.dart';

class LockButton extends StatelessWidget {
  final bool isLocked;
  final VoidCallback onPressed;

  const LockButton({
    super.key,
    required this.isLocked,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      splashRadius: 20,
      icon: Icon(
        isLocked ? Icons.lock_outline : Icons.lock_open_outlined,
        color: Colors.black,
        size: 20,
      ),
    );
  }
}