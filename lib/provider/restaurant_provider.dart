import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/restaurant.dart';

enum ResultState {
  isLoading,
  noData,
  hasData,
  error,
}

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    _fetchRestaurantList();
  }

  late Restaurants _restaurantResult;
  late ResultState _state;
  String _message = '';

  Restaurants get restaurantResult => _restaurantResult;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> _fetchRestaurantList() async {
    try {
      _state = ResultState.isLoading;
      notifyListeners();
      final restaurant = await apiService.restaurants();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (error) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Error --> $error";
    }
  }
}
