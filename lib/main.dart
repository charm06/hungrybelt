import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hungrybelt/app_state.dart';
import 'package:hungrybelt/pages/splashscreen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: ((context, child) => const MainApp()),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        brightness: Brightness.light, // Light theme ensures white base colors
        scaffoldBackgroundColor: Colors.white, // White background
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, // White AppBar
          elevation: 0, // Flat AppBar without shadow
          foregroundColor: Colors.black, // Black text and icons
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
