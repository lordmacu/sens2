import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:sens2/core/components/inputs/input_text.dart';
import 'package:sens2/core/components/inputs/type_ahead.dart';

class ShowAllRollsDialog extends StatelessWidget {
  final List<String> operators;

  const ShowAllRollsDialog({Key? key, required this.operators}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Rollos utilizados', style: TextStyle(color: Color.fromARGB(255, 17, 11, 97), fontSize: 23)),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color.fromARGB(17, 104, 104, 104),
              child: Table(
                border: TableBorder.all(color: const Color.fromARGB(255, 136, 136, 136)),
                columnWidths: const {
                  0: FixedColumnWidth(80.0),
                  1: FixedColumnWidth(90.0),
                  2: FixedColumnWidth(90.0),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text('Etiquetas', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text('Peso total', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text('Peso consumido', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ]),
                 
                 TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: TypeAhead(
                        suggestions: operators,
                        text: "Etiqueta",
                        onSuggestionSelectedCallback: (String suggestion) {
                          
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: InputTextGeneral(
                        text: 'Peso total',
                        controller: TextEditingController(), 
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Peso consumido',
                        ),
                      ),
                    ),
                  ]),
                 
                    TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text('EXT002'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text('500'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text('500'),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text('IMP003'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text('450'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text('450'),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text('IMP004'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text('400'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text('200'),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text('IMP005'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text('1850'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text('1650'),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text('EXT003'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text('470'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text(''),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text('IMP005'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text('520'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text(''),
                    ),
                  ]),
                  
                   TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text('TOTAL', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text('2840', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                      child: Text('', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ]),
               
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cerrar', style: TextStyle(color: Color.fromARGB(255, 19, 10, 136), fontSize: 17)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
