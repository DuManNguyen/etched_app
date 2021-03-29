import 'package:flutter/material.dart';
import 'package:etched_test/models/Folder.dart';

import 'finished.dart';

class NewFolderOccasionView extends StatelessWidget {
  final Folder folder;
  NewFolderOccasionView({Key key, @required this.folder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _thoughtsController = new TextEditingController();
    _thoughtsController.text = folder.occasion;

    return Scaffold(
      appBar: AppBar(title: Text('Places we went')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              "Favourite spots near or far, family trips and visits with friends and family"),
          Padding(
            padding: const EdgeInsets.all(35.0),
            child: TextField(
              controller: _thoughtsController,
              autofocus: true,
            ),
          ),
          RaisedButton(
            child: Text("Submit"),
            onPressed: () {
              folder.thoughts = _thoughtsController.text;
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NewFolderFinishedView(folder: folder)),
              );
            },
          )
        ],
      ),
    );
  }
}
