import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethodService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  bool _googleInitialized = false;

  Future<void> _initGoogle() async {
    if (_googleInitialized) return;

    await _googleSignIn.initialize(
      serverClientId:
          "998106791878-g0ep6o701cgd3mq62a73fl7f8fgtpfe5.apps.googleusercontent.com",
    );

    _googleInitialized = true;
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      if (email.isEmpty ||
          password.isEmpty ||
          name.isEmpty) {
        return 'Please enter all fields';
      }
      final UserCredential cred = await _auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

      await _firestore
          .collection('users')
          .doc(cred.user!.uid)
          .set({
            'name': name,
            'email': email,
            'uid': cred.user!.uid,
            'photoURL': cred.user!.photoURL ?? '',
            'provider': 'email',
            'createdAt': FieldValue.serverTimestamp(),
          });
      return 'success';
    } on FirebaseAuthException catch (e) {
      return e.message ?? e.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        return 'Please enter all fields';
      }
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'SignIn successful!';
    } on FirebaseAuthException catch (e) {
      return e.message ?? e.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signInWithGoogle() async {
    try {
      await _initGoogle();

      // Start Google Sign-In flow
      final GoogleSignInAccount googleUser =
          await _googleSignIn.authenticate();

      // Get Google tokens
      final String? idToken =
          googleUser.authentication.idToken;

      final GoogleSignInAuthorizationClient authClient =
          googleUser.authorizationClient;

      GoogleSignInClientAuthorization? authorization =
          await authClient.authorizationForScopes([
            'email',
            'profile',
          ]);

      String? accessToken = authorization?.accessToken;

      // Double try if null (sometimes needed on Android)
      if (accessToken == null) {
        authorization = await authClient
            .authorizationForScopes(['email', 'profile']);
        accessToken = authorization?.accessToken;
      }

      if (accessToken == null) {
        throw FirebaseAuthException(
          code: 'token-failed',
          message: 'Failed to get Google access token',
        );
      }

      // Create Firebase credential
      final OAuthCredential credential =
          GoogleAuthProvider.credential(
            idToken: idToken,
            accessToken: accessToken,
          );

      // Firebase login
      final UserCredential userCred = await _auth
          .signInWithCredential(credential);
      final User? user = userCred.user;

      // Save user in Firestore
      if (user != null) {
        final userDoc = _firestore
            .collection('users')
            .doc(user.uid);
        final doc = await userDoc.get();

        if (!doc.exists) {
          await userDoc.set({
            'uid': user.uid,
            'name': user.displayName ?? '',
            'email': user.email ?? '',
            'photoURL': user.photoURL,
            'provider': 'google',
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      }

      return 'success';
    } catch (e) {
      debugPrint("Google Sign-In Error: $e");
      return e.toString();
    }
  }

  Future<String> logOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      return 'success';
    } catch (e) {
      return 'Failed to log out.';
    }
  }
}

final authMethodProvider = Provider<AuthMethodService>((
  ref,
) {
  return AuthMethodService();
});
