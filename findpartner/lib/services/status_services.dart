import 'dart:io';

import 'package:findpartner/models/status.dart';
import 'package:findpartner/services/user_service.dart';
import 'package:findpartner/utils/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StatusService {
  final String statusId = Uuid().v1();
  final UserService userService = UserService();

  void showSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }

  Future<void> sendStatus(StatusModel status, String chatId) async {
    try {
      // Envoie du statut à la collection des chats avec les identifiants d'utilisateur
      await statusRef
          .doc(chatId)
          .collection("statuses")
          .doc(status.statusId!)
          .set(status.toJson());

      // Mise à jour de "lastTextTime" à la dernière fois où un texte a été envoyé
      await statusRef.doc(chatId).update({
        "userId": FirebaseAuth.instance.currentUser!.uid,
      });
    } catch (error) {
      print("Error sending status: $error");
      throw error;
    }
  }

  Future<String> sendFirstStatus(StatusModel status) async {
    try {
      final ids = await getUsersIds();
      final ref = await statusRef.add({
        'whoCanSee': ids,
      });
      await sendStatus(status, ref.id);
      return ref.id;
    } catch (error) {
      print("Error sending first status: $error");
      throw error;
    }
  }

  Future<List<String>> getUsersIds() async {
    try {
      final ids = <String>[];
      final snapshot = await usersRef.get();
      snapshot.docs.forEach((documentSnapshot) {
        ids.add(documentSnapshot.get('id'));
      });
      return ids;
    } catch (error) {
      print("Error getting users IDs: $error");
      throw error;
    }
  }

  Future<String> uploadImage(File image) async {
    try {
      final storageReference =
          storage.ref().child("chats").child(Uuid().v1()).child(Uuid().v4());
      final uploadTask = storageReference.putFile(image);
      await uploadTask.whenComplete(() => null);
      final imageUrl = await storageReference.getDownloadURL();
      return imageUrl;
    } catch (error) {
      print("Error uploading image: $error");
      throw error;
    }
  }
}
