import 'package:flutter/material.dart';
import 'package:hungrybelt/models/food_place.dart';
import 'package:hungrybelt/pages/info_page.dart';

class FilterTile extends StatelessWidget {
  final FoodPlace foodplace;

  const FilterTile({
    super.key,
    required this.foodplace,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfoPage(foodPlaceName: foodplace.name),
          ),
        );
      },
      borderRadius: BorderRadius.circular(15),
      splashColor: Colors.grey.withOpacity(0.2),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(10.0),
        height: 85,
        width: MediaQuery.of(context).size.width * .9,
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
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  foodplace.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  foodplace.location,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}