// custom_circleavatar.dart
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listapratica/src/services/controller.dart';

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
  late RxString userName;
  late RxString userEmail;

  @override
  void initState() {
    super.initState();
    UserController userController = Get.find<UserController>();
    userName = userController.userName;
    userEmail = userController.userEmail;
    
    // Adiciona um Ever para reagir a alterações no userName
    ever(userName, (_) {
      if (mounted) {
        setState(() {}); // Atualiza o estado do widget quando o userName muda
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String displayText;

    // Verifica se o userName está vazio ou se é a primeira letra do nome
    if (userName.isEmpty) {
      // Obtém o nome do banco de dados se userName estiver vazio
      displayText = userEmail.isNotEmpty ? userEmail.value[0].toUpperCase() : '';
    } else {
      displayText = userName.isNotEmpty ? userName.value[0].toUpperCase() : '';
    }

    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      child: Text(displayText, style: widget.textStyle),
    );
  }
}
