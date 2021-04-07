import 'package:flutter/material.dart';
import 'package:etched_test/models/Folder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etched_test/widgets/provider_widget.dart';

class NewFolderFinishedView extends StatelessWidget {
  final db = Firestore.instance;
  final Folder folder;
  NewFolderFinishedView({Key key, @required this.folder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Album - Confirmed')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Please confirm your album info"),
            Text("Moments: ${folder.name}"),
            Text("Start Date: ${folder.startDate}"),
            Text("End Date: ${folder.endDate}"),
            Text("Things you said: ${folder.note}"),
            Text("Places we went: ${folder.occasion}"),
            Text("My thoughts on being your parent: ${folder.thoughts}"),
            RaisedButton(
              child: Text("Finished"),
              onPressed: () async {
                // save data to firebase
                final uid = await Provider.of(context).auth.getUID();
                await db
                    .collection("userFolders")
                    .document(uid)
                    .collection("userData")
                    .add(folder.toJson());

                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            )
          ],
        ),
      ),
    );
  }
}
