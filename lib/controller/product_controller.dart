import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/product_model.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  var productList = <Product>[].obs;

  // Fetch product list
  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      final response =
      await http.get(Uri.parse('https://fakestoreapi.com/products'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        productList.value = data.map((e) => Product.fromJson(e)).toList();
      } else {
        productList.clear();
      }
    } catch (e) {
      productList.clear();
      print("Error fetching products: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
