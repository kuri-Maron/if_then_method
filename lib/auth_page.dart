// import 'dart:html';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sign_button/sign_button.dart' as google;

class AuthPage extends StatelessWidget {
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);
      // print('例外発生');
      return null;
    }
  }

  Future<UserCredential> signInWithApple() async {
    try {
      final result = await AppleSignIn.performRequests([
        AppleIdRequest(
          requestedScopes: [Scope.fullName],
          requestedOperation: OpenIdOperation.operationLogin,
        )
      ]);

      final OAuthProvider oAuthProvider = OAuthProvider('apple.com');
      final OAuthCredential credential = oAuthProvider.credential(
        idToken: String.fromCharCodes(result.credential.identityToken),
        accessToken: String.fromCharCodes(result.credential.authorizationCode),
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);

      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ログイン'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(
              Buttons.Google,
              onPressed: signInWithGoogle,
            ),
            SignInButton(
              Buttons.Apple,
              onPressed: signInWithApple,
            ),
          ],
        ),
        // child: ElevatedButton(
        //   child: Text('Sign in with Google'),
        //   onPressed: signInWithGoogle,
        // ),
      ),
    );
  }
}
