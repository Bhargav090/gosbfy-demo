import '../../models/product.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final Product product;
  final int quantity;
  AddToCart(this.product, this.quantity);
}

class RemoveFromCart extends CartEvent {
  final String productId;
  RemoveFromCart(this.productId);
}

class UpdateQuantity extends CartEvent {
  final String productId;
  final int change;
  UpdateQuantity(this.productId, this.change);
}