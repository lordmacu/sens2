import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sens2/apps/samiya/controllers/lote_controller.dart';
import 'package:sens2/core/components/inputs/CategoryTypeAhead.dart';
import 'package:sens2/core/components/modals/menu_drawer.dart';
import 'package:sens2/core/controllers/menu_controller.dart';
import 'package:intl/intl.dart';

class TableLotePage extends StatefulWidget {
  const TableLotePage({super.key});

  @override
  _TableLotePageState createState() => _TableLotePageState();
}

class _TableLotePageState extends State<TableLotePage> {
  final LoteController loteController = Get.put(LoteController());
  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();
  final MenuDrawerController menuController = Get.put(MenuDrawerController());

  DateTimeRange? selectedDateRange;

  @override
  void initState() {
    super.initState();
  }

  void _selectDateRange() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: selectedDateRange,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDateRange) {
      setState(() {
        selectedDateRange = picked;
        // Actualiza los campos del controlador con las fechas seleccionadas
        loteController.fechaFilterController.value.text =
            '${DateFormat('yyyy-MM-dd').format(picked.start)} - ${DateFormat('yyyy-MM-dd').format(picked.end)}';
      });
    }
  }

  void _showAddLoteDialog() {
    final TextEditingController batchController = TextEditingController();
    final TextEditingController pesoController = TextEditingController();
    final TextEditingController supplierController = TextEditingController();
    final TextEditingController productController = TextEditingController();
    final TextEditingController unitsController = TextEditingController();
    final TextEditingController dateController = TextEditingController();

    batchController.text = loteController.loteFilterController.value.text;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: const Text('Agregar Lote'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: batchController,
                  decoration: const InputDecoration(
                    hintText: 'Lote',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: pesoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Peso neto',
                  ),
                ),
                const SizedBox(height: 8),
                CategoryTypeAhead(
                  categoryName: 'supplier',
                  text: 'Seleccionar proveedor',
                  displayFields: ['key'], // Campos a mostrar combinados
                  controller: supplierController,
                  onSuggestionSelectedCallback: (selectedSuggestion) {
                    print('Selected suggestion: $selectedSuggestion');
                  },
                ),
                const SizedBox(height: 8),
                CategoryTypeAhead(
                  categoryName: 'materiaPrima',
                  text: 'Seleccionar Materia Prima',
                  displayFields: ['key'],
                  controller: productController,
                  onSuggestionSelectedCallback: (selectedSuggestion) {
                    print('Selected suggestion: $selectedSuggestion');
                  },
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: dateController,
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
                      // Mostrar el selector de hora
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (pickedTime != null) {
                        // Combinar la fecha seleccionada con la hora seleccionada
                        DateTime fullPickedDate = DateTime(
                          pickedDate.year,
                          pickedDate.month,
                          pickedDate.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );

                        // Formatear la fecha y hora
                        String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss')
                            .format(fullPickedDate);

                        dateController.text = formattedDate;
                      }
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (batchController.text.isNotEmpty &&
                    pesoController.text.isNotEmpty &&
                    supplierController.text.isNotEmpty &&
                    productController.text.isNotEmpty &&
                    dateController.text.isNotEmpty) {
                  // Envía los datos del lote
                  loteController.sendData(
                      batchController.text,
                      pesoController.text,
                      supplierController.text,
                      productController.text,
                      dateController.text);
                  Navigator.of(context).pop();
                } else {
                  Get.snackbar(
                    'Error',
                    'Todos los campos son obligatorios',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddLoteDialog, // Muestra el diálogo para agregar lote
        backgroundColor: const Color.fromARGB(255, 25, 38, 83),
        child: const Icon(Icons.add),
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
                        width: double.infinity,
                        height: 50.0,
                        child: TextField(
                          controller: loteController.loteFilterController.value,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter
                                .digitsOnly, // Permite solo dígitos
                          ],
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
                          controller:
                              loteController.fechaFilterController.value,
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
                            _selectDateRange();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        loteController.fetchLotes();
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
                      child: Obx(() => DataTable(
                            columns: const [
                              DataColumn(label: Text('Opciones')),
                              DataColumn(label: Text('Lote')),
                              DataColumn(label: Text('Peso')),
                              DataColumn(label: Text('Fecha de creación')),
                              DataColumn(label: Text('Proveedor')),
                            ],
                            rows: loteController.lotes.map((row) {
                              String formattedDate = DateFormat('yyyy-MM-dd')
                                  .format(
                                      DateTime.parse(row['date'].toString()));

                              return DataRow(cells: [
                                DataCell(
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        padding: const EdgeInsets.all(0.0),
                                        child: IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            loteController.editLoteController
                                                .value.text = "${row['batch']}";
                                            loteController.editPesoController
                                                    .value.text =
                                                row['weight'].toString();
                                            loteController
                                                .editSupplierController
                                                .value
                                                .text = row['supplier'];

                                            loteController.editProductController
                                                .value.text = row['product'];

                                            loteController
                                                .editUnitsController
                                                .value
                                                .text = row['weight_units'];
                                            DateTime parsedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .parse(row['date']);
                                            String formattedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(parsedDate);

                                            loteController.editDateController
                                                .value.text = formattedDate;

                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 255, 253, 244),
                                                  titlePadding: EdgeInsets.zero,
                                                  title: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 25, 38, 83),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                15.0),
                                                        topRight:
                                                            Radius.circular(
                                                                15.0),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      'Editar',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const SizedBox(
                                                            height: 8),
                                                        CategoryTypeAhead(
                                                          categoryName:
                                                              'supplier',
                                                          text:
                                                              'Seleccionar proveedor',
                                                          displayFields: [
                                                            'key'
                                                          ], // Campos a mostrar combinados
                                                          controller: loteController
                                                              .editSupplierController
                                                              .value,
                                                          onSuggestionSelectedCallback:
                                                              (selectedSuggestion) {
                                                            print(
                                                                'Selected suggestion: $selectedSuggestion');
                                                          },
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        CategoryTypeAhead(
                                                          categoryName:
                                                              'materiaPrima',
                                                          text:
                                                              'Seleccionar Materia Prima',
                                                          displayFields: [
                                                            'key'
                                                          ],
                                                          controller: loteController
                                                              .editProductController
                                                              .value,
                                                          onSuggestionSelectedCallback:
                                                              (selectedSuggestion) {
                                                            print(
                                                                'Selected suggestion: $selectedSuggestion');
                                                          },
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        TextField(
                                                          controller: loteController
                                                              .editPesoController
                                                              .value,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              const InputDecoration(
                                                            hintText:
                                                                'Weight Value',
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        TextField(
                                                          controller: loteController
                                                              .editUnitsController
                                                              .value,
                                                          decoration:
                                                              const InputDecoration(
                                                            hintText:
                                                                'Weight Units',
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        TextField(
                                                          controller: loteController
                                                              .editDateController
                                                              .value,
                                                          decoration:
                                                              const InputDecoration(
                                                            hintText: 'Date',
                                                            suffixIcon: Icon(Icons
                                                                .calendar_today),
                                                          ),
                                                          readOnly: true,
                                                          onTap: () async {
                                                            DateTime?
                                                                pickedDate =
                                                                await showDatePicker(
                                                              context: context,
                                                              initialDate:
                                                                  DateTime
                                                                      .now(),
                                                              firstDate:
                                                                  DateTime(
                                                                      2000),
                                                              lastDate:
                                                                  DateTime(
                                                                      2101),
                                                            );
                                                            if (pickedDate !=
                                                                null) {
                                                              String
                                                                  formattedDate =
                                                                  DateFormat(
                                                                          'yyyy-MM-dd')
                                                                      .format(
                                                                          pickedDate);
                                                              loteController
                                                                      .editDateController
                                                                      .value
                                                                      .text =
                                                                  formattedDate;
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    SizedBox(
                                                      width: 100,
                                                      child: TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty.all<
                                                                      Color>(
                                                                  const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      231,
                                                                      230,
                                                                      230)),
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              side: const BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          201,
                                                                          201,
                                                                          201),
                                                                  width: 2.0),
                                                            ),
                                                          ),
                                                        ),
                                                        child: const Text(
                                                            'Cancelar',
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        21,
                                                                        19,
                                                                        107))),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 100,
                                                      child: TextButton(
                                                        onPressed: () {
                                                          loteController.udpate(
                                                              row['id']);
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty.all<
                                                                      Color>(
                                                                  const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      22,
                                                                      37,
                                                                      92)),
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              side: const BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          21,
                                                                          14,
                                                                          90),
                                                                  width: 2.0),
                                                            ),
                                                          ),
                                                        ),
                                                        child: const Text(
                                                            'Guardar',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
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
                                                  content: Text(
                                                      "¿Seguro que quiere borrar este lote?"),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text(
                                                          "Cancelar"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child:
                                                          const Text("Borrar"),
                                                      onPressed: () {
                                                        setState(() {
                                                          loteController
                                                              .removeItem(
                                                                  row["id"]);
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
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
                                DataCell(Text("${row['batch']}")),
                                DataCell(Text(double.parse(row['weight'].toString()).toStringAsFixed(2))),
                                DataCell(Text(formattedDate)),
                                DataCell(Text(row['supplier'])),
                              ]);
                            }).toList(),
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
