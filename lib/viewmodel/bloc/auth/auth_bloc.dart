// SignIn bloc

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/model/repository/authrepo/SignInRepo.dart';
import 'package:news_app/model/repository/authrepo/SignUpRepo.dart';
import 'package:news_app/model/usecases/authusecase/auth_usecase.dart';
import 'package:news_app/viewmodel/bloc/auth/event.dart';
import 'package:news_app/viewmodel/bloc/auth/state.dart';

//  SignIn Bloc
class SignInBloc extends Bloc<AuthEvent, SignInStates> {
  AuthUseCase authUseCase = AuthUseCase();
  SignInRepo siginInRepo = SignInRepo();
  SignInBloc() : super(SignInInitialState()) {
    on<EmailTextFieldEvent>((event, emit) {
      String email = authUseCase.emailValidate(event.email);
      emit(SignInValidEmailState(email: email));
    });

    on<PasswordTextFieldEvent>((event, emit) {
      String password = authUseCase.passwordValidate(event.password);
      emit(SignInValidPasswordState(password: password));
    });

    //
    on<ButtonColorChangeEvent>((event, emit) {
      String email = authUseCase.emailValidate(event.email);
      String password = authUseCase.passwordValidate(event.password);
      if (email == "Valid Email" && password == "Valid Password") {
        emit(
          SignInEnableButtonState(email: event.email, password: event.password),
        );
      } else {
        emit(SignInDisableButtonState());
      }
    });

    on<CheckUserValidEvent>((event, emit) async {
      // CHANGED: Emit loading state before starting async operation
      emit(SignInLoadingState());
      
      String message = await siginInRepo.signInRepo(
        event.email,
        event.password,
      );

      if (message == "SignIn Successful!") {
        emit(SignInSuccessState(message: message));
      } else {
        emit(SignInErrorState(error: message));
      }
    });
  }
}

//  SignUp Bloc for email and password
class SignUpBloc extends Bloc<AuthEvent, SignUpStates> {
  AuthUseCase authUseCase = AuthUseCase();
  SignUpRepo signUpRepo = SignUpRepo();
  SignUpBloc() : super(SignUpInitialState()) {
    on<EmailTextFieldEvent>((event, emit) {
      String email = authUseCase.emailValidate(event.email);
      emit(SignUpValidEmailState(email: email));
    });

    on<PasswordTextFieldEvent>((event, emit) {
      String password = authUseCase.passwordValidate(event.password);
      emit(SignUpValidPasswordState(password: password));
    });

    // handle enabling/disabling sign up button (same logic as SignIn)
    on<ButtonColorChangeEvent>((event, emit) {
      String email = authUseCase.emailValidate(event.email);
      String password = authUseCase.passwordValidate(event.password);
      if (email == "Valid Email" && password == "Valid Password") {
        emit(
          SignUpEnableButtonState(email: event.email, password: event.password),
        );
      } else {
        emit(SignUpDisableButtonState());
      }
    });

    on<CheckUserValidEvent>((event, emit) async {
      // CHANGED: Emit loading state before starting async operation
      emit(SignUpLoadingState());
      
      String message = await signUpRepo.signUpRepo(event.email, event.password);

      if (message == "SignUp Successful!") {
        emit(SignUpSuccessState(message: message));
      } else {
        emit(SignUpErrorState(error: message));
      }
    });
  }
}



// 