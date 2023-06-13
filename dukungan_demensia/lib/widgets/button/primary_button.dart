import 'package:dukungan_demensia/widgets/layout/button_layout.dart';
import 'package:dukungan_demensia/widgets/layout/button_size.dart';
import 'package:dukungan_demensia/widgets/layout/colors_layout.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    this.leading,
    this.label,
    this.trailing,
    this.buttonSize = ButtonSize.large,
  });

  final VoidCallback? onPressed;

  final Widget? leading;

  final Widget? label;

  final Widget? trailing;

  final ButtonSize buttonSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return ColorLayout.blue3;
          } else {
            return ColorLayout.blue5;
          }
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          return ColorLayout.neutral5;
        }),
        textStyle: MaterialStatePropertyAll(buttonSize.textStyle),
        padding: MaterialStatePropertyAll(buttonSize.padding),
      ),
      onPressed: onPressed,
      child: ButtonLayout(
        leading: leading,
        label: label,
        trailing: trailing,
        buttonSize: buttonSize,
      ),
    );
  }
}
