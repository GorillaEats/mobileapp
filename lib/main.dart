import 'package:flutter/material.dart';
import './screens/map.dart';
import './screens/restaurant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Gorilla Eats', initialRoute: '/', routes: {
      '/': (context) => MapScreen(),
    });
  }
}
