import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/restaurant_details.dart';
import '../models/restaurant.dart';

class RestaurantListItem extends StatelessWidget {
  const RestaurantListItem({super.key});

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return Card(
      margin: const EdgeInsets.fromLTRB(5, 5, 5, 10),
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RestaurantDetails.routeName,
              arguments: restaurant);
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: Hero(
                tag: restaurant.pictureId,
                child: Image.network(restaurant.pictureId),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 18,
                      ),
                      Text(restaurant.city)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        size: 18,
                      ),
                      Text(restaurant.rating.toString())
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        final List<Restaurant> restaurant = parsedRestaurant(snapshot.data);
        return ListView.builder(
          itemCount: restaurant.length,
          itemBuilder: (context, index) {
            return _buildRestaurantItem(context, restaurant[index]);
          },
        );
      },
    );
  }
}
