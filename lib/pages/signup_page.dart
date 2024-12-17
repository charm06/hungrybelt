import 'package:flutter/material.dart';
import 'package:hungrybelt/components/button.dart';
import 'package:hungrybelt/components/inputfield.dart';
import 'package:hungrybelt/firebase_auth/auth_gate.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/signup.png',
                    height: 150,
                    width: 250,
                  ),
                  const SizedBox(height: 40.0),

                  InputField(
                    hintText: "Username",
                    controller: username,
                    validator: _validateUsername,
                  ),

                  InputField(
                    hintText: "Email",
                    controller: email,
                    validator: _validateEmail,
                  ),

                  InputField(
                    hintText: "Password",
                    controller: password,
                    validator: _validatePassword,
                    isPassword: true,
                  ),

                  InputField(
                    hintText: "Confirm Password",
                    controller: confirmPassword,
                    validator: _validateConfirmPassword,
                    isPassword: true,
                  ),

                  Button(
                    label: "Sign Up",
                    onPressed: (){
                      //action here
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),

                      TextButton(
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Color(0xFF0D1282),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AuthGate(),
                            ),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // validator
  String? _validateUsername(String? value){
    if(value == null || value.isEmpty){
      return "Username is required";
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Confirm Password is required";
    } else if (value != password.text) {
      return "Passwords do not match";
    }
    return null;
  }
}