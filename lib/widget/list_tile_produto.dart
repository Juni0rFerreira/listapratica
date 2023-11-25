import 'package:flutter/material.dart';
import 'package:listapratica/src/models/product.dart';

class ListTileProduto extends StatelessWidget {
  final Product product;
  final bool isComprado;
  final Function showModal;
  final Function iconclick;
  final Function deleteclick;
  const ListTileProduto({
    super.key,
    required this.product,
    required this.isComprado,
    required this.showModal,
    required this.iconclick,
    required this.deleteclick,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showModal(model: product);
      },
      leading: IconButton(
        onPressed: () {
          iconclick(product);
        },
        icon: Icon(
          (isComprado) ? Icons.check : Icons.shopping_cart_outlined,
        ),
      ),
      trailing: IconButton(
          onPressed: () {
            deleteclick(product);
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          )),
      title: Text(
        "${product.product} (x${product.amount})",
      ),
      subtitle: Text((product.category)),
    );
  }
}
