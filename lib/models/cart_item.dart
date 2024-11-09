import 'package:hive/hive.dart';

part 'cart_item.g.dart';

@HiveType(typeId: 1)
class CartItem {
  @HiveField(0)
  final String productId;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final double price;
  
  @HiveField(3)
  int quantity;

  @HiveField(4)
  int key; 

  @HiveField(5)
  final String image;

  CartItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    required this.key, 
    required this.image,
  });
}