import 'package:flutter/material.dart';

class ReportFormWidget extends StatelessWidget {
  final TextEditingController report1Controller = TextEditingController();
  final TextEditingController report2Controller = TextEditingController();
  final TextEditingController report3Controller = TextEditingController();
  final Function(String, String, String) onSubmit;

  ReportFormWidget({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(234, 255, 255, 255),
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Nuevo Reporte'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: report1Controller,
              decoration: const InputDecoration(labelText: 'Info de Reporte'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: report2Controller,
              decoration: const InputDecoration(labelText: 'Info de Reporte'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: report3Controller,
              decoration: const InputDecoration(labelText: 'Info de Reporte'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  onSubmit(
                    report1Controller.text,
                    report2Controller.text,
                    report3Controller.text,
                  );
                  report1Controller.clear();
                  report2Controller.clear();
                  report3Controller.clear();
                },
                child: const Text('Agregar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
