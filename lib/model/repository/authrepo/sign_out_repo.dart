import 'package:news_app/model/datasource/remote/authservice/firebase_auth_service.dart';

class SignOutRepo {
  AuthService authservice = AuthService();

  Future<void> signOut() async {
    authservice.signOut();
  }
}
