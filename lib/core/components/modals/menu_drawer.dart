import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sens2/apps/samiya/controllers/tara_controller.dart';
import 'package:sens2/core/controllers/menu_controller.dart';
import 'package:sens2/core/services/auth_service.dart';

class MenuDrawer extends StatelessWidget {
  final MenuDrawerController controller = Get.find<MenuDrawerController>();
  final TableController controllerTable = Get.find<TableController>();

  final AuthService authService = Get.find<AuthService>();
  final box = GetStorage(); // GetStorage instance

  MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                _buildSectionTitle('CONFIGURACIÓN'),

                _buildListTile('Servidor', '/server'),
                _buildListTile('Configuración general', '/gateWay'),
                _buildSectionTitle('GENERAL'),
                _buildListTile('Corrección de lote', '/tableLote'),
                _buildPalletListTile(), // Updated Pallet ListTile
                _buildSectionTitle('PARAMETROS'),
                Obx(() {
                  return Column(
                    children: controller.menuItems.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: ListTile(
                          title: Text(
                            item['value']!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () async {
                            final Map<String, Map<String, dynamic>> tableConfigurations = {
                              'material': {
                                'headersMapping': {
                                  'Tara': 'key',
                                  'Peso (Kg)': 'tariff',
                                },
                                'editableFieldsMapping': {
                                  'key': {
                                    'type': 'textfield',
                                    'value': 'key',
                                    'name': 'Tara',
                                  },
                                  'tariff': {
                                    'type': 'textfield',
                                    'value': 'tariff',
                                    'name': 'Peso (Kg)',
                                  },
                                },
                              },
                              'supplier': {
                                'headersMapping': {
                                  'Proveedor': 'key',
                                },
                                'editableFieldsMapping': {
                                  'key': {
                                    'type': 'textfield',
                                    'value': 'key',
                                    'name': 'Proveedor',
                                  },
                                },
                              },
                              'proveedor': {
                                'headersMapping': {
                                  'Proveedor': 'key',
                                },
                                'editableFieldsMapping': {
                                  'key': {
                                    'type': 'textfield',
                                    'value': 'key',
                                    'name': 'Proveedor',
                                  },
                                },
                              },
                              'materiaPrima': {
                                'headersMapping': {
                                  'Materia Prima': 'key',
                                },
                                'editableFieldsMapping': {
                                  'key': {
                                    'type': 'textfield',
                                    'value': 'key',
                                    'name': 'Materia Prima'
                                  },
                                },
                              },
                            };


                            final config = tableConfigurations[item['key']];

                            final headersMapping = config?['headersMapping'] as Map<String, String>;
                            final editableFieldsMapping = config?['editableFieldsMapping'] as Map<String, Map<String, dynamic>>;

                            await controllerTable.loadItems(
                              item['key'] as String,
                              headersMapping,
                              item['value'] as String,
                              editableFieldsMapping,
                            );

                            Navigator.of(context).pop();

                            Get.offNamed('/generalTable', arguments: {
                              'key': item['key'],
                              'value': item['value']
                            });
                          },
                        ),
                      );
                    }).toList(),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: ListTile(
                    title: const Text(
                      'Cerrar turno',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    onTap: () {
                      authService.logout();
                      Get.offNamed('/');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPalletListTile() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: ListTile(
        title: const Text(
          'Pallet',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: () {
          // Open the modal when "Pallet" is clicked
          _showPalletModal();
        },
      ),
    );
  }

  void _showPalletModal() {
    final TextEditingController controller = TextEditingController();
    controller.text = box.read('pallet') ?? ''; // Set the current pallet value

    Get.dialog(
      AlertDialog(
        title: const Text('Enter Pallet Value'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter Pallet value',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Save the value to GetStorage and close the modal
              box.write('pallet', controller.text);
              Get.offNamed('/'); // Close the modal
              Navigator.of(Get.context!).pop(); // Close the drawer
            },
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () {
              Get.offNamed('/'); // Close the modal without saving
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 150, 150, 150),
        ),
      ),
    );
  }

  Widget _buildListTile(String title, String? route) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: route != null
            ? () {
          Get.offNamed(route);
        }
            : null,
      ),
    );
  }
}
