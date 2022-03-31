
import 'package:dghome3d/data/data_provider.dart';
import 'package:dghome3d/data/model/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
  static setupFirebase() {
    DataProvider dataProvider = DataProvider();
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) async {
      if (user == null) {
        await dataProvider.removeUser();
      } else {
        AppUser? appUser = await dataProvider.getUser();
        if (appUser == null) {
          return;
        }
        DateTime expireTime = DateTime.fromMillisecondsSinceEpoch(appUser.expirationTime ?? 0);
        if (expireTime.isBefore(DateTime.now())) {
          print('Session expired, signing out');
          FirebaseAuth.instance.signOut();
          await dataProvider.removeUser();
        }
      }
    });
  }

  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}