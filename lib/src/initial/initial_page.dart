// initial_page.dart
import 'package:flutter/material.dart';
import 'package:listapratica/src/home/db_helper.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          right: 20,
          left: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Seja muito bem-vindo(a)!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Text(
                'Estamos felizes por tê-lo(a) conosco. Como podemos te chamar? Digite abaixo o nome que você prefere!',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Apelido",
                hintText: "Como podemos te chamar?",
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            OutlinedButton(
              onPressed: () async {
                final nickname = _controller.text.trim();

                if (nickname.isNotEmpty) {
                  // Salvar no banco de dados
                  await SQLHelper.createData('title', 'desc', 'amount', nickname);

                  // Navegar para a tela /home
                  Navigator.of(context).pushNamed('/home');
                }
              },
              child: const Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
