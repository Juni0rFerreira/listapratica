// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatefulWidget {
  final double? radius;
  final TextStyle? textStyle;

  const CustomCircleAvatar({
    Key? key,
    this.radius,
    this.textStyle,
  }) : super(key: key);

  @override
  _CustomCircleAvatarState createState() => _CustomCircleAvatarState();
}

class _CustomCircleAvatarState extends State<CustomCircleAvatar> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      child: Text("C", style: widget.textStyle),
    );
  }
}
