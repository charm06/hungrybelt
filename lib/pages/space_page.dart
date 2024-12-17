import 'package:flutter/material.dart';
import 'package:hungrybelt/components/space_tile.dart';

class SpacePage extends StatefulWidget {
  const SpacePage({super.key});

  @override
  State<SpacePage> createState() => _SpacePageState();
}

class _SpacePageState extends State<SpacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 200.0, 
          child: Image.asset('assets/images/uSpace_title.png'),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpaceTile(
                  imagePath: 'assets/logos/foodpanda.png',
                  appName: 'Food Panda',
                  url: 'https://www.foodpanda.com',
                  packageName: 'com.global.foodpanda.android',
                ),

                SpaceTile(
                  imagePath: 'assets/logos/grab.png',
                  appName: 'Grab',
                  url: 'https://food.grab.com/ph/en/',
                  // packageName: 'to app',
                ),

                SpaceTile(
                  imagePath: 'assets/logos/ordermo.png',
                  appName: "Order Mo",
                  url: 'https://www.ordermo.ph/',
                  // packageName: 'to app',
                ),

                SpaceTile(
                  imagePath: 'assets/logos/jollibee.png',
                  appName: 'Jollibee',
                  url: 'https://www.jollibeedelivery.com/fullmenu',
                  // packageName: 'to app',
                ),

                SpaceTile(
                  imagePath: 'assets/logos/mcdo.png',
                  appName: "McDonald's",
                  url: 'https://www.mcdelivery.com.ph/account/location/',
                  // packageName: 'to app',
                ),

                SpaceTile(
                  imagePath: 'assets/logos/chowking.jpg',
                  appName: "Chowking",
                  url: 'https://www.chowkingdelivery.com/',
                  // packageName: 'to app',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
