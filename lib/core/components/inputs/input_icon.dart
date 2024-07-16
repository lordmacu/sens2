import 'package:flutter/material.dart';


class InputGeneral extends StatelessWidget {
  final String text;
  final IconData icon;

  const InputGeneral({
    super.key, required this.text, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: 370,
        child: TextField(
                decoration: InputDecoration(
                  hintText: text,
                  filled: true,
                  hintStyle: TextStyle(color: Color.fromARGB(255, 25, 38, 83)),
                  fillColor: Color.fromARGB(73, 210, 209, 231).withOpacity(0.7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  prefixIcon: Icon(icon, color: Color.fromARGB(255, 25, 38, 83)),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
      ),
    );
  }
}