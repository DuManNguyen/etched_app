import 'package:etched_test/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'views/navigation_view.dart';
import 'package:etched_test/views/new_album.dart/welcome_page.dart';
import 'package:etched_test/views/register_view.dart';
import 'package:etched_test/widgets/provider_widget.dart';

void main() {
  runApp(MyApp());
}

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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        title: "Etched",
        theme: ThemeData(
          primarySwatch: kPrimaryColor,
        ),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/signUp': (BuildContext context) =>
              Register(authFormType: AuthFormType.signUp),
          '/signIn': (BuildContext context) =>
              Register(authFormType: AuthFormType.signIn),
          '/anonymousSignIn': (BuildContext context) =>
              Register(authFormType: AuthFormType.anonymous),
          '/home': (BuildContext context) => HomeController(),
          '/convertUser': (BuildContext context) =>
              Register(authFormType: AuthFormType.convert),
        },
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? Home() : welcomeView();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
