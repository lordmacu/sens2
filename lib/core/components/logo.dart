import 'package:flutter/material.dart';

class LogoPrincipal extends StatelessWidget {
  final int topValue;

  const LogoPrincipal({
    super.key, 
    required this.topValue,
  }); 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 130,
      child: Image.asset(
        'lib/core/assets/icon-seas.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
