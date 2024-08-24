import 'package:flutter/material.dart';
import 'package:sens2/core/components/buttons/edit_buton.dart';
import 'package:sens2/core/components/modals/edit_modal.dart';

class ShowAllRollsTable extends StatelessWidget {
  final List<String> operators;

  const ShowAllRollsTable({super.key, required this.operators});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: const Color.fromARGB(17, 104, 104, 104),
            child: Table(
              border: TableBorder.all(color: const Color.fromARGB(255, 136, 136, 136)),
              children: [
                const TableRow(children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Text('Etiquetas', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Text('Peso total', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Text('Peso consumido', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        EditButton(onPressed: () {
                         showEditDialog(context);
                        }),
                        const Expanded(child: Text('EXT001')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        EditButton(onPressed: () {
                         showEditDialog(context);
                        }),
                        const Expanded(child: Text('500')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        EditButton(onPressed: () {
                         showEditDialog(context);
                        }),
                        const Expanded(
                          child: Text(
                          'ok',
                          style: TextStyle(
                            color: Color.fromARGB(255, 66, 151, 26), 
                            fontSize: 16.0, 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ), 
                      ],
                    ),
                  ),
                ]),
               
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        EditButton(onPressed: () {
                         showEditDialog(context);
                        }),
                        const Expanded(child: Text('EXT002')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        EditButton(onPressed: () {
                         showEditDialog(context);
                        }),
                        const Expanded(child: Text('500')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        EditButton(onPressed: () {
                         showEditDialog(context);
                        }),
                        const Expanded(child: Text('500')),
                      ],
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        EditButton(onPressed: () {
                         showEditDialog(context);
                        }),
                        const Expanded(child: Text('IMP003')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        EditButton(onPressed: () {
                         showEditDialog(context);
                        }),
                        const Expanded(child: Text('450')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        EditButton(onPressed: () {
                         showEditDialog(context);
                        }),
                        const Expanded(child: Text('450')),
                      ],
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        EditButton(onPressed: () {
                         showEditDialog(context);
                        }),
                        const Expanded(child: Text('IMP004')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        EditButton(onPressed: () {
                         showEditDialog(context);
                        }),
                        const Expanded(child: Text('400')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        EditButton(onPressed: () {
                         showEditDialog(context);
                        }),
                        const Expanded(child: Text('200')),
                      ],
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        EditButton(onPressed: () {
                         showEditDialog(context);
                        }),
                        const Expanded(child: Text('IMP005')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        EditButton(onPressed: () {
                         showEditDialog(context);
                        }),
                        const Expanded(child: Text('1850')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        EditButton(onPressed: () {
                         showEditDialog(context);
                        }),
                        const Expanded(child: Text('1650')),
                      ],
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        EditButton(onPressed: () {
                         showEditDialog(context);
                        }),
                        const Expanded(child: Text('EXT003')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        EditButton(onPressed: () {
                         showEditDialog(context);
                        }),
                        const Expanded(child: Text('470')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        EditButton(onPressed: () {
                         showEditDialog(context);
                        }),
                        const Expanded(child: Text('')),
                      ],
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        EditButton(onPressed: () {
                         showEditDialog(context);
                        }),
                        const Expanded(child: Text('IMP005')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        EditButton(onPressed: () {
                         showEditDialog(context);
                        }),
                        const Expanded(child: Text('520')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        EditButton(onPressed: () {
                         showEditDialog(context);
                        }),
                        const Expanded(child: Text('')),
                      ],
                    ),
                  ),
                ]),
                const TableRow(children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Text('TOTAL', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Text('2840', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Text('', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
