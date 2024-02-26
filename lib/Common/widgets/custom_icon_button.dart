import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;
  final double? iconSize;
  final double? minWidth;
  final BoxBorder? border;
  final Color? background;
  const CustomIconButton({super.key, required this.icon, required this.onTap, this.iconColor, this.iconSize, this.minWidth, this.border, this.background,});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: border,
        color: background,
        shape: BoxShape.circle
      ),
      child: IconButton(
        onPressed: onTap,
        constraints: BoxConstraints(minWidth: minWidth ?? 40),
        icon: Icon(
          icon,
          color: iconColor,
        ),
        iconSize: iconSize ?? 22,
      ),
    );
  }
}