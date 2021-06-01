import 'package:e_shoeapp/widgets/custombutton.dart';
import 'package:e_shoeapp/widgets/custominput.dart';
import 'package:flutter/material.dart';
import 'package:e_shoeapp/constants.dart';
import 'package:e_shoeapp/screens/registerpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                child: Text("Close Dialog"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
    );
  }

  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);
      return null;
    } on FirebaseAuthException catch(e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }


  void _submitForm() async {
    // set the form to loading state
    setState(() {
      _loginFormLoading = true;
    });

    // Run the create account method
    String _loginFeedback = await _loginAccount();
    if(_loginFeedback != null) {
      _alertDialogBuilder(_loginFeedback);
      setState(() {
        _loginFormLoading = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  // Form Loading State
  bool _loginFormLoading = false;

  // Form input field values
  String _loginEmail = "";
  String _loginPassword = "";

  // Focus Node for input fields
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
            padding: EdgeInsets.only(
            top: 24.0,
          ),
            child: Text(
                "Welcome User, \nLogin to your account",
                textAlign: TextAlign.center,
                style: Constants.boldHeading,
            ),
          ),
            Column(
              children: [
                CustomInput(
                  hintText: "Email...",
                  onChanged: (value) {
                    _loginEmail = value;
                  },
                  onSubmitted: (value) {
                    _passwordFocusNode.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                ),
                CustomInput(
                  hintText: "Password...",
                  onChanged: (value) {
                    _loginPassword = value;
                  },
                  focusNode: _passwordFocusNode,
                  isPasswordField: true,
                  onSubmitted: (value) {
                      _submitForm();
                  },
                ),
                CustomButton(
                  text: "Login",
                  onPress: () {
                    _submitForm();
                  },
                  isLoading: _loginFormLoading,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 16.0,
              ),
             child: CustomButton(
              text: "Create New Account",
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()
                      ),
                    );
                  },
              outlineButton: true,
              ),
            ),
          ],
          ),
          ),
        ),

        );
  }
}
