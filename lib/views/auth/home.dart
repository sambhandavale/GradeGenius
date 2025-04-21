import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradegenius/api/routes/post/auth/login.dart';
import 'package:gradegenius/api/routes/post/auth/signup.dart';
import 'package:gradegenius/components/auth/signin.dart';
import 'package:gradegenius/components/auth/signup.dart';
import 'package:gradegenius/components/landing/pop_up.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradegenius/components/shared/button.dart';
import 'package:gradegenius/components/shared/toast.dart';
import 'package:gradegenius/providers/authProvider.dart';
import 'package:gradegenius/views/main/main_page.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showSignInBox = false;
  bool showSignUpBox = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showInfoPopup(context);
    });
  }

  void setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  Future<void> handleSignup({
    required String username,
    required String email,
    required String password,
    required String role,
  }) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      setLoading(true);
      final response = await signup({
        'username': username,
        'email': email,
        'password': password,
        'role':role,
      });

      final statusCode = response['statusCode'];
      final responseData = response['data'];
  

      switch (statusCode) {
        case 200:
          await authProvider.login(responseData['jwtToken']);
          await authProvider.fetchUser();
          if (authProvider.isAuthenticated) {
            showToast(message: 'Sign Up Successfull !!!');
            Navigator.of(context).pushReplacement(
              CupertinoPageRoute(builder: (context) => const HomeController()));
          } else {
            showToast(message: 'Sign-up failed!', isError: true);
          }
          break;
        default:
          showToast(message: responseData['error'], isError: true);
          break;
      }
    } catch (e) {
      debugPrint('Error during signup: $e');
      showToast(message: 'An error occurred.', isError: true);
    } finally {
      setLoading(false);
    }
  }
 
  Future<void> handleLogin(String email, String password) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      setLoading(true);
      final response = await login({
        'email': email,
        'password': password,
      });

      final statusCode = response['statusCode'];
      final responseData = response['data'];

      switch (statusCode) {
        case 200:
          await authProvider.login(responseData['jwtToken']);
          await authProvider.fetchUser();
          if (authProvider.isAuthenticated) {
            showToast(message: 'Sign-in successful!');
              Navigator.of(context).pushReplacement(
                CupertinoPageRoute(builder: (context) => const HomeController()));
          } else {
            showToast(message: 'Sign-in failed!', isError: true);
          }
          break;
        case 400:
        case 401:
          showToast(message: 'Invalid credentials.', isError: true);
          break;
        case 404:
          showToast(message: 'User not found.', isError: true);
          break;
        default:
          showToast(message: 'An error occurred.', isError: true);
          break;
      }
    } catch (e) {
      debugPrint('Error during login: $e');
      showToast(message: 'An error occurred.', isError: true);
    } finally {
      setLoading(false);
    }
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 34, 34, 34),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
              ),
              const SizedBox(width: 10,),
              Text(
                "GradeGenius",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'GoogleSans'
                ),
              ),
            ],
          ),
        ),
      ),
      
      body: Stack(
        children: [
          Positioned(
            top: 60,
            right: -80,
            child: SvgPicture.asset(
              'assets/icons/paper-pen.svg',
              width: 250,
              height: 250, 
              fit: BoxFit.contain,
            ),
          ),

          Positioned(
            top: 250,
            left: -120,
            child: SvgPicture.asset(
              'assets/icons/paper-pen.svg',
              width: 300,
              height: 300, 
              fit: BoxFit.contain,
            ),
          ),

          Positioned(
            bottom: -80,
            right: -60,
            child: SvgPicture.asset(
              'assets/icons/paper-pen.svg',
              width: 250,
              height: 250, 
              fit: BoxFit.contain,
            ),
          ),

          // Your actual body content
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Less Grading,     More Teaching – Let AI Handle the Rest!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontFamily: 'GoogleSans',
                        height: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconTextButton(
                      text: 'Sign In',
                      iconPath: 'assets/icons/common/play.svg',
                      onPressed: () {
                        showAuthDialog(context, 'Sign In');
                      },
                      textColor: Colors.white,
                      iconSize: 28,
                    ),
                    const SizedBox(width: 10),
                    IconTextButton(
                      text: 'Sign Up',
                      iconPath: 'assets/icons/common/play.svg',
                      onPressed: () {
                        showAuthDialog(context, 'Sign Up');
                      },
                      textColor: Colors.white,
                      iconSize: 28,
                      backgroundColor: Color.fromARGB(255, 68, 68, 68),
                    ),
                  ],
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),

    );
  }

  void showAuthDialog(BuildContext context, String initialTitle) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {

        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              backgroundColor: const Color(0xFF1E1E1E),
              child: initialTitle == 'Sign In'
                  ? SignInBox(
                      setLoading: setLoading,
                      handleLogin: handleLogin,
                    )
                  : SignUpBox(
                      handleSignup: handleSignup,
                      setLoading: setLoading,
                    ),
            );
          },
        );
      },
    );
  }

  void showInfoPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      // isDismissible: false,
      // enableDrag: false,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => InfoPopup(showAuthDialog: showAuthDialog),
    );
  }
}


