import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rechoice_app/models/services/firestore_service.dart';

ValueNotifier<AuthService> authService = ValueNotifier(AuthService());

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirestoreService _firebaseFirestore = FirestoreService();

  User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  //email sign in/login
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  //

  //email sign up/register
  Future<UserCredential> register({
    required String email,
    required String password,
    required String name,
    // required String phoneNumber,
  }) async {
    //create user with email and password
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    //Create firestore user document
    await _firebaseFirestore.createUser(
      uid: userCredential.user!.uid,
      name: name,
      email: email,
    );
    return userCredential;
  }

  //user logout
  Future<void> logout() async {
    await firebaseAuth.signOut();
    // await googleSignIn.signOut();
  }

  //user reset password
  Future<void> resetPassword({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> updateUsername({required String username}) async {
    if (currentUser != null) {
      await currentUser!.updateDisplayName(username);
    }
  }

  Future<void> deleteAccount({
    required String email,
    required String password,
  }) async {
    if (currentUser != null) return;

    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.delete();
    await firebaseAuth.signOut();
  }

  //user change password
  Future<void> resetPwFromCurrPw({
    required String currentPassword,
    required String newPassword,
    required String email,
  }) async {
    if (currentUser != null) return;
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.updatePassword(newPassword);
  }

  //google sign in
  // Future<UserCredential?> signInWithGoogle() async {
  //   try {
  //     //trigger google sign in flow

  //     final GoogleSignInAccount? gUser = await googleSignIn.signIn();
  //     if (gUser == null) return null; // User cancelled

  //     //await auth details from request
  //     final GoogleSignInAuthentication gAuth = await gUser.authentication;

  //     // Ensure tokens are available (additional safety)
  //     if (gAuth.idToken == null || gAuth.accessToken == null) {
  //       throw FirebaseAuthException(
  //         code: 'missing-tokens',
  //         message: 'Authentication tokens are missing. Please try again.',
  //       );
  //     }

  //     // Create a new credential for user (fixes error 3 by using correct getters)
  //     final credential = GoogleAuthProvider.credential(
  //       idToken: gAuth.idToken,
  //       accessToken: gAuth.accessToken, // Corrected: Use gAuth.accessToken
  //     );

  //     // Sign in with Firebase Auth to get UserCredential (fixes errors 4 & 5)
  //     final userCredential = await FirebaseAuth.instance.signInWithCredential(
  //       credential,
  //     );
  //     final firebaseUser = userCredential.user;

  //     // Now accessible from UserCredential

  //     // Create Firestore user if new (optional, with error handling)
  //     if (firebaseUser != null) {
  //       try {
  //         final userDoc = await _firebaseFirestore.getUser(firebaseUser.uid);
  //         if (!userDoc.exists) {
  //           await _firebaseFirestore.createUser(
  //             uid: firebaseUser.uid,
  //             name: firebaseUser.displayName ?? '',
  //             email: firebaseUser.email ?? '',
  //           );
  //         }
  //       } catch (e) {
  //         print('Firestore operation failed: $e');
  //         // Optionally handle or rethrow
  //       }
  //     }

  //     return userCredential; // Fixed: Return UserCredential, not OAuthCredential
  //   } catch (e) {
  //     throw FirebaseAuthException(
  //       code: 'google-signin-failed',
  //       message: e.toString(),
  //     );
  //   }
  // }
}
