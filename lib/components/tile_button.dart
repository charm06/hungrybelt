import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TileButton extends StatelessWidget {
  final String label;
  final String? url;
  final String? packageName;
  //final VoidCallback onPressed;

  const TileButton({
    super.key,
    required this.label,
    this.url,
    this.packageName,
  });

  Future<void> _handlePress() async {
    if (url != null) {
      // Launch the URL
      final Uri uri = Uri.parse(url!);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch URL: $url';
      }
    } else if (packageName != null) {
      // Launch the app by package name (Android intent)
      final Uri uri = Uri.parse('intent://$packageName#Intent;end');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch app with package name: $packageName';
      }
    } else {
      throw 'No valid URL or package name provided';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
          backgroundColor: WidgetStateProperty.all(const Color(0xFF0D1282)),    // button color
          foregroundColor: WidgetStateProperty.all(const Color(0xFFD9D9D9)),    // text color
        ),
        onPressed: _handlePress,
        child: Text(
          label
        ),
      ),
    );
  }
}
