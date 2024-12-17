import 'package:flutter/material.dart';
import 'package:hungrybelt/components/tile_button.dart';

class SpaceTile extends StatelessWidget {
  final String imagePath;
  final String appName;
  final String? url;
  final String? packageName;

  const SpaceTile({
    super.key,
    required this.imagePath,
    required this.appName,
    this.url,
    this.packageName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(10.0),
      height: 95,
      width: 320,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              height: 46,
              width: 46,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                appName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D1282),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TileButton(
                    label: 'Website',
                    url: url,
                  ),
                  const SizedBox(width: 25),

                  TileButton(
                    label: 'App',
                    packageName: packageName,
                  ),
                  
                  /*
                  TileButton(
                    label: 'App',
                    url: URL,
                  ),
                  */
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
