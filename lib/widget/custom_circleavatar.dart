import 'package:flutter/material.dart';
import 'package:listapratica/src/profiler/profiler_page.dart';

class CustomCircleAvatar extends StatelessWidget {
  final double? radius;
  final TextStyle? textStyle;

  const CustomCircleAvatar({
    Key? key,
    this.radius, this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      child: Text(
        firstName.isNotEmpty ? firstName[0].toUpperCase() : '?',
        style: textStyle,
      ),
    );
  }
}
