// import 'package:flutter/material.dart';

// class TextFieldInput extends StatelessWidget {
//   final TextEditingController textEditingController;
//   final bool isPass;
//   final String hintText;
//   final IconData? icon;
//   final TextInputType textInputType;
//   const TextFieldInput({
//     super.key,
//     required this.textEditingController,
//     this.isPass = false,
//     required this.hintText,
//     this.icon,
//     required this.textInputType,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         vertical: 10,
//         horizontal: 20,
//       ),
//       child: TextField(
//         style: const TextStyle(fontSize: 20),
//         controller: textEditingController,
//         decoration: InputDecoration(
//           prefixIcon: Icon(icon, color: Colors.black54),
//           hintText: hintText,
//           hintStyle: const TextStyle(
//             color: Colors.black45,
//             fontSize: 18,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide.none,
//             borderRadius: BorderRadius.circular(30),
//           ),
//           border: InputBorder.none,
//           focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: Colors.blue,
//               width: 2,
//             ),
//             borderRadius: BorderRadius.circular(30),
//           ),
//           filled: true,
//           fillColor: const Color(0xFFedf0f8),
//           contentPadding: const EdgeInsets.symmetric(
//             vertical: 15,
//             horizontal: 20,
//           ),
//         ),
//         keyboardType: textInputType,
//         obscureText: isPass,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class TextFieldInput extends StatefulWidget {
  final IconData icon;
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType textInputType;
  final bool isPass;

  const TextFieldInput({
    super.key,
    required this.icon,
    required this.textEditingController,
    required this.hintText,
    required this.textInputType,
    this.isPass = false,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TextFieldInputState createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Color?> _borderAnimation;
  bool _isFocused = false;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _borderAnimation = ColorTween(
      begin: Colors.grey[300],
      end: Colors.blueAccent,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleFocusChange(bool hasFocus) {
    setState(() {
      _isFocused = hasFocus;
      if (hasFocus) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.3),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 8,
            ),
            child: TextField(
              controller: widget.textEditingController,
              keyboardType: widget.textInputType,
              obscureText: widget.isPass && !_showPassword,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  widget.icon,
                  color: _isFocused ? Colors.blueAccent : Colors.grey,
                  size: 24,
                ),
                suffixIcon: widget.isPass
                    ? IconButton(
                        icon: Icon(
                          _showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: _isFocused ? Colors.blueAccent : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      )
                    : null,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w400,
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.9),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: _borderAnimation.value ?? Colors.grey[300]!,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.blueAccent,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.redAccent,
                    width: 2,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {}); // Trigger rebuild for validation
              },
              onTap: () => _handleFocusChange(true),
              onEditingComplete: () => _handleFocusChange(false),
            ),
          ),
        );
      },
    );
  }
}
