import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/product.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<SortProducts>(_onSortProducts);
  }

  Future<void> _onFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final response = await http.get(Uri.parse('https://interview.gdev.gosbfy.com/api/collections/Products/records'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<Product> products = (data['items'] as List).map((item) => Product.fromJson(item)).toList();
        emit(ProductLoaded(products: products, total: products.length));
      } else {
        emit(ProductError('Failed to load products'));
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onSortProducts(SortProducts event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      List<Product> sortedProducts = List.from(currentState.products);
      switch (event.sortOption) {
        case 'name_asc':
          sortedProducts.sort((a, b) => a.name.compareTo(b.name));
          break;
        case 'name_desc':
          sortedProducts.sort((a, b) => b.name.compareTo(a.name));
          break;
        case 'price_asc':
          sortedProducts.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'price_desc':
          sortedProducts.sort((a, b) => b.price.compareTo(a.price));
          break;
      }
      emit(ProductLoaded(products: sortedProducts, total: currentState.total));
    }
  }
}