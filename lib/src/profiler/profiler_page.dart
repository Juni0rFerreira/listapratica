import 'package:flutter/material.dart';
import 'package:listapratica/widget/custom_appbar.dart';
import 'package:listapratica/widget/custom_circleavatar.dart';

class ProfilerPage extends StatefulWidget {
  const ProfilerPage({super.key});

  @override
  State<ProfilerPage> createState() => _ProfilerPageState();
}

String firstName = 'Fulano';

class _ProfilerPageState extends State<ProfilerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Column(
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
            const Align(
              child: Text(
                'Fulano Fulano Fulano',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Align(
              child: Text(
                'email@email.com.br',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Desconectar'),
            ),
          ],
        ),
      ),
    );
  }
}
