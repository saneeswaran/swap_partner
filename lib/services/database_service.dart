import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swap_store/model/database_detail_model.dart';

class DatabaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth user = FirebaseAuth.instance;

  final CollectionReference reference =
      FirebaseFirestore.instance.collection("User");

  Future<void> createData(BuildContext context,
      {required String storeName,
      required int phoneNumber,
      required String category,
      required String location}) async {
    try {
      await reference.doc(user.currentUser!.uid).set(DatabaseDetailModel(
              storeName: storeName,
              phoneNumber: phoneNumber,
              category: category,
              location: location)
          .toMap());
    } on FirebaseException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? 'An error occurred')));
      }
    }
  }
}
