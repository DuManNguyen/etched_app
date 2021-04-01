import 'package:cloud_firestore/cloud_firestore.dart';

class Folder {
  String name;
  DateTime startDate;
  DateTime endDate;
  String note;
  String occasion;
  String thoughts;
  String imgUrl;
  String documentId;

  Folder(this.note, this.name, this.startDate, this.endDate, this.occasion,
      this.thoughts, this.imgUrl);
//Create a Folder Object from firebas snapshot

  Map<String, dynamic> toJson() => {
        'name': name,
        'startDate': startDate,
        'endDate': endDate,
        'note': note,
        'occasion': occasion,
        'thoughts': thoughts,
        'imgUrl': imgUrl
      };
  Folder.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        startDate = snapshot['startDate'].toDate(),
        endDate = snapshot['endDate'].toDate(),
        note = snapshot['note'],
        occasion = snapshot['occasion'],
        thoughts = snapshot['thoughts'],
        imgUrl = snapshot['imgUrl'],
        documentId = snapshot.documentID;
}
