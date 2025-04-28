import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateQuantity>(_onUpdateQuantity);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final updatedItems = Map<String, CartItem>.from(state.items);
    if (updatedItems.containsKey(event.product.id)) {
      updatedItems[event.product.id]!.quantity += event.quantity;
    } else {
      updatedItems[event.product.id] = CartItem(product: event.product, quantity: event.quantity);
    }
    emit(CartState(items: updatedItems));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final updatedItems = Map<String, CartItem>.from(state.items);
    updatedItems.remove(event.productId);
    emit(CartState(items: updatedItems));
  }

  void _onUpdateQuantity(UpdateQuantity event, Emitter<CartState> emit) {
    final updatedItems = Map<String, CartItem>.from(state.items);
    if (updatedItems.containsKey(event.productId)) {
      final newQuantity = updatedItems[event.productId]!.quantity + event.change;
      if (newQuantity > 0) {
        updatedItems[event.productId]!.quantity = newQuantity;
      } else {
        updatedItems.remove(event.productId);
      }
      emit(CartState(items: updatedItems));
    }
  }
}