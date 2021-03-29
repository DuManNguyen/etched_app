import 'package:etched_test/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:etched_test/widgets/provider_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

final primaryColor = const Color(0xFF1B5E20);
enum AuthFormType { signIn, signUp, reset, anonymous, convert }

class Register extends StatefulWidget {
  final AuthFormType authFormType;

  Register({Key key, @required this.authFormType}) : super(key: key);

  @override
  _RegisterState createState() =>
      _RegisterState(authFormType: this.authFormType);
}

class _RegisterState extends State<Register> {
  AuthFormType authFormType;
  _RegisterState({this.authFormType});

  final formKey = GlobalKey<FormState>();
  String _email, _password, _name, _error;

  void switchFormState(String state) {
    formKey.currentState.reset();
    if (state == "signUp") {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else if (state == "home") {
      Navigator.of(context).pop();
    } else {
      setState(() {
        authFormType = AuthFormType.signIn;
      });
    }
  }

  bool validate() {
    final form = formKey.currentState;
    if (authFormType == AuthFormType.anonymous) {
      return true;
    }
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit() async {
    if (validate()) {
      try {
        final auth = Provider.of(context).auth;
        switch (authFormType) {
          case AuthFormType.signIn:
            String uid =
                await auth.signInWithEmailAndPassword(_email, _password);
            print("Signed In with ID $uid");
            Navigator.of(context).pushReplacementNamed('/home');
            break;
          case AuthFormType.signUp:
            String uid =
                await auth.signupwithEmailAndPassword(_email, _password, _name);
            print("Signed up with New ID $uid");
            Navigator.of(context).pushReplacementNamed('/home');
            break;
          case AuthFormType.reset:
            await auth.sendPasswordResetEmail(_email);
            print("Password reset email sent");
            _error = "A password reset link has been sent to $_email";
            setState(() {
              authFormType = AuthFormType.signIn;
            });
            break;
          case AuthFormType.anonymous:
            await auth.signInAnonymously();
            Navigator.of(context).pushReplacementNamed('/home');
            break;
          case AuthFormType.convert:
            await auth.convertUserWithEmail(_email, _password, _name);
            Navigator.of(context).pop();
            break;
        }
      } catch (e) {
        print(e);
        setState(() {
          _error = e.message;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    if (authFormType == AuthFormType.anonymous) {
      submit();
      return Scaffold(
        backgroundColor: Colors.teal[200],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
            ),
            SpinKitPumpingHeart(
              color: Colors.pink[100],
            ),
            Text(
              "Loading",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/DSCF7129.jpg'), fit: BoxFit.cover)),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(height: _height * 0.07),
                showAlert(),
                SizedBox(height: _height * 0.02),
                buildHeaderText(),
                SizedBox(
                  height: _height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: buildInputs() + buildButtons(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 9.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                _error,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                },
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  AutoSizeText buildHeaderText() {
    String _headerText;
    if (authFormType == AuthFormType.signIn) {
      _headerText = "Sign In Now";
    } else if (authFormType == AuthFormType.reset) {
      _headerText = "Reset Password";
    } else {
      _headerText = "Create New Account";
    }
    return AutoSizeText(
      _headerText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: 'Raleway',
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.normal),
    );
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];
    if (authFormType == AuthFormType.reset) {
      textFields.add(
        TextFormField(
          validator: EmailValidation.validate,
          style: TextStyle(fontSize: 22.0),
          decoration: buildSignUpInputDecoration("Email"),
          onSaved: (value) => _email = value,
        ),
      );
      textFields.add(SizedBox(
        height: 20.0,
      ));
      return textFields;
    }

    //add name in sign up state
    if ([AuthFormType.signUp, AuthFormType.convert].contains(authFormType)) {
      textFields.add(
        TextFormField(
          validator: NameValidation.validate,
          style: TextStyle(fontSize: 22.0),
          decoration: buildSignUpInputDecoration("Name"),
          onSaved: (value) => _name = value,
        ),
      );
      textFields.add(SizedBox(
        height: 20.0,
      ));
    }

    textFields.add(
      TextFormField(
        validator: EmailValidation.validate,
        style: TextStyle(fontSize: 22.0),
        decoration: buildSignUpInputDecoration("Email"),
        onSaved: (value) => _email = value,
      ),
    );
    textFields.add(SizedBox(
      height: 20.0,
    ));
    textFields.add(
      TextFormField(
        validator: PasswordValidation.validate,
        style: TextStyle(fontSize: 22.0),
        decoration: buildSignUpInputDecoration("Password"),
        obscureText: true,
        onSaved: (value) => _password = value,
      ),
    );

    textFields.add(SizedBox(
      height: 20.0,
    ));
    return textFields;
  }

  InputDecoration buildSignUpInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.0)),
      contentPadding:
          const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
    );
  }

  List<Widget> buildButtons() {
    String _switchButtonText, _newFormState, _submitButtonText;
    bool _showForgotPassword = false;
    bool _showSocialNetwork = true;

    if (authFormType == AuthFormType.signIn) {
      _switchButtonText = "Create New Account";
      _newFormState = "signUp";
      _submitButtonText = "Sign In";
      _showForgotPassword = true;
    } else if (authFormType == AuthFormType.reset) {
      _switchButtonText = "Return to Sign In";
      _newFormState = "signIn";
      _submitButtonText = "Submit";
      _showSocialNetwork = false;
    } else if (authFormType == AuthFormType.convert) {
      _switchButtonText = "Cancel sign up";
      _newFormState = "home";
      _submitButtonText = "Sign Up";
    } else {
      _switchButtonText = "Already have an account with us? Sign In ";
      _newFormState = "signIn";
      _submitButtonText = "Sign Up";
    }
    return [
      Container(
        width: MediaQuery.of(context).size.height * 0.25,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.white,
          textColor: primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _submitButtonText,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
            ),
          ),
          onPressed: submit,
        ),
      ),
      showForgotPassword(_showForgotPassword),
      FlatButton(
        color: primaryColor,
        child: Text(
          _switchButtonText,
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
        onPressed: () {
          switchFormState(_newFormState);
        },
      ),
      buildSocialIcons(_showSocialNetwork),
    ];
  }

  Widget showForgotPassword(bool visibility) {
    return Visibility(
      child: FlatButton(
        color: primaryColor,
        onPressed: () {
          setState(() {
            authFormType = AuthFormType.reset;
          });
        },
        child: Text(
          "Forgot Password?",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
      visible: visibility,
    );
  }

  Widget buildSocialIcons(bool visible) {
    final _auth = Provider.of(context).auth;
    return Visibility(
      child: Column(
        children: <Widget>[
          Divider(
            color: Colors.white,
          ),
          SizedBox(height: 10),
          GoogleSignInButton(
            onPressed: () async {
              try {
                if (authFormType == AuthFormType.convert) {
                  await _auth.convertWithGoogle();
                  Navigator.of(context).pop();
                } else {
                  await _auth.signInWithGoogle();
                  Navigator.of(context).pushReplacementNamed('/home');
                }
              } catch (e) {
                setState(() {
                  _error = e.message;
                });
              }
            },
          )
        ],
      ),
      visible: visible,
    );
  }
}
