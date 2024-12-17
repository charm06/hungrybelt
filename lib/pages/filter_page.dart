import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hungrybelt/components/filter_tile.dart';
import 'package:hungrybelt/models/food_place.dart';

class FilterPage extends StatefulWidget {
  final String filterCategory;

  const FilterPage({super.key, required this.filterCategory});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<FoodPlace> filteredFoodPlaces = []; // List to store filtered food places
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    fetchFilteredFoodPlaces();
  }

  Future<void> fetchFilteredFoodPlaces() async {
    try {
      // Query Firestore for food places where 'filterCategory' matches
      final snapshot = await FirebaseFirestore.instance
          .collection('foodPlaces')
          .where('filterCategory', isEqualTo: widget.filterCategory)
          .get();

      // Map Firestore documents to FoodPlace objects
      final List<FoodPlace> foodPlaces = snapshot.docs.map((doc) {
        final data = doc.data();
        return FoodPlace(
          id: doc.id,
          name: data['name'] as String? ?? '',
          location: data['location'] as String? ?? '',
          rating: data['rating'] as num? ?? 0,
          comments: [], // Assuming no comments for now, add handling if needed
          socialMedia: data['category'] as String? ?? '',
          filterCategory: data['filterCategory'] as String? ?? '',
          image: data['image'] as String? ?? '',
          isFavorite: data['isFavorite'] as bool? ?? false,
        );
      }).toList();

      // Update state with filtered food places
      setState(() {
        filteredFoodPlaces = foodPlaces;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching filtered food places: $e');
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
          child: Image.asset('assets/images/uFilter_title.png'),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : filteredFoodPlaces.isEmpty
              ? const Center(
                  child: Text(
                    'No food places found for this category',
                    style: TextStyle(fontSize: 16.0),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: filteredFoodPlaces.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: FilterTile(
                        foodplace: filteredFoodPlaces[index],
                      ),
                    ),
                  ),
                ),
    );
  }
}
