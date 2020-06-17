import 'package:flutter/material.dart';
import 'package:gorilla_eats/widgets/restaurant_banner.dart';

class RestaurantScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: RestaurantBanner(),
    );
  }
}