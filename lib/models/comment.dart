import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String userID;
  Timestamp date; // Firestore Timestamp
  String comment;

  Comment({
    required this.userID,
    required this.date,
    required this.comment,
  });

  // Factory constructor to create a Comment from a map
  factory Comment.fromMap(Map<String, dynamic> data) {
    return Comment(
      userID: data['userID'] ?? '', // Safely get userID from data
      date: data['date'] ?? Timestamp.now(), // Default to current timestamp if missing
      comment: data['comment'] ?? '', // Default to empty string if missing
    );
  }

  // Convert a Comment instance back to a map (if needed for uploading)
  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'date': date,
      'comment': comment,
    };
  }
}
