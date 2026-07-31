import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/view/AuthScreens/sign_in_page.dart';
import 'package:news_app/view/MainScreen/main_screen.dart';
import 'package:news_app/viewmodel/bloc/auth/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SignInBloc()),
        BlocProvider(create: (_) => SignUpBloc()),
      ],
      child: MyWidget(),
    ),
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // CHANGED: Added routes for navigation
      routes: {
        '/': (context) => StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return const MainScreen();
            } else {
              return const SignInPage();
            }
          },
        ),
        '/main': (context) => const MainScreen(),
      },
      // CHANGED: Use initialRoute instead of home for better route management
      initialRoute: '/',
    );
  }
}
