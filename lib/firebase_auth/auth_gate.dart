import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:hungrybelt/app_router.dart';
import 'package:hungrybelt/pages/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: const Color(0x00eeeded), 
            body: SignInScreen(
              providers: [
                EmailAuthProvider(),
              ],
            ),
          );
        }

        return const AppRouter();
      },
    );
  }
}
