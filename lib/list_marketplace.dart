import 'package:flutter/material.dart';

class ListMarketplace {
  final String? id;
  final Widget? avatar;
  final String description;
  final String date;

  const ListMarketplace({
  this.id,
  this.avatar,
  required this.description,
  required this.date,
  });
}

