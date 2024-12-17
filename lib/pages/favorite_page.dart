import 'package:flutter/material.dart';
import 'package:hungrybelt/components/fave_tile.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  // sample food places
  List foodPlace = [
    
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 200.0, 
          child: Image.asset('assets/images/uFave_title.png'),
        ),
      ),
      body: Center(
        //child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
              child: ListView.builder(
                itemCount: foodPlace.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: FaveTile(
                    foodplace: foodPlace[index],
                  ),
                ),
              ),
          ),
        //),
      ),
    );
  }
}


