// import 'dart:io';
// import 'package:etched_test/services/auth_service.dart';
// import 'package:etched_test/views/new_album.dart/image.dart';
// import 'package:random_string/random_string.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:etched_test/models/Folder.dart';
// import 'package:date_range_picker/date_range_picker.dart' as DatePicker;
// import 'package:intl/intl.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'dart:async';
// import 'note.dart';

// class NewFolderDateView extends StatefulWidget {
//   final Folder folder;
//   NewFolderDateView({Key key, @required this.folder}) : super(key: key);

//   @override
//   _NewFolderDateViewState createState() => _NewFolderDateViewState();
// }

// class _NewFolderDateViewState extends State<NewFolderDateView> {
//   DateTime _startDate = DateTime.now();
//   DateTime _endDate = DateTime.now().add(Duration(days: 7));

//   Future calendar(BuildContext context) async {
//     final List<DateTime> picked = await DatePicker.showDatePicker(
//       context: context,
//       initialFirstDate: _startDate,
//       initialLastDate: _endDate,
//       firstDate: new DateTime(DateTime.now().year - 50),
//       lastDate: new DateTime(DateTime.now().year + 50),
//     );

//     if (picked != null && picked.length == 2) {
//       setState(() {
//         _startDate = picked[0];
//         _endDate = picked[1];
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('This memory is on: ')),
//       body: Center(
//         child: CustomScrollView(
//           slivers: <Widget>[
//             SliverAppBar(
//               title: Text(''),
//               backgroundColor: Colors.green,
//               expandedHeight: 350.0,
//               flexibleSpace: FlexibleSpaceBar(
//                 background: Image.network(widget.folder.imgUrl),
//               ),
//             ),
//             SliverFixedExtentList(
//               itemExtent: 200.00,
//               delegate: SliverChildListDelegate([
//                 buildSelectedDetails(context, widget.folder),
//                 buildButtons(),
//               ]),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildButtons() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         SizedBox(
//           width: MediaQuery.of(context).size.width * 0.60,
//           child: RaisedButton(
//             child: Text("Change Date Range"),
//             color: Colors.deepPurpleAccent,
//             textColor: Colors.white,
//             onPressed: () async {
//               await calendar(context);
//             },
//           ),
//         ),
//         SizedBox(
//           width: MediaQuery.of(context).size.width * 0.60,
//           child: RaisedButton(
//             child: Text('Continue'),
//             color: Colors.amberAccent,
//             onPressed: () {
//               widget.folder.startDate = _startDate;
//               widget.folder.endDate = _endDate;
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => NewFolderNoteView(
//                     folder: widget.folder,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildSelectedDates() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 15.0),
//       child: Container(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text("Start Date"),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8.0),
//                   child: Text(
//                     "${DateFormat('MM-dd').format(_startDate).toString()}",
//                     style: TextStyle(fontSize: 35, color: Colors.red[200]),
//                   ),
//                 ),
//                 Text(
//                   "${DateFormat('yyyy').format(_startDate).toString()}",
//                   style: TextStyle(color: Colors.red[200]),
//                 ),
//               ],
//             ),
//             Container(
//                 child: Icon(
//               Icons.arrow_forward,
//               color: Colors.deepOrange,
//               size: 45,
//             )),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text("End Date"),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8.0),
//                   child: Text(
//                     "${DateFormat('MM-dd').format(_endDate).toString()}",
//                     style: TextStyle(fontSize: 35, color: Colors.deepPurple),
//                   ),
//                 ),
//                 Text(
//                   "${DateFormat('yyyy').format(_endDate).toString()}",
//                   style: TextStyle(color: Colors.deepPurple),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildSelectedDetails(BuildContext context, Folder folder) {
//     return Hero(
//       tag: "SelectedTrip-${folder.name}",
//       transitionOnUserGestures: true,
//       child: Container(
//         child: Padding(
//           padding: const EdgeInsets.only(
//             left: 8.0,
//             right: 8.0,
//           ),
//           child: SingleChildScrollView(
//             child: Card(
//               child: Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           top: 16.0, left: 16.0, bottom: 16.0),
//                       child: Column(
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               Flexible(
//                                 child: AutoSizeText(folder.name,
//                                     maxLines: 3,
//                                     style: TextStyle(fontSize: 25.0)),
//                               ),
//                             ],
//                           ),
//                           buildSelectedDates(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:etched_test/models/Folder.dart';
import 'package:date_range_picker/date_range_picker.dart' as DatePicker;
import 'package:intl/intl.dart';
import 'dart:async';
import 'note.dart';

class NewFolderDateView extends StatefulWidget {
  final Folder folder;
  NewFolderDateView({Key key, @required this.folder}) : super(key: key);

  @override
  _NewFolderDateViewState createState() => _NewFolderDateViewState();
}

class _NewFolderDateViewState extends State<NewFolderDateView> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 7));

  Future calendar(BuildContext context) async {
    final List<DateTime> picked = await DatePicker.showDatePicker(
      context: context,
      initialFirstDate: _startDate,
      initialLastDate: _endDate,
      firstDate: new DateTime(DateTime.now().year - 50),
      lastDate: new DateTime(DateTime.now().year + 50),
    );

    if (picked != null && picked.length == 2) {
      setState(() {
        _startDate = picked[0];
        _endDate = picked[1];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('This memory is on: ')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Album: ${widget.folder.name}"),
          RaisedButton(
              child: Text("Select the date"),
              onPressed: () async {
                await calendar(context);
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                  "Start Date: ${DateFormat('MM/dd/yyyy').format(_startDate).toString()}"),
              Text(
                  "End Date: ${DateFormat('MM/dd/yyyy').format(_endDate).toString()}"),
            ],
          ),
          RaisedButton(
            child: Text("Submit"),
            onPressed: () {
              widget.folder.startDate = _startDate;
              widget.folder.endDate = _endDate;
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NewFolderNoteView(folder: widget.folder)),
              );
            },
          )
        ],
      ),
    );
  }
}
