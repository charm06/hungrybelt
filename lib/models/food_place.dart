import 'package:hungrybelt/models/comment.dart';

class FoodPlace{
  String name;
  String location;
  int rating;
  List<Comment> comments; 
  String socialMedia;
  String filterCategory;
  String image;
  bool isFavorite;

  FoodPlace({
    required this.name,
    required this.location,
    required this.rating,
    required this.comments,
    required this.socialMedia,
    required this.filterCategory,
    required this.image,
    required this.isFavorite
  });
}