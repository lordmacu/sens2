import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sens2/apps/samiya/controllers/tara_controller.dart';
import 'package:sens2/core/components/modals/menu_drawer.dart';

class GeneralTable extends StatelessWidget {
  final TableController tableController = Get.put(TableController());
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // Obtener el ancho de la vista
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 38, 83),
        title: Obx(() {
          return Text(
            tableController.title.value,
            style: TextStyle(color: Colors.white, fontSize: 17),
          );
        }),
        iconTheme: IconThemeData(color: Colors.white),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      drawer: MenuDrawer(),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [

                    Expanded(
                      child: Container(
                        height: 50.0,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Filtrar',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                          ),
                          onChanged: (value) {
                            tableController.filterTable(value);  // Aplicar filtro
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
                      return Container(
                        width: screenWidth,
                        child: DataTable(
                          columns: [
                            ...tableController.headers.keys.map((header) {
                              return DataColumn(label: Text(header));
                            }).toList(),
                            DataColumn(label: Text('OPCIONES')), // Columna para las opciones
                          ],
                          rows: tableController.filteredData.map((row) {
                            return DataRow(cells: [
                              ...tableController.headers.keys.map((header) {
                                return DataCell(Text(row[header]?.toString() ?? ''));
                              }).toList(),
                              DataCell(
                                Builder(
                                  builder: (BuildContext context) {
                                    return IconButton(
                                      icon: Icon(Icons.more_vert),
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
                                            PopupMenuItem<String>(
                                              value: 'edit',
                                              child: Text('Editar'),
                                            ),
                                            PopupMenuItem<String>(
                                              value: 'delete',
                                              child: Text('Borrar'),
                                            ),
                                          ],
                                        ).then((value) {
                                          if (value == 'edit') {
                                            // Lógica para editar
                                          } else if (value == 'delete') {
                                            // Lógica para borrar
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
          backgroundColor: Color.fromARGB(255, 25, 38, 83),
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  backgroundColor: Color.fromARGB(255, 255, 253, 244),
                  titlePadding: EdgeInsets.zero,
                  title: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 25, 38, 83),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      'Agregar',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Tara',
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Peso',
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    Container(
                      width: 100,
                      child: TextButton(
                        child: Text(
                          'Cancelar',
                          style: TextStyle(
                              color: Color.fromARGB(255, 21, 19, 107)),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 231, 230, 230)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                  color: Color.fromARGB(255, 201, 201, 201),
                                  width: 2.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      child: TextButton(
                        child: Text(
                          'Agregar',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          // Implementar funcionalidad de guardar aquí
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 22, 37, 92)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                  color: Color.fromARGB(255, 21, 14, 90),
                                  width: 2.0),
                            ),
                          ),
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
