import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listapratica/app_widget.dart';
import 'package:listapratica/src/home/db_helper.dart';
import 'package:listapratica/src/services/controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper().initDB();

  Get.put(UserController()); // Inicialize o controlador do usuário

  runApp(const AppWidget());
}