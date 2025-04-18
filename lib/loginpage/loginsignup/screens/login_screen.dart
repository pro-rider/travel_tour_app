import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tour_travel/loginpage/PhoneAuth/phone_authentication.dart';
import 'package:tour_travel/loginpage/facebooklogin/facebook_login.dart';
import 'package:tour_travel/loginpage/forget_password/forget_password_screen.dart';
import 'package:tour_travel/loginpage/googlelogin/google_login.dart';
import 'package:tour_travel/loginpage/loginsignup/constants/constants.dart';
import 'package:tour_travel/loginpage/loginsignup/screens/home_screen.dart';
import 'package:tour_travel/loginpage/loginsignup/screens/signup_screen.dart';
import 'package:tour_travel/loginpage/loginsignup/services/authentication_services.dart';
import 'package:tour_travel/loginpage/loginsignup/widgets/button_widgets.dart';
import 'package:tour_travel/loginpage/loginsignup/widgets/snackbar_widgets.dart';
import 'package:tour_travel/loginpage/loginsignup/widgets/text_field_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (!_validateInputs(email, password)) {
      showSnackBar(context, 'Please enter valid email and password');
      return;
    }

    setState(() => isLoading = true);

    final res = await AuthMethod().loginUser(email: email, password: password);

    if (!mounted) return;

    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      showSnackBar(context, res);
    }

    setState(() => isLoading = false);
  }

  bool _validateInputs(String email, String password) {
    final emailRegEx = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegEx.hasMatch(email) && password.length >= 6;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height / 2.7,
                child: Image.asset('assets/images/login.jpg'),
              ),
              const SizedBox(height: 16),
              TextFieldInput(
                icon: Icons.person,
                textEditingController: emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              TextFieldInput(
                icon: Icons.lock,
                textEditingController: passwordController,
                hintText: 'Enter your password',
                textInputType: TextInputType.visiblePassword,
                isPass: true,
              ),
              const SizedBox(height: 12),
              const ForgetPasswordScreen(),
              const SizedBox(height: 16),
              isLoading
                  ? const CircularProgressIndicator()
                  : MyButtons(onTap: loginUser, text: "Log In"),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text("or", style: Theme.of(context).textTheme.bodyMedium),
                  ),
                  const Expanded(child: Divider(thickness: 1)),
                ],
              ),
              const SizedBox(height: 16),
              const GoogleLogin(),
              const SizedBox(height: 12),
              const FacebookLogin(),
              const SizedBox(height: 12),
              const PhoneAuthentication(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ", style: Theme.of(context).textTheme.bodyMedium),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const SignupScreen()),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}