import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final auth = FirebaseAuth.instance;

  // for creating account in firebase
  Future<void> signUp(String email, String password) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  // for login account in firebase
  Future<void> signIn(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // for logout from firebase
  Future<void> signOut() async {
    await auth.signOut();
  }
}
