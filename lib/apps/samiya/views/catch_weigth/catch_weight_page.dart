import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:sens2/apps/samiya/controllers/catch_weight_controller.dart';
import 'package:sens2/apps/samiya/views/catch_weigth/Live_weight_display.dart';
import 'package:sens2/core/components/inputs/CategoryTypeAhead.dart';
import 'package:sens2/core/components/modals/menu_drawer.dart';
import 'package:sens2/core/controllers/menu_controller.dart';
import 'package:logger/logger.dart';

class CatchWeight extends StatelessWidget {
  final CatchWeightController catchWeightController =
      Get.put(CatchWeightController());
  final MenuDrawerController menuController = Get.put(MenuDrawerController());
  final GetStorage box = GetStorage();
  final Logger logger = Logger();

  // Constructor que incluye el parámetro key
  CatchWeight({super.key}) {
    // Inicializa los controladores con los valores almacenados en GetStorage
    catchWeightController.palletController.value.text =
        box.read('pallet') ?? '';
  }

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
              onPressed: () async {
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
            icon: const Row(
              children: [Text("3"), Icon(Icons.access_alarms_rounded)],
            ),
            onPressed: () {
              Get.offNamed('/');
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.offNamed('/');
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
                    LiveWeightDisplay(),
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
                    CategoryTypeAhead(
                      categoryName: 'supplier',
                      text: 'Seleccionar proveedor',
                      searchKey: 'key',
                      controller:
                          catchWeightController.supplierController.value,
                      onSuggestionSelectedCallback: (selectedSuggestion) {
                        logger.d('Selected suggestion: $selectedSuggestion');
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
                    CategoryTypeAhead(
                      categoryName: 'materiaPrima',
                      text: 'Seleccionar Materia Prima',
                      searchKey: 'key',
                      controller: catchWeightController.materiaPrima.value,
                      onSuggestionSelectedCallback: (selectedSuggestion) {
                        logger.d('Selected suggestion: $selectedSuggestion');
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
                            controller:
                                catchWeightController.palletController.value,
                            decoration: const InputDecoration(
                              labelText: 'Pallet',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              // Acciones al cambiar el valor
                            },
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
                                CategoryTypeAhead(
                                  categoryName: 'material',
                                  text: 'Seleccionar Materia Prima',
                                  searchKey: 'key',
                                  controller: catchWeightController
                                      .materialController.value,
                                  onSuggestionSelectedCallback:
                                      (selectedSuggestion) {
                                    logger.d(
                                        'Selected suggestion: $selectedSuggestion');
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
                                TextFormField(
                                  controller: catchWeightController
                                      .operatorController.value,
                                  decoration: const InputDecoration(
                                    labelText: "Valor",
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  onChanged: (value) {
                                    logger.d('Valor input: $value');
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
                          catchWeightController.send();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 224, 211, 138),
                          ),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 20.0),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                          //printicketController.send();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 214, 212, 212),
                          ),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 20.0),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
