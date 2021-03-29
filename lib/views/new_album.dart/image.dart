import 'dart:io';
import 'package:etched_test/models/Folder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:etched_test/services/auth_service.dart';
import 'package:random_string/random_string.dart';
import 'date_view.dart';

class UploadImage extends StatefulWidget {
  final Folder folder;
  UploadImage({Key key, @required this.folder}) : super(key: key);
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File selectedImage;
  get picker => ImagePicker();
  bool _isLoading = false;
  AuthService authService = new AuthService();

  Future getImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        selectedImage = File(image.path);
      } else {
        print("No image");
      }
    });
  }

  uploadFolder() async {
    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
      });

      /// uploading image to firebase storage
      StorageReference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("etchedImages")
          .child("${randomAlphaNumeric(9)}.jpg");
      final StorageUploadTask task = firebaseStorageRef.putFile(selectedImage);
      var downloadUrl = await (await task.onComplete).ref.getDownloadURL();
      print("this is url $downloadUrl");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  "Enter your album image: ",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Avenir',
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                uploadFolder();
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.file_upload)),
            ),
          ],
        ),
        body: _isLoading
            ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
            : Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child: selectedImage != null
                            ? Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                height: 170,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.file(
                                    selectedImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                height: 170,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6)),
                                width: MediaQuery.of(context).size.width,
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.black45,
                                ),
                              )),
                    SizedBox(
                      height: 8,
                    ),
                    RaisedButton(
                        child: Text("Submit"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewFolderDateView(
                                  folder: widget.folder,
                                ),
                              ));
                        })
                  ],
                ),
              ));
  }
}
