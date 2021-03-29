import 'package:auto_size_text/auto_size_text.dart';
import 'package:etched_test/main.dart';
import 'package:flutter/material.dart';
import 'package:etched_test/widgets/customdialog.dart';

class welcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/CAM10412.jpg'), fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: _height * 0.03,
            ),
            Image.asset(
              'assets/logo1.png',
              fit: BoxFit.contain,
              height: 170,
            ),
            SizedBox(
              height: _height * 0.03,
            ),
            Text(
              "Welcome",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Raleway',
                fontSize: 40,

                // fontWeight: FontWeight.bold,
              ),
            ),
            AutoSizeText(
              "  Capture memories with Etched",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black.withOpacity(1.0),
                fontFamily: 'Raleway',
                fontSize: 27,
              ),
            ),
            SizedBox(
              height: _height * 0.2,
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 15.0, bottom: 15.0, left: 30.0, right: 30.0),
                child: Text(
                  "Log In",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Raleway',
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/signIn');
              },
            ),
            SizedBox(
              height: _height * 0.06,
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 15.0, bottom: 15.0, left: 30.0, right: 30.0),
                child: Text(
                  "Sign up",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Raleway',
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => CustomDialog(
                      name: "Create a free account with Etched now",
                      description:
                          "Personalize your photo collage and make some wonderful albums with a personal account",
                      primaryButtonText: "Create My Account",
                      primaryButtonRoute: "/signUp",
                      secondaryButtonText: "Maybe Later",
                      secondaryButtonRoute: "/anonymousSignIn"),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
