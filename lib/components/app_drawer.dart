import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:hungrybelt/pages/developers_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF0d1282),
              ),
              child: Image.asset('assets/images/splashscreen_logo.png')),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Developers Page'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DevelopersPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
