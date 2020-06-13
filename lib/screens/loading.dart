import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'loading...',
          style:
              TextStyle(fontFamily: 'Avenir-Medium', color: Colors.grey[400]),
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}
