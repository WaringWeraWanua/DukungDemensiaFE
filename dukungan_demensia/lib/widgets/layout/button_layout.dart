import 'package:flutter/material.dart';
import "button_size.dart";

const _iconAndTextSpace = 4.0;

class ButtonLayout extends StatelessWidget {
  const ButtonLayout({
    super.key,
    this.leading,
    this.label,
    this.trailing,
    required this.buttonSize,
    this.iconAndTextSpace,
  });

  final Widget? leading;

  final Widget? label;

  final Widget? trailing;

  final ButtonSize buttonSize;

  final double? iconAndTextSpace;

  @override
  Widget build(BuildContext context) {
    final iconTextSpace = iconAndTextSpace ?? _iconAndTextSpace;

    return IconTheme(
      data: IconTheme.of(context).merge(
        IconThemeData(size: buttonSize.iconSize),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) leading!,
          if (leading != null && label != null) SizedBox(width: iconTextSpace),
          if (label != null) label!,
          if (trailing != null && label != null) SizedBox(width: iconTextSpace),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
