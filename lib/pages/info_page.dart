import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hungrybelt/models/food_place.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  final FoodPlace foodPlace;

  const InfoPage({
    super.key,
    required this.foodPlace,
  });

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  num userRating = 0;
  num averageRating = 4.2;
  bool isFavorite = false;

  String location = 'Loading...';
  String image = 'assets/images/default_image.png';
  String sns = 'No SNS available';
  String snsUrl = '';

  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchFoodPlaceDetails();
  }

  Future<void> _fetchFoodPlaceDetails() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('foodPlaces')
          .where('name', isEqualTo: widget.foodPlace.name)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();

        setState(() {
          location = data['location'] ?? 'No location';
          image = data['image'] ?? 'assets/images/default_image.png';
          sns = data['socialMedia'] ?? 'No SNS available';
          snsUrl = data['socialMedia'] ?? '';
          averageRating = (data['rating'] as num? ?? 4);
          isFavorite =
              data['isFavorite'] ?? false; // Fetch the current favorite status
        });
      }
    } catch (e) {
      print("Error fetching food place details: $e");
    }
  }

  Future<void> _addComment(String comment) async {
    try {
      await FirebaseFirestore.instance.collection('comments').add({
        'author': FirebaseAuth.instance.currentUser?.email, 
        'foodPlaceName': widget.foodPlace.name,
        'comment': comment,
        'date': Timestamp.now(),
      });
      _commentController.clear();
      print("Comment added successfully!");
    } catch (e) {
      print("Error adding comment: $e");
    }
  }

  Future<void> _updateRating() async {
    try {
      double newAverageRating = (averageRating + userRating) / 2;
      await FirebaseFirestore.instance
          .collection('foodPlaces')
          .doc(widget.foodPlace.id)
          .update({
        'rating': newAverageRating,
      });
      setState(() {
        averageRating = newAverageRating;
      });
      print('Rating updated successfully!');
    } catch (e) {
      print("Error updating rating: $e");
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _updateFavoriteStatus(bool isFavorite) async {
    try {
      await FirebaseFirestore.instance
          .collection('foodPlaces')
          .where('name', isEqualTo: widget.foodPlace.name)
          .get()
          .then((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          snapshot.docs.first.reference.update({
            'isFavorite':
                isFavorite, // Update the isFavorite field in Firestore
          });
        }
      });
    } catch (e) {
      print("Error updating favorite status: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final String foodPlaceName = widget.foodPlace.name;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(foodPlaceName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Food Place Details
              Container(
                height: 275,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF0D1282),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              foodPlaceName,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                Icons.star,
                                color: index < averageRating.floor()
                                    ? Colors.yellow
                                    : Colors.white,
                                size: 20,
                              );
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/default_image.png',
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Location Display
              Row(
                children: [
                  const Icon(Icons.location_pin, color: Colors.red),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(location, style: const TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Rating Display
              Row(
                children: [
                  const Icon(Icons.star_border, color: Colors.red),
                  const SizedBox(width: 8),
                  const Text("Add Rating:", style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Row(
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            userRating = index + 1.0;
                            _updateRating();
                          });
                        },
                        child: Icon(
                          Icons.star,
                          color:
                              index < userRating ? Colors.yellow : Colors.grey,
                          size: 28,
                        ),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Favorite Icon Below Ratings
              Row(
                children: [
                  const SizedBox(width: 8),
                  Text("Mark as Favorite:",
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite; // Toggle the favorite status
                      });
                      _updateFavoriteStatus(
                          isFavorite); // Update Firestore with the new status
                    },
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                      size: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // SNS Display
              Row(
                children: [
                  const Icon(Icons.language, color: Colors.red),
                  const SizedBox(width: 8),
                  snsUrl.isNotEmpty
                      ? GestureDetector(
                          onTap: () => _launchURL(snsUrl),
                          child: Text(
                            sns,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      : Text(sns, style: const TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 20),

              // Comments Section
              const Text(
                'Comments:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('comments')
                    .where('foodPlaceName', isEqualTo: foodPlaceName)
                    .orderBy('date', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Error loading comments');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final comments = snapshot.data!.docs;

                  return Column(
                    children: comments.map((doc) {
                      final commentData = doc.data() as Map<String, dynamic>;
                      return ListTile(
                        title: Text(commentData['comment'] ?? ''),
                        subtitle:
                            Text('By ${commentData['author'] ?? 'Anoynmous'}'),
                        trailing: Text(
                          commentData['date'].toDate().toString().split(' ')[0],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Add Comment Section
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        hintText: 'Add a comment...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_commentController.text.trim().isNotEmpty) {
                        _addComment(_commentController.text.trim());
                      }
                    },
                    child: const Text('Send'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
