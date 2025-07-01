import 'package:flutter/material.dart';

class Button extends StatelessWidget {
const  Button({required this.size, required this.color, required this.text, required this.onPresed, super.key});

  final Color color;
  final String text;
  final double size;
  final VoidCallback onPresed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: this.onPresed,
      color: this.color,
      minWidth: this.size,
      child: Text(this.text, style:  TextStyle(
          color: Colors.white70
        ),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  final Color color;
  final String text;
  final int value;
  final VoidCallback onPressed;

  const SettingsButton(this.color, this.text, this.value, {required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white70,
        ),
      ),
      onPressed: onPressed,
      color: color,
    );
  }
}
