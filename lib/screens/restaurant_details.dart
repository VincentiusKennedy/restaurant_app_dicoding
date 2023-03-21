import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';

class RestaurantDetails extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final String id;

  const RestaurantDetails({required this.id, super.key});

  @override
  State<RestaurantDetails> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) =>
          RestaurantDetailProvider(apiService: ApiService(), id: widget.id),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          title: const Text(
            'Detail Restaurant',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Hero(
                      tag: state.restaurantDetail.restaurant.pictureId,
                      child: Stack(
                        children: [
                          Image.network(
                              state.restaurantDetail.restaurant.pictureId),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: Colors.black),
                          color: Colors.black26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Restoran:',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  state.restaurantDetail.restaurant.name,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  overflow: TextOverflow.clip,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Kota:',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  state.restaurantDetail.restaurant.city,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  overflow: TextOverflow.clip,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Deskripsi:',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  state.restaurantDetail.restaurant.description,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  overflow: TextOverflow.clip,
                                )
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('Makanan: '),
                          ),
                          buildContainer(
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.restaurantDetail.restaurant.menus
                                  .foods.length,
                              itemBuilder: (ctx, index) => _buildCardMenu(
                                  ctx,
                                  state.restaurantDetail.restaurant.menus
                                      .foods[index].name),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('Minuman: '),
                          ),
                          buildContainer(
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.restaurantDetail.restaurant.menus
                                  .drinks.length,
                              itemBuilder: (ctx, index) => _buildCardMenu(
                                  ctx,
                                  state.restaurantDetail.restaurant.menus
                                      .drinks[index].name),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Material(
                  child: Text(state.message),
                ),
              );
            } else if (state == ResultState.error) {
              return Center(
                child: Material(
                  child: Text(state.message),
                ),
              );
            } else {
              return const Material(child: Text('KOSONG'));
            }
          },
        ),
      ),
    );
  }
}

Widget buildContainer(Widget child) {
  return Container(
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 238, 215, 238),
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    ),
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    height: 150,
    width: double.infinity,
    child: child,
  );
}

Widget _buildCardMenu(BuildContext context, String menus) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          menus,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    ),
  );
}
