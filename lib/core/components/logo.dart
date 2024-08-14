import 'package:flutter/material.dart';

class LogoPrincipal extends StatelessWidget {
  final int topValue;

  const LogoPrincipal({
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
          'lib/core/assets/icon-seas.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
