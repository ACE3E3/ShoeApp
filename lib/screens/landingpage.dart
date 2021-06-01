import 'package:e_shoeapp/screens/homepage.dart';
import 'package:e_shoeapp/screens/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:e_shoeapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Scaffold(
            body: Center(
                child: Text("Error : ${snapshot.error}")
            ),
          );
        }

        // Connection Initialized - Firebase App is running
        if(snapshot.connectionState == ConnectionState.done){
          // Checking Login state live
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              //Connection state active - Do the user login check inside the if statement
              if(streamSnapshot.connectionState == ConnectionState.active) {
              //Get the user
                User _user = streamSnapshot.data;

                if(_user == null) {
                  return LoginPage();
                } else {
                  return HomePage();
                }
              }

              // Checking the auth state - Loading
              return Scaffold(
                body: Center(
                  child: Text(
                    "Checking Authentication...",
                    style: Constants.regularHeading,
                  ),
                ),
              );
            },
          );
        }


        return Scaffold(
          body: Center(
            child: Text(
                "Checking Authentication...",
                style: Constants.regularHeading,
            ),
          ),
        );
      },
    );
  }
}
