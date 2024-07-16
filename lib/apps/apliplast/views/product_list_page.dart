import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_list_controller.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductListController controller = Get.put(ProductListController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              var product = controller.products[index];
              return ListTile(
                title: Text(product['name']),
                subtitle: Text(product['description']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Implementar lógica para actualizar producto
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        controller.deleteProduct(product['id']);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implementar lógica para añadir nuevo producto
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
