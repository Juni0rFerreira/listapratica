import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listapratica/app_widget.dart';
import 'package:listapratica/src/home/db_helper.dart';
import 'package:listapratica/src/services/controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper().initDB(); // Inicialize o bd local
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );                         // Inicialize o bd firebase nuve

  Get.put(UserController()); // Inicialize o controlador do usuário

  runApp(const AppWidget());

  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  // firestore.collection("So para testar").doc("Estou Testando").set({
  //   "funcionou?": true,
  // });
}
