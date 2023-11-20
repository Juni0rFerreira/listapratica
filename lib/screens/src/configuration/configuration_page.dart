// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({Key? key, required this.onThemeChanged})
      : super(key: key);

  final void Function(ThemeMode themeMode) onThemeChanged;

  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  ThemeMode _selectedTheme = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListaPrática'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                child: const Text('A'),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Configuração',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Tema',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.system,
              groupValue: _selectedTheme,
              title: const Text('Sistema'),
              onChanged: (mode) {
                setState(() {
                  _selectedTheme = mode!;
                  widget.onThemeChanged(_selectedTheme);
                });
              },
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.light,
              groupValue: _selectedTheme,
              title: const Text('Claro'),
              onChanged: (mode) {
                setState(() {
                  _selectedTheme = mode!;
                  widget.onThemeChanged(_selectedTheme);
                });
              },
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.dark,
              groupValue: _selectedTheme,
              title: const Text('Escuro'),
              onChanged: (mode) {
                setState(() {
                  _selectedTheme = mode!;
                  widget.onThemeChanged(_selectedTheme);
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Controle de dados',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(
              height: 10,
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Apagar dados'),
            ),
          ],
        ),
      ),
    );
  }
}
