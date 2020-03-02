import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Cart.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/providers/product_providers.dart';
import 'package:shop_app/ui/add/add_edit_screen.dart';
import 'package:shop_app/ui/cart/cart_screen.dart';
import 'package:shop_app/ui/order/orders_screen.dart';
import 'package:shop_app/ui/productDetail/product_detail_screen.dart';
import 'package:shop_app/ui/productOverview/product_overview_screen.dart';
import 'package:shop_app/ui/products/user_product_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Order(),
        ),
      ],
      child: MaterialApp(
        title: 'Shop App',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        initialRoute: '/',
        routes: {
          '/': (ctx) => ProductOverView(),
          ProductDetailScreen.routName: (ctx) => ProductDetailScreen(),
          CartScreen.routName: (ctx) => CartScreen(),
          OrderScreen.routName: (ctx) => OrderScreen(),
          UserProductScreen.routName: (ctx) => UserProductScreen(),
          AddEditScreen.routName: (ctx) => AddEditScreen(),
        },
      ),
    );
  }
}
