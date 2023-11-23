// initial_page.dart
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listapratica/src/home/home_page.dart';
import 'package:listapratica/src/services/controller.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              const Text(
                'Seja muito bem-vindo(a)!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/img/bemvindo.png',
                height: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Text(
                  'Estamos felizes por tê-lo(a) conosco. Como podemos te chamar? Digite abaixo o nome que você prefere!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Digite seu apelido',
                  labelText: 'Apelido',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Digite seu e-mail',
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              OutlinedButton(
                style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size(200,50))),
                onPressed: () async {
                  String name = _nameController.text;
                  String email = _emailController.text;
          
                  userController.setUser(name, email);
          
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                
                child: const Text('Enter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
