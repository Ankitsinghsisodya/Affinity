import 'package:affinity/models/crushlist_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:affinity/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db
        .collection("users")
        .doc(user.email)
        .set(user.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Your account has been created.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        );
  }

  createCrushList(CrushListModel crushListModel) async {
    final user = FirebaseAuth.instance.currentUser!.email;
    await _db
        .collection("users")
        .doc(user)
        .set(crushListModel.toJson(), SetOptions(merge: true))
        .whenComplete(
          () => Get.snackbar("Success", "Your account has been created.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        );
  }
}
