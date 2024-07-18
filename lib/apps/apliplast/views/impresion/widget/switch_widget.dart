import 'package:flutter/material.dart';

class SwitchState extends StatefulWidget {
  const SwitchState({super.key});

  @override
  State<SwitchState> createState() => _SwitchState();
}

class _SwitchState extends State<SwitchState> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
    
      value: light,
      activeColor: Color.fromARGB(255, 15, 26, 85),
      inactiveThumbColor: Color.fromARGB(127, 14, 10, 71), 
      inactiveTrackColor: Color.fromARGB(255, 194, 194, 194), 
      onChanged: (bool value) {
       
        setState(() {
          light = value;
        });
      },
    );
  }
}
