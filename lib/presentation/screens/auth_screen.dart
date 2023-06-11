import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noted/core/enums.dart';

import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/social_tile_auth.dart';
import '../widgets/two_dividers_with_text_inbetween.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const String routeName = "/auth_screen";

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 88,
                  ),
                  const Text(
                    "Noted",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("Welcom back!"),
                  const SizedBox(
                    height: 16,
                  ),
                  AuthTextField(
                    hintText: "E-mail",
                    textFieldType: AuthTextFieldType.email,
                    isObsecured: false,
                    textEditingController: emailTextController,
                    focusNode: emailFocusNode,
                  ),
                  const SizedBox(height: 16),
                  AuthTextField(
                    hintText: "Password",
                    textFieldType: AuthTextFieldType.password,
                    isObsecured: true,
                    textEditingController: passwordTextController,
                    focusNode: passwordFocusNode,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            // TODO: implemente forgot password feature
                          },
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(color: Colors.blue),
                          ))
                    ],
                  ),
                  const SizedBox(height: 16),
                  AuthButton(
                      buttonText: "Login",
                      function: () async {
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate()) {
                          var authInstance = FirebaseAuth.instance;
                          authInstance.signInWithEmailAndPassword(
                              email: emailTextController.text,
                              password: passwordTextController.text);
                          // UserCredential userCredential =
                          //     await authInstance.createUserWithEmailAndPassword(
                          //         email: emailTextController.text,
                          //         password: passwordTextController.text);
                          // print(userCredential.user!.email);
                        }
                      }),
                  const SizedBox(height: 32),
                  const TwoDividerWithTextInbetween("or"),
                  const SizedBox(height: 32),
                  const SocialTileAuthCard(imagePath: "assets/google_logo.png"),
                  const SizedBox(height: 32),
                  GestureDetector(
                      onTap: () {
                        // TODO: implemente forgot register page
                      },
                      child: const Text(
                        "Not a user? Register Now!",
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
