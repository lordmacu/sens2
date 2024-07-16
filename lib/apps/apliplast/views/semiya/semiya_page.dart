import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sens2/core/components/buttons/button.dart';
import 'package:sens2/core/components/inputs/input_text.dart';
import 'package:sens2/core/components/inputs/dropdown_text.dart';

class SemiyaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController loteController = TextEditingController();
    TextEditingController palletController = TextEditingController();
    TextEditingController taraCantidadController = TextEditingController();

    String? selectedProveedor;
    String? selectedMaterial;
    String? selectedTaraTipo;

    void enviarDatos() {
      // Implementa la lógica para enviar los datos aquí
      print('Datos enviados');
    }

    void crearLote() {
      // Implementa la lógica para crear el lote aquí
      print('Lote creado');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('SAMIYA'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Opción 1'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Opción 2'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              width: 360,
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 25, 38, 83),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    '0',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Peso Neto',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                width: 360,
                decoration: BoxDecoration(
                  color: Color.fromARGB(22, 79, 92, 150),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Lote',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 11, 19, 68)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: TextField(
                        controller: loteController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: '100',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Proveedores',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 11, 19, 68)),
                      ),
                    ),
                    Container(
                      width: 380,
                      height: 40,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedProveedor,
                        onChanged: (String? newValue) {
                          selectedProveedor = newValue;
                        },
                        style: TextStyle(
                            color: Color.fromARGB(255, 129, 129, 129)),
                        underline: Container(
                          height: 1,
                          color: Color.fromARGB(167, 88, 97, 121),
                        ),
                        items: <String>[
                          'Proveedor selection',
                          'Proveedor 2',
                          'Proveedor 3',
                          'Proveedor 4'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(value),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Materia Prima',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 11, 19, 68)),
                      ),
                    ),
                    Container(
                      width: 380,
                      height: 40,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedMaterial,
                        onChanged: (String? newValue) {
                          selectedMaterial = newValue;
                        },
                        style: TextStyle(
                            color: const Color.fromARGB(255, 129, 129, 129)),
                        underline: Container(
                          height: 1,
                          color: Color.fromARGB(167, 88, 97, 121),
                        ),
                        items: <String>[
                          'Material selection',
                          'Material 2',
                          'Material 3',
                          'Material 4'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(value),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Pallet',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 11, 19, 68)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: TextField(
                        controller: palletController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: '24',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Taras',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 11, 19, 68)),
                      ),
                    ),
                    SizedBox(height: 0),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.only(right: 10),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: selectedTaraTipo,
                              onChanged: (String? newValue) {
                                selectedTaraTipo = newValue;
                              },
                              style: TextStyle(
                                  color: Color.fromARGB(255, 129, 129, 129)),
                              underline: Container(
                                height: 1,
                                color: Color.fromARGB(167, 60, 66, 82),
                              ),
                              items: <String>[
                                'Tipo 5',
                                'Tipo 2',
                                'Tipo 3',
                                'Tipo 4'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: TextField(
                              controller: taraCantidadController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: '3500',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              margin: EdgeInsets.only(bottom: 13, top: 10, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ButtonGeneral(
                    text: 'Enviar',
                    colorValue: Color.fromARGB(255, 13, 139, 128),
                    fontSize: 10,
                   // onPressed: () {
                    //  enviarDatos(); // Llama a la función enviarDatos
                   // },
                  ),
                  SizedBox(height: 2),
                  ButtonGeneral(
                    text: 'Crear lote',
                    colorValue: Color.fromARGB(255, 14, 12, 87),
                    fontSize: 10,
                   // onPressed: () {
                     // crearLote(); // Llama a la función crearLote
                    //},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
