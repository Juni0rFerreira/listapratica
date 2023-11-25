import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        displayedName: 'Chaperoso',
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
                 const Text(
                    "Chaperoso",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                
                const SizedBox(
                  height: 5,
                ),
                 const Text(
                    "junioredilsonferreira@hotmail.com",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
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
                        onPressed: () {},
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
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Digite o novo nome',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
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
