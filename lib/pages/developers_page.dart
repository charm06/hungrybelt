import 'package:flutter/material.dart';

class DevelopersPage extends StatelessWidget {
  //const DevelopersPage({super.key});

  final List<Map<String, String>> developers = [
    {'imagePath': 'assets/images/pfp_facturan.jpg', 'name': 'Francheska Kyle A. Facturan'},
    {'imagePath': 'assets/images/pfp_timbal.jpg', 'name': 'Diane Elaine L. Timbal'},
    {'imagePath': 'assets/images/pfp_villalobos.jpg', 'name': 'Charmaine Chesca Q. Villalobos'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Meet the Developers',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // list of developers
          Expanded(
            child: ListView(
              children: [
                ...developers.map((developer) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D1282),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // for image
                          Container(
                            margin: const EdgeInsets.all(20),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: AssetImage(developer['imagePath']!),
                            ),
                          ),

                          // for name
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text(
                              developer['name']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),

                // sources section
                const Divider(thickness: 2),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Sources',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '1. Flutter Official Documentation - https://flutter.dev/docs',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '2. Flutter Package Repository - https://pub.dev/',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
