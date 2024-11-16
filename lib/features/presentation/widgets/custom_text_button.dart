// ignore_for_file: must_be_immutable


import 'package:dairy_track/features/presentation/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  String text;
  void Function()? onPressed;

  bool progress;

  CustomTextButton({
    super.key,
    this.text = '',
    this.onPressed,
    this.progress = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 10,
      child: FilledButton(
        style: _buttonStyle(),
        onPressed: onPressed,
        child: progress
            ? CircularProgressIndicator(
                color: Themes.secondary,
              )
            : Text(
                text,
                style: TextStyle(
                  color: Themes.secondary,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Themes.tertiary),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        minimumSize: const WidgetStatePropertyAll(
          Size(double.infinity, 50),
        ),
        overlayColor: WidgetStatePropertyAll(Themes.primary));
  }
}
