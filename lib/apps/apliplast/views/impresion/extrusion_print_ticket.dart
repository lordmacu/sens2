import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/print_ticket_extrusion_controller.dart';
import 'package:sens2/apps/apliplast/views/impresion/widget/current_date_widget.dart';

import 'package:sens2/apps/apliplast/views/impresion/widget/capture_widget.dart';
import 'package:sens2/core/components/inputs/dropdown_text.dart';
import 'package:sens2/core/components/inputs/input_text.dart';

import 'package:sens2/core/components/inputs/type_ahead.dart';



class PrintTicket extends StatelessWidget {
   final PrintTicketExtrusionController printTicketExtrusionController =
      Get.put(PrintTicketExtrusionController());

  final List<String> operators = [
    'Operador 1',
    'Operador 2',
    'Operador 3'
  ]; // Lista de operadores

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 38, 83),
        title: const Text(
          'Formulario de impresión',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back),
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
            const DrawerHeader(
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
              title: const Text('Opción 1'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Opción 2'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                width: 360,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(22, 79, 92, 150),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 30, left: 20, right: 20),
                      width: double.infinity,
                      color: Colors.grey.shade400.withOpacity(0.2),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'N° 12',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 11, 19, 68),
                                ),
                              ),
                              CurrentDateWidget()
                            ],
                          ),
                          const SizedBox(height: 16),
                          const DropdownText(items: ['Turno', 'Item 2', 'Item 3']),
                          const SizedBox(height: 8),
                          TypeAhead(
                            suggestions: operators,
                            text: "Operador",
                            onSuggestionSelectedCallback: (String suggestion) {
                              printTicketExtrusionController
                                  .operatorController.value.text = suggestion;
                            },
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    TypeAhead(
                      text: "Orden de Producción",
                      onSuggestionSelectedCallback: (String suggestion) {
                        printTicketExtrusionController.operatorController.value.text =
                            suggestion;
                      },
                    ),
                    const SizedBox(height: 30),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.only(left: 8, right: 8),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Maquina',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                        hintText: 'Maquina 1',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.only(left: 8, right: 8),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Tipo de Producto',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                        hintText: 'Producto 1',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.only(left: 8, right: 8),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Color preparado',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                        hintText: 'Color 1',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              child: Column(
                                children: [
                                  const Text(
                                    'Peso Neto Extrusión',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      hintText: 'Extrusión 1',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                    const SizedBox(height: 8),
                    const CaptureWidget(
                      optionalTitle: '',
                      weightText: '10kg',
                      mainText: 'Peso Neto Impresión',
                      incrementableValue: '--',
                      buttonText: 'Capturar',
                      optionalText: '',
                      optionalNumber: 0,
                    ),
                    const SizedBox(height: 18),
                    InputTextGeneral(
                      text: 'Densidad',
                      controller: printTicketExtrusionController
                          .maquinController.value,
                    ),
                    const SizedBox(height: 16),
                    InputTextGeneral(
                      text: 'Cliente',
                      controller: printTicketExtrusionController
                          .maquinController.value,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 200,
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextButton(
                        onPressed: () {
                          printTicketExtrusionController.send();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 14, 12, 87),
                          ),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Guardar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
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