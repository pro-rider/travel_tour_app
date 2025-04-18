import 'package:flutter/material.dart';
import 'package:tour_travel/loginpage/loginsignup/constants/constants.dart';
import 'package:tour_travel/loginpage/loginsignup/screens/home_screen.dart';
import 'package:tour_travel/loginpage/loginsignup/services/authentication_services.dart';
import 'package:tour_travel/loginpage/loginsignup/widgets/button_widgets.dart';
import 'package:tour_travel/loginpage/loginsignup/widgets/snackbar_widgets.dart';

class FacebookLogin extends StatefulWidget {
  const FacebookLogin({super.key});

  @override
  State<FacebookLogin> createState() => _FacebookLoginState();
}

class _FacebookLoginState extends State<FacebookLogin> {
  bool isLoading = false;

  void signInWithFacebook() async {
    setState(() => isLoading = true);

    final res = await AuthMethod().signInWithFacebook();

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
    return isLoading
        ? const CircularProgressIndicator()
        : MyButtons(
            onTap: signInWithFacebook,
            text: "Sign in with Facebook",
            leading: Image.asset(
              'assets/images/facebook.png',
              height: 24,
              width: 24,
            ),
            backgroundColor: AppColors.facebookButtonColor,
          );
  }
}