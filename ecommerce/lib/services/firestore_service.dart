// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/models/user_data.dart';

class FirestoreService {
  FirestoreService({required this.uid});
  final String uid; // userId

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addProduct(
    Product product,
  ) async {
    final docId = firestore.collection("products").doc().id;
    // await firestore
    //     .collection("products")
    //     .add(product.toMap())        Before we stwarted adding delete function
    //     .then((value) => print(value))
    //     .catchError((onError) => print("Error"));
    await firestore
        .collection("products")
        .doc(docId)
        .set(product.toMap(docId)); // After delete function
  }

  Stream<List<Product>> getProducts() {
    return firestore
        .collection("products") // gets collection
        .snapshots() // gets snapshots, loop through
        .map((snapshot) => snapshot.docs.map((doc) {
              // loop through docs
              final d = doc.data(); // for each doc get the data
              return Product.fromMap(d); // convert into a map
            }).toList()); // build a list out of the products mapping
  }

  Future<void> deleteProduct(String id) async {
    return await firestore.collection("products").doc(id).delete();
  }

  Future<void> addUser(
    UserData user,
  ) async {
    await firestore.collection("users").doc(user.uid).set(user.toMap());
  }

  Future<UserData?> getUser(String uid) async {
    final doc = await firestore.collection("users").doc(uid).get();
    return doc.exists ? UserData.fromMap(doc.data()!) : null;
  }
}
