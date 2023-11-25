// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listapratica/src/home/db_helper.dart';
import 'package:listapratica/src/models/lists.dart';
import 'package:listapratica/src/products/products_page.dart';
import 'package:listapratica/widget/custom_appbar.dart';
import 'package:listapratica/widget/custom_navigationdrawer.dart';
import 'package:uuid/uuid.dart';

import '../services/controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Lists> listmonth = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final List<String> months = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro',
  ];

  final UserController userController = Get.find();

  

  String displayedName = ''; // Adicione esta linha

  @override
  void initState() {
    super.initState();
    _loadUserData();
    refresh();
  }

  void _loadUserData() async {
    DBHelper dbHelper = DBHelper();
    User? user = await dbHelper.getUser();

    if (user != null) {
      setState(() {
        userController.setUser(user.name, user.email);
      });
    }
  }

  showFormModal({Lists? model}) {
    // Labels à serem mostradas no Modal
    String title = "Adicionar Lista";
    String confirmationButton = "Salvar";
    String skipButton = "Cancelar";

    // Controlador do campo que receberá o nome do Listin
    TextEditingController nameController = TextEditingController();
    String selectedMonth = '';

    //Modificações
    if (model != null) {
      title = "Editando lista de ${model.month}";
      nameController.text = model.month;
    }

    // Função do Flutter que mostra o modal na tela
    showModalBottomSheet(
      context: context,

      // Define que as bordas verticais serão arredondadas
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(32.0),

          // Formulário com Título, Campo e Botões
          child: ListView(
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              DropdownButtonFormField<String>(
                items: months.map((String months) {
                  return DropdownMenuItem<String>(
                    value: months,
                    child: Text(months),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Mês",
                ),
                onChanged: (String? value) {
                  setState(() {
                    selectedMonth = value ?? '';
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(skipButton),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Lists lists = Lists(
                          id: const Uuid().v1(),
                          month: selectedMonth,
                        );

                        //id model

                        if (model != null) {
                          lists.id = model.id;
                        }

                        //Salvar Firestore
                        firestore
                            .collection("listmonth")
                            .doc(lists.id)
                            .set(lists.toMap());
                        refresh();
                        Navigator.of(context).pop();
                      },
                      child: Text(confirmationButton)),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomNavigationDrawer(),
      appBar: CustomAppBar(
        displayedName: displayedName,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showFormModal(),
        icon: const Icon(Icons.edit),
        label: const Text(
          "Nova Lista",
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: Container(
          child: (listmonth.isEmpty)
              ? const Center(
                  child: Text("Nenhuma lista criada")
                )
              : RefreshIndicator(
                  onRefresh: () {
                    return refresh();
                  },
                  child: ListView(
                    children: List.generate(listmonth.length, (index) {
                      Lists model = listmonth[index];
                      return Dismissible(
                        key: ValueKey<Lists>(model),
                        direction: DismissDirection.startToEnd,
                        background: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 12),
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (direction) {
                          remove(model);
                        },
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProductsPage(lists: model)));
                          },
                          onLongPress: () {
                            showFormModal(
                              model: model,
                            );
                          },
                          leading: const Icon(Icons.calendar_month),
                          title: Text("Lista de ${model.month}"),
                        ),
                      );
                    }),
                  ),
                ),
        ),
      ),
    );
  }

  refresh() async {
    List<Lists> temp = [];

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("listmonth").get();

    for (var doc in snapshot.docs) {
      temp.add(Lists.fromMap(doc.data()));
    }
    setState(() {
      listmonth = temp;
    });
  }

  void remove(Lists model) {
    firestore.collection("listmonth").doc(model.id).delete();
    refresh();
  }
}
