import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import '../data/models/restaurant_details.dart';

enum ResultState {
  isLoading,
  noData,
  hasData,
  error,
}

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({
    required this.apiService,
    required this.id,
  }) {
    _fetchRestaurantDetail(id);
  }

  late Detail _restaurantDetail;
  late ResultState _state;
  String _message = '';

  Detail get restaurantDetail => _restaurantDetail;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> _fetchRestaurantDetail(String id) async {
    try {
      _state = ResultState.isLoading;
      notifyListeners();
      final restaurantDetail = await apiService.restaurantDetail(id);
      if (restaurantDetail.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetail = _restaurantDetail;
      }
    } catch (error) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $error';
    }
  }
}
