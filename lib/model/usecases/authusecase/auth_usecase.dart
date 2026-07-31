// handling Bussiness logic  for auth screens(signin/signup)
import 'package:email_validator/email_validator.dart';

class AuthUseCase {
  // all edge cases for validating email on signin/ signup page 
  String emailValidate(String email) {
    if (email.isEmpty) {
      return "Please Enter your Email";
    } else if (!EmailValidator.validate(email)) {
      return "Email is not valid";
    } else {
      return "Valid Email";
    }
  }


 // all edge cases for validating password  on signin/ signup page 
  String passwordValidate(String password) {
    if (password.isEmpty) {
      return "Please Enter your Password";
    } else if (password.length<6) {
      return "Password shouldn't less than 6 digit";
    } else {
      return "Valid Password";
    }
  }

}
