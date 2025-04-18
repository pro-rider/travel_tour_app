// import 'package:flutter/material.dart';

// class CustomButton extends StatelessWidget {
//   final String label;
//   final VoidCallback onPressed;
//   final Color color;
//   final Color textColor;
//   final double borderRadius;

//   const CustomButton({
//     super.key,
//     required this.label,
//     required this.onPressed,
//     this.color = Colors.blue,
//     this.textColor = Colors.white,
//     this.borderRadius = 8.0,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         foregroundColor: textColor,
//         backgroundColor: color,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(borderRadius),
//         ),
//       ),
//       onPressed: onPressed,
//       child: Text(label),
//     );
//   }
// }
