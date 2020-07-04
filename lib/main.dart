import 'package:flutter/material.dart';
import './screens/map.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gorilla Eats',
      initialRoute: '/',
      routes: {
        '/': (context) => MapScreen(),
      },
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          colorScheme: Theme.of(context)
              .colorScheme
              .copyWith(secondary: Colors.grey[700]),
        ),
        toggleButtonsTheme: ToggleButtonsThemeData(
          color: Colors.grey[700],
          selectedColor: Colors.red,
          fillColor: Colors.red[100],
          disabledColor: Colors.white,
        ),
      ),
    );
  }
}
