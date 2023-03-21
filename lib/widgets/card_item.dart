import 'package:flutter/material.dart';

import '../data/models/restaurant.dart';

class CardItem extends StatelessWidget {
  final Restaurant restaurant;

  const CardItem({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Card(
        margin: const EdgeInsets.fromLTRB(5, 5, 5, 10),
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: InkWell(
          onTap: () {
            // Navigator.pushNamed(context, RestaurantDetails.routeName,
            //     arguments: restaurant);
          },
          child: Column(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                child: Hero(
                  tag:
                      "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
                  child: Image.network(
                      "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}"),
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
      ),
    );
  }
}
