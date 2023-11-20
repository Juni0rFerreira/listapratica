import 'package:flutter/material.dart';
import 'package:listapratica/list_marketplace.dart';

class ListsTile extends StatelessWidget {
  final ListMarketplace listMarketplace;

  const ListsTile({Key? key, required this.listMarketplace}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: listMarketplace.avatar,
      title: Text(listMarketplace.description),
      subtitle: Text(listMarketplace.date),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
