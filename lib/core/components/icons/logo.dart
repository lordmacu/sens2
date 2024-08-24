import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final int topValue;

  const Logo({
    super.key, 
    required this.topValue,
  }); 

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topValue.toDouble(), 
      left: 0,
      child: SizedBox(
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
