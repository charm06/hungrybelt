import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hungrybelt/firebase_options.dart';
import 'package:hungrybelt/models/comment.dart';
import 'package:hungrybelt/models/food_place.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  StreamSubscription<QuerySnapshot>? _foodPlaceSubscription;
  List<FoodPlace> _foodPlace = [];
  List<FoodPlace> get foodPlace => _foodPlace;

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _foodPlaceSubscription = FirebaseFirestore.instance
            .collection('foodPlaces')
            .orderBy('name')
            .snapshots()
            .listen((snapshot) async {
          _foodPlace = [];
          for (final document in snapshot.docs) {
            // Fetch the comments and convert them to Comment objects
            List<Comment> comments = [];
            if (document.data()['comments'] != null) {
              final commentCollection =
                  FirebaseFirestore.instance.collection('comments');
              for (var commentID in document.data()['comments']) {
                // Fetch each comment by its ID
                final commentDoc = await commentCollection.doc(commentID).get();
                final commentData = commentDoc.data();
                if (commentData != null) {
                  comments.add(
                    Comment(
                      author: commentData['author'] as String? ?? '',  // Default empty string if null
                      date: commentData['date'] as Timestamp? ?? Timestamp.now(),  // Default current timestamp if null
                      comment: commentData['comment'] as String? ?? '',  // Default empty string if null
                    ),
                  );
                }
              }
            }

            // Create the FoodPlace object with the converted comments
            _foodPlace.add(FoodPlace(
              id: document.id,
              name: document.data()['name'] as String? ?? '',  // Default empty string if null
              location: document.data()['location'] as String? ?? '',  // Default empty string if null
              rating: document.data()['rating'] as num? ?? 0,  // Default 0 if null
              comments: comments,
              socialMedia: document.data()['category'] as String? ?? '',  // Default empty string if null
              filterCategory: document.data()['filterCategory'] as String? ?? '',  // Default empty string if null
              image: document.data()['image'] as String? ?? '',  // Default empty string if null
              isFavorite: document.data()['isFavorite'] as bool? ?? false,  // Default false if null
            ));
          }
          notifyListeners();
        });
      } else {
        _loggedIn = false;
        _foodPlace = [];
        _foodPlaceSubscription?.cancel();
      }
      notifyListeners();
    });
  }
}
