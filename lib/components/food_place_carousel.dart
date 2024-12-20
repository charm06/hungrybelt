import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hungrybelt/models/food_place.dart';
import 'package:hungrybelt/pages/info_page.dart';

class FoodPlaceCarousel extends StatefulWidget {
  const FoodPlaceCarousel({super.key, required this.foodPlaces});

  final List<FoodPlace> foodPlaces;

  @override
  State<FoodPlaceCarousel> createState() => _FoodPlaceCarouselState();
}

class _FoodPlaceCarouselState extends State<FoodPlaceCarousel> {
  final int _currentIndex = 0; // To track the current slide index
  late CarouselController _controller; // Use aliased CarouselController

  @override
  void initState() {
    super.initState();
    _controller = CarouselController(); // Initialize the controller
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: CarouselSlider(
            items: widget.foodPlaces.map((foodPlace) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
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
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          0.8, // Reduce width
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                        color: Color(0xFF0d1282),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    120, // Adjust height to make the image smaller
                                width: 80, // Reduce width of the image
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Set the rounding radius here
                                  child: AspectRatio(
                                    aspectRatio: 3 / 4, // Vertical aspect ratio
                                    child: Image.network(
                                      foodPlace.image,
                                      fit: BoxFit
                                          .cover, // Ensures the image covers the area while maintaining its aspect ratio
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        foodPlace.name,
                                        style: const TextStyle(
                                          color: Color(0xFFEEEDED),
                                          fontSize: 16, // Reduce font size
                                          fontWeight: FontWeight.bold,
                                        ),
                                        softWrap: true,
                                      ),
                                    ),
                                    Text(
                                      foodPlace.location,
                                      style: const TextStyle(
                                        color: Color(0xFFEEEDED),
                                        fontSize: 14, // Reduce font size
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: List.generate(5, (index) {
                                        return Icon(
                                          Icons.star,
                                          color:
                                              index < foodPlace.rating.floor()
                                                  ? Colors.yellow
                                                  : Colors.white,
                                          size: 20,
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: 150.0, // Reduce overall height of the carousel
              enlargeCenterPage: true, // Option to highlight the center card
              enableInfiniteScroll: true,
              autoPlay: true,
            ),
          ),
        ),
      ],
    );
  }
}
