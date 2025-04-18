import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tour_travel/loginpage/loginsignup/constants/constants.dart';
import 'package:tour_travel/loginpage/loginsignup/widgets/button_widgets.dart';
import 'package:tour_travel/loginpage/loginsignup/widgets/snackbar_widgets.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void sendResetEmail() async {
    final email = emailController.text.trim();
    if (!_validateEmail(email)) {
      showSnackBar(context, 'Please enter a valid email');
      return;
    }

    setState(() => isLoading = true);

    try {
      await _auth.sendPasswordResetEmail(email: email);
      if (!mounted) return;
      showSnackBar(context, 'Password reset link sent to your email');
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      showSnackBar(context, _mapFirebaseError(e.code));
    } catch (e) {
      if (!mounted) return;
      showSnackBar(context, 'An unexpected error occurred');
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }

    emailController.clear();
  }

  bool _validateEmail(String email) {
    final emailRegEx = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegEx.hasMatch(email);
  }

  String _mapFirebaseError(String code) {
    switch (code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-not-found':
        return 'No user found with this email.';
      default:
        return 'Failed to send reset email. Please try again.';
    }
  }

  void showDialogBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Reset Password",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "example@gmail.com",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const CircularProgressIndicator()
                  : MyButtons(
                      onTap: sendResetEmail,
                      text: "Send",
                      backgroundColor: AppColors.primaryColor,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: showDialogBox,
          child: const Text(
            "Forgot Password?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}