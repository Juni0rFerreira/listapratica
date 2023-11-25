import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listapratica/src/helpers/enum_order.dart';
import 'package:listapratica/src/models/product.dart';

class ProductService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  addProduct({required String listsId, required Product product}) {
    firestore
        .collection("listmonth")
        .doc(listsId)
        .collection("products")
        .doc(product.id)
        .set(product.toMap());
  }

  Future<List<Product>> readProducts(
      {required String listsId,
      required OrderProducts ordem,
      required bool isDescending}) async {
    List<Product> temp = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection("listmonth")
        .doc(listsId)
        .collection("products")
        .orderBy(ordem.name, descending: isDescending)
        .get();

    for (var doc in snapshot.docs) {
      Product product = Product.fromMap(doc.data());
      temp.add(product);
    }

    return temp;
  }

  toggleProduct({required String listsId, required Product product}) async {
    return firestore
        .collection("listmonth")
        .doc(listsId)
        .collection("products")
        .doc(product.id)
        .update({"isComprado": product.isComprado});
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> connectStreamProduct({
    required Function refresh,
    required String listsId,
    required OrderProducts ordem,
    required bool isDescending,
  }) {
    return firestore
        .collection("listmonth")
        .doc(listsId)
        .collection("products")
        .orderBy(ordem.name, descending: isDescending)
        .snapshots()
        .listen((snapshot) {
      refresh(snapshot: snapshot);
    });
  }

  Future<void> removeProduct({required String listsId, required Product product}) async{
    return firestore
        .collection("listmonth")
        .doc(listsId)
        .collection("products")
        .doc(product.id)
        .delete();
  }
}
