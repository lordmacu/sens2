import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/end_work_extrusion_controller.dart';
import 'package:sens2/apps/apliplast/views/impresion/widget/current_date_widget.dart';
import 'package:sens2/core/components/inputs/dropdown_text.dart';
import 'package:sens2/core/components/inputs/input_text.dart';
import 'package:sens2/core/components/inputs/type_ahead.dart';
import 'package:sens2/apps/apliplast/views/impresion/widget/capture_widget.dart';
import 'package:sens2/apps/apliplast/views/impresion/widget/filter_options_widget.dart';

// ignore: must_be_immutable
class ExtrusionEndWork extends StatelessWidget {
  EndWorkExtrusionController endWorkExtrusionController = Get.put(EndWorkExtrusionController());

  final List<String> operators = [
    'Operador 1',
    'Operador 2',
    'Operador 3'
  ];

  ExtrusionEndWork({super.key}); // Lista de operadores


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 38, 83),
        title: const Text(
          'Final de turno',
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
                                'N° 13',
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
                              endWorkExtrusionController.operatorController.value.text =
                                  suggestion;
                            },
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    TypeAhead(
                      suggestions: operators,
                      text: "Operador",
                      onSuggestionSelectedCallback: (String suggestion) {
                        endWorkExtrusionController.operatorController.value.text =
                            suggestion;
                      },
                    ),
                    const SizedBox(height: 8),
                    InputTextGeneral(
                      text: 'Maquina',
                      controller: endWorkExtrusionController.maquinController.value,
                    ),
                    const SizedBox(height: 8),
                    InputTextGeneral(
                      text: 'Cliente',
                      controller: endWorkExtrusionController.clientController.value,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      padding:
                          const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      width: double.infinity,
                      color: Colors.grey.shade400.withOpacity(0.2),
                      child: Column(
                        children: [
                          FilterOptionsWidget(
                            controller: endWorkExtrusionController.orderController.value,
                            options: const [
                              'Impresion 1',
                              'Impresion 2',
                              'Impresion 3',
                              'Impresion 4',
                              'Impresion 5',
                              'Impresion 6',
                            ],
                            title: 'Rollos Trabajados',
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Subtotal: 500',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 11, 19, 68),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const CaptureWidget(
                      mainText: 'Torta de rollos',
                      incrementableValue: '--',
                      weightText: '10kg',
                      buttonText: 'Capturar',
                    ),
                    const SizedBox(height: 16),
                    const CaptureWidget(
                      buttonText: 'Capturar',
                      weightText: '10kg',
                      mainText: 'Desperdicions de rollos',
                      incrementableValue: '--',
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Total de Producción : 500',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 11, 19, 68),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      padding:
                          const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      width: double.infinity,
                      color: Colors.grey.shade400.withOpacity(0.2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Materias primas',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 11, 19, 68),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 140, // Ancho deseado
                                child: Text(
                                  'Materia prima 1',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),

                              const SizedBox(
                                  width:
                                      10), // Espacio entre los elementos del Row
                              Expanded(
                                flex: 5,
                                child: InputTextGeneral(
                                  text: 'Ingresa',
                                  controller: endWorkExtrusionController
                                      .materialController.value,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10), // Espacio entre los elementos
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 140, // Ancho deseado
                                child: Text(
                                  'Materia prima 2',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),

                              const SizedBox(
                                  width:
                                      10), // Espacio entre los elementos del Row
                              Expanded(
                                flex: 5,
                                child: InputTextGeneral(
                                  text: 'Ingresa',
                                  controller: endWorkExtrusionController
                                      .materialController.value,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          const Text(
                            'Materia Prima Utilizada : 500',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 11, 19, 68),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    InputTextGeneral(
                      text: 'Saldo anterior',
                      controller: endWorkExtrusionController.balanceController.value,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Saldo actual: 500',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 11, 19, 68),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 200,
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextButton(
                        onPressed: () {
                          endWorkExtrusionController.send();
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
