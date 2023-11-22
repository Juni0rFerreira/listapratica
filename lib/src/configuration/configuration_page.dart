// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:listapratica/widget/custom_appbar.dart';
import 'package:listapratica/widget/custom_circleavatar.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({Key? key, required this.onThemeChanged})
      : super(key: key);

  final void Function(ThemeMode themeMode) onThemeChanged;

  @override
  ConfigurationPageState createState() => ConfigurationPageState();
}

String firstName = 'Fulano';

class ConfigurationPageState extends State<ConfigurationPage> {
  TextEditingController _newNameController = TextEditingController();
  String displayedName = firstName; // Variável para armazenar o nome exibido

  // Função para exibir o modal de alteração de nome
  void _showChangeNameModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Novo Nome',
                style: Theme.of(context).textTheme.titleLarge,
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
                onPressed: () {
                  // Atualizar o nome quando o usuário confirmar
                  setState(() {
                    firstName = _newNameController.text;
                    displayedName = firstName; // Atualizar a variável exibida
                  });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const CustomCircleAvatar(
                    radius: 60,
                    textStyle: TextStyle(fontSize: 34),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    child: Text(
                      displayedName, // Utilizar a variável atualizada
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Divider(
                    height: 50,
                  ),
                  const Align(
                    child: Text(
                      '"Transforme sua lista em magia, escolha com sabedoria, compre com consciência, e deixe a magia da organização transformar sua rotina!"',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Divider(
                    height: 50,
                  ),
                  Text(
                    'Configuração',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      _showChangeNameModal(); // Chamar a função ao clicar
                    },
                    child: const SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Alterar Nome',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('Apagar dados'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
