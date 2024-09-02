import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sens2/core/components/inputs/type_ahead.dart';
import 'package:sens2/apps/apliplast/views/reprocesos/widgets/custom_button_widget.dart';

class ReceptionPage extends StatefulWidget {
  @override
  _ReceptionPageState createState() => _ReceptionPageState();
}

class _ReceptionPageState extends State<ReceptionPage> {
 final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _operadorController = TextEditingController();
  final TextEditingController _proveedorController = TextEditingController();
  final TextEditingController _taraController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _pesoNetoController = TextEditingController();

  String? selectedDensidad;
  Map<String, bool> selectedOptions = {
    'Densidad 1': false,
    'Densidad 2': false,
    'Densidad 3': false,
  };

  final List<String> densidades = ['Densidad 1', 'Densidad 2', 'Densidad 3'];

  // Lista de pesos capturados
  final List<Map<String, dynamic>> _pesos = [
    {'id': 1, 'capturado': 150, 'menos_tara': 135},
    {'id': 2, 'capturado': 200, 'menos_tara': 185},
    {'id': 3, 'capturado': 450, 'menos_tara': 435},
    {'id': 4, 'capturado': 500, 'menos_tara': 485},
    {'id': 5, 'capturado': 365, 'menos_tara': 345},
  ];

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Detalles de Peso'),
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Get.offNamed('/'); // Volver a la pantalla anterior
                },
              ),
            ],
          ),
          content: Scrollbar(
            thumbVisibility: true, // Hace que la barra de desplazamiento sea visible
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Ver listado')),
                  DataColumn(label: Text('Peso capturado')),
                  DataColumn(label: Text('Peso menos tara')),
                  DataColumn(label: Text('')),
                ],
                rows: _pesos.map((peso) {
                  return DataRow(cells: [
                    DataCell(Text(peso['id'].toString())),
                    DataCell(Text(peso['capturado'].toString())),
                    DataCell(Text(peso['menos_tara'].toString())),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Acción para editar (puedes implementar esto)
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            // Acción para borrar
                            _deletePeso(peso['id']);
                          },
                        ),
                      ],
                    )),
                  ]);
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  void _deletePeso(int id) {
    setState(() {
      _pesos.removeWhere((peso) => peso['id'] == id);
    });
    // Cierra el popup y lo vuelve a abrir para mostrar los datos actualizados
    Navigator.of(context).pop();
    _showPopup(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 38, 83),
        title: const Text(
          'Recepcion',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Get.offNamed('/'); // Volver a la pantalla anterior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'N° Registro: REPR-D000001',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _fechaController,
              decoration: const InputDecoration(labelText: 'Fecha'),
              readOnly: true,
            ),
            const SizedBox(height: 16),
            TypeAhead(
              text: 'Operador',
              onSuggestionSelectedCallback: (String suggestion) {
                _operadorController.text = suggestion;
              },
            ),
            const SizedBox(height: 16),
            TypeAhead(
              text: 'Proveedor',
              onSuggestionSelectedCallback: (String suggestion) {
                _proveedorController.text = suggestion;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedDensidad,
              decoration: const InputDecoration(labelText: 'Densidad'),
              items: densidades.map((String densidad) {
                return DropdownMenuItem<String>(
                  value: densidad,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(densidad),
                      Checkbox(
                        value: selectedOptions[densidad],
                        onChanged: (bool? value) {
                          setState(() {
                            selectedOptions.forEach((key, val) {
                              selectedOptions[key] = false;
                            });
                            selectedOptions[densidad] = value ?? false;
                            selectedDensidad = value == true ? densidad : null;
                          });
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedDensidad = newValue;
                  selectedOptions.forEach((key, val) {
                    selectedOptions[key] = false;
                  });
                  selectedOptions[newValue!] = true;
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taraController,
                    decoration: const InputDecoration(labelText: 'Tara'),
                    readOnly: true,
                  ),
                ),
                const SizedBox(width: 10),
                CustomButton(
                  width: 100,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  text: 'Capturar',
                  onPressed: () {
                    // Lógica para capturar la Tara
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _pesoController,
                    decoration: const InputDecoration(labelText: 'Peso'),
                    readOnly: true,
                  ),
                ),
                const SizedBox(width: 10),
                CustomButton(
                  width: 100,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  text: 'Capturar',
                  onPressed: () {
                    // Lógica para capturar el Peso
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _pesoNetoController,
                    decoration: const InputDecoration(labelText: 'Peso Neto'),
                    readOnly: true,
                  ),
                ),
                const SizedBox(width: 10),
                CustomButton(
                  width: 100,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  text: 'Ver',
                  onPressed: () {
                    _showPopup(context); // Mostrar popup con la tabla
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomButton(
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              text: 'Guardar',
              onPressed: () {
                // Acción que se ejecuta al presionar el botón de guardar
              },
            ),
          ],
        ),
      ),
    );
  }
}
