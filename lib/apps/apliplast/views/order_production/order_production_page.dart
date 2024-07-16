import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/order_production_controller.dart';
import 'package:sens2/core/components/buttons/button.dart';
import 'package:sens2/core/components/inputs/input_text.dart';
import 'package:sens2/core/components/inputs/dropdown_text.dart';


class OrderProductionPage extends GetView<OrderProductionController> {
  Widget _buildDatePicker(BuildContext context) {
    return TextField(
      readOnly: true,
      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: 'Fecha',
        suffixIcon: Icon(Icons.calendar_today),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(167, 88, 97, 121)),
        ),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2024),
        );
        if (pickedDate != null) {}
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 38, 83),
        title: Text(
          'Production Order',
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
              Get.back(); // Usando Get para navegar hacia atrás
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
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Orden de producción',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 11, 19, 68)),
                ),
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
                    SizedBox(height: 8),

                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Orden No:',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 11, 19, 68)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 0),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: 'Numero de orden',
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 129, 129, 129)),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Picker de fecha
                    Container(
                      width: 380,
                      height: 40,
                      child: _buildDatePicker(context),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Datos generales',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 11, 19, 68)),
                      ),
                    ),
                    SizedBox(height: 8),
                   InputTextGeneral(text: 'Cliente'),

                    SizedBox(height: 8),
                     InputTextGeneral(text: 'Código de cliente'),
                    SizedBox(height: 10),
                     InputTextGeneral(text: 'Referencia'),
                    SizedBox(height: 10),
                     InputTextGeneral(text: 'Código de producto'),
                    SizedBox(height: 20),
                  ],
                ),
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
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Detalles de Extrusión',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 11, 19, 68)),
                      ),
                    ),
                    SizedBox(height: 8),
                     InputTextGeneral(text: 'Ancho'),
                    SizedBox(height: 8),
                     InputTextGeneral(text: 'Fuelle'),
                    SizedBox(height: 8),
                     InputTextGeneral(text: 'Espesor'),
                    SizedBox(height: 8),
                     InputTextGeneral(text: 'Peso probeta'),
                    SizedBox(height: 8),
                     InputTextGeneral(text: 'Densidad'),
                    SizedBox(height: 8),
                    DropdownText(items: ['Color ', 'Item 2', 'Item 3']),
                    SizedBox(height: 8),
                     InputTextGeneral(text: 'Tipo de Extrusión'),
                    SizedBox(height: 20),
                  ],
                ),
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
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Datos del material a utilizar',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 11, 19, 68)),
                      ),
                    ),
                     InputTextGeneral(text: 'Alta Virgen'),
                    SizedBox(height: 10),
                     InputTextGeneral(text: 'Lineal'),
                    SizedBox(height: 8),
                     InputTextGeneral(text: 'Reprocesado A/D'),
                    SizedBox(height: 8),
                     InputTextGeneral(text: 'Reprocesado B/D'),
                    SizedBox(height: 8),
                     InputTextGeneral(text: 'Pigmento Negro'),
                    SizedBox(height: 8),
                     InputTextGeneral(text: 'Total'),
                  ],
                ),
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Detalles de Producción',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 11, 19, 68)),
                      ),
                    ),
                    SizedBox(height: 8),
                     InputTextGeneral(text: 'Tipo de producto'),
                    SizedBox(height: 8),
                     InputTextGeneral(text: 'Peso (KG)'),
                    SizedBox(height: 8),
                     InputTextGeneral(text: 'Cantidad solicitada'),
                    SizedBox(height: 8),
                     InputTextGeneral(text: 'Máquina'),
                    SizedBox(height: 8),
                     InputTextGeneral(text: 'Peso del rollo'),
                    SizedBox(height: 8),
                     InputTextGeneral(text: '# Rollos'),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(47, 90, 255, 255),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Agregar otro',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
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
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              margin: EdgeInsets.only(bottom: 13, top: 10, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 2),
                  ButtonGeneral(
                    text: 'Guardar',
                    colorValue: Color.fromARGB(255, 14, 12, 87),
                    fontSize: 13,
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
