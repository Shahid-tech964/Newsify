class AuthEvent {}

class EmailTextFieldEvent extends AuthEvent {
  String email;
  EmailTextFieldEvent({required this.email});
}

class PasswordTextFieldEvent extends AuthEvent {
  String password;
  PasswordTextFieldEvent({required this.password});
}

class ButtonColorChangeEvent extends AuthEvent {
  String email = "";
  String password = "";
  ButtonColorChangeEvent(this.email, this.password);
}

class CheckUserValidEvent extends AuthEvent {
  String email;
  String password;
  CheckUserValidEvent({required this.email, required this.password});
}

