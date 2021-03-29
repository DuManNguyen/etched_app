import 'package:flutter/material.dart';
import 'package:etched_test/models/Folder.dart';

import 'occasion.dart';

class NewFolderNoteView extends StatelessWidget {
  final Folder folder;
  NewFolderNoteView({Key key, @required this.folder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _noteController = new TextEditingController();
    _noteController.text = folder.note;

    return Scaffold(
      appBar: AppBar(title: Text('Things you said')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              "Funny conversations, mispronounced words, ideas and opinions you had"),
          Padding(
            padding: const EdgeInsets.all(35.0),
            child: TextField(
              controller: _noteController,
              autofocus: true,
            ),
          ),
          RaisedButton(
            child: Text("Submit"),
            onPressed: () {
              folder.note = _noteController.text;
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NewFolderOccasionView(folder: folder)),
              );
            },
          )
        ],
      ),
    );
  }
}
