// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:etched_test/models/Folder.dart';

// class DetailCardView extends StatelessWidget {
//   final Folder folder;
//   DetailCardView({Key key, @required this.folder}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//             child: CustomScrollView(
//       slivers: <Widget>[
//         SliverAppBar(
//           title: Text("Details"),
//           backgroundColor: Colors.red[200],
//           expandedHeight: 350.0,
//           flexibleSpace: FlexibleSpaceBar(
//               //  background: getImage()
//               ),
//         ),
//       ],
//     )));
//   }
// }
// import 'package:flutter/material.dart';

// import 'package:page_turn/page_turn.dart';
// import 'content.dart';

// //import '../common/index.dart';

// class DetailCardView extends StatefulWidget {
//   const DetailCardView({
//     Key key,
//   }) : super(key: key);

//   @override
//   _DetailCardViewState createState() => _DetailCardViewState();
// }

// class _DetailCardViewState extends State<DetailCardView> {
//   final _controller = GlobalKey<PageTurnState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageTurn(
//         key: _controller,
//         backgroundColor: Colors.white,
//         showDragCutoff: false,
//         lastPage: Container(child: Center(child: Text('Last Page!'))),
//         children: <Widget>[
//           for (var i = 0; i < 5; i++) AlicePage(page: i),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.search),
//         onPressed: () {
//           _controller.currentState.goToPage(2);
//         },
//       ),
//     );
//   }
// }
// //
import 'package:flutter/material.dart';
import 'package:etched_test/models/Folder.dart';
import 'package:intl/intl.dart';
import 'edit_notes_view.dart';
import 'package:image_collage_widget/utils/CollageType.dart';
import 'src/fade_route_transition.dart';
import 'src/sample.dart';

class DetailCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
        primarySwatch: Colors.blue,
      ),
      home: DetailCardViewPage(),
    );
  }
}

class DetailCardViewPage extends StatefulWidget {
  final Folder folder;
  const DetailCardViewPage({Key key, this.folder}) : super(key: key);

  @override
  _DetailCardViewPageState createState() => _DetailCardViewPageState(folder);
}

class _DetailCardViewPageState extends State<DetailCardViewPage> {
  final Folder folder;

  var color = Colors.white;

  _DetailCardViewPageState(this.folder);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildRaisedButton(CollageType collageType, String text) {
      return RaisedButton(
        onPressed: () => pushImageWidget(collageType),
        shape: buttonShape(),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: CustomScrollView(
          // padding: EdgeInsets.all(16.0),
          shrinkWrap: true,
          // SliverAppBar(
          //   title: Text('Album Details'),
          //   backgroundColor: Colors.red[100],
          //   expandedHeight: 350.0,
          //   flexibleSpace: FlexibleSpaceBar(
          //
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Album Details'),
              backgroundColor: Colors.red[100],
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                      'https://cdn.dribbble.com/users/1428985/screenshots/8952933/media/2c0bee2176b3af268ce9993aed6b651c.jpg?compress=1&resize=1000x750')),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "${folder.name}",
                    style: TextStyle(
                        fontSize: 35.0,
                        color: Colors.deepOrange,
                        fontFamily: 'Avenir'),
                  ),
                ),
                folderDetails(),
                notesCard(context),
                buildRaisedButton(CollageType.VSplit, 'Vsplit'),
                buildRaisedButton(CollageType.HSplit, 'HSplit'),
                buildRaisedButton(CollageType.FourSquare, 'FourSquare'),
                buildRaisedButton(CollageType.NineSquare, 'NineSquare'),
                buildRaisedButton(CollageType.ThreeVertical, 'ThreeVertical'),
                buildRaisedButton(
                    CollageType.ThreeHorizontal, 'ThreeHorizontal'),
                buildRaisedButton(CollageType.LeftBig, 'LeftBig'),
                buildRaisedButton(CollageType.RightBig, 'RightBig'),
                buildRaisedButton(CollageType.FourLeftBig, 'FourLeftBig'),
                buildRaisedButton(CollageType.VMiddleTwo, 'VMiddleTwo'),
                buildRaisedButton(CollageType.CenterBig, 'CenterBig'),
              ]),
            )
          ],
        ),
      ),
    );
  }

  pushImageWidget(CollageType type) async {
    await Navigator.of(context).push(
      FadeRouteTransition(
        page: CollageSample(type),
      ),
    );
  }

  RoundedRectangleBorder buttonShape() {
    return RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0));
  }

  Widget folderDetails() {
    return Card(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  folder.occasion,
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.green[900],
                      fontFamily: 'Avenir'),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Text(
                  "${DateFormat('MM/dd/yyyy').format(folder.startDate).toString()} - ${DateFormat('MM/dd/yyyy').format(folder.endDate).toString()}",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.green[900],
                      fontFamily: 'Avenir'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget notesCard(context) {
    return Hero(
      tag: "AlbumNotes-${folder.name}",
      transitionOnUserGestures: true,
      child: Card(
        color: Colors.red[300],
        child: InkWell(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                child: Row(
                  children: <Widget>[
                    Text("Album Notes",
                        style: TextStyle(fontSize: 24, color: Colors.white)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: setNoteText(),
                ),
              )
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditNotesView(folder: folder)));
          },
        ),
      ),
    );
  }

  List<Widget> setNoteText() {
    if (folder.note == null) {
      return [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(Icons.add_circle_outline, color: Colors.grey[300]),
        ),
        Text("Click To Add Notes", style: TextStyle(color: Colors.grey[300])),
      ];
    } else {
      return [Text(folder.note, style: TextStyle(color: Colors.grey[300]))];
    }
  }
}
