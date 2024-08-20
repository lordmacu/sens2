import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sens2/apps/samiya/controllers/tara_controller.dart';
import 'package:sens2/core/controllers/menu_controller.dart';
import 'package:sens2/core/services/auth_service.dart';

class MenuDrawer extends StatelessWidget {
  final MenuDrawerController controller = Get.find<MenuDrawerController>();
  final TableController controllerTable = Get.find<TableController>();
  final AuthService authService = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 20),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
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
                _buildSectionTitle('CONFIGURACIÓN'),
                _buildListTile('GateWay', '/gateWay'),
                _buildSectionTitle('GENERAL'),
                 _buildListTile('Lotes', '/tableLote'),
                _buildListTile('Pallet', null),
                _buildSectionTitle('PARAMETROS'),
                Obx(() {
                  return Column(
                    children: controller.menuItems.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: ListTile(
                          title: Text(
                            item['value']!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () async {
                            final Map<String, Map<String, dynamic>>
                                tableConfigurations = {
                              'material': {
                                'headersMapping': {
                                  'Material': 'key',
                                  'Tarifa': 'tariff',
                                },
                                'editableFieldsMapping': {
                                  'key': {
                                    'type': 'textfield',
                                    'value': 'key',
                                    'name': 'Material',
                                  },
                                  'tariff': {
                                    'type': 'textfield',
                                    'value': 'tariff',
                                    'name': 'Tarifa',
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

                            final headersMapping = config?['headersMapping']
                                as Map<String, String>;
                            final editableFieldsMapping =
                                config?['editableFieldsMapping']
                                    as Map<String, Map<String, dynamic>>;

                            await controllerTable.loadItems(
                              item['key'] as String,
                              headersMapping,
                              item['value'] as String,
                              editableFieldsMapping,
                            );

                            Navigator.of(context).pop();

                            Get.toNamed('/generalTable', arguments: {
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
                    title: Text(
                      'Cerrar turno',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    onTap: () {
                      authService.logout();
                      Get.toNamed('/');
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        title,
        style: TextStyle(
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
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: route != null
            ? () {
                Get.toNamed(route);
              }
            : null,
      ),
    );
  }
}
