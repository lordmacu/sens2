// current_date_widget.dart
import 'package:flutter/material.dart';
import 'dart:async';

class CurrentDateWidget extends StatefulWidget {
  @override
  _CurrentDateWidgetState createState() => _CurrentDateWidgetState();
}

class _CurrentDateWidgetState extends State<CurrentDateWidget> {
  String _currentDate = '';

  @override
  void initState() {
    super.initState();
    _updateDate();
    _scheduleMidnightUpdate();
  }

  void _updateDate() {
    setState(() {
      _currentDate = DateTime.now().toLocal().toString().split(' ')[0];
    });
  }

  void _scheduleMidnightUpdate() {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day + 1);
    final durationUntilMidnight = midnight.difference(now);

    Timer(durationUntilMidnight, () {
      _updateDate();
      _scheduleMidnightUpdate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today,
            color: Color.fromARGB(255, 11, 19, 68), // Color del icono
            size: 30, // Tamaño del icono
          ),
          SizedBox(width: 10), // Espacio entre el icono y el texto
          Text(
            _currentDate,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 11, 19, 68),
            ),
          ),
        ],
      ),
    );
  }
}
