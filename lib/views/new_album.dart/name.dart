import 'package:etched_test/views/new_album.dart/image.dart';
import 'package:flutter/material.dart';
import 'package:etched_test/models/Folder.dart';
import 'date_view.dart';

class NewFolderView extends StatelessWidget {
  final Folder folder;
  NewFolderView({Key key, @required this.folder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = new TextEditingController();
    _nameController.text = folder.name;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Moments',
          style: TextStyle(
              fontSize: 30.0,
              fontFamily: 'Raleway',
              color: Colors.white,
              fontWeight: FontWeight.w900),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(30.0),
            child: Text(
              "Enter your album name: ",
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Avenir',
                  color: Colors.black,
                  fontWeight: FontWeight.w900),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(35.0),
            child: TextField(
              controller: _nameController,
              autofocus: true,
            ),
          ),
          RaisedButton(
            child: Text("Submit"),
            onPressed: () {
              folder.name = _nameController.text;
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UploadImage(folder: folder)),
                //builder: (context) => NewFolderDateView(folder: folder),
              );
            },
          )
        ],
      ),
    );
  }
}
