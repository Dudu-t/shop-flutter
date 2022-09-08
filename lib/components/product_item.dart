import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductList provider = Provider.of(context, listen: false);

    Future<bool> showDialogRemove() async {
      final dialog = await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Tem certeza?'),
          content: Text(
            'Você deseja remover esse produto?\nEssa ação não pode ser desfeita',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(false);
              },
              child: Text('Não'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(ctx).errorColor),
              onPressed: () {
                Navigator.of(ctx).pop(true);
              },
              child: Text('Sim',
                  style: TextStyle(
                      color:
                          Theme.of(context).primaryTextTheme.headline6!.color)),
            ),
          ],
        ),
      );
      if (dialog == null) {
        return false;
      } else {
        return dialog;
      }
    }

    void _attempRemoveProduct(product) async {
      final bool dialogReponse = await showDialogRemove();
      if (dialogReponse) {
        provider.removeProduct(product);
      }
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCT_FORM,
                  arguments: product,
                );
              },
              color: Theme.of(context).colorScheme.primary,
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                _attempRemoveProduct(product);
              },
              color: Theme.of(context).errorColor,
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
