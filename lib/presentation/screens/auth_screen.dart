import 'package:flutter/material.dart';

enum AuthAction { login, register }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
              width: deviceSize.width,
              height: deviceSize.height,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 8.0),
                          child: FittedBox(
                            child: Text(
                              'NOTED',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: deviceSize.width / 10.roundToDouble(),
                                // fontFamily: GoogleFonts(),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: const AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  late String _password;
  bool isHidden = true;
  Future<void> _submit(String action) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      // if (action == 'login') {
      //   await Provider.of<Auth>(context, listen: false)
      //       .login(_authData['email'], _authData['password']);
      // } else {
      //   await Provider.of<Auth>(context, listen: false).register(
      //       _authData['name'], _authData['email'], _authData['password']);
      // }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      _showDialogue();
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _showDialogue() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: const Text('something went wrong'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Approve'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return DefaultTabController(
        length: 2,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            TabBar(
              tabs: const [
                Tab(text: 'SIGN IN'),
                Tab(text: 'SIGN UP'),
              ],
              labelColor: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 15),
            Flexible(
              child: Form(
                key: _formKey,
                child: TabBarView(children: [
                  SizedBox(
                    height: deviceSize.height * 0.4,
                    child: Column(
                      children: [
                        TextFormField(
                          style: const TextStyle(fontSize: 18),
                          decoration:
                              const InputDecoration(labelText: 'E-Mail'),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).nextFocus(),
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                              return 'Invalid email!';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['email'] = value!;
                          },
                        ),
                        TextFormField(
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  isHidden = !isHidden;
                                });
                              },
                              child: isHidden
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                            ),
                          ),
                          obscureText: isHidden,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () =>
                              FocusScope.of(context).unfocus(),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 5) {
                              return 'Password is too short!';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['password'] = value!;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        _isLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () => _submit('login'),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 80.0, vertical: 10.0),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            TextFormField(
                              style: const TextStyle(fontSize: 18),
                              decoration:
                                  const InputDecoration(labelText: 'Username'),
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () =>
                                  FocusScope.of(context).nextFocus(),
                              onSaved: (value) {
                                _authData['name'] = value!;
                              },
                            ),
                            TextFormField(
                              style: const TextStyle(fontSize: 18),
                              decoration:
                                  const InputDecoration(labelText: 'E-Mail'),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () =>
                                  FocusScope.of(context).nextFocus(),
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                  return 'Invalid email!';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['email'] = value!;
                              },
                            ),
                            TextFormField(
                              style: const TextStyle(fontSize: 18),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isHidden = !isHidden;
                                    });
                                  },
                                  child: isHidden
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                ),
                              ),
                              obscureText: true,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () =>
                                  FocusScope.of(context).nextFocus(),
                              validator: (value) {
                                _password = value!;
                                if (value.isEmpty || value.length < 5) {
                                  return 'Password is too short!';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['password'] = value!;
                              },
                            ),
                            TextFormField(
                              style: const TextStyle(fontSize: 18),
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isHidden = !isHidden;
                                    });
                                  },
                                  child: isHidden
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                ),
                              ),
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () =>
                                  FocusScope.of(context).unfocus(),
                              validator: (value) {
                                if (value != _password) {
                                  return 'Passwords do not match!';
                                }
                                return null;
                              },
                            ),
                            const Expanded(
                              child: SizedBox(),
                            )
                          ],
                        ),
                      ),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                _submit('register');
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 80.0, vertical: 10.0),
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              child: const Text(
                                'SIGN UP',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                    ],
                  ),
                ]),
              ),
            ),
          ]),
        ));
  }
}
