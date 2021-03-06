import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:gorilla_eats/data/location.dart';
import 'package:gorilla_eats/data/models/restaurantcard.dart';
import 'package:gorilla_eats/screens/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

class RestaurantCard extends StatefulWidget {
  final Location location;
  final bool onMap;

  RestaurantCard({@required this.location, @required this.onMap});

  @override
  _RestaurantCardState createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  var onScreen = false;

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

  Future<void> _launchURL(String prefix, String postfix) async {
    if (await canLaunch(prefix + postfix)) {
      await launch(prefix + postfix);
    } else {
      throw 'Could not launch $prefix$postfix';
    }
  }

  @override
  Widget build(context) {
    return VisibilityDetector(
      key: Key(widget.location.id),
      onVisibilityChanged: (info) {
        if (widget.onMap && info.visibleFraction > .5) {
          onScreen = true;
          Provider.of<RestaurantCardSelectedModel>(context, listen: false)
              .updateSelectedCard(widget.location.id);
        } else {
          onScreen = false;
        }
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
                builder: (context) =>
                    RestaurantScreen(location: widget.location)),
          );
        },
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
                    color: Colors.red[400],
                  ),
                  child: Center(
                    child: Text(
                      widget.location.reviewMeta.veganRating.toString(),
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
                      Text(widget.location.restaurantId.name),
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
                          widget.location.numOfItems.toString(),
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
                      _getPrice(widget.location.priceRange),
                      Padding(
                        padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                        child: GestureDetector(
                          onTap: () {
                            _launchURL(
                              'https://maps.google.com/?q=',
                              widget.location.address.toString(),
                            );
                          },
                          child: SizedBox(
                            width: 100,
                            height: 30,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.red[400],
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
                          onTap: () {
                            _launchURL('tel:', widget.location.telephone);
                          },
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
      ),
    );
  }
}
