// ignore_for_file: use_build_context_synchronously, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listapratica/src/home/db_helper.dart';
import 'package:listapratica/src/services/controller.dart';
import 'package:listapratica/widget/custom_appbar.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage(
      {Key? key, required Null Function(dynamic themeMode) onThemeChanged})
      : super(key: key);

  @override
  ConfigurationPageState createState() => ConfigurationPageState();
}

class ConfigurationPageState extends State<ConfigurationPage> {
  TextEditingController _newNameController = TextEditingController();

  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        displayedName: '${Get.find<UserController>().userName}',
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Text(
                  '${Get.find<UserController>().userName}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Obx(
                () => Text(
                  '${Get.find<UserController>().userEmail}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _showChangeNameModal();
                },
                child: const Text('Mudar Nome'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //LOGICA

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _showChangeNameModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Novo Nome',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _newNameController,
                decoration: const InputDecoration(
                  labelText: 'Digite o novo nome',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String newName = _newNameController.text;
                  await userController.setUser(
                      newName, userController.userEmail.value);
                  await DBHelper()
                      .updateUserName(userController.userEmail.value, newName);
                  Navigator.pop(context);
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        );
      },
    );
  }
}
