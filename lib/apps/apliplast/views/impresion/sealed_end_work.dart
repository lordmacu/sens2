import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/end_work_sealed_controller.dart';
import 'package:sens2/apps/apliplast/views/impresion/widget/current_date_widget.dart';
import 'package:sens2/core/components/inputs/dropdown_text.dart';
import 'package:sens2/core/components/inputs/type_ahead.dart';
import 'widget/capture_widget.dart';
import 'package:sens2/apps/apliplast/views/impresion/widget/show_rolls_dialog.dart';
import 'package:sens2/apps/apliplast/views/impresion/widget/list_data_widget.dart';  // Importa el nuevo widget

// ignore: must_be_immutable
class SealedEndWork extends StatelessWidget {
  EndWorkSealedController endWorkSealedController = Get.put(EndWorkSealedController());

  final List<String> operators = [
    'Operador 1',
    'Operador 2',
    'Operador 3'
  ];

  SealedEndWork({super.key}); // Lista de operadores


  void _showListData(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  ListDataWidget();
      },
    );
  }

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
                                'N° 15',
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
                            controller: TextEditingController(),
                            suggestions: operators,
                            text: "Operador",
                            onSuggestionSelectedCallback: (String suggestion) {
                              endWorkSealedController.operatorController.value.text =
                                  suggestion;
                            },
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    TypeAhead(
                      controller: TextEditingController(),
                      suggestions: operators,
                      text: "Orden de producción",
                      onSuggestionSelectedCallback: (String suggestion) {
                        endWorkSealedController.operatorController.value.text =
                            suggestion;
                      },
                    ),
                      const SizedBox(height: 16),
                     TypeAhead(
                       controller: TextEditingController(),
                      suggestions: operators,
                      text: "Maquina",
                      onSuggestionSelectedCallback: (String suggestion) {
                        endWorkSealedController.operatorController.value.text =
                            suggestion;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Rollos utilizados',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 11, 19, 68),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Manejar la acción de agregar
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 5, 16, 77), // Color del texto
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Tamaño del botón
                            ),
                            child: const Text('Agregar'),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                   ShowAllRollsTable(
            operators: operators),
              const SizedBox(height: 16),
                    const SizedBox(height: 8),
                    const Text(
                      'Subtotal de peso rollos: 1650',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 11, 19, 68),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const CaptureWidget(
                      buttonText: 'Capturar',
                      weightText: '10kg',
                      mainText: 'Sacos',
                      incrementableValue: '--',
                    ),
                    const SizedBox(height: 16),
                    const CaptureWidget(
                      buttonText: 'Capturar',
                      weightText: '10kg',
                      mainText: 'Empaque',
                      incrementableValue: '--',
                      
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Total de material utilizado : 500',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 11, 19, 68),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      color: Colors.grey.shade400.withOpacity(0.2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 150,
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: const Text(
                                  'Total fundas: 32',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width:
                                      10), // Espacio entre los elementos del Row
                              Container(
                                width: 110,
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: TextButton(
                                  onPressed: () {
                                    _showListData(context);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      const Color.fromARGB(255, 14, 12, 87),
                                    ),
                                    padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                      const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 20.0),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Ver todas',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    
                     const Text(
                      'Peso neto fundas: 1650',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 11, 19, 68),
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    const CaptureWidget(
                      buttonText: 'Capturar',
                      weightText: '10kg',
                      mainText: 'Desperdicio',
                      incrementableValue: '--',
                    ),
                    const SizedBox(height: 16),
               
                  
                    const Text(
                      'Total de produccion : 500',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 11, 19, 68),
                      ),
                    ),
                    const CaptureWidget(
                      buttonText: 'Capturar',
                      weightText: 'Saldo: 500',
                      mainText: '',
                      incrementableValue: null,
                       showButton: false,
                    ),
                    
                    const SizedBox(height: 8),
                    Container(
                      width: 200,
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextButton(
                        onPressed: () {
                          endWorkSealedController.send();
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
