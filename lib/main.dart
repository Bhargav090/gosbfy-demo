import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gosbfy/block/cart/cart_bloc.dart';
import 'package:gosbfy/block/favorite/favorite_bloc.dart';
import 'package:gosbfy/block/product/product_block.dart';
import 'package:gosbfy/block/product/product_event.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductBloc()..add(FetchProducts())),
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => FavoriteBloc()),
      ],
      child: MaterialApp(
        title: 'Helendo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        ),
        home: const HomeScreen(),
      ),
    );
  }
}