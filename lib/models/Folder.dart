import 'package:cloud_firestore/cloud_firestore.dart';

class Folder {
  String name;
  DateTime startDate;
  DateTime endDate;
  String note;
  String occasion;
  String thoughts;
  String imgUrl;

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
        //   startDate = snapshot['startDate'],
        //  endDate = snapshot['endDate'],
        note = snapshot['note'],
        occasion = snapshot['occasion'],
        thoughts = snapshot['thoughts'];
}
