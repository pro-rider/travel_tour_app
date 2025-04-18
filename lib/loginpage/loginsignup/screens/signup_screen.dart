import 'package:flutter/material.dart';
import 'package:tour_travel/loginpage/loginsignup/constants/constants.dart';
import 'package:tour_travel/loginpage/loginsignup/screens/home_screen.dart';
import 'package:tour_travel/loginpage/loginsignup/screens/login_screen.dart';
import 'package:tour_travel/loginpage/loginsignup/services/authentication_services.dart';
import 'package:tour_travel/loginpage/loginsignup/widgets/button_widgets.dart';
import 'package:tour_travel/loginpage/loginsignup/widgets/snackbar_widgets.dart';
import 'package:tour_travel/loginpage/loginsignup/widgets/text_field_widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signupUser() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (!_validateInputs(name, email, password)) {
      showSnackBar(context, 'Please enter valid name, email, and password');
      return;
    }

    setState(() => isLoading = true);

    final res = await AuthMethod().signupUser(email: email, password: password, name: name);

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

  bool _validateInputs(String name, String email, String password) {
    final emailRegEx = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return name.length >= 2 && emailRegEx.hasMatch(email) && password.length >= 6;
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
                height: height / 2.8,
                child: Image.asset('assets/images/signup.jpg'),
              ),
              const SizedBox(height: 16),
              TextFieldInput(
                icon: Icons.person,
                textEditingController: nameController,
                hintText: 'Enter your name',
                textInputType: TextInputType.name,
              ),
              const SizedBox(height: 12),
              TextFieldInput(
                icon: Icons.email,
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
              const SizedBox(height: 16),
              isLoading
                  ? const CircularProgressIndicator()
                  : MyButtons(onTap: signupUser, text: "Sign Up"),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? ", style: Theme.of(context).textTheme.bodyMedium),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      "Login",
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