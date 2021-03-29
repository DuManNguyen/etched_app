import 'package:etched_test/views/home_view.dart';
import 'package:etched_test/views/navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

class AlbumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => AlbumPage()),
    );
  }

  Widget _buildImage(String assetimage) {
    return Align(
      child: Image.asset('assets/$assetimage.jpg', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0, fontFamily: 'Avenir');
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 28.0, fontFamily: 'Raleway', fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Nostalgia in your hands",
          body:
              "A journal at your fingertips.\nFill it with photos and text to document everyday life with your children.",
          image: _buildImage('DSCF4316'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Document your life as they grow",
          body:
              "A place to collect and record the little and big moments with your children, favourites places you visited, conversations shared, lessons and hopes, and thoughts on parenthood.",
          image: _buildImage('DSCF8110'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Capture it for them, and for you",
          body:
              "Keep your family memories organized, ready to enjoy and share.\n“It is the sweet, simple things of life\nwhich are the real\nonesafter all”\n- Laura Ingalls Wilder",
          image: _buildImage('CAM10413'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Start your photo journals",
          body:
              "Your memories are safe with us.\nThank you for your support.\nEnjoy your personal eco-friendly album",
          image: _buildImage('DSCF6481'),
          footer: RaisedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => HomeView()));
            },
            child: const Text(
              'Take me to home page',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.red[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Read again',
          style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}

class ArchievePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[100],
    );
  }
}
