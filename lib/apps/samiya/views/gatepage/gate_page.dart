import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sens2/apps/apliplast/controllers/Gate_controller.dart';
import 'package:sens2/apps/samiya/controllers/catch_weight_controller.dart';

class GatewayPage extends GetView<GateController> {
  final GetStorage box = GetStorage();


  final CatchWeightController catchWeightController = Get.find<CatchWeightController>();

  GatewayPage({super.key});

  @override
  Widget build(BuildContext context) {
     final TextEditingController serverController = TextEditingController(
      text: box.read('serverGatewayUrl') ?? '192.168.100.162',
    );
    final TextEditingController loteController = TextEditingController(
      text: box.read('lote') ?? '100',
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 38, 83),
        title: const Text(
          'Configuracion general',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              width: 360,
              decoration: BoxDecoration(
                color: const Color.fromARGB(40, 79, 92, 150),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Dirección ip del equipo',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: TextField(
                      controller: serverController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'localhost',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Lote',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: loteController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      hintText: '100',
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
          const Spacer(),
          Center(
            child: ButtonGeneral(
              text: 'Guardar',
              onPressed: () {
                // Guardar los valores en GetStorage
                box.write('serverGatewayUrl', serverController.text);
                box.write('lote', loteController.text);

                catchWeightController.loteController.value =int.parse(loteController.text);

                    Get.snackbar('Guardado', 'Configuración guardada con éxito');
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ButtonGeneral extends StatelessWidget {
  final String text;
  final VoidCallback onPressed; // Cambio aquí

  const ButtonGeneral({
    super.key,
    required this.text,
    required this.onPressed, // Y aquí
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 25, 38, 83),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 150),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
