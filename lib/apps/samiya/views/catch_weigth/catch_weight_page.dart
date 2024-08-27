import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/print_ticket_controller.dart';
import 'package:sens2/core/components/inputs/dropdown_text.dart';
import 'package:sens2/core/components/inputs/type_ahead.dart';
import 'package:sens2/core/components/modals/menu_drawer.dart';
import 'package:sens2/core/controllers/menu_controller.dart';

class CatchWeight extends StatelessWidget {
  final PrintTicketController printicketController = Get.put(PrintTicketController());
  final MenuDrawerController menuController = Get.put(MenuDrawerController());

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
          'SAMIYA',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () async{
                final Map<String, String> categoryMenuMapping = {
                  'supplier': 'Proveedor',
                  'material': 'Material',
                  'proveedor': 'Proveedor',
                  'materiaPrima': 'Materia prima',
                };
                menuController.loadMenuItems(categoryMenuMapping);
                Scaffold.of(context).openDrawer();

              },
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back(); 
            },
          ),
        ],
      ),
       drawer: MenuDrawer(),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
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
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 30, left: 20, right: 20),
                      width: double.infinity,
                      color: Colors.grey.shade400.withOpacity(0.2),
                      child: const Column(
                        children: [
                          Text(
                            '0',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 207, 11, 11),
                            ),
                          ),
                          Text(
                            'Peso Neto 0.00',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 148, 8, 8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Lote',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '100',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 150, 150, 150),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Proveedor',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                    TypeAhead(
                      text: 'Proveedor',
                      
                      onSuggestionSelectedCallback: (String suggestion) {
                        printicketController.operatorController.value.text = suggestion;
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Materia Prima',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                    TypeAhead(
                      text: 'Materia Prima',
                     
                      onSuggestionSelectedCallback: (String suggestion) {
                        printicketController.operatorController.value.text = suggestion;
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Pallet',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Pallet',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Taras',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Column(
                              children: [
                                const SizedBox(height: 8),
                                TypeAhead(
                                  text: "Graveta",
                                  onSuggestionSelectedCallback:
                                      (String suggestion) {
                                    printicketController
                                        .operatorController.value.text =
                                        suggestion;
                                  },
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
                                const SizedBox(height: 8),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: "Graveta 2",  // Puedes poner aquí el texto que quieras mostrar como etiqueta
                                    border: OutlineInputBorder(),  
                                  ),
                                  keyboardType: TextInputType.number,  
                                  onChanged: (value) {
                                    
                                    printicketController.operatorController.value.text = value;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 500,
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextButton(
                        onPressed: () {
                          printicketController.send();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 224, 211, 138),
                          ),
                          padding: MaterialStateProperty.all<
                              EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 20.0),
                          ),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Enviar',
                          style: TextStyle(
                            color: Color.fromARGB(255, 129, 123, 68),
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 500,
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextButton(
                        onPressed: () {
                          printicketController.send();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 214, 212, 212),
                          ),
                          padding: MaterialStateProperty.all<
                              EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 20.0),
                          ),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Cerrar Lote',
                          style: TextStyle(
                              color: Color.fromARGB(255, 43, 41, 41),
                              fontSize: 17),
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

