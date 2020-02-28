import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/custom/badge.dart';
import 'package:shop_app/providers/Cart.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/product_providers.dart';
import 'package:shop_app/ui/cart/cart_screen.dart';
import 'package:shop_app/ui/productOverview/product_item.dart';

enum FilterOption { All, Favorite }

class ProductOverView extends StatefulWidget {
  @override
  _ProductOverViewState createState() => _ProductOverViewState();
}

class _ProductOverViewState extends State<ProductOverView> {
  bool showFav = false;

  @override
  Widget build(BuildContext context) {
    final List<Product> products = [];
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: <Widget>[
          Consumer<Cart>(
            builder: (context, value, child) {
              return Badge(child: child, value: value.itemsCount.toString());
            },
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routName);
              },
            ),
          ),
          PopupMenuButton(
            onSelected: (FilterOption value) {
              setState(() {
                if (value == FilterOption.All) {
                  showFav = false;
                } else {
                  showFav = true;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text('Show Favorite'),
                  value: FilterOption.Favorite,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: FilterOption.All,
                ),
              ];
            },
          ),
        ],
      ),
      body: ProductGrids(showFav),
    );
  }
}

class ProductGrids extends StatelessWidget {
  final bool showFav;

  ProductGrids(this.showFav);

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<Products>(context);
    var products =
        showFav ? productProvider.getFavorite() : productProvider.items;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(),
        );
      },
      itemCount: products.length,
      padding: EdgeInsets.all(10.0),
    );
  }
}
