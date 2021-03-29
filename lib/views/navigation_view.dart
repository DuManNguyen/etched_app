import 'package:etched_test/models/Folder.dart';
import 'package:etched_test/services/auth_service.dart';
import 'package:etched_test/views/new_album.dart/name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages.dart';
import 'home_view.dart';
import '../widgets/provider_widget.dart';
import 'profile.dart';

const MaterialColor kPrimaryColor = const MaterialColor(
  0xFFEF9A9A,
  const <int, Color>{
    50: const Color(0xFFEF9A9A),
    100: const Color(0xFFEF9A9A),
    200: const Color(0xFFEF9A9A),
    300: const Color(0xFFEF9A9A),
    400: const Color(0xFFEF9A9A),
    500: const Color(0xFFEF9A9A),
    600: const Color(0xFFEF9A9A),
    700: const Color(0xFFEF9A9A),
    800: const Color(0xFFEF9A9A),
    900: const Color(0xFFEF9A9A),
  },
);

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _albums = [
    HomeView(),
    AlbumPage(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final newFolder = new Folder(null, null, null, null, null, null, null);
    return MaterialApp(
      title: "Flutter navigation bar",
      theme: ThemeData(
        primarySwatch: kPrimaryColor,
      ),
      home: DefaultTabController(
        length: 4, //for TAB
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //  Image.asset(
                //  'assets/logo1.png',
                //  fit: BoxFit.contain,
                //   height: 50,
                //    ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'etched',
                    style: TextStyle(
                        fontSize: 55.0,
                        fontFamily: 'Delany',
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewFolderView(folder: newFolder)),
                  );
                },
              ),
              /*
              IconButton(
                icon: Icon(Icons.undo),
                onPressed: () async {
                  try {
                    AuthService auth = Provider.of(context).auth;
                    await auth.signOut();
                    print("Signed Out");
                  } catch (a) {
                    print(a);
                  }
                },
              ),
              *
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {
                  Navigator.of(context).pushNamed('/convertUser');
                },
              )*/
            ],
            //  backgroundColor: Colors.white,
            //   elevation: 0,
          ),
          body: Scaffold(
            appBar: AppBar(
              toolbarHeight: 50,
              //backgroundColor: Colors.blue,
              elevation: 0,
              bottom: TabBar(
                  unselectedLabelColor: Colors.white,
                  indicatorColor: Colors.white,
                  isScrollable: true,
                  tabs: [
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Moments",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'San Francisco',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Places",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'San Francisco',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Words",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'San Francisco',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Thoughts",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'San Francisco',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
            body: TabBarView(children: [
              ///ADDING TAB PAGE HERE
              _albums[_currentIndex],
              _albums[_currentIndex],
              _albums[_currentIndex],
              _albums[_currentIndex],
            ]),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: new Icon(Icons.home),
                  // ignore: deprecated_member_use
                  title: new Text("Home")),
              BottomNavigationBarItem(
                  icon: new Icon(CupertinoIcons.book),
                  // ignore: deprecated_member_use
                  title: new Text("About")),
              BottomNavigationBarItem(
                  icon: new Icon(Icons.account_circle),
                  // ignore: deprecated_member_use
                  title: new Text("Profile")),
            ],
          ),
        ),
      ),
    );
  }

  void onTabTapped(int i) {
    setState(() {
      {
        _currentIndex = i;
      }
    });
  }
}
