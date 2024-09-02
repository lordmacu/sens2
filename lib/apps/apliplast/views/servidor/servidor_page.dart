import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/services.dart';
import 'package:sens2/core/components/buttons/button_general.dart';

class ServidorPage extends StatelessWidget {
  const ServidorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 38, 83),
        title: const Text(
          'Servidores',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Volver a la pantalla anterior
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(40, 79, 92, 150),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TypeAheadField<String>(
                            textFieldConfiguration: TextFieldConfiguration(
                              decoration: const InputDecoration(
                                hintText: 'Protocolo',
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            suggestionsCallback: (pattern) {
                              return ['HTTP', 'HTTPS', 'FTP', 'SFTP']
                                  .where((item) => item.toLowerCase().contains(pattern.toLowerCase()));
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion),
                              );
                            },
                            onSuggestionSelected: (suggestion) {
                              // Aquí puedes manejar lo que ocurre al seleccionar una sugerencia.
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                      
                      ],
                      decoration: InputDecoration(
                        hintText: 'Ruta del Servidor',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        
                      ],
                      decoration: InputDecoration(
                        hintText: 'Puerto',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: ButtonGeneral(
                text: 'Guardar',
                colorValue: Color.fromARGB(255, 25, 38, 83),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
