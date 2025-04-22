import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradegenius/components/shared/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInBox extends StatefulWidget {
  final Function(bool) setLoading;
  final Future<void> Function(String, String) handleLogin;
  final bool isLoading;

  const SignInBox({
    required this.setLoading,
    required this.handleLogin, 
    required this.isLoading,
    super.key,
  });

  @override
  State<SignInBox> createState() => _SignInBoxState(); 
}

class _SignInBoxState extends State<SignInBox> {
  bool obscurePassword = true;
  bool rememberMe = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      emailController.text = prefs.getString('email') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
      rememberMe = prefs.getBool('rememberMe') ?? false;
    });
  }

  Future<void> _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (rememberMe) {
      await prefs.setString('email', emailController.text);
      await prefs.setString('password', passwordController.text);
      await prefs.setBool('rememberMe', true);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.setBool('rememberMe', false);
    }
  }

  void setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'SignIn',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'GoogleSans',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter Email",
                hintStyle: const TextStyle(
                    color: Colors.white54, fontFamily: 'GoogleSans'),
                filled: true,
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: passwordController,
              style: const TextStyle(color: Colors.white),
              obscureText: obscurePassword,
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: const Color.fromARGB(255, 19, 19, 19),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white54,
                  ),
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  side: const BorderSide(
                    color: Colors.white,
                    width: 2.0,
                  ),
                  onChanged: (value) {
                    setState(() {
                      rememberMe = value ?? false;
                    });
                  },
                ),
                const Text(
                  "Remember Me",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(color: Colors.white70),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle sign up tap
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _saveCredentials();
                  setLoading(true);
                  widget
                      .handleLogin(
                    emailController.text,
                    passwordController.text,
                  )
                      .then((_) {
                    setLoading(false);
                  }).catchError((error) {
                    setLoading(false);
                    showToast(
                      message: 'An error occurred.',
                      isError: true,
                    );
                  });
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    !isLoading ? 'SignIn' : 'Loading..',
                    style: TextStyle(
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
      ),
    );
  }
}
