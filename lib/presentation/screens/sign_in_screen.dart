import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '/presentation/screens/register_screen.dart';
import '/core/enums.dart';
import '/presentation/manager/cubits/auth_cubits/login_cubit/login_cubit_cubit.dart';
import '/presentation/screens/all_notes_screen.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const String routeName = "/sign_in_screen";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
    return BlocConsumer<LoginCubit, LoginCubitState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          Navigator.of(context).pushNamed(AllNotesScreen.routeName);
        } else if (state is LoginFailure) {
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
                              await BlocProvider.of<LoginCubit>(context).singIn(
                                  userData: {
                                    "email": emailTextController.text,
                                    "password": passwordTextController.text
                                  });
                            }
                          }),
                      const SizedBox(height: 32),
                      // const TwoDividerWithTextInbetween("or"),
                      // const SizedBox(height: 32),
                      // const SocialTileAuthCard(
                      //     imagePath: "assets/google_logo.png"),
                      // const SizedBox(height: 32),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(RegisterScreen.routeName);
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: 'Not a user? ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Register Now!',
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
