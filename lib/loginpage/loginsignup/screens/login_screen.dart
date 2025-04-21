import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height / 2.9,
                child: Image.asset('assets/image/login/undraw_secure-login_m11a.png'),
              ),
              Gap(2),
              TextFieldInput(
                icon: Icons.person,
                textEditingController: emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
              ),
              Gap(5),
              TextFieldInput(
                icon: Icons.lock,
                textEditingController: passwordController,
                hintText: 'Enter your password',
                textInputType: TextInputType.visiblePassword,
                isPass: true,
              ),
              Gap(5),
              const ForgetPasswordScreen(),
              Gap(5),
              isLoading
                  ? const CircularProgressIndicator()
                  : MyButtons(onTap: loginUser, text: "Log In"),
              Gap(5),
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
              Gap(0.1),
              const GoogleLogin(),
              Gap(0.1),
              const FacebookLogin(),
              Gap(5),
              const PhoneAuthentication(),
              Gap(5),
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
              Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}