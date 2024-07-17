

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/print_ticket_controller.dart';
import 'package:sens2/apps/apliplast/views/impresion/widget/current_date_widget.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sens2/apps/apliplast/views/impresion/widget/custom_widget.dart';
import 'package:sens2/core/components/inputs/dropdown_text.dart';
import 'package:sens2/core/components/inputs/input_text.dart';
import 'package:sens2/core/components/buttons/button.dart';
import 'package:sens2/core/components/inputs/type_ahead.dart';

class ExtrusionPrintTicket extends StatelessWidget {
 
      PrintTicketController printicketController = Get.put(PrintTicketController());

  final List<String> operators = [
    'Operador 1',
    'Operador 2',
    'Operador 3'
  ]; // Lista de operadores
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 38, 83),
        title: Text(
          'Formulario de Extrusión',
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 8),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      padding: EdgeInsets.only(
                          top: 20, bottom: 30, left: 20, right: 20),
                      width: double.infinity,
                      color: Colors.grey.shade400.withOpacity(0.2),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'N° 10',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 11, 19, 68),
                                ),
                              ),
                              CurrentDateWidget()
                            ],
                          ),
                          SizedBox(height: 16),
                          DropdownText(items: ['Turno', 'Item 2', 'Item 3']),
                          SizedBox(height: 8),
                          TypeAhead(
                            suggestions: operators,
                            text: "Operador",
                            onSuggestionSelectedCallback: (String suggestion) {
                              printicketController
                                  .operatorController.value.text = suggestion;
                            },
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                    TypeAhead(
                      text: "Orden de Producción",
                      onSuggestionSelectedCallback: (String suggestion) {
                        printicketController.operatorController.value.text =
                            suggestion;
                      },
                    ),
                    SizedBox(height: 30),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        'Maquina',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      child: TextFormField(
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          hintText: 'Maquina 1',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        'Medida',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      child: TextFormField(
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          hintText: 'Medida 1',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        'Espesor',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      child: TextFormField(
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          hintText: 'Espesor 1',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        'Color',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      child: TextFormField(
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          hintText: 'Color 1',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        'Densidad',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      child: TextFormField(
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          hintText: 'Densidad 1',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        'Cliente',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      child: TextFormField(
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          hintText: 'Cliente 1',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),

                    CustomWidget(
                    optionalTitle: 'Bobina: 10kg',
                    weightText: '10kg',
                    mainText: 'Peso neto',
                    incrementableValue: '--',
                    buttonText: 'Capturar',
                    optionalText: 'Peso Bruto',
                    optionalNumber: 15,
                  ),
                   
                    SizedBox(height: 10),
                    Container(
                      width: 200,
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextButton(
                        onPressed: () {
                          printicketController.send();
                        },
                        child: Text(
                          'Guardar',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 14, 12, 87),
                          ),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
