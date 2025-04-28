import '../../models/product.dart';

class CartState {
  final Map<String, CartItem> items;

  CartState({this.items = const {}});

  int get itemCount => items.values.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => items.values.fold(0, (sum, item) => sum + item.product.price * item.quantity);
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}