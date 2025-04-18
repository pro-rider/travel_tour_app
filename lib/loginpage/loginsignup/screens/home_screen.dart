import 'package:flutter/material.dart';
import 'package:tour_travel/loginpage/googlelogin/google_auth.dart';
import 'package:tour_travel/loginpage/loginsignup/constants/constants.dart';
import 'package:tour_travel/loginpage/loginsignup/screens/login_screen.dart';
import 'package:tour_travel/loginpage/loginsignup/services/authentication_services.dart';
import 'package:tour_travel/loginpage/loginsignup/widgets/button_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tour & Travel'),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Congratulations!\nYou have successfully logged in",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textColor),
            ),
            const SizedBox(height: 32),
            MyButtons(
              onTap: () async {
                await AuthMethod().signOut();
                if (!context.mounted) return;
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              text: "Log Out",
              backgroundColor: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }
}