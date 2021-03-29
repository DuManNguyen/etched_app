import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etched_test/models/Folder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
      );

  Future<void> addData(Folder) async {
    Firestore.instance.collection("folders").add(Folder).catchError((e) {
      print(e);
    });
  }

  getData() async {
    return await Firestore.instance.collection("folders").snapshots();
  }

  // current user uid
  Future<String> getUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  // user
  Future getUser() async {
    return await _firebaseAuth.currentUser();
  }

  //email sign up
  Future<String> signupwithEmailAndPassword(
      String email, String password, String name) async {
    final current = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    //Update username
    await updateusrname(name, current);
    return current.uid;
  }

  Future updateusrname(String name, FirebaseUser current) async {
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await current.updateProfile(userUpdateInfo);
    await current.reload();
  }

  //email sign in
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .uid;
  }

  //sign out
  signOut() {
    return _firebaseAuth.signOut();
  }

  //reset password
  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  //anonymous sign in
  Future signInAnonymously() {
    return _firebaseAuth.signInAnonymously();
  }

  //sign in with Google
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
    return (await _firebaseAuth.signInWithCredential(credential)).uid;
  }

  //convert with Google
  Future convertWithGoogle() async {
    final currentUser = await _firebaseAuth.currentUser();
    final GoogleSignInAccount account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
    await currentUser.linkWithCredential(credential);
    await updateusrname(_googleSignIn.currentUser.displayName, currentUser);
  }

  Future convertUserWithEmail(
      String email, String password, String name) async {
    final currentUser = await _firebaseAuth.currentUser();
    final credential =
        EmailAuthProvider.getCredential(email: email, password: password);
    await currentUser.linkWithCredential(credential);
    await updateusrname(name, currentUser);
  }
}

class EmailValidation {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Email cannot be blank";
    }
    return null;
  }
}

class PasswordValidation {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Password cannot be blank";
    }
    return null;
  }
}

class NameValidation {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Name cannot be blank";
    }
    if (value.length < 2) {
      return "Name must be more than 2 characters long";
    }
    if (value.length > 50) {
      return "Name must be less than 50 characters long";
    }
    return null;
  }
}
