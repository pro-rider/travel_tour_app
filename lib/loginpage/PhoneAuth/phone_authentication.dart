import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tour_travel/loginpage/PhoneAuth/otp_screen.dart';
import 'package:tour_travel/loginpage/loginsignup/constants/constants.dart';
import 'package:tour_travel/loginpage/loginsignup/widgets/button_widgets.dart';

class PhoneAuthentication extends StatefulWidget {
  const PhoneAuthentication({super.key});

  @override
  State<PhoneAuthentication> createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {
  final TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void sendOTP(BuildContext context) async {
    final phone = phoneController.text.trim();
    if (!_validatePhone(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Please enter a valid phone number (e.g., +9771234567890)')),
      );
      return;
    }

    setState(() => isLoading = true);

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Error: ${error.message ?? 'Failed to send OTP'}")),
        );
      },
      codeSent: (verificationId, forceResendingToken) {
        setState(() => isLoading = false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPScreen(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  bool _validatePhone(String phone) {
    final phoneRegEx = RegExp(r'^\+\d{10,15}$');
    return phoneRegEx.hasMatch(phone);
  }

  void showPhoneDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Enter your phone number",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "+9771234567890",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const CircularProgressIndicator()
                  : MyButtons(
                      onTap: () => sendOTP(context),
                      text: "Send Code",
                      backgroundColor: AppColors.successColor,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyButtons(
      onTap: showPhoneDialog,
      text: "Sign in with Phone",
      leading: const Icon(Icons.phone, color: Colors.white),
      backgroundColor: AppColors.successColor,
    );
  }
}
