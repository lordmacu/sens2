import 'package:flutter/material.dart';

class ReportFormWidget extends StatelessWidget {
  final TextEditingController report1Controller = TextEditingController();
  final TextEditingController report2Controller = TextEditingController();
  final TextEditingController report3Controller = TextEditingController();
  final Function(String, String, String) onSubmit;

  ReportFormWidget({Key? key, required this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(234, 255, 255, 255),
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Nuevo Reporte'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: report1Controller,
              decoration: InputDecoration(labelText: 'Info de Reporte'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: report2Controller,
              decoration: InputDecoration(labelText: 'Info de Reporte'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: report3Controller,
              decoration: InputDecoration(labelText: 'Info de Reporte'),
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
                child: Text('Agregar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
