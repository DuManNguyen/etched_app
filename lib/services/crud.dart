import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
  Future<void> addData(FolderData) async {
    Firestore.instance.collection("image").add(FolderData).catchError((err) {
      print(err);
    });
  }
}
