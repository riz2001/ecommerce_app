import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/product_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    // Fetch products when page opens
    controller.fetchProducts();

    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.productList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/empty.png', // Add empty image in assets
                  width: 150,
                ),
                const SizedBox(height: 16),
                const Text("No products available"),
              ],
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: controller.fetchProducts,
            child: ListView.builder(
              itemCount: controller.productList.length,
              itemBuilder: (context, index) {
                final product = controller.productList[index];
                return ListTile(
                  leading: Image.network(
                    product.image,
                    width: 50,
                    height: 50,
                  ),
                  title: Text(product.title),
                  subtitle: Text("\$${product.price}"),
                  onTap: () {
                    Get.toNamed('/product', arguments: product.id);
                  },
                );
              },
            ),
          );
        }
      }),
    );
  }
}
