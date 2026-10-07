import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/model/datasource/remote/authservice/firebase_auth_service.dart';

class SignUpRepo {
  final AuthService _authservice = AuthService();

  Future<String> signUpRepo(String email, String password) async {
    try {
      await _authservice.signUp(email, password);
      return "SignUp Successful!";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return 'Please enter a valid email address.';
        case 'invalid-credential':
          return 'Invalid email or password.';
        case 'user-disabled':
          return 'This account has been disabled.';
        case 'too-many-requests':
          return 'Too many login attempts. Please try again later.';
        case 'network-request-failed':
          return 'No internet connection. Please check your network.';
        default:
          return 'Something went wrong. Please try again.';
      }
    }
  }
}
