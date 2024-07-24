import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sens2/apps/apliplast/controllers/end_work_sealed_controller.dart';
import 'package:sens2/apps/apliplast/views/impresion/widget/current_date_widget.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sens2/core/components/inputs/dropdown_text.dart';
import 'package:sens2/core/components/inputs/input_text.dart';
import 'package:sens2/core/components/inputs/type_ahead.dart';
import 'package:sens2/core/components/buttons/button.dart';
import 'package:sens2/apps/apliplast/views/impresion/widget/capture_widget.dart';
import 'package:sens2/apps/apliplast/views/impresion/widget/filter_options_widget.dart';
import 'package:sens2/apps/apliplast/views/impresion/widget/show_rolls_dialog.dart';
import 'package:sens2/apps/apliplast/views/impresion/widget/list_data_widget.dart';  // Importa el nuevo widget

class SealedEndWork extends StatelessWidget {
  EndWorkSealedController endWorkSealedController = Get.put(EndWorkSealedController());

  final List<String> operators = [
    'Operador 1',
    'Operador 2',
    'Operador 3'
  ]; // Lista de operadores

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
        if (pickedDate != null) {
          // Aquí puedes hacer algo con la fecha seleccionada
        }
      },
    );
  }

  void _showListData(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  ListDataWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 38, 83),
        title: Text(
          'Final de turno',
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
              Get.back(); // Utilizando Get para navegar hacia atrás
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 8),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      padding: EdgeInsets.only(
                          top: 20, bottom: 30, left: 20, right: 20),
                      width: double.infinity,
                      color: Colors.grey.shade400.withOpacity(0.2),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'N° 15',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 11, 19, 68),
                                ),
                              ),
                              CurrentDateWidget()
                            ],
                          ),
                          SizedBox(height: 16),
                          DropdownText(items: ['Turno', 'Item 2', 'Item 3']),
                          SizedBox(height: 8),
                          TypeAhead(
                            suggestions: operators,
                            text: "Operador",
                            onSuggestionSelectedCallback: (String suggestion) {
                              endWorkSealedController.operatorController.value.text =
                                  suggestion;
                            },
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    TypeAhead(
                      suggestions: operators,
                      text: "Orden de producción",
                      onSuggestionSelectedCallback: (String suggestion) {
                        endWorkSealedController.operatorController.value.text =
                            suggestion;
                      },
                    ),
                      SizedBox(height: 16),
                     TypeAhead(
                      suggestions: operators,
                      text: "Maquina",
                      onSuggestionSelectedCallback: (String suggestion) {
                        endWorkSealedController.operatorController.value.text =
                            suggestion;
                      },
                    ),
                    SizedBox(height: 16),
                    
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rollos utilizados',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 11, 19, 68),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Manejar la acción de agregar
                            },
                            child: Text('Agregar'),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 5, 16, 77), // Fondo del botón
                              onPrimary: Colors.white, // Color del texto
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Tamaño del botón
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16),
                   ShowAllRollsTable(
            operators: operators),
              SizedBox(height: 16),
                    SizedBox(height: 8),
                    Text(
                      'Subtotal de peso rollos: 1650',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 11, 19, 68),
                      ),
                    ),
                    SizedBox(height: 8),
                    CaptureWidget(
                      buttonText: 'Capturar',
                      weightText: '10kg',
                      mainText: 'Sacos',
                      incrementableValue: '--',
                    ),
                    SizedBox(height: 16),
                    CaptureWidget(
                      buttonText: 'Capturar',
                      weightText: '10kg',
                      mainText: 'Empaque',
                      incrementableValue: '--',
                      
                    ),
                    SizedBox(height: 32),
                    Text(
                      'Total de material utilizado : 500',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 11, 19, 68),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      color: Colors.grey.shade400.withOpacity(0.2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 150,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  'Total fundas: 32',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      10), // Espacio entre los elementos del Row
                              Container(
                                width: 110,
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: TextButton(
                                  onPressed: () {
                                    _showListData(context);
                                  },
                                  child: Text(
                                    'Ver todas',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Color.fromARGB(255, 14, 12, 87),
                                    ),
                                    padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                      EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 20.0),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                    
                     Text(
                      'Peso neto fundas: 1650',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 11, 19, 68),
                      ),
                    ),
                    
                    SizedBox(height: 8),
                    CaptureWidget(
                      buttonText: 'Capturar',
                      weightText: '10kg',
                      mainText: 'Desperdicio',
                      incrementableValue: '--',
                    ),
                    SizedBox(height: 16),
               
                  
                    Text(
                      'Total de produccion : 500',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 11, 19, 68),
                      ),
                    ),
                    CaptureWidget(
                      buttonText: 'Capturar',
                      weightText: 'Saldo: 500',
                      mainText: '',
                      incrementableValue: null,
                       showButton: false,
                    ),
                    
                    SizedBox(height: 8),
                    Container(
                      width: 200,
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextButton(
                        onPressed: () {
                          endWorkSealedController.send();
                        },
                        child: Text(
                          'Guardar',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 14, 12, 87),
                          ),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
