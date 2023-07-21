import 'package:flutter/material.dart';

class ElevatedButtonCustom extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ElevatedButtonCustom({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        overlayColor: MaterialStateProperty.all<Color>(Colors.blue.shade600),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
