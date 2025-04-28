import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gosbfy/block/cart/cart_bloc.dart';
import 'package:gosbfy/block/cart/cart_event.dart';
import 'package:gosbfy/block/favorite/favorite_bloc.dart';
import 'package:gosbfy/block/favorite/favorite_event.dart';
import '../models/product.dart';

class ProductDialog extends StatefulWidget {
  final Product product;
  final int initialQuantity;

  const ProductDialog({
    super.key,
    required this.product,
    required this.initialQuantity,
  });

  @override
  State<ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;
    
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: isMobile ? screenSize.width * 0.9 : screenSize.width * 0.8,
        constraints: BoxConstraints(
          minHeight: isMobile ? 0 : screenSize.height * 0.8,
          maxHeight: screenSize.height * 0.9,
        ),
        child: isMobile
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    child: Container(
                      height: screenSize.height * 0.3,
                      width: double.infinity,
                      child: Image.network(
                        'https://interview.gdev.gosbfy.com/api/files/${widget.product.collectionId}/${widget.product.id}/${widget.product.image}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: _buildProductDetails(isMobile),
                      ),
                    ),
                  ),
                ],
              )
            // Desktop layout (Row: image on left, details on right)
            : Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
                      child: Image.network(
                        'https://interview.gdev.gosbfy.com/api/files/${widget.product.collectionId}/${widget.product.id}/${widget.product.image}',
                        fit: BoxFit.cover,
                        height: double.infinity,
                        errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: _buildProductDetails(isMobile),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildProductDetails(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            widget.product.name,
            style: TextStyle(
              fontSize: isMobile ? 18 : MediaQuery.of(context).size.width * 0.023,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            '\$${widget.product.price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isMobile ? 16 : MediaQuery.of(context).size.width * 0.02,
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Text(
                'Available: ',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'in-stock',
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Html(data: widget.product.longDesc),
        SizedBox(height: 16),
        isMobile
            // Mobile layout for buttons (more compact)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (quantity > 0)
                                IconButton(
                                  iconSize: 20,
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      quantity--;
                                    });
                                  },
                                ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: quantity > 0 ? 0 : 8,
                                ),
                                child: Text(quantity.toString()),
                              ),
                              IconButton(
                                iconSize: 20,
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: IconButton(
                          iconSize: 20,
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: Icon(Icons.favorite_border),
                          onPressed: () {
                            context.read<FavoriteBloc>().add(
                              ToggleFavorite(widget.product.id),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (quantity > 0) {
                          context.read<CartBloc>().add(
                            AddToCart(widget.product, quantity),
                          );
                          Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: Size(double.infinity, 44),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text('Add to Cart'),
                    ),
                  ),
                ],
              )
            // Desktop layout for buttons (side by side)
            : Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        if (quantity > 0)
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                quantity--;
                              });
                            },
                          ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: quantity > 0 ? 0 : 8,
                          ),
                          child: Text(quantity.toString()),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (quantity > 0) {
                        context.read<CartBloc>().add(
                          AddToCart(widget.product, quantity),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: Size(50, 50),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text('Add to Cart'),
                  ),
                  SizedBox(width: 16),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {
                        context.read<FavoriteBloc>().add(
                          ToggleFavorite(widget.product.id),
                        );
                      },
                    ),
                  ),
                ],
              ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'SKU: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: '${widget.product.sku}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Category: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: '${widget.product.category}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Tags: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: '${widget.product.tag}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.facebook),
                    Icon(Icons.share),
                    Icon(Icons.link),
                  ],
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Share this item',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}