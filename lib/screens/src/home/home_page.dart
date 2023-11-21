// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:listapratica/screens/src/home/db_helper.dart';
import 'package:listapratica/widget/custom_appbar.dart';
import 'package:listapratica/widget/custom_navigationdrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _allData = [];
  final List<String> _categories = [
    '🥘 Alimentos em Geral',
    '🥦 Feira',
    '🧀 Frios',
    '🥩 Açougue',
    '🍞 Padaria',
    '🧻 Higiene',
    '🧹 Limpeza',
    '🍻 Bebidas',
    '❄️ Congelados',
    '❓ Outros',
  ];
  bool _isLoading = true;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    final data = await SQLHelper.getAllData();
    setState(() {
      _allData = data;
      _isLoading = false;
    });
  }

  Future<void> _addOrUpdateData(int? id) async {
    if (id == null) {
      await SQLHelper.createData(
        _titleController.text,
        _descController.text,
        _amountController.text,
      );
    } else {
      await SQLHelper.updateData(
        id,
        _titleController.text,
        _descController.text,
        _amountController.text,
      );
    }

    _clearControllers();
    _refreshData();
    Navigator.of(context).pop();
  }

  void _deleteData(int id) async {
    await SQLHelper.deleteData(id);
    _showSnackBar('Item Excluido');
    _refreshData();
  }

  void _clearControllers() {
    _titleController.text = '';
    _descController.text = '';
    _amountController.text = '';
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _showBottomSheet(int? id) async {
    if (id != null) {
      final existingData =
          _allData.firstWhere((element) => element['id'] == id);
      _titleController.text = existingData['title'];
      _descController.text = existingData['desc'];
      _amountController.text = existingData['amount'];
    }

    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(id == null ? "Cadastrar Item" : "Atualizar Item"),
            const SizedBox(height: 20),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Produto",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              controller: _amountController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Quantidade",
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _categories.isNotEmpty ? _categories[9] : 'Outros',
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _descController.text = value ?? '';
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Categoria",
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => _addOrUpdateData(id),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(id == null ? "Adicionar Item" : "Atualizar"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomNavigationDrawer(),
      appBar: const CustomAppBar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showBottomSheet(null),
        icon: const Icon(Icons.edit),
        label: const Text("Novo Item"),
      ),
      body: Container(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _allData.length,
                itemBuilder: (context, index) => Card(
                  margin: const EdgeInsets.all(15),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      child: Text(_allData[index]['amount']),
                    ),
                    title: Text(_allData[index]['title']),
                    subtitle: Text(_allData[index]['desc']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () =>
                              _showBottomSheet(_allData[index]['id']),
                          icon: const Icon(
                            Icons.edit,
                          ),
                        ),
                        IconButton(
                          onPressed: () => _deleteData(_allData[index]['id']),
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
