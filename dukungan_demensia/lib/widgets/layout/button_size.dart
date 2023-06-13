import 'package:flutter/material.dart';
import 'package:dukungan_demensia/widgets/layout/text_layout.dart';

enum ButtonSize {
  xSmall(
    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
    iconSize: 16,
  ),
  small(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    iconSize: 16,
  ),
  medium(
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    iconSize: 24,
  ),
  large(
    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    iconSize: 24,
  );

  const ButtonSize({required this.padding, required this.iconSize});

  final EdgeInsets padding;

  final double iconSize;

  TextStyle get textStyle {
    switch (this) {
      case ButtonSize.xSmall:
        return TextLayout.title14;
      case ButtonSize.small:
        return TextLayout.title16;
      case ButtonSize.medium:
        return TextLayout.title18;
      case ButtonSize.large:
        return TextLayout.display24;
    }
  }
}
