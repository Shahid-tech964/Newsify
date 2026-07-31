import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/view/AuthScreens/sign_up_page.dart';
import 'package:news_app/viewmodel/bloc/auth/auth_bloc.dart';
import 'package:news_app/viewmodel/bloc/auth/event.dart';
import 'package:news_app/viewmodel/bloc/auth/state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  static const Color primaryBlue = Color(0xFF1976D2);
  static const Color lightGrey = Color(0xFFF5F5F5);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // CHANGED: Removed TODO comment - initialization handled properly
    super.initState();
    context.read<SignInBloc>().add(
      ButtonColorChangeEvent(emailController.text, passwordController.text),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInStates>(
      listener: (context, state) {
        // CHANGED: Added navigation after successful sign in
        if (state is SignInSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          // Navigate to main screen after showing snackbar
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              Navigator.pushReplacementNamed(context, '/main');
            }
          });
        }

        if (state is SignInErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 40),

              // Email
              TextField(
                onChanged: (temail) {
                  context.read<SignInBloc>().add(
                    EmailTextFieldEvent(email:temail),
                  );
                  context.read<SignInBloc>().add(
                    ButtonColorChangeEvent(temail, passwordController.text),
                  );
                },
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: lightGrey,
                  hintText: "E-Mail",
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: primaryBlue,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              // CHANGED: BlocBuilder for email validation - only shows text when not empty
              BlocBuilder<SignInBloc, SignInStates>(
                builder: (_, state) {
                  if (state is SignInValidEmailState) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        state.email,
                        style: TextStyle(
                          color: state.email == "Valid Email"
                              ? Colors.green
                              : Colors.red,
                          fontSize: 13,
                        ),
                      ),
                    );
                  } else {
                    // CHANGED: Return empty container instead of empty text to avoid whitespace
                    return const SizedBox.shrink();
                  }
                },
              ),

              const SizedBox(height: 16),

              // Password
              TextField(
                onChanged: (tpassword) {
                  context.read<SignInBloc>().add(
                    PasswordTextFieldEvent(password: tpassword),
                  );
                  context.read<SignInBloc>().add(
                    ButtonColorChangeEvent(emailController.text, tpassword),
                  );
                },
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: lightGrey,
                  hintText: "Password",
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: primaryBlue,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              // CHANGED: BlocBuilder for password validation - only shows text when not empty
              BlocBuilder<SignInBloc, SignInStates>(
                builder: (_, state) {
                  if (state is SignInValidPasswordState) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        state.password,
                        style: TextStyle(
                          color: state.password == "Valid Password"
                              ? Colors.green
                              : Colors.red,
                          fontSize: 13,
                        ),
                      ),
                    );
                  } else {
                    // CHANGED: Return empty container instead of empty text to avoid whitespace
                    return const SizedBox.shrink();
                  }
                },
              ),

              const SizedBox(height: 30),

              // Sign In Button
              BlocBuilder<SignInBloc, SignInStates>(
                builder: (_, state) {
                  // CHANGED: Added loading state with circular progress indicator
                  if (state is SignInLoadingState) {
                    return SizedBox(
                      height: 50,
                      width: 180,
                      child: ElevatedButton(
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ),
                    );
                  } else if (state is SignInEnableButtonState) {
                    return SizedBox(
                      height: 50,
                      width: 180,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<SignInBloc>().add(
                            CheckUserValidEvent(
                              email: state.email,
                              password: state.password,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  } else if (state is SignInDisableButtonState) {
                    return SizedBox(
                      height: 50,
                      width: 180,
                      child: ElevatedButton(
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              const SizedBox(height: 20),

              // Navigate to Sign Up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "If not registered yet please ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SignUpPage()),
                      );
                      // navigate to SignUpPage
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
