import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const Button({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      width: MediaQuery.of(context).size.width * 1,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
          backgroundColor: WidgetStateProperty.all(const Color(0xFF0D1282)),    // button color
          foregroundColor: WidgetStateProperty.all(const Color(0xFFF0DE36)),    // text color
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }
}