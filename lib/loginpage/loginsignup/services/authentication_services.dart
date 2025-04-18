import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: 'YOUR_GOOGLE_CLIENT_ID',
  );

  // Sign Up User
  Future<String> signupUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      if (email.isEmpty || password.isEmpty || name.isEmpty) {
        return "Please fill in all fields";
      }

      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection("users").doc(cred.user!.uid).set({
        'name': name,
        'uid': cred.user!.uid,
        'email': email,
      });

      return "success";
    } on FirebaseAuthException catch (e) {
      return _mapFirebaseError(e.code);
    } catch (e) {
      return "An unexpected error occurred";
    }
  }

  // Log In User
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        return "Please fill in all fields";
      }

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "success";
    } on FirebaseAuthException catch (e) {
      return _mapFirebaseError(e.code);
    } catch (e) {
      return "An unexpected error occurred";
    }
  }

  // Sign In with Google
  Future<String> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return "Google sign-in cancelled";
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null && user.email != null && user.displayName != null) {
        await _firestore.collection("users").doc(user.uid).set({
          'name': user.displayName,
          'uid': user.uid,
          'email': user.email,
        }, SetOptions(merge: true));
      } else {
        return "Google user data incomplete";
      }

      return "success";
    } on FirebaseAuthException catch (e) {
      return _mapFirebaseError(e.code);
    } catch (e) {
      return "An unexpected error occurred during Google sign-in";
    }
  }

  // Sign In with Facebook
  Future<String> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status != LoginStatus.success) {
        return "Facebook sign-in cancelled or failed";
      }

      final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.tokenString);
      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final facebookData = await FacebookAuth.instance.getUserData();
        final email = facebookData['email'];
        final name = facebookData['name'] ?? 'Facebook User';
        if (email == null || email.isEmpty) {
          return "Facebook email not provided";
        }

        await _firestore.collection("users").doc(user.uid).set({
          'name': name,
          'uid': user.uid,
          'email': email,
        }, SetOptions(merge: true));
      } else {
        return "Facebook user data incomplete";
      }

      return "success";
    } on FirebaseAuthException catch (e) {
      return _mapFirebaseError(e.code);
    } catch (e) {
      return "An unexpected error occurred during Facebook sign-in";
    }
  }

  // Sign In with Phone
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(String, int?) onCodeSent,
    required Function(FirebaseAuthException) onVerificationFailed,
    required Function(PhoneAuthCredential) onVerificationCompleted,
    Function(String)? onCodeAutoRetrievalTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onVerificationCompleted,
      verificationFailed: onVerificationFailed,
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout ?? (String verificationId) {},
    );
  }

  Future<String> signInWithPhoneCredential(PhoneAuthCredential credential) async {
    try {
      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null && user.phoneNumber != null) {
        await _firestore.collection("users").doc(user.uid).set({
          'name': 'Phone User',
          'uid': user.uid,
          'phone': user.phoneNumber,
        }, SetOptions(merge: true));
      } else {
        return "Phone user data incomplete";
      }

      return "success";
    } on FirebaseAuthException catch (e) {
      return _mapFirebaseError(e.code);
    } catch (e) {
      return "An unexpected error occurred during phone sign-in";
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await FacebookAuth.instance.logOut();
    await _auth.signOut();
  }

  // Map Firebase errors to user-friendly messages
  String _mapFirebaseError(String code) {
    switch (code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'The email address is already in use.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with a different sign-in method.';
      case 'invalid-verification-code':
        return 'Invalid OTP. Please try again.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}