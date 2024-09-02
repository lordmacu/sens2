import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListDataWidget extends StatelessWidget {
  final List<int> numbers = [100, 200, 300, 400, 500, 600];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Total fundas', style: TextStyle(color: Color.fromARGB(255, 17, 11, 97), fontSize: 23)),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Get.offNamed('/');
            },
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color.fromARGB(17, 104, 104, 104),
              child: Table(
                border: TableBorder.all(color: const Color.fromARGB(255, 136, 136, 136)),
                children: [
                  const TableRow(children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Fundas', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ]),
                  ...numbers.map((number) {
                    return TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(number.toString()),
                      ),
                    ]);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
