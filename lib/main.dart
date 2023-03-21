import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/screens/home_page.dart';
import 'package:restaurant_app/screens/restaurant_details.dart';
import 'common/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
              onPrimary: Colors.black,
              secondary: secondaryColor,
            ),
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 222, 233),
        textTheme: myTextTheme,
        appBarTheme: const AppBarTheme(elevation: 0),
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        // RestaurantDetails.routeName: (context) => RestaurantDetails(
        //       restaurant:
        //           ModalRoute.of(context)?.settings.arguments as Restaurant,
        //     ),
      },
    );
  }
}
