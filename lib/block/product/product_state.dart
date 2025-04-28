import '../../models/product.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final int total;
  ProductLoaded({required this.products, required this.total});
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}