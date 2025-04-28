import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gosbfy/block/cart/cart_bloc.dart';
import 'package:gosbfy/block/cart/cart_state.dart';
import 'package:gosbfy/block/favorite/favorite_bloc.dart';
import 'package:gosbfy/block/favorite/favorite_state.dart';
import 'package:gosbfy/block/product/product_block.dart';
import 'package:gosbfy/block/product/product_event.dart';
import 'package:gosbfy/block/product/product_state.dart';
import '../widgets/product_card.dart';
import '../widgets/cart_sidebar.dart';
import '../widgets/favorite_sidebar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showCartSidebar = false;
  bool _showFavoriteSidebar = false;
  bool _showSearchBox = false;
  String _sortOption = 'default';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount =
        screenWidth > 1200
            ? 3
            : screenWidth > 600
            ? 2
            : 1;
    final isMobile = screenWidth < 600;

    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          scrolledUnderElevation: 0,
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent, 
          title: isMobile 
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.black),
                      onPressed: () {
                        setState(() {
                          _showSearchBox = !_showSearchBox;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:48.0),
                      child: Text(
                        'Helendo',
                        style: TextStyle(
                          fontWeight: FontWeight.w900, 
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Stack(
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              icon: Icon(Icons.favorite_border, color: Colors.black, size: 22),
                              onPressed: () {
                                setState(() {
                                  _showFavoriteSidebar = true;
                                  _showCartSidebar = false;
                                });
                              },
                            ),
                            Positioned(
                              right: 10,
                              bottom: 10,
                              child: BlocBuilder<FavoriteBloc, FavoriteState>(
                                builder: (context, state) => CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Colors.amber,
                                  child: Text(
                                    state.count.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 1),
                        Stack(
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              icon: Icon(Icons.shopping_cart_outlined, color: Colors.black, size: 22),
                              onPressed: () {
                                setState(() {
                                  _showCartSidebar = true;
                                  _showFavoriteSidebar = false;
                                });
                              },
                            ),
                            Positioned(
                              right: 10,
                              bottom: 10,
                              child: BlocBuilder<CartBloc, CartState>(
                                builder: (context, state) => CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Colors.amber,
                                  child: Text(
                                    state.itemCount.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 1),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: Icon(Icons.menu, color: Colors.black, size: 22),
                          onPressed: () {
                             setState(() {
                                _showCartSidebar = true;
                                _showFavoriteSidebar = false;
                              });
                          },
                        ),
                      ],
                    ),
                  ],
                )
              : Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.1, right: screenWidth * 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: screenWidth * 0.01),
                        child: Container(
                          width: screenWidth * 0.2,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search anything...',
                              suffixIcon: Icon(Icons.search, color: Colors.black),
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Helendo',
                            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 26),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.person, color: Colors.black),
                          SizedBox(width: 10),
                          Stack(
                            children: [
                              IconButton(
                                icon: Icon(Icons.favorite_border, color: Colors.black),
                                onPressed: () {
                                  setState(() {
                                    _showFavoriteSidebar = true;
                                    _showCartSidebar = false;
                                  });
                                },
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: BlocBuilder<FavoriteBloc, FavoriteState>(
                                  builder: (context, state) => CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.amber,
                                    child: Text(
                                      state.count.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showCartSidebar = true;
                                    _showFavoriteSidebar = false;
                                  });
                                },
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: BlocBuilder<CartBloc, CartState>(
                                  builder: (context, state) => CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.amber,
                                    child: Text(
                                      state.itemCount.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(Icons.menu, color: Colors.black),
                            onPressed: () {
                              setState(() {
                                _showCartSidebar = true;
                                _showFavoriteSidebar = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: isMobile ? 1 : screenWidth * 0.1,
              right: isMobile ? 1 : screenWidth * 0.1,
            ),
            child: Column(
              children: [
                if (isMobile && _showSearchBox)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search anything...',
                          suffixIcon: Icon(Icons.search, color: Colors.black),
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(
                    top: screenWidth * 0.01,
                    left: isMobile ? 20 : screenWidth * 0.02,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          if (state is ProductLoaded) {
                            return Text(
                              'Showing 1 - ${state.products.length} of ${state.total}',
                              style: TextStyle(
                                fontSize: isMobile ? 12 : MediaQuery.of(context).size.height * 0.023,
                                color: Colors.black,
                              ),
                            );
                          }
                          return Text(
                            'Showing 0 of 0',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: isMobile ? 12 : MediaQuery.of(context).size.height * 0.023
                            ),
                          );
                        },
                      ),
                      Text(' | ', style: TextStyle(fontSize: isMobile ? 12 : 16)),
                      DropdownButton<String>(
                        value: _sortOption,
                        items:
                            [
                                  DropdownMenuItem(
                                    value: 'default',
                                    child: Text(
                                      'Sort by default',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: isMobile ? 12 : MediaQuery.of(context).size.height * 0.023
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'name_asc',
                                    child: Text(
                                      'Name (A-Z)',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: isMobile ? 12 : MediaQuery.of(context).size.height * 0.023
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'name_desc',
                                    child: Text(
                                      'Name (Z-A)',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: isMobile ? 12 : MediaQuery.of(context).size.height * 0.023
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'price_asc',
                                    child: Text(
                                      'Price (Low to High)',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: isMobile ? 12 : MediaQuery.of(context).size.height * 0.023
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'price_desc',
                                    child: Text(
                                      'Price (High to Low)',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: isMobile ? 12 : MediaQuery.of(context).size.height * 0.023
                                      ),
                                    ),
                                  ),
                                ]
                                .map(
                                  (item) => DropdownMenuItem(
                                    value: item.value,
                                    child: Container(
                                      color:
                                          _sortOption == item.value
                                              ? Colors.transparent
                                              : null,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 2,
                                        vertical: 4,
                                      ),
                                      child: item.child,
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            _sortOption = value!;
                            context.read<ProductBloc>().add(
                              SortProducts(value),
                            );
                          });
                        },
                        icon: Icon(Icons.arrow_drop_down, size: isMobile ? 16 : 24),
                        underline: SizedBox(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is ProductLoaded) {
                        return ScrollConfiguration(
                          behavior: ScrollConfiguration.of(
                            context,
                          ).copyWith(scrollbars: false),
                          child: GridView.builder(
                            padding: EdgeInsets.all(isMobile ? 8 : 16),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  crossAxisSpacing: isMobile ? 8 : 16,
                                  mainAxisSpacing: isMobile ? 8 : 16,
                                  childAspectRatio: 0.9,
                                ),
                            itemCount: state.products.length,
                            itemBuilder: (context, index) {
                              return ProductCard(
                                product: state.products[index],
                              );
                            },
                          ),
                        );
                      } else if (state is ProductError) {
                        return Center(child: Text(state.message));
                      }
                      return Center(child: Text('No products available'));
                    },
                  ),
                ),
              ],
            ),
          ),
           if (_showCartSidebar || _showFavoriteSidebar)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showCartSidebar = false;
                        _showFavoriteSidebar = false;
                      });
                    },
                  ),
                ),
              ),
            ),
          if (_showCartSidebar)
            CartSidebar(
              onClose: () {
                setState(() {
                  _showCartSidebar = false;
                });
              },
            ),
          if (_showFavoriteSidebar)
            FavoriteSidebar(
              onClose: () {
                setState(() {
                  _showFavoriteSidebar = false;
                });
              },
            ),
        ],
      ),
    );
  }
}