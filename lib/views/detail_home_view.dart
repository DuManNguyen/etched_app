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
//           backgroundColor: Color.fromRGBO(1, 3, 4, 3),
//           expandedHeight: 350.0,
//           flexibleSpace: FlexibleSpaceBar(
//               //   background: getImage(widget.trip.photoReference)
//               ),
//         ),
//       ],
//     )));
//   }
// }
import 'package:flutter/material.dart';

import 'package:page_turn/page_turn.dart';
import 'content.dart';

//import '../common/index.dart';

class DetailCardView extends StatefulWidget {
  const DetailCardView({
    Key key,
  }) : super(key: key);

  @override
  _DetailCardViewState createState() => _DetailCardViewState();
}

class _DetailCardViewState extends State<DetailCardView> {
  final _controller = GlobalKey<PageTurnState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTurn(
        key: _controller,
        backgroundColor: Colors.white,
        showDragCutoff: false,
        lastPage: Container(child: Center(child: Text('Last Page!'))),
        children: <Widget>[
          for (var i = 0; i < 5; i++) AlicePage(page: i),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          _controller.currentState.goToPage(2);
        },
      ),
    );
  }
}
//
