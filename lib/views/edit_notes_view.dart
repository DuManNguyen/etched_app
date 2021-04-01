import 'package:flutter/material.dart';
import 'package:etched_test/models/Folder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etched_test/widgets/provider_widget.dart';

class EditNotesView extends StatefulWidget {
  final Folder folder;

  EditNotesView({Key key, @required this.folder}) : super(key: key);

  @override
  _EditNotesViewState createState() => _EditNotesViewState();
}

class _EditNotesViewState extends State<EditNotesView> {
  TextEditingController _notesController = new TextEditingController();

  final db = Firestore.instance;

  @override
  void initState() {
    super.initState();
    _notesController.text = widget.folder.note;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.red[100],
        child: Hero(
          tag: "AlbumNotes-${widget.folder.name}",
          transitionOnUserGestures: true,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  buildHeading(context),
                  buildNotesText(),
                  buildSubmitButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeading(context) {
    return Material(
      color: Colors.red[200],
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                "Album Notes",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            FlatButton(
              child: Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildNotesText() {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
          maxLines: null,
          controller: _notesController,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          cursorColor: Colors.white,
          autofocus: true,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget buildSubmitButton(context) {
    return Material(
      color: Colors.blue,
      child: RaisedButton(
        child: Text("Save"),
        color: Colors.blue,
        onPressed: () async {
          widget.folder.note = _notesController.text;

          final uid = await Provider.of(context).auth.getUID();

          await db
              .collection("userData")
              .document(uid)
              .collection("folder")
              .document(widget.folder.documentId)
              .updateData({'notes': _notesController.text});

          Navigator.of(context).pop();
        },
      ),
    );
  }
}
