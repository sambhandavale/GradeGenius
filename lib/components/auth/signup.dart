import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradegenius/components/shared/drop_down.dart';
import 'package:gradegenius/components/shared/toast.dart';


class SignUpBox extends StatefulWidget {
  final Future<void> Function({
    required String username,
    required String email,
    required String password,
    required String role,
  }) handleSignup;
  final Function(bool) setLoading;
  final bool isLoading;

  const SignUpBox({
    required this.handleSignup,
    required this.setLoading, 
    required this.isLoading,
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
  var _roleSelected = 'teacher';
  bool isLoading = false;

  void setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

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
            CustomDropdownField<String>(
              value: _roleSelected,
              hint: 'Max Questions',
              items: ['student', 'teacher']
                .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text('Role: ${value[0].toUpperCase()}${value.substring(1)}'),
                    ))
                .toList(),

              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _roleSelected = newValue;
                  });
                }
              },
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
                  role:_roleSelected,
                ).then((_) => 
                  setLoading(false))
                  .catchError((error) {
                    setLoading(false);
                    showToast(
                      message: 'An error occurred.',
                      isError: true,
                    );
                  });;
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    !isLoading ? 'SignUp' : 'Loading..',
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
