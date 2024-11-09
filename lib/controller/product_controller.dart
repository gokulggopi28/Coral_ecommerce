import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/product_model.dart';

class ProductController extends GetxController {
  var productList = <Product>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    isLoading.value = true;
    try {
      var response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        var productsJson = json.decode(response.body) as List;
        productList.value = productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        errorMessage.value = "Failed to load products: ${response.statusCode}";
      }
    } catch (e) {
      errorMessage.value = "Error fetching products: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
