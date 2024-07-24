import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SamiyaTara extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {"fecha_creacion": "2024-07-23", "TARA": "Prueba 1", "PESO": 10.0},
    {"fecha_creacion": "2024-07-22", "TARA": "Prueba 2", "PESO": 90.0},
    {"fecha_creacion": "2024-07-21", "TARA": "Prueba 3", "PESO": 77.0},
    {"fecha_creacion": "2024-07-20", "TARA": "Prueba 4", "PESO": 0.05},
    {"fecha_creacion": "2024-07-19", "TARA": "Prueba 5", "PESO": 2.0},
    {"fecha_creacion": "2024-07-18", "TARA": "Prueba 6", "PESO": 2.5},
  ];

  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 38, 83),
        title: Text(
          'TARA',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
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
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Tara',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Filtrar',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: () {
                   
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 96.0, 
                left: 0,
                right: 0,
                child: Container(
                  color: Color.fromARGB(22, 168, 161, 161), 
                  child: RawScrollbar(
                    controller: _horizontalScrollController,
                    thumbVisibility: true,
                    thickness: 8,
                    radius: Radius.circular(10),
                    thumbColor: Color.fromARGB(255, 25, 38, 83), 
                    child: SingleChildScrollView(
                      controller: _horizontalScrollController,
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        width: 1000, 
                        height: 20, 
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _horizontalScrollController,
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    controller: _verticalScrollController,
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('Fecha de creación')),
                        DataColumn(label: Text('TARA')),
                        DataColumn(label: Text('PESO')),
                        DataColumn(label: Text('OPCIONES')),
                      ],
                      rows: data.map((row) {
                        return DataRow(cells: [
                          DataCell(Text(row['fecha_creacion'].toString())),
                          DataCell(Text(row['TARA'])),
                          DataCell(Text(row['PESO'].toString())),
                          DataCell(IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: () {
                           
                            },
                          )),
                        ]);
                      }).toList(),
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
                  topLeft: Radius.circular(15.0), // Radio de la esquina superior izquierda
                  topRight: Radius.circular(15.0), // Radio de la esquina superior derecha
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
                width: 100, // Ajusta el ancho según sea necesario
                child: TextButton(
                  child: Text(
                    'Cancelar',
                    style: TextStyle(color: Color.fromARGB(255, 21, 19, 107)), // Color del texto
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 231, 230, 230)), // Color de fondo
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Borde redondeado
                        side: BorderSide(color: Color.fromARGB(255, 201, 201, 201), width: 2.0), // Borde con color y ancho
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 100, // Ajusta el ancho según sea necesario
                child: TextButton(
                  child: Text(
                    'Agregar',
                    style: TextStyle(color: Colors.white), // Color del texto
                  ),
                  onPressed: () {
                    // Implement save functionality here
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 22, 37, 92)), // Color de fondo
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Borde redondeado
                        side: BorderSide(color: Color.fromARGB(255, 21, 14, 90), width: 2.0), // Borde con color y ancho
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

