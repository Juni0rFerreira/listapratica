// ignore_for_file: use_build_context_synchronously, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listapratica/src/home/db_helper.dart';
import 'package:listapratica/src/services/controller.dart';
import 'package:listapratica/widget/custom_appbar.dart';
import 'package:listapratica/widget/custom_circleavatar.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage(
      {Key? key, required Null Function(dynamic themeMode) onThemeChanged})
      : super(key: key);

  @override
  ConfigurationPageState createState() => ConfigurationPageState();
}

class ConfigurationPageState extends State<ConfigurationPage> {
  TextEditingController _newNameController = TextEditingController();
  TextEditingController _newEmailController = TextEditingController();

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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const CustomCircleAvatar(
                  radius: 54,
                  textStyle: TextStyle(fontSize: 34),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => Text(
                    '${Get.find<UserController>().userName}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Obx(
                  () => Text(
                    '${Get.find<UserController>().userEmail}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  height: 20,
                ),
                const Text(
                  'Transforme sua lista em magia: escolha com sabedoria, compre com consciência, e deixe a magia da organização transformar sua rotina!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const Divider(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _showChangeNameModal();
                        },
                        child: const Text('Mudar Nome'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showChangeEmailModal();
                        },
                        child: const Text('Mudar E-mail'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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

  void _showChangeEmailModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Novo E-mail',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              TextField(
                controller:
                    _newEmailController, 
                decoration: const InputDecoration(
                  labelText: 'Digite o novo e-mail',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String newEmail = _newEmailController.text;
                  await DBHelper().updateUserEmail(
                    userController.userEmail.value,
                    newEmail,
                  );
                                    userController.setUser(
                      userController.userName.value, newEmail);
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
