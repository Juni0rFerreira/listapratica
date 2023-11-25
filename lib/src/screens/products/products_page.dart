import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listapratica/src/helpers/enum_order.dart';
import 'package:listapratica/src/models/lists.dart';
import 'package:listapratica/src/models/product.dart';
import 'package:listapratica/src/services/product_services.dart';
import 'package:listapratica/widget/list_tile_produto.dart';
import 'package:uuid/uuid.dart';

class ProductsPage extends StatefulWidget {
  final Lists lists;
  const ProductsPage({super.key, required this.lists});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Product> listProductsPending = []; // Produtos Pendentes
  List<Product> listProductsPurchased = []; // Produtos Comprados
  ProductService productService = ProductService();

  OrderProducts ordem = OrderProducts.product;
  bool isDescending = false;

  late StreamSubscription listener;

  @override
  void initState() {
    setupListeners();
    super.initState();
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  final List<String> categories = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lists.month),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: OrderProducts.product,
                  child: Text("Ordenar por produtos"),
                ),
                const PopupMenuItem(
                  value: OrderProducts.amount,
                  child: Text("Ordenar por quantidade"),
                ),
                const PopupMenuItem(
                  value: OrderProducts.category,
                  child: Text("Ordenar por categoria"),
                ),
              ];
            },
            onSelected: (value) {
              setState(() {
                if (ordem == value) {
                  isDescending = !isDescending;
                } else {
                  ordem = value;
                  isDescending = false;
                }
              });
              refresh();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showFormModal();
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        child: (listProductsPending.isEmpty)
            ? Center(
                child: Image.asset(
                  'assets/img/fundovazio.png',
                  width: 400,
                  height: 400,
                  fit: BoxFit.cover,
                ),
              )
            : RefreshIndicator(
                onRefresh: () {
                  return refresh();
                },
                child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Divider(thickness: 2),
                    ),
                    const Text(
                      "Produtos Pendentes",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children:
                          List.generate(listProductsPending.length, (index) {
                        Product product = listProductsPending[index];
                        return ListTileProduto(
                          product: product,
                          isComprado: false,
                          showModal: showFormModal,
                          iconclick: changePurchased,
                          deleteclick: deleteProduct,
                        );
                      }),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Divider(thickness: 2),
                    ),
                    const Text(
                      "Produtos Comprados",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children:
                          List.generate(listProductsPurchased.length, (index) {
                        Product produto = listProductsPurchased[index];
                        return ListTileProduto(
                          product: produto,
                          isComprado: true,
                          showModal: showFormModal,
                          iconclick: changePurchased,
                          deleteclick: deleteProduct,
                        );
                      }),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  showFormModal({Product? model}) {
    // Labels à serem mostradas no Modal
    String labelTitle = "Adicionar Produto";
    String labelConfirmationButton = "Salvar";
    String labelSkipButton = "Cancelar";

    // Controlador dos campos do produto
    TextEditingController productsController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    double result = double.tryParse(amountController.text) ?? 0.0;
    String selectedCategory = '';

    bool isComprado = false;

    // Caso esteja editando
    if (model != null) {
      labelTitle = "Editando ${model.product}";
      productsController.text = model.product;

      amountController.text = model.amount.toString();

      amountController.text = model.amount.toString();

      isComprado = model.isComprado;
    }

    // Função do Flutter que mostra o modal na tela
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // Define que as bordas verticais serão arredondadas
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          padding: const EdgeInsets.all(32.0),

          // Formulário com Título, Campo e Botões
          child: ListView(
            children: [
              Text(labelTitle,
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: productsController,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Produto"),
                  hintText: "Digite o nome do produto",
                  icon: Icon(Icons.abc_rounded),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: false,
                  decimal: false,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Quantidade"),
                  hintText: "Digite a quantidade de produto",
                  icon: Icon(Icons.numbers),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              DropdownButtonFormField<String>(
                items: categories.map((String categories) {
                  return DropdownMenuItem<String>(
                    value: categories,
                    child: Text(categories),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Categoria",
                  icon: Icon(Icons.shopping_bag_outlined),
                ),
                onChanged: (String? value) {
                  setState(() {
                    selectedCategory = value ?? '';
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
                    child: Text(labelSkipButton),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      // Criar um objeto Produto com as infos
                      Product product = Product(
                        id: const Uuid().v1(),
                        product: productsController.text,
                        isComprado: isComprado,
                        amount: result,
                        category: selectedCategory,
                      );

                      // Usar id do model
                      if (model != null) {
                        product.id = model.id;
                      }

                      if (amountController.text != "") {
                        product.amount = double.parse(amountController.text);
                      }

                      if (amountController.text != "") {
                        product.amount = double.parse(amountController.text);
                      }

                      productService.addProduct(
                          listsId: widget.lists.id, product: product);

                      // Fechar o Modal
                      Navigator.pop(context);
                    },
                    child: Text(labelConfirmationButton),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  refresh({QuerySnapshot<Map<String, dynamic>>? snapshot}) async {
    List<Product> productsRead = await productService.readProducts(
        listsId: widget.lists.id, ordem: ordem, isDescending: isDescending);

    if (snapshot != null) {
      checkChanges(snapshot);
    }

    filterProduct(productsRead);
  }

  filterProduct(List<Product> listProducts) {
    List<Product> tempProductsPending = [];
    List<Product> tempProductsPurchased = [];

    for (var product in listProducts) {
      if (product.isComprado) {
        tempProductsPurchased.add(product);
      } else {
        tempProductsPending.add(product);
      }
    }

    setState(() {
      listProductsPurchased = tempProductsPurchased;
      listProductsPending = tempProductsPending;
    });
  }

  changePurchased(Product product) async {
    product.isComprado = !product.isComprado;

    await productService.toggleProduct(
        listsId: widget.lists.id, product: product);
  }

  setupListeners() {
    listener = productService.connectStreamProduct(
        refresh: refresh,
        listsId: widget.lists.id,
        ordem: ordem,
        isDescending: isDescending);
  }

  checkChanges(QuerySnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.docChanges.length == 1) {
      for (var change in snapshot.docChanges) {
        String typeChange = "";
        Color cor = Colors.transparent;
        switch (change.type) {
          case DocumentChangeType.added:
            typeChange = "Novo produto:";
            cor = Colors.green;
            break;
          case DocumentChangeType.modified:
            typeChange = "Produto modificado:";
            cor = Colors.orange;
            break;
          case DocumentChangeType.removed:
            typeChange = "Produto removido:";
            cor = Colors.red;
            break;
        }
        Product product = Product.fromMap(change.doc.data()!);
        final snackBar = SnackBar(
          backgroundColor: cor,
          content: Text("$typeChange ${product.product}"),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  deleteProduct(Product product) async {
    await productService.removeProduct(
        listsId: widget.lists.id, product: product);
  }
}
