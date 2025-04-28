import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gosbfy/block/favorite/favorite_bloc.dart';
import 'package:gosbfy/block/favorite/favorite_event.dart';
import 'package:gosbfy/block/favorite/favorite_state.dart';
import 'package:gosbfy/block/product/product_block.dart';
import 'package:gosbfy/block/product/product_state.dart';

class FavoriteSidebar extends StatelessWidget {
  final VoidCallback onClose;

  const FavoriteSidebar({super.key, required this.onClose});

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
                        'Favorites',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<FavoriteBloc, FavoriteState>(
                  builder: (context, favoriteState) {
                    return BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, productState) {
                        if (favoriteState.favoriteIds.isEmpty) {
                          return Center(child: Text('You have no items in your favorites'));
                        }
                        if (productState is ProductLoaded) {
                          final favoriteProducts = productState.products
                              .where((product) => favoriteState.favoriteIds.contains(product.id))
                              .toList();
                          return ListView.builder(
                            itemCount: favoriteProducts.length,
                            itemBuilder: (context, index) {
                              final product = favoriteProducts[index];
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
                                          Text('\$${product.price.toStringAsFixed(2)}'),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        context.read<FavoriteBloc>().add(ToggleFavorite(product.id));
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                        return Center(child: Text('Loading favorites...'));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
