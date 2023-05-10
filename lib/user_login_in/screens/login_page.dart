import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:gncms_clone/initial_data.dart';
import 'package:provider/provider.dart';
import '../../custom_widgets/custom_radio_button.dart';
import '../common/theme_helper.dart';
import '../screen_decider.dart';
import 'forgot_password_page.dart';
import 'registration_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const id = '/loginScreen';

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final Key _formKey = GlobalKey<FormState>();
  final TextEditingController _emailEnteredController = TextEditingController(),
      _passwordController = TextEditingController();
  String _emailPassed = "";
  SingingCharacter? character = SingingCharacter.student;

  bool isErrorLog = false;

  String errorMessage = "";

  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              margin: const EdgeInsets.fromLTRB(
                  20, 10, 20, 10), // This will be the login form
              child: Column(
                children: [
                  const SizedBox(height: 30.0),
                  const Icon(Icons.lock, size: 100),
                  const SizedBox(height: 30.0),
                  const Text(
                    'Hello',
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Sign in into your account',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomRadioButton(
                        character: character,
                        title: SingingCharacter.teacher.name,
                        value: SingingCharacter.teacher,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            character = value;
                          });
                        },
                      ),
                      CustomRadioButton(
                        character: character,
                        title: SingingCharacter.student.name,
                        value: SingingCharacter.student,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            character = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextField(
                            controller: _emailEnteredController,
                            decoration: ThemeHelper().textInputDecoration(
                                'User Name', 'Enter your user name'),
                          ),
                          const SizedBox(height: 30.0),
                          TextField(
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                'Password', 'Enter your password'),
                            controller: _passwordController,
                          ),
                          const SizedBox(height: 15.0),
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ForgotPasswordScreen.id);
                              },
                              child: const Text(
                                "Forgot your password?",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          if (isErrorLog)
                            Text(errorMessage,
                                style: const TextStyle(
                                  color: Colors.red,
                                )),
                          const SizedBox(height: 15.0),
                          Consumer<InitialData>(
                            builder: (context, dataClass, child) =>
                                ElevatedButton(
                              style: ThemeHelper().buttonStyle(
                                isActive ? Colors.black : Colors.grey,
                              ),
                              child: Text(
                                'Log in'.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              onPressed: () {
                                isActive
                                    ? signIn(dataClass.writeLocalData,
                                        dataClass.getUser)
                                    : {};
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                            //child: Text('Don\'t have an account? Create'),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                      text: "Don't have an account? "),
                                  TextSpan(
                                    text: 'Create',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(
                                            context, RegistrationScreen.id);
                                      },
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              )),
        ),
      ),
    );
  }

  void signIn(Function writeLocalData, Function getUser) async {
    //await getUser();
    try {
      loadingDialog();
      await isEmail(writeLocalData, getUser);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailPassed, password: _passwordController.text);
      navigateAuthScreen();
    } on FirebaseAuthException catch (e) {
      onError(e);
    }
  }

  Future<void> isEmail(Function writeLocalData, Function getUser) async {
    //check weather email or usn
    RegExp exp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
        caseSensitive: false);

    String userId = "";

    var snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(character!.name)
        .get();
    if (exp.hasMatch(_emailEnteredController.text)) {
      _emailPassed = _emailEnteredController.text;
      userId = snap.data()![_emailPassed]['userId'];
    } else {
      _emailPassed = snap.data()![_emailEnteredController.text];
      userId = _emailEnteredController.text;
    }

    writeLocalData(
        currentUser: character!.name, email: _emailPassed, userId: userId);
    print(
        "$InitialData.globalUserId  $InitialData.globalCurrentUser $InitialData.globalEmail");
    await getUser();
  }

  void loadingDialog() {
    showDialog(
        useRootNavigator: false,
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
  }

  void onError(FirebaseAuthException e) {
    Navigator.pop(context);
    if (e.code == "unknown") {
      errorMessage = "Nothing is Entered";
    } else if (e.code == "wrong-password") {
      errorMessage = "Wrong password.Try Again";
    } else if (e.code == "user-not-found") {
      errorMessage = "User Not Found";
    } else if (e.code == "too-many-requests") {
      isActive = false;
      startTimerForActivateButton();
    }
    setState(() {});
    isErrorLog = true;
    errorMessage = e.code;
  }

  void startTimerForActivateButton() {
    Timer(const Duration(seconds: 5), () {
      isActive = true;
      setState(() {
        errorMessage = "";
      });
    });
  }

  void popContext() {
    Navigator.pop(context);
  }

  void navigateAuthScreen() {
    popContext();
    setState(() {});
    Navigator.pushNamedAndRemoveUntil(
        context, ScreenDecider.id, (route) => false);
  }
}
