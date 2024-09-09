import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sens2/core/controllers/table_controller.dart';
import 'package:sens2/core/components/modals/editable_fields_dialog_content.dart';
import 'package:sens2/core/components/modals/menu_drawer.dart';

class GeneralTable extends StatelessWidget {
  final TableController tableController = Get.put(TableController());
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

  GeneralTable({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 38, 83),
        title: Obx(() {
          return Text(
            tableController.title.value,
            style: const TextStyle(color: Colors.white, fontSize: 17),
          );
        }),
        iconTheme: const IconThemeData(color: Colors.white),


      ),
       body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50.0,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Filtrar',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                          ),
                          onChanged: (value) {
                            tableController.filterTable(value); // Apply filter
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _horizontalScrollController,
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    controller: _verticalScrollController,
                    scrollDirection: Axis.vertical,
                    child: Obx(() {
                      return SizedBox(
                        width: screenWidth,
                        child: DataTable(
                          columns: [
                            ...tableController.headers.keys.map((header) {
                              return DataColumn(
                                label: InkWell(
                                  onTap: () {
                                    tableController.sortData(header);
                                  },
                                  child: Row(
                                    children: [
                                      Text(header),
                                      if (tableController.sortedColumn.value ==
                                          header)
                                        Icon(tableController.isAscending.value
                                            ? Icons.arrow_upward
                                            : Icons.arrow_downward),
                                    ],
                                  ),
                                ),
                              );
                            }),
                            const DataColumn(label: Text('OPCIONES')), // No sorting here
                          ],
                          rows: tableController.filteredData.map((row) {
                            return DataRow(cells: [
                              ...tableController.headers.keys.map((header) {
                                return DataCell(Text(row[header]?.toString() ?? ''));
                              }),
                              DataCell(
                                Builder(
                                  builder: (BuildContext context) {
                                    return IconButton(
                                      icon: const Icon(Icons.more_vert),
                                      onPressed: () {
                                        final RenderBox renderBox = context.findRenderObject() as RenderBox;
                                        final Offset offset = renderBox.localToGlobal(Offset.zero);
                                        showMenu(
                                          context: context,
                                          position: RelativeRect.fromLTRB(
                                            offset.dx,
                                            offset.dy,
                                            offset.dx + 1,
                                            offset.dy + 1,
                                          ),
                                          items: [
                                            const PopupMenuItem<String>(
                                              value: 'edit',
                                              child: Text('Editar'),
                                            ),
                                            const PopupMenuItem<String>(
                                              value: 'delete',
                                              child: Text('Borrar'),
                                            ),
                                          ],
                                        ).then((value) {
                                          if (value == 'edit') {
                                            final selectedItem = row;
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(15.0),
                                                  ),
                                                  backgroundColor: const Color.fromARGB(255, 255, 253, 244),
                                                  titlePadding: EdgeInsets.zero,
                                                  title: Container(
                                                    padding: const EdgeInsets.all(16.0),
                                                    decoration: const BoxDecoration(
                                                      color: Color.fromARGB(255, 25, 38, 83),
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(15.0),
                                                        topRight: Radius.circular(15.0),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      'Editar',
                                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                                    ),
                                                  ),
                                                  content: EditableFieldsDialogContent(
                                                    editableFieldsMapping: tableController.editableFields.value,
                                                    initialValues: selectedItem, // Pass current values to the dialog
                                                  ),
                                                  actions: [
                                                    SizedBox(
                                                      width: 100,
                                                      child: TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                        style: ButtonStyle(
                                                          backgroundColor: MaterialStateProperty.all<Color>(
                                                              const Color.fromARGB(255, 231, 230, 230)),
                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10.0),
                                                              side: const BorderSide(
                                                                  color: Color.fromARGB(255, 201, 201, 201),
                                                                  width: 2.0),
                                                            ),
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          'Cancelar',
                                                          style: TextStyle(
                                                              color: Color.fromARGB(255, 21, 19, 107)),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 100,
                                                      child: TextButton(
                                                        onPressed: () {
                                                          tableController.saveEditedItem(selectedItem); // Save edited data
                                                          Navigator.of(context).pop();
                                                        },
                                                        style: ButtonStyle(
                                                          backgroundColor: MaterialStateProperty.all<Color>(
                                                              const Color.fromARGB(255, 22, 37, 92)),
                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10.0),
                                                              side: const BorderSide(
                                                                  color: Color.fromARGB(255, 21, 14, 90),
                                                                  width: 2.0),
                                                            ),
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          'Guardar',
                                                          style: TextStyle(color: Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          } else if (value == 'delete') {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text('Confirmar eliminación'),
                                                  content: const Text('¿Estás seguro de que quieres eliminar este elemento?'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: const Text('Cancelar'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: const Text('Eliminar'),
                                                      onPressed: () {
                                                        tableController.deleteItem(row['id']);
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                            ]);
                          }).toList(),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 25, 38, 83),
          child: const Icon(Icons.add),
          onPressed: () {
            final editableFieldsMapping = tableController.editableFields;
            final Map<String, dynamic> initialValues = {};
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  backgroundColor: const Color.fromARGB(255, 255, 253, 244),
                  titlePadding: EdgeInsets.zero,
                  title: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 25, 38, 83),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                    ),
                    child: const Text(
                      'Agregar',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  content: EditableFieldsDialogContent(
                    editableFieldsMapping: editableFieldsMapping,
                    initialValues: initialValues, // Pass empty values for new items
                  ),
                  actions: [
                    SizedBox(
                      width: 100,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 231, 230, 230)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(color: Color.fromARGB(255, 201, 201, 201), width: 2.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(color: Color.fromARGB(255, 21, 19, 107)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: TextButton(
                        onPressed: () {
                          tableController.addNewItem(); // Add new item
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 22, 37, 92)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(color: Color.fromARGB(255, 21, 14, 90), width: 2.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Agregar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
