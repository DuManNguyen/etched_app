import 'package:etched_test/widgets/provider_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File _image;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image path $_image');
    });
  }

  Future uploadPic(BuildContext context) async {
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      print("Avatar image upload successful");
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Avatar Image Uploaded')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        FutureBuilder(
            future: Provider.of(context).auth.getUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return userInfo(context, snapshot);
              } else {
                return CircularProgressIndicator();
              }
            })
      ],
    ));
  }

  Widget userInfo(context, snapshot) {
    final user = snapshot.data;

    return Column(
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.blue,
                  child: ClipOval(
                    child: SizedBox(
                        width: 150,
                        height: 150,
                        child: (_image != null)
                            ? Image.file(_image, fit: BoxFit.fill)
                            : Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        //TODO: Image upload to appear here instead of asset image
                                        image:
                                            AssetImage('./assets/profile.jpg'),
                                        fit: BoxFit.cover)),
                              )),
                  ),
                )),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: IconButton(
            icon: Icon(Icons.camera_alt),
            iconSize: 30.0,
            onPressed: () {
              getImage();
            },
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Name: ${user.displayName ?? 'Anonymous'}",
                style: TextStyle(fontFamily: 'Raleway', fontSize: 36))),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Email: ${user.email ?? ''}",
                style: TextStyle(fontFamily: 'Raleway', fontSize: 30))),
        showSignOut(context, user.isAnonymous),
        Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                color: Colors.blue[300],
                onPressed: () {
                  Navigator.of(context).pop();
                },
                elevation: 4.0,
                splashColor: Colors.blue[300],
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
              RaisedButton(
                color: Colors.blue[300],
                onPressed: () {
                  uploadPic(context);
                },
                elevation: 4.0,
                splashColor: Colors.blueGrey,
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget showSignOut(context, bool isAnonymous) {
    if (isAnonymous == true) {
      return RaisedButton(
          child: Text("Sign In To Save Your Data"),
          onPressed: () {
            Navigator.of(context).pushNamed('/convertUser');
          });
    } else {
      return RaisedButton(
          child: Text("Sign out"),
          onPressed: () async {
            try {
              await Provider.of(context).auth.signOut();
            } catch (e) {
              print(e);
            }
          });
    }
  }
}
