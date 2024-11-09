import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color_constants.dart';
import '../constants/constants.dart';
import '../controller/cart_controller.dart';
import '../models/cart_item.dart';
import '../models/product_model.dart';
import 'cart_page.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(widget.product.title),
        actions: [
          Obx(() {
            return IconButton(
              onPressed: () {
                Get.to(() => const CartPage());
              },
              icon: Badge(
                label: Text(cartController.cartItems.length.toString()),
                child: const Icon(Icons.shopping_cart),
              ),
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.product.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 450,
              ),
              const SizedBox(height: 16.0),
              Text(
                widget.product.title,
                style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                "₹ ${widget.product.price} ",
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                Constants.inclusiveText,
                style: TextStyle(fontSize: 16.0,color: Colors.grey),
              ),
              const Text(
                Constants.applicableDutiesText,
                style: TextStyle(fontSize: 16.0,color: Colors.grey),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: SizedBox(
                  width: 320, 
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.backgroundColor,
                  foregroundColor: Colors.black,
                  
                  shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Colors.black, width: 2),
                            
                  ),
                  
                              ),
                    child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(Constants.selectSizeText),
          Icon(Icons.arrow_drop_down, color: Colors.black),
        ],
      ),
    ),
  ),
),
              const SizedBox(height: 16.0),
              Center(
                child: SizedBox(
                  width: 320, 
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      cartController.addToCart(
                        CartItem(
                          productId: widget.product.id.toString(),
                          title: widget.product.title,
                          price: widget.product.price,
                          quantity: 1,
                          key: 0,
                          image: widget.product.image,
                        ),
                      );
                      Get.snackbar(
                        "Success",
                        "${widget.product.title} has been added to the cart",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: AppColors.backgroundColor,
                  shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            
                  ),
                  
                              ),
                    child: const Text(Constants.addToCart),
                  ),
                ),
              ),

              const SizedBox(height: 16.0),

              Text(
                widget.product.description,
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              
            ],
          ),
        ),
      ),
    );
  }
}