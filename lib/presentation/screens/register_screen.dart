// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '/core/enums.dart';
import '/presentation/manager/cubits/auth_cubits/register_cubit/register_cubit_cubit.dart';
import '/presentation/screens/all_notes_screen.dart';
import '/presentation/screens/sign_in_screen.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/social_tile_auth.dart';
import '../widgets/two_dividers_with_text_inbetween.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = "/register_screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
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
    return BlocConsumer<RegisterCubit, RegisterCubitState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          isLoading = false;
          Navigator.of(context).pushNamed(AllNotesScreen.routeName);
        } else if (state is RegisterFailure) {
          isLoading = false;
          if (context.mounted) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
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
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "Be a member now!",
                      ),
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
                          buttonText: "Register",
                          function: () async {
                            _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
                              await BlocProvider.of<RegisterCubit>(context)
                                  .register(userData: {
                                "email": emailTextController.text,
                                "password": passwordTextController.text
                              });
                            }
                          }),
                      const SizedBox(height: 32),
                      // const TwoDividerWithTextInbetween("or"),
                      // const SizedBox(height: 32),
                      // const SocialTileAuthCard(
                      // imagePath: "assets/google_logo.png"),
                      // const SizedBox(height: 32),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(SignInScreen.routeName);
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: 'Already a user? ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Sign in',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
