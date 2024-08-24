import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sens2/apps/samiya/controllers/lote_controller.dart'; 
import 'package:sens2/core/components/modals/menu_drawer.dart';
import 'package:sens2/core/controllers/menu_controller.dart';
import 'package:intl/intl.dart';

class TableLotePage extends StatefulWidget {
  const TableLotePage({super.key});

  @override
  _TableLotePageState createState() => _TableLotePageState();
}

class _TableLotePageState extends State<TableLotePage> {
  final List<Map<String, dynamic>> data = [
    {"fecha_creacion": "2024-07-23", "lote": "Prueba 1", "PESO": 10.0, "proveedor": "Proveedor A"},
    {"fecha_creacion": "2024-07-22", "lote": "Prueba 2", "PESO": 90.0, "proveedor": "Proveedor B"},
    {"fecha_creacion": "2024-07-21", "lote": "Prueba 3", "PESO": 77.0, "proveedor": "Proveedor C"},
    {"fecha_creacion": "2024-07-20", "lote": "Prueba 4", "PESO": 0.05, "proveedor": "Proveedor D"},
    {"fecha_creacion": "2024-07-19", "lote": "Prueba 5", "PESO": 2.0, "proveedor": "Proveedor E"},
    {"fecha_creacion": "2024-07-18", "lote": "Prueba 6", "PESO": 2.5, "proveedor": "Proveedor F"},
  ];

  List<Map<String, dynamic>> filteredData = [];

  final LoteController loteController = Get.put(LoteController());
  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();
  final MenuDrawerController menuController = Get.put(MenuDrawerController());

  TextEditingController loteFilterController = TextEditingController();
  TextEditingController fechaFilterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredData = List.from(data); // Mostrar todos los registros inicialmente
  }

  void filterTable() {
    setState(() {
      String loteFilter = loteFilterController.text.toLowerCase();
      String fechaFilter = fechaFilterController.text.toLowerCase();

      filteredData = data.where((row) {
        final String lote = row['lote'].toString().toLowerCase();
        final String fecha = row['fecha_creacion'].toString().toLowerCase();

        return lote.contains(loteFilter) && fecha.contains(fechaFilter);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 38, 83),
        title: const Text(
          'Lotes',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back),
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
                      child: SizedBox(
                        width: double.infinity,
                        height: 50.0,
                        child: TextField(
                          controller: loteFilterController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'lote',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: 50.0,
                        child: TextField(
                          controller: fechaFilterController,
                          decoration: InputDecoration(
                            hintText: 'Fecha',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                            suffixIcon: const Icon(Icons.calendar_today),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              fechaFilterController.text = formattedDate;
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        filterTable(); // Filtrar al hacer clic en el icono de búsqueda
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RawScrollbar(
                  controller: _verticalScrollController,
                  thumbVisibility: true,
                  thickness: 8,
                  radius: const Radius.circular(10),
                  thumbColor: const Color.fromARGB(255, 25, 38, 83),
                  child: SingleChildScrollView(
                    controller: _verticalScrollController,
                    child: SingleChildScrollView(
                      controller: _horizontalScrollController,
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Opciones')),
                          DataColumn(label: Text('Lote')),
                          DataColumn(label: Text('Peso')),
                          DataColumn(label: Text('Fecha de creación')),
                          DataColumn(label: Text('Proveedor')),
                        ],
                        rows: filteredData.map((row) {
                          return DataRow(cells: [
                            DataCell(
                              Row(
                                children: [
                                 Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 0.0), 
                                    padding: const EdgeInsets.all(0.0), 
                                    child: IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        TextEditingController editLoteController = TextEditingController(text: row['lote']);
                                        TextEditingController editPesoController = TextEditingController(text: row['PESO'].toString());
                                        TextEditingController editProveedorController = TextEditingController(text: row['proveedor']);

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
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextField(
                                                    controller: editLoteController,
                                                    keyboardType: TextInputType.number, // Solo numérico
                                                    decoration: const InputDecoration(
                                                      hintText: 'Lote',
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  TextField(
                                                    controller: editPesoController,
                                                    decoration: const InputDecoration(
                                                      hintText: 'Peso',
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  TextField(
                                                    controller: editProveedorController,
                                                    decoration: const InputDecoration(
                                                      hintText: 'Proveedor',
                                                    ),
                                                  ),
                                                ],
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
                                                          side: const BorderSide(color: Color.fromARGB(255, 201, 201, 201), width: 2.0),
                                                        ),
                                                      ),
                                                    ),
                                                    child: const Text('Cancelar', style: TextStyle(color: Color.fromARGB(255, 21, 19, 107))),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 100,
                                                  child: TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        row['lote'] = editLoteController.text;
                                                        row['PESO'] = double.tryParse(editPesoController.text) ?? row['PESO'];
                                                        row['proveedor'] = editProveedorController.text;
                                                      });
                                                      Navigator.of(context).pop();
                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all<Color>(
                                                        const Color.fromARGB(255, 22, 37, 92)),
                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          side: const BorderSide(color: Color.fromARGB(255, 21, 14, 90), width: 2.0),
                                                        ),
                                                      ),
                                                    ),
                                                    child: const Text('Guardar', style: TextStyle(color: Colors.white)),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),

                                  const SizedBox(width: 4), 
                                  Container(
                                    margin: const EdgeInsets.only(left: 0), 
                                    padding: const EdgeInsets.only(left: 0), 
                                    child: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Borrar"),
                                              content: const Text("¿Seguro que quiere borrar este lote?"),
                                              actions: [
                                                TextButton(
                                                  child: const Text("Cancelar"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text("Borrar"),
                                                  onPressed: () {
                                                    setState(() {
                                                      data.remove(row);
                                                      filterTable();
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  )

                                ],
                              ),
                            ),
                            DataCell(Text(row['lote'])),
                            DataCell(Text(row['PESO'].toString())),
                            DataCell(Text(row['fecha_creacion'].toString())),
                            DataCell(Text(row['proveedor'])),
                          ]);
                        }).toList(),
                      ),
                    ),
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
            TextEditingController nuevoLoteController = TextEditingController();
            TextEditingController nuevoPesoController = TextEditingController();
            TextEditingController nuevaFechaController = TextEditingController();
            TextEditingController nuevoProveedorController = TextEditingController();

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
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: nuevoLoteController,
                        decoration: const InputDecoration(
                          hintText: 'Lote',
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: nuevoPesoController,
                        decoration: const InputDecoration(
                          hintText: 'Peso',
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: nuevaFechaController,
                        decoration: const InputDecoration(
                          hintText: 'Fecha',
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            nuevaFechaController.text = formattedDate;
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: nuevoProveedorController,
                        decoration: const InputDecoration(
                          hintText: 'Proveedor',
                        ),
                      ),
                    ],
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
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
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
                          if (nuevoLoteController.text.isNotEmpty &&
                              nuevaFechaController.text.isNotEmpty) {
                            setState(() {
                              data.add({
                                "fecha_creacion": nuevaFechaController.text,
                                "lote": nuevoLoteController.text,
                                "PESO": nuevoPesoController.text.isNotEmpty
                                    ? double.tryParse(nuevoPesoController.text) ?? 0.0
                                    : 0.0,
                                "proveedor": nuevoProveedorController.text.isNotEmpty
                                    ? nuevoProveedorController.text
                                    : "Nuevo Proveedor", 
                              });
                            });
                            Navigator.of(context).pop();
                            filterTable(); // Refrescar la tabla después de agregar un nuevo registro
                          }
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 22, 37, 92),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(
                                color: Color.fromARGB(255, 21, 14, 90),
                                width: 2.0),
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