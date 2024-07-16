import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sens2/core/components/buttons/button.dart';
import 'package:sens2/core/components/icons/logo.dart';


class ServidorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 38, 83),
        title: Text(
          'Servidores',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  color: Color.fromARGB(40, 79, 92, 150),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButton<String>(
                            value: 'Protocolo',
                            onChanged: (String? newValue) {},
                            items: <String>[
                              'Protocolo',
                              'Option 2',
                              'Option 3',
                              'Option 4'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(value),
                                    SizedBox(width: 185),
                                  ],
                                ),
                              );
                            }).toList(),
                            underline: Container(
                              height: 1,
                              color: Color.fromARGB(167, 88, 97, 121),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Ruta del Servidor',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Puerto',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ButtonGeneral(
                text: 'Guardar',
                colorValue: Color.fromARGB(255, 25, 38, 83),
                fontSize: 14,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
