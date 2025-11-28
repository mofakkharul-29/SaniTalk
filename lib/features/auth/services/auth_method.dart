import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthMethodService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
            'createdAt': FieldValue.serverTimestamp(),
          });
      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint(
          'The account already exists for that email.',
        );
      }
      return 'from firebase: ${e.toString()}';
    } catch (e) {
      debugPrint('error caught: ${e.toString()}');
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
      return 'account created successfully!';
    } on FirebaseAuthException catch (e) {
      return 'from firebase: ${e.toString()}';
    } catch (e) {
      debugPrint('error caught: ${e.toString()}');
      return e.toString();
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}

final authMethodProvider = Provider<AuthMethodService>((
  ref,
) {
  return AuthMethodService();
});
