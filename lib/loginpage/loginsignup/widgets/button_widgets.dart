import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MyButtons extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text;
  final Color? backgroundColor;
  final Widget? leading;

  const MyButtons({
    super.key,
    this.onTap,
    this.text,
    this.backgroundColor,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 8,
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: backgroundColor ?? Colors.blue,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leading != null) ...[
                leading!,
                Gap(8),
              ],
              Text(
                text ?? "Button",
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
