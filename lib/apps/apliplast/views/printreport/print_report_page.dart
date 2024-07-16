import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/print_report_controller.dart';

import 'package:sens2/core/components/inputs/label_and_input.dart';
import 'package:sens2/core/components/buttons/button.dart';
import 'package:sens2/core/components/inputs/input_text.dart';
import 'package:sens2/core/components/inputs/dropdown_text.dart';
  

class PrintReportPage extends GetView<PrintReportController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 38, 83),
        title: Text('Reporte de Impresion',
            style: TextStyle(color: Colors.white, fontSize: 17)),
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
              Get.back(); // Utilizando Get para navegar hacia atrás
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
              onTap: () {},
            ),
            ListTile(
              title: Text('Opción 2'),
              onTap: () {},
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
                  'Reporte de Impresion',
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
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Preparacion de tinta',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 11, 19, 68)),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Orden de produccion:',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 11, 19, 68)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 0),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: 'Orden de produccion',
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 129, 129, 129)),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    InputTextGeneral(text: 'Turno'),
                    SizedBox(height: 8),
                    InputTextGeneral(text: 'Maquina '),
                    SizedBox(height: 8),
                    Container(
                      width: 380,
                      height: 40,
                      child: TextField(
                        readOnly: true,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'Fecha',
                          suffixIcon: Icon(Icons.calendar_today),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(167, 88, 97, 121)),
                          ),
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2024),
                          );
                          if (pickedDate != null) {}
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Color preparado',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 11, 19, 68)),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'Ingresa color preparado...',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[400],
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      ),
                    ),
                    SizedBox(height: 20),
                    DropdownText(items: ['Color', 'Item 2', 'Item 3']),
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
                    SizedBox(height: 8),
                    InputTextGeneral(text: 'Maquina'),
                    SizedBox(height: 8),
                    InputTextGeneral(text: 'Fuelle'),
                    SizedBox(height: 8),
                    InputTextGeneral(text: 'Color'),
                    SizedBox(height: 8),
                    InputTextGeneral(text: 'kilo'),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(47, 90, 255, 255),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Agregar otro',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
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
                    SizedBox(height: 5),
                    InputTextGeneral(text: 'Materia prima utilizada'),
                    SizedBox(height: 8),
                    InputTextGeneral(text: 'produccion'),
                    SizedBox(height: 8),
                    LabelAndInput(
                      label: 'Subtotal',
                      placeholder: 'Subtotal',
                      labelStyle:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    LabelAndInput(
                      label: 'Total',
                      placeholder: 'Total',
                      labelStyle:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Novedades ',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 11, 19, 68)),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'Ingresa novedades ...',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[400],
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                    fontSize: 10,
                    // onPressed: null, // Temporalmente desactivado
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

class labelAndInput extends StatelessWidget {
  final String label;
  final String placeholder;
  const labelAndInput({
    Key? key,
    required this.label,
    required this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          child: Text(
            label,
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 11, 19, 68)),
          ),
        ),
        Expanded(
          child: InputTextGeneral(text: placeholder),
        ),
      ],
    );
  }
}
