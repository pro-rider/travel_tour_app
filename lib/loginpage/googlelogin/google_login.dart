import 'package:flutter/material.dart';
import 'package:tour_travel/loginpage/loginsignup/constants/constants.dart';
import 'package:tour_travel/loginpage/loginsignup/screens/home_screen.dart';
import 'package:tour_travel/loginpage/loginsignup/services/authentication_services.dart';
import 'package:tour_travel/loginpage/loginsignup/widgets/button_widgets.dart';
import 'package:tour_travel/loginpage/loginsignup/widgets/snackbar_widgets.dart';

class GoogleLogin extends StatefulWidget {
  const GoogleLogin({super.key});

  @override
  State<GoogleLogin> createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {
  bool isLoading = false;

  void signInWithGoogle() async {
    setState(() => isLoading = true);

    final res = await AuthMethod().signInWithGoogle();

    if (!mounted) return;

    setState(() => isLoading = false);

    if (res == 'success') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: isLoading
                ? const CircularProgressIndicator()
                : MyButtons(
                    onTap: signInWithGoogle,
                    text: "Sign in with Google",
                    leading: Image.asset(
                      'assets/image/login/google.png',
                      height: 20,
                      width: 20,
                    ),
                    backgroundColor: AppColors.googleButtonColor,
                  )));
  }
}
