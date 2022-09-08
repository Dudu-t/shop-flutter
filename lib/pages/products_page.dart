import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/utils/app_routes.dart';

import '../models/product_list.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
        },
      ),
      appBar: AppBar(
        title: Text('Gerenciar Produtos'),
        actions: [
          IconButton(
              onPressed: (() {
                Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
              }),
              icon: Icon(Icons.add))
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: products.items.length == 0
            ? (Center(
                child: Text(
                  'Nenhum produto cadastrado!',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ))
            : ListView.builder(
                itemCount: products.items.length,
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ProductItem(product: products.items[index]),
                    Divider(),
                  ],
                ),
              ),
      ),
    );
  }
}
