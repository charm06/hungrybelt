import 'package:flutter/material.dart';
import 'package:hungrybelt/pages/filter_page.dart';
import 'package:hungrybelt/app_state.dart';
import 'package:hungrybelt/components/app_drawer.dart'; // Import the AppDrawer
import 'package:hungrybelt/components/food_place_carousel.dart';
import 'package:hungrybelt/pages/search_page.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedFoodPlace = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 200.0,
          child: Image.asset('assets/images/uHome_title.png'),
        ),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Consumer<ApplicationState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Recommendations Section
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to SearchPage when pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(color: Colors.grey),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      backgroundColor: Colors.white,
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Search for food places",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Top Recommendations",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                // Food Place Carousel Section
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: FoodPlaceCarousel(
                    foodPlaces: appState.foodPlaces,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // Filter Section
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "UFilter",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Cafe filter
                    _buildFilterOption(
                      context,
                      'assets/images/filter_cafe.png',
                      'Cafe',
                      const FilterPage(filterCategory: 'Cafe'),
                    ),
                    const SizedBox(width: 25),

                    // Drinks filter
                    _buildFilterOption(
                      context,
                      'assets/images/filter_drinks.png',
                      'Drinks',
                      const FilterPage(filterCategory: 'Drinks'),
                    ),
                    const SizedBox(width: 25),

                    // Meal filter
                    _buildFilterOption(
                      context,
                      'assets/images/filter_meal.png',
                      'Meal',
                      const FilterPage(filterCategory: 'Meal'),
                    ),
                    const SizedBox(width: 25),

                    // Snack filter
                    _buildFilterOption(
                      context,
                      'assets/images/filter_snack.png',
                      'Snack',
                      const FilterPage(filterCategory: 'Snack'),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterOption(BuildContext context, String imagePath,
      String label, Widget destinationPage) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // Use Get.to for navigation
            Get.to(() => destinationPage);
          },
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 6.0,
                  offset: const Offset(2, 2),
                ),
              ],
              border: Border.all(
                color: const Color(0xFFD6D5D5),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.asset(
                imagePath,
                height: 65,
                width: 65,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 1),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
