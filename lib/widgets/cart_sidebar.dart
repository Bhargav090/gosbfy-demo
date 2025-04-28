import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gosbfy/block/cart/cart_bloc.dart';
import 'package:gosbfy/block/cart/cart_event.dart';
import 'package:gosbfy/block/cart/cart_state.dart';

class CartSidebar extends StatelessWidget {
  final VoidCallback onClose;

  const CartSidebar({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width < 600 
    ? MediaQuery.of(context).size.width * 0.8 
    : MediaQuery.of(context).size.width * 0.3,
        // Full height from top to bottom
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: onClose,
                    ),
                    Expanded(
                      child: Text(
                        'Cart',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state.items.isEmpty) {
                      return Center(child: Text('You have not added any items to the cart'));
                    }
                    return ListView.builder(
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final item = state.items.values.toList()[index];
                        final product = item.product;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.12,
                                height: 100,
                                child: Image.network(
                                  'https://interview.gdev.gosbfy.com/api/files/${product.collectionId}/${product.id}/${product.image}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text('Qty: ${item.quantity}'),
                                    Text('\$${product.price.toStringAsFixed(2)}'),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  context.read<CartBloc>().add(RemoveFromCart(product.id));
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subtotal:', style: Theme.of(context).textTheme.titleMedium),
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) => Text('\$${state.subtotal.toStringAsFixed(2)}'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.black),
                        backgroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                      ),
                      child: Text('View Cart', style: TextStyle(color: Colors.black)),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 48),
                      ),
                      child: Text('Checkout'),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}