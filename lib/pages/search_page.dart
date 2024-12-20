import 'package:flutter/material.dart';
import 'package:hungrybelt/models/food_place.dart';
import 'package:hungrybelt/app_state.dart';
import 'package:hungrybelt/pages/info_page.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _controller;
  List<FoodPlace> _filteredFoodPlaces = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _filteredFoodPlaces = context.read<ApplicationState>().foodPlaces;
    _controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Update the filtered list based on the search text
  void _onSearchChanged() {
    final query = _controller.text.toLowerCase();
    setState(() {
      _filteredFoodPlaces = context
          .read<ApplicationState>()
          .foodPlaces
          .where((foodPlace) => foodPlace.name
              .toLowerCase()
              .contains(query)) // Filter based on name
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Search for food places...',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.grey,
                style: BorderStyle.solid,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.black,
                style: BorderStyle.solid,
              ),
            ),
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
          ),
        ),
      ),
      body: _controller.text.isEmpty
          ? Container() // Empty container when search field is empty
          : ListView(
              children: [
                // Display suggestions as a list when typing
                for (var foodPlace in _filteredFoodPlaces)
                  ListTile(
                    key: ValueKey(foodPlace.id),
                    title: Text(foodPlace.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InfoPage(
                            foodPlace: foodPlace,
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
    );
  }
}
