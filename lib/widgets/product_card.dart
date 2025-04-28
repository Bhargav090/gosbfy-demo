import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gosbfy/block/cart/cart_bloc.dart';
import 'package:gosbfy/block/cart/cart_event.dart';
import 'package:gosbfy/block/favorite/favorite_bloc.dart';
import 'package:gosbfy/block/favorite/favorite_event.dart';
import '../models/product.dart';
import 'product_dialog.dart';
class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => ProductDialog(product: widget.product, initialQuantity: 1),
          );
        },
        child: Card(
          elevation: 2,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                        child: Image.network(
                          'https://interview.gdev.gosbfy.com/api/files/${widget.product.collectionId}/${widget.product.id}/${widget.product.image}',
                          fit: BoxFit.cover,
                          height: 140, // Reduced by 30% from 200
                          width: 140, // Reduced by 30% from implicit full width
                          errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          widget.product.name,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '\$${widget.product.price.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              AnimatedOpacity(
                opacity: _isHovered ? 1.0 : 0.0,
                duration: Duration(milliseconds: 300),
                child: AnimatedScale(
                  scale: _isHovered ? 1.0 : 0.8,
                  duration: Duration(milliseconds: 300),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildIconButton(
                          icon: Icons.add,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => ProductDialog(product: widget.product, initialQuantity: 0),
                            );
                          },
                        ),
                        SizedBox(width: 10),
                        _buildIconButton(
                          icon: Icons.shopping_bag_outlined,
                          onPressed: () {
                            context.read<CartBloc>().add(AddToCart(widget.product, 1));
                          },
                        ),
                        SizedBox(width: 10),
                        _buildIconButton(
                          icon: Icons.favorite_border,
                          onPressed: () {
                            context.read<FavoriteBloc>().add(ToggleFavorite(widget.product.id));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton({required IconData icon, required VoidCallback onPressed}) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: IconButton(
        icon: Icon(icon, color: Colors.black),
        onPressed: onPressed,
      ),
    );
  }
}