import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:gorilla_eats/data/locations.dart';
import 'package:gorilla_eats/screens/restaurant.dart';
import 'package:gorilla_eats/widgets/googlemaps.dart';

class RestaurantCard extends StatefulWidget {
  final Location location;

  RestaurantCard({@required this.location});

  @override
  _RestaurantCardState createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  Color _getColor(double rating) {
    if (rating <= 3.0) {
      return Colors.red[900];
    } else if (rating <= 3.5) {
      return Colors.red[700];
    } else if (rating <= 4.0) {
      return Colors.red[600];
    }
    return Colors.red[400];
  }

  RichText _getPrice(String price) {
    var emptyPrice = '';

    for (var i = price.length; i < 4; i++) {
      emptyPrice += r'$';
    }

    return RichText(
      text: TextSpan(
        text: price,
        style: TextStyle(color: Colors.red[400]),
        children: <TextSpan>[
          TextSpan(
              text: emptyPrice,
              style: TextStyle(
                color: Colors.grey[400],
              )),
        ],
      ),
    );
  }

  @override
  Widget build(context) {
    return GestureDetector(
      child: Card(
        elevation: 2,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 50,
              height: 50,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: _getColor(widget.location.rating),
                ),
                child: Center(
                  child: Text(
                    widget.location.rating.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(widget.location.name),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Icon(Icons.brightness_1,
                          size: 5, color: Colors.grey[500]),
                    ),
                    Text(
                      'Open Now',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(70, 0, 0, 0),
                      child: Text(
                        '3',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(2, 0, 5, 3),
                      child: Icon(Icons.fastfood,
                          size: 15, color: Colors.grey[500]),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    _getPrice(widget.location.price),
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                      child: GestureDetector(
                        child: SizedBox(
                          width: 100,
                          height: 30,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: _getColor(widget.location.rating),
                            ),
                            child: Center(
                              child: Text(
                                'Directions',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: GestureDetector(
                        child: SizedBox(
                          width: 50,
                          height: 30,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[500],
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Call',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
