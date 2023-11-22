import 'package:flutter/material.dart';
import 'package:listapratica/widget/custom_circleavatar.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('ListaPrática'),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 8),
          child: CustomCircleAvatar(),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
