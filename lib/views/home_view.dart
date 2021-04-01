import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etched_test/widgets/provider_widget.dart';
import 'package:etched_test/views/detail_home_view.dart';
import 'package:etched_test/models/Folder.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: getUserDataStreamSnapshot(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text("Loading");
            return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int i) =>
                    _folderListView(context, snapshot.data.documents[i]));
          }),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('./assets/DSCF4535.jpg'), fit: BoxFit.cover)),
    );
  }

  Stream<QuerySnapshot> getUserDataStreamSnapshot(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getUID();
    yield* Firestore.instance
        .collection('userFolders')
        .document(uid)
        .collection('userData')
        .snapshots();
  }

  Widget _folderListView(BuildContext context, DocumentSnapshot folder) {
    final document = Folder.fromSnapshot(folder);

    return new Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    //TODO: Image upload to appear here instead of asset image
                    image: AssetImage('./assets/DSCF3507.jpg'),
                    fit: BoxFit.cover)),
            //Change padding to InkWell
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Row(children: <Widget>[
                        Text(
                          folder['name'],
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            fontSize: 25.0,
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.w900,
                            //  color: Colors.white
                          ),
                        ),
                        Spacer()
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "${DateFormat('dd/MM/yyyy').format(folder['startDate'].toDate()).toString()}- ${DateFormat('dd/MM/yyyy').format(folder['endDate'].toDate()).toString()}",
                            style: new TextStyle(
                              fontSize: 15.0,
                              // color: Colors.white,
                            ),
                          ),
                          Spacer()
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            folder['occasion'],
                            style: new TextStyle(
                              fontSize: 15.0,
                              //color: Colors.white,
                            ),
                          ),
                          Spacer(),
                          Text(
                            folder['note'],
                            style: new TextStyle(
                              fontSize: 15.0,
                              //color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailCardView(
                        folder: document,
                      ),
                    ));
                // print(document.name);
              },
            ),
          ),
        ),
      ),
    );
  }
}
