import 'package:firebase_auth/firebase_auth.dart';

abstract class TheAuth {
  User currentUser();
  Future<dynamic> signIn(String email, String password);
  Future<void> signOut();
}

class Auth implements TheAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User> signIn(String email, String password) async {
    print(email + password);
    try {
      UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return user.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  User currentUser() {
    User user = _firebaseAuth.currentUser;
    return user ?? null;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
