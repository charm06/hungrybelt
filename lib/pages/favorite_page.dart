import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hungrybelt/models/food_place.dart';
import 'package:hungrybelt/pages/info_page.dart';
import 'package:hungrybelt/components/fave_tile.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<FoodPlace> favoriteFoodPlaces = [];
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    fetchFavoriteFoodPlaces();
  }

  Future<void> fetchFavoriteFoodPlaces() async {
    try {
      // Query Firestore for food places where 'isFavorite' is true
      final snapshot = await FirebaseFirestore.instance
          .collection('foodPlaces')
          .where('isFavorite', isEqualTo: true)
          .get();

      // Map Firestore documents to FoodPlace objects
      final List<FoodPlace> foodPlaces = snapshot.docs.map((doc) {
        final data = doc.data();
        return FoodPlace(
          id: doc.id,
          name: data['name'] as String? ?? '',
          location: data['location'] as String? ?? '',
          rating: data['rating'] as double? ?? 0,
          comments: [], // Assuming no comments for now, add handling if needed
          socialMedia: data['category'] as String? ?? '',
          filterCategory: data['filterCategory'] as String? ?? '',
          image: data['image'] as String? ?? '',
          isFavorite: data['isFavorite'] as bool? ?? false,
        );
      }).toList();

      setState(() {
        favoriteFoodPlaces = foodPlaces;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching favorite food places: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 200.0,
          child: Image.asset('assets/images/uFave_title.png'),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : favoriteFoodPlaces.isEmpty
              ? const Center(
                  child: Text(
                    'No favorite food places found.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: favoriteFoodPlaces.length,
                    itemBuilder: (context, index) {
                      final foodPlace = favoriteFoodPlaces[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: FaveTile(
                          foodplace: foodPlace,
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
