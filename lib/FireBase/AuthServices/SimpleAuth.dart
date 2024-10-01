import 'package:firebase_auth/firebase_auth.dart';

class SimpleAuth {

  SimpleAuth._();

  static SimpleAuth simpleAuth = SimpleAuth._();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Sign Up

  Future<void> createAccountWithEmailAndPassword(String email,
      String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  // Sign In

  Future<String> signInWithEmailAndPassword(String email, String password) async {
    try
    {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return 'Success';
    }catch(e)
    {
      return e.toString();
    }
  }

  //Sign Out

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  //todo get Current User Info

  User? getCurrentUser()
  {
    User? user = _firebaseAuth.currentUser;
    return user;
  }
}