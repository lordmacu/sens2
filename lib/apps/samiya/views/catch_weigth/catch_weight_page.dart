import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sens2/apps/samiya/controllers/catch_weight_controller.dart';
import 'package:sens2/apps/samiya/controllers/fetch_controller.dart';
import 'package:sens2/apps/samiya/views/catch_weigth/Live_weight_display.dart';
import 'package:sens2/core/components/inputs/CategoryTypeAhead.dart';
import 'package:sens2/core/components/modals/menu_drawer.dart';
import 'package:sens2/core/controllers/menu_controller.dart';
import 'package:sens2/core/services/request_queue_service.dart';

class CatchWeight extends StatelessWidget {
  final CatchWeightController catchWeightController =
      Get.put(CatchWeightController());
  final MenuDrawerController menuController = Get.put(MenuDrawerController());
  final GetStorage box = GetStorage();
  final FetchController fetchController = Get.put(FetchController());
  final RequestQueueService requestQueueService = Get.find<RequestQueueService>();

  CatchWeight() {

    catchWeightController.palletController.value.text =
        box.read('pallet') ?? '24';
    catchWeightController.loteController.value =
        int.parse(box.read('lote') ?? '100');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
            icon: Obx(() {
              // Verificar si pendingRequest es mayor que cero para mostrar el icono y el texto
              if (fetchController.pendingRequest.value > 0) {
                return Row(
                  children: [
                    Text(
                      "${fetchController.pendingRequest.value}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    const Icon(Icons.access_alarms_rounded),
                  ],
                );
              } else {
                return const SizedBox.shrink(); // No mostrar nada si es 0
              }
            }),
            onPressed: () {
              requestQueueService.processRequests();
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
                width: screenWidth ,
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
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Obx(() => Text(
                              '${catchWeightController.loteController.value}',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 150, 150, 150),
                              ),
                            )),
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
                      displayFields: ['key'],
                      controller:
                          catchWeightController.supplierController.value,
                      onSuggestionSelectedCallback: (selectedSuggestion) {
                        print('Selected suggestion: $selectedSuggestion');
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
                      displayFields: ['key'],
                      controller: catchWeightController.materiaPrima.value,
                      onSuggestionSelectedCallback: (selectedSuggestion) {
                        print('Selected suggestion: $selectedSuggestion');
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
                            enabled: false, // Deshabilita el TextFormField
                            onChanged: (value) {},
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
                                  text: 'Seleccionar material',
                                  displayFields: const ['key', "tariff"],
                                  suffixText: 'kg',
                                  returnFullObject: true,
                                  controller: catchWeightController
                                      .materialController.value,
                                  onSuggestionSelectedCallback: (suggestion) {
                                    if (suggestion is Map<String, dynamic>) {
                                      catchWeightController
                                              .materialWeight.value =
                                          double.parse(
                                              "${suggestion["fields"]["tariff"]}");
                                    } else if (suggestion is String) {
                                      print('Selected text: $suggestion');
                                    }
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
                                    FilteringTextInputFormatter
                                        .digitsOnly, // Permite solo números
                                  ],
                                  onChanged: (value) {
                                    // Si deseas realizar alguna acción cuando el valor cambie
                                    print('Valor input: $value');
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
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Obx(() {
                        final isPesoValido =
                            catchWeightController.getPesoNeto() > 0;

                        return TextButton(
                          onPressed: isPesoValido
                              ? () {
                                  catchWeightController.send();
                                }
                              : null, // Deshabilita el botón si la condición no se cumple
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors
                                      .grey; // Color cuando está deshabilitado
                                }
                                return const Color.fromARGB(255, 255, 165,
                                    0); // Color naranja vivo cuando está habilitado
                              },
                            ),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
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
                          child: Text(
                            'Enviar',
                            style: TextStyle(
                              color: isPesoValido
                                  ? const Color.fromARGB(255, 255, 255,
                                      255) // Texto blanco cuando está habilitado
                                  : const Color.fromARGB(255, 169, 169,
                                      169), // Texto gris cuando está deshabilitado
                              fontSize: 17,
                            ),
                          ),
                        );
                      }),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextButton(
                        onPressed: () {
                          int currentLote =
                              int.parse(box.read('lote') ?? '100');
                          int newLote = currentLote + 1;
                          box.write('lote', newLote.toString());
                          catchWeightController.loteController.value = newLote;
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
