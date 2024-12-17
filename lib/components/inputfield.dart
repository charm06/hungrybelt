import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  //final FormFieldValidator? validator;
  final FormFieldValidator<String>? validator;
  final bool isPassword;

  const InputField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.isPassword = false,
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _isObscured = true;

  void _toggleObscureText(){
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
        controller: widget.controller,
        obscureText: widget.isPassword && _isObscured,

        decoration: InputDecoration(

          // hint text color
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),

          // border color
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),

          // border color if clicked
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xFF0D1282),
            ),
          ),

          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),

          // password toggle icon
          suffixIcon: widget.isPassword
              ? GestureDetector(
            onTap: _toggleObscureText,
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Image.asset(
                _isObscured ? 'assets/icons/eye.png' : 'assets/icons/eye_clicked.png',
                width: 10,
                height: 10,
                color: Colors.grey,
              ),
            ),
          )
              : null,
        ),
      ),
    );
  }
}