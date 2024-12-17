import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  final String foodPlaceName;

  const InfoPage({super.key, required this.foodPlaceName});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  double userRating = 0;
  double averageRating = 4.2;
  bool isFavorite = false;

  String foodPlaceName = '';
  String location = 'Loading...';
  String image = 'assets/images/default_image.png';
  String sns = 'No SNS available';
  String snsUrl = '';

  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    foodPlaceName = widget.foodPlaceName;
    _fetchFoodPlaceDetails();
  }

  Future<void> _fetchFoodPlaceDetails() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('foodPlaces')
          .where('name', isEqualTo: foodPlaceName)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();

        setState(() {
          location = data['location'] ?? 'No location';
          image = data['image'] ?? 'assets/images/default_image.png';
          sns = data['socialMedia'] ?? 'No SNS available';
          snsUrl = data['socialMedia'] ?? '';
          averageRating = (data['rating']?.toDouble() ?? 4);
        });
      }
    } catch (e) {
      print("Error fetching food place details: $e");
    }
  }

  Future<void> _addComment(String comment) async {
    try {
      // Replace with the actual user ID retrieved from your authentication system
      String userID = 'User123';

      await FirebaseFirestore.instance.collection('comments').add({
        'userID': userID,
        'foodPlaceName': foodPlaceName,
        'comment': comment,
        'date': Timestamp.now(),
      });
      _commentController.clear();
      print("Comment added successfully!");
    } catch (e) {
      print("Error adding comment: $e");
    }
  }

  Future<String> _fetchUserName(String userID) async {
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('userID', isEqualTo: userID)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        return userSnapshot.docs.first.data()['username'] ?? 'Unknown User';
      } else {
        return 'Unknown User';
      }
    } catch (e) {
      print("Error fetching user details: $e");
      return 'Unknown User';
    }
  }

  Future<void> _updateRating() async {
    try {
      double newAverageRating = (averageRating + userRating) / 2;
      await FirebaseFirestore.instance.collection('foodPlaces').doc(foodPlaceName).update({
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

  @override
  Widget build(BuildContext context) {
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
                      print('Error: ${snapshot.error}');
                      return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final comments = snapshot.data!.docs;

                  return Column(
                    children: comments.map((doc) {
                      final commentData = doc.data() as Map<String, dynamic>;

                      return FutureBuilder<String>(
                        future: _fetchUserName(commentData['userID']),
                        builder: (context, userSnapshot) {
                          String username = userSnapshot.data ?? 'Unknown User';

                          return ListTile(
                            title: Text(commentData['comment'] ?? ''),
                            subtitle: Text('By $username'),
                            trailing: Text(
                              commentData['date'].toDate().toString().split(' ')[0],
                            ),
                          );
                        },
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
