import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/screens/restaurant_details.dart';
import '../data/models/restaurant.dart';
import 'package:provider/provider.dart';

import '../widgets/card_item.dart';

class RestaurantListItem extends StatelessWidget {
  const RestaurantListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantListProvider>(
      create: (_) => RestaurantListProvider(apiService: ApiService()),
      child: Scaffold(
        body: Consumer<RestaurantListProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.hasData) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.restaurantResult.restaurants.length,
                      itemBuilder: (context, index) {
                        var restaurant =
                            state.restaurantResult.restaurants[index];
                        return CardItem(restaurant: restaurant);
                      },
                    ),
                  ),
                ),
              );
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Text(state.message),
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text(''),
              );
            }
          },
        ),
      ),
    );
  }
}
