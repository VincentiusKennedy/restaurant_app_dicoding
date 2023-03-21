import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/models/restaurant.dart';

import '../models/restaurant_details.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<Restaurants> restaurants() async {
    final response = await http.get(Uri.parse('${_baseUrl}/list'));
    if (response.statusCode == 200) {
      return Restaurants.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restarant list');
    }
  }

  Future<Detail> restaurantDetail(String id) async {
    final response = await http.get(Uri.parse('${_baseUrl}/detail/${id}'));
    if (response.statusCode == 200) {
      return Detail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }
}
