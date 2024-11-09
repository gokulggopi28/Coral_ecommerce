import 'package:coral_machine_test/constants/color_constants.dart';
import 'package:coral_machine_test/services/auth/auth_service.dart';
import 'package:coral_machine_test/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/my_drawer.dart';
import '../constants/constants.dart';
import '../controller/product_controller.dart';
import '../models/cart_item.dart';
import 'cart_page.dart';
import 'product_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    final productController = Get.put(ProductController());
    final cartController = Get.put(CartController());  

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
         backgroundColor: AppColors.backgroundColor,
        title: Center(child: Text(Constants.appTitle,style: TextStyle(
              fontSize: isSmallScreen ? 24 : 30,
              fontWeight: FontWeight.bold,
            ),)),
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
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: 
      Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: screenWidth > 600 ? 3 : 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.5,
            ),
            itemCount: productController.productList.length,
            itemBuilder: (context, index) {
              var product = productController.productList[index];
              return GestureDetector(
  onTap: () {
    Get.to(() => ProductDetailPage(product: product));
  },
  child: Card(
    color: const Color.fromARGB(255, 237, 235, 235),
    elevation: 4,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              Image.network(
                product.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () {
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            product.title,
           style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isSmallScreen ? 13 : 15,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "MRP: ₹${product.price}",style: TextStyle(fontSize: isSmallScreen ? 18 : 20)
            ,),
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              cartController.addToCart(
                CartItem(
                  productId: product.id.toString(), 
                  title: product.title,
                  price: product.price,
                  quantity: 1,
                  key: 0,
                  image: product.image,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: AppColors.backgroundColor,
              
              shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(20),
                ),
              
            ),
            child: const Text(
              Constants.addToCart,
                maxLines: 1,
              overflow: TextOverflow.ellipsis,
                 ),
          
          ),
        ),
      ],
    ),
  ),
);

            },
          );
        }
      }),
    );
  }
}
