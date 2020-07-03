import 'package:flutter/material.dart';

class RestaurantBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 210.0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.red[400],
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: BackButton(
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text('Taco Bell',
                      style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child:
                        Icon(Icons.brightness_1, size: 8, color: Colors.white)),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Text('Open Now',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(22, 3, 0, 0),
                  child: Text(
                    '3501 E 29th St, Bryan, TX 77802',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: SizedBox(
                    height: 49,
                    width: MediaQuery.of(context).size.width,
                    child: Opacity(
                      opacity: 0.15,
                      child: Image(
                        width: 20,
                        image: AssetImage('assets/fork.png'),
                        repeat: ImageRepeat.repeat,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
