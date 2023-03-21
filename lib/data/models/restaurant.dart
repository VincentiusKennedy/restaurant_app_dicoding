import 'dart:convert';

Restaurants restaurantsFromJson(String str) =>
    Restaurants.fromJson(json.decode(str));

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> restaurant) => Restaurant(
        id: restaurant["id"],
        name: restaurant["name"],
        description: restaurant["description"],
        pictureId: restaurant["pictureId"],
        city: restaurant["city"],
        rating: restaurant["rating"].toDouble(),
      );
}

class Restaurants {
  Restaurants({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
          (json["restaurants"] as List).map((x) => Restaurant.fromJson(x)),
        ),
      );
}
