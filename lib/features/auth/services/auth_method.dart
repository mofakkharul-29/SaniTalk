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
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _googleInitialized = false;
  String _verificationId = '';
  int? _resendToken;

  Future<void> _initGoogle() async {
    if (_googleInitialized) return;

    await _googleSignIn.initialize(
      serverClientId:
          "998106791878-g0ep6o701cgd3mq62a73fl7f8fgtpfe5.apps.googleusercontent.com",
    );

    _googleInitialized = true;
  }

  Future<void> _setUserOnline(String uid) async {
    await _firestore.collection('users').doc(uid).update({
      'isOnline': true,
      'lastSeen': FieldValue.serverTimestamp(),
    });
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
            'isOnline': true,
            'lastSeen': FieldValue.serverTimestamp(),
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
      // here i will get the use
      final UserCredential credential = await _auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          );
      await _setUserOnline(credential.user!.uid);
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
            'isOnline': true,
            'lastSeen': FieldValue.serverTimestamp(),
            'createdAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));
        } else {
          await userDoc.update({
            'isOnline': true,
            'lastSeen': FieldValue.serverTimestamp(),
          });
        }

        await _setUserOnline(user.uid);
      }

      return 'success';
    } catch (e) {
      debugPrint("Google Sign-In Error: $e");
      return e.toString();
    }
  }

  Future<String> sendOtop(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        forceResendingToken: _resendToken,

        verificationCompleted:
            (PhoneAuthCredential credential) async {
              await _auth.signInWithCredential(credential);
              await _savePhoneUser();
            },

        verificationFailed: (FirebaseAuthException e) {
          throw e.message ?? 'Phone verification failed';
        },
        codeSent:
            (
              String verificationId,
              int? forceResendingToken,
            ) {
              _verificationId = verificationId;
              _resendToken = forceResendingToken;
            },

        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
      return 'otp_sent';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> verifyOtp(String smsCode) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );
      // ignore: unused_local_variable
      UserCredential userCred = await _auth
          .signInWithCredential(credential);
      await _savePhoneUser();
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> _savePhoneUser() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final doc = await _firestore
        .collection('users')
        .doc(user.uid)
        .get();

    if (!doc.exists) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .set({
            'uid': user.uid,
            'phone': user.phoneNumber,
            'provider': 'phone',
            'createdAt': FieldValue.serverTimestamp(),
          });
    }
  }

  Future<String> logOut() async {
    try {
      final uid = _auth.currentUser?.uid;
      // Google logout if available
      try {
        await _googleSignIn.signOut();
      } catch (e) {
        // ignore google signout error (safe)
      }
      await _auth.signOut();
      if (uid != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update({
              'isOnline': false,
              'lastSeen': FieldValue.serverTimestamp(),
            });
      }
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
