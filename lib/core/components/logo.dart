import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final int topValue;

  const Logo({
    Key? key, 
    required this.topValue,
  }) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topValue.toDouble(), 
      left: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 130,
        child: Image.asset(
          'assets/seans-icon.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
