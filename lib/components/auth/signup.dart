import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class SignUpBox extends StatefulWidget {
  final Future<void> Function({
    required String username,
    required String email,
    required String password,
    required String role,
  }) handleSignup;
  final Function(bool) setLoading;

  const SignUpBox({
    required this.handleSignup,
    required this.setLoading, 
    super.key,
  });

  @override
  State<SignUpBox> createState() => _SignUpBoxState();
}

class _SignUpBoxState extends State<SignUpBox> {
  bool obscurePassword = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return 
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'SignIn',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'GoogleSans',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter Username",
                hintStyle: const TextStyle(
                  color: Colors.white54,
                  fontFamily: 'GoogleSans'
                ),
                filled: true,
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter Email",
                hintStyle: const TextStyle(
                  color: Colors.white54,
                  fontFamily: 'GoogleSans'
                ),
                filled: true,
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              style: const TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: const Color.fromARGB(255, 19, 19, 19),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _roleController,
              style: const TextStyle(color: Colors.white),
              obscureText: false,
              decoration: InputDecoration(
                hintText: "Role",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: const Color.fromARGB(255, 19, 19, 19),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Have an account? ",
                  style: const TextStyle(color: Colors.white70),
                ),
                GestureDetector(
                  onTap: () {
                      // widget.onClose();
                      // widget.onSignInPopup();
                  },
                  child: Text(
                    "Sign In",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF76BC7B),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: () {
                widget.handleSignup(
                  username: _usernameController.text,
                  email: _emailController.text,
                  password: _passwordController.text,
                  role:_roleController.text,
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'SignIn',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'GoogleSans',
                    ),
                  ),
                  const SizedBox(width: 10),
                  SvgPicture.asset(
                    'assets/icons/common/play.svg',
                    width: 28,
                    height: 28,
                  ),
                ],
              ),
            )
          ],
        ),
      );
  }
}
