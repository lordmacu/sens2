import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sens2/apps/samiya/controllers/catch_weight_controller.dart';

class LiveWeightDisplay extends StatelessWidget {
  final CatchWeightController catchWeightController = Get.put(CatchWeightController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(top: 20, bottom: 30, left: 20, right: 20),
      width: double.infinity,
      color: Colors.grey.shade400.withOpacity(0.2),
      child: Column(
        children: [
          Obx(() => Text(
            catchWeightController.netWeightController.value.text.isNotEmpty
                ? catchWeightController.netWeightController.value.text
                : '0',
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 207, 11, 11),
            ),
          )),
          Obx(() => Text(
            'Peso Neto ${catchWeightController.netWeightController.value.text.isNotEmpty
                ? catchWeightController.getPesoNeto().toStringAsFixed(2)
                : '0.00'} ${catchWeightController.grossWeightController.value.text}',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 148, 8, 8),
            ),
          )),
        ],
      ),
    );
  }
}
