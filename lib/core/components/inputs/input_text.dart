import 'package:flutter/material.dart';



class InputTextGeneral extends StatelessWidget {
    final String text;
    final TextEditingController? controller;
  const InputTextGeneral({
    super.key, required this.text, this.controller,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Padding(
        padding: EdgeInsets.only(bottom: 0),
        child: TextField(
          keyboardType: TextInputType.number,
          
          style: TextStyle(
              color: Colors.black), 
          decoration: InputDecoration(
            hintText: text,
            hintStyle: TextStyle(
               fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 129, 129,
                    129)), 
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
          controller: controller,
        ),
      ),
    );
  }
}
