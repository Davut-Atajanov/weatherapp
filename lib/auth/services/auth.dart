import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signInAnon() async {
    try {
      UserCredential userCredentials = await _firebaseAuth.signInAnonymously();
      print("**************** $userCredentials");
      return userCredentials;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  dynamic getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

}
