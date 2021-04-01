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
import 'edit_notes_view.dart';

class DetailCardView extends StatelessWidget {
  final Folder folder;

  DetailCardView({Key key, @required this.folder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Album Details'),
              backgroundColor: Colors.red[100],
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                    'https://cdn.dribbble.com/users/1428985/screenshots/8952933/media/2c0bee2176b3af268ce9993aed6b651c.jpg?compress=1&resize=1000x750'),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    folder.name,
                    style: TextStyle(fontSize: 30, color: Colors.green[900]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Occasion: ${folder.occasion.toString()}",
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                ),
                notesCard(context),
              ]),
            )
          ],
        ),
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
