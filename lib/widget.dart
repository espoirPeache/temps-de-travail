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
      onPressed: onPressed,
      color: color,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white70,
        ),
      ),
    );
  }
}
// utilisation de la classe CustomButton pour créer des boutons personnalisé

class CustomButton extends StatelessWidget {
  final Color color;
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.color,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        minimumSize: Size(double.infinity, 48), // Large bouton
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
      ),
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
