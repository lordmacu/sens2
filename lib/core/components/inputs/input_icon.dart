import 'package:flutter/material.dart';


class InputGeneral extends StatelessWidget {
  final String text;
  final IconData icon;
  final controller;

  const InputGeneral({
    super.key, required this.text, required this.icon, this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: 370,
        child: TextField(
          controller: controller,
                decoration: InputDecoration(
                  hintText: text,
                  filled: true,
                  hintStyle: const TextStyle(color: Color.fromARGB(255, 25, 38, 83)),
                  fillColor: const Color.fromARGB(73, 210, 209, 231).withOpacity(0.7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  prefixIcon: Icon(icon, color: const Color.fromARGB(255, 25, 38, 83)),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
      ),
    );
  }
}