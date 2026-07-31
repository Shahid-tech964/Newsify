//  signin page bloc states (covering all the states use inside signin page )
class SignInStates {}

class SignInInitialState extends SignInStates {
  String emptytext = "";
}

class SignInValidEmailState extends SignInStates {
  String email;
  SignInValidEmailState({required this.email});
}

class SignInValidPasswordState extends SignInStates {
  String password;
  SignInValidPasswordState({required this.password});
}

class SignInEnableButtonState extends SignInStates {
  String email;
  String password;
  SignInEnableButtonState({required this.email, required this.password});
}

class SignInDisableButtonState extends SignInStates {}

class SignInLoadingState extends SignInStates {}

class SignInSuccessState extends SignInStates {
  String message;
  SignInSuccessState({required this.message});
}

class SignInErrorState extends SignInStates {
  String error;
  SignInErrorState({required this.error});
}

//  signup page bloc states (covering all the states use inside signup page )
class SignUpStates {}

class SignUpInitialState extends SignUpStates {
  String emptytext = "";
}

class SignUpValidEmailState extends SignUpStates {
  String email;
  SignUpValidEmailState({required this.email});
}

class SignUpValidPasswordState extends SignUpStates {
  String password;
  SignUpValidPasswordState({required this.password});
}

class SignUpEnableButtonState extends SignUpStates {
  String email;
  String password;
  SignUpEnableButtonState({required this.email, required this.password});
}

class SignUpDisableButtonState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates {}

class SignUpSuccessState extends SignUpStates {
  String message;
  SignUpSuccessState({required this.message});
}

class SignUpErrorState extends SignUpStates {
  String error;
  SignUpErrorState({required this.error});
}