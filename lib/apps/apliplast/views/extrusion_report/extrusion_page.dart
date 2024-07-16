import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/gate_controller.dart';
import 'package:sens2/core/components/buttons/button.dart';
import 'package:sens2/core/components/inputs/input_text.dart';
import 'package:sens2/core/components/inputs/dropdown_text.dart';


class ExtrusionReport extends GetView<GateController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 38, 83),
        title: Text(
          'Extrusion Report',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Opción 1'),
              onTap: () {
                // Lógica para la opción 1
              },
            ),
            ListTile(
              title: Text('Opción 2'),
              onTap: () {
                // Lógica para la opción 2
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              width: 360,
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Reporte de extrusión',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 11, 19, 68)),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                width: 360,
                decoration: BoxDecoration(
                  color: Color.fromARGB(22, 79, 92, 150),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Materia prima utilizada',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 11, 19, 68)),
                      ),
                    ),
                    SizedBox(height: 10),
                    InputTextGeneral(text: 'Kilos'),
                    SizedBox(height: 10),
                    DropdownButton<String>(
                items: ['Color', 'Item 2', 'Item 3'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // Implementa la lógica para cuando se selecciona un elemento del menú desplegable
                },
              ),
                    SizedBox(height: 10),
                    InputTextGeneral(text: 'Número'),
                    SizedBox(height: 10),
                    InputTextGeneral(text: 'Ancho'),
                    SizedBox(height: 10),
                    InputTextGeneral(text: 'Espesor'),
                    SizedBox(height: 10),
                    InputTextGeneral(text: 'Peso'),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                width: 360,
                decoration: BoxDecoration(
                  color: Color.fromARGB(22, 79, 92, 150),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 8),
                    InputTextGeneral(text: 'Saldo anterior'),
                    SizedBox(height: 8),
                    InputTextGeneral(text: 'Materia prima utilizada'),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                width: 360,
                decoration: BoxDecoration(
                  color: Color.fromARGB(22, 79, 92, 150),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LabelAndInput(
                      label: 'Subtotal',
                      placeholder: 'Subtotal',
                      labelStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 11, 19, 68),
                      ),
                    ),
                    SizedBox(height: 20),
                    LabelAndInput(
                      label: 'Scrap',
                      placeholder: 'Scrap',
                      labelStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 11, 19, 68),
                      ),
                    ),
                    LabelAndInput(
                      label: 'Total',
                      placeholder: 'Total',
                      labelStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 11, 19, 68),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              margin: EdgeInsets.only(bottom: 13, top: 10, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 2),
                  ButtonGeneral(
                    text: 'Guardar',
                    colorValue: Color.fromARGB(255, 14, 12, 87),
                    fontSize: 13,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LabelAndInput extends StatelessWidget {
  final String label;
  final String placeholder;
  final TextStyle labelStyle;
  
  const LabelAndInput({
    Key? key,
    required this.label,
    required this.placeholder,
    required this.labelStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          child: Text(
            label,
            style: labelStyle,
          ),
        ),
        Expanded(
          child: InputTextGeneral(text: placeholder),
        ),
      ],
    );
  }
}
