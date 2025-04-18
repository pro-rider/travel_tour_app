import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  final bool isLoading;

  const LoaderWidget({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Your app color
            ),
          )
        : SizedBox.shrink();
  }
}
