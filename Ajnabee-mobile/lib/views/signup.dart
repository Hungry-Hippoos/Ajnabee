import 'package:memechat/helper/helperfunctions.dart';
import 'package:memechat/services/auth.dart';
import 'package:memechat/services/database.dart';
import 'package:memechat/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:memechat/screens/quizwelcome.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp(this.toggleView);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  TextEditingController usernameEditingController = new TextEditingController();

  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  FirebaseUser user;

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  singUp() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signUpWithEmailAndPassword(
              emailEditingController.text, passwordEditingController.text)
          .then((result) async {
        if (result != null) {
          Map<String, String> userDataMap = {
            "userName": usernameEditingController.text,
            "userEmail": emailEditingController.text,
          };

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              usernameEditingController.text);
          HelperFunctions.saveUserEmailSharedPreference(
              emailEditingController.text);

          databaseMethods.addUserInfo(userDataMap);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => QuizWelcome()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffc629),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffffc629),
        centerTitle: true,
        title: Text('',style: TextStyle(
          fontSize: 30.0,
          letterSpacing: 2.5,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Image.asset('assets/images/hippo.png'),
                      Text('ajnabee',style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),),
                      SizedBox(
                        height: 50.0,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              style: simpleTextStyle(),
                              controller: usernameEditingController,
                              validator: (val) {
                                return val.isEmpty || val.length < 3
                                    ? "Enter Username 3+ characters"
                                    : null;
                              },
                              decoration:
                                  textFieldInputDecoration("username"),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              controller: emailEditingController,
                              style: simpleTextStyle(),
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val)
                                    ? null
                                    : "Enter correct email";
                              },
                              decoration: textFieldInputDecoration("email"),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              obscureText: true,
                              style: simpleTextStyle(),
                              decoration:
                                  textFieldInputDecoration("password"),
                              controller: passwordEditingController,
                              validator: (val) {
                                return val.length < 6
                                    ? "Enter Password 6+ characters"
                                    : null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          singUp();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 2.0),
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Sign Up",
                            style:
                            TextStyle(color: Colors.black, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: simpleTextStyle(),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.toggleView();
                            },
                            child: Text(
                              "SignIn now",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
    ;
  }
}
