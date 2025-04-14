import 'package:flutter/material.dart';
import 'package:gradegenius/components/landing/pop_up.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradegenius/components/shared/button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showInfoPopup(context);
    });
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
}

void showInfoPopup(BuildContext context) {
showModalBottomSheet(
  context: context,
  // isDismissible: false,
  // enableDrag: false,
  backgroundColor: Colors.transparent,
  isScrollControlled: true,
  builder: (context) => const InfoPopup(),
);
}

void showAuthDialog(BuildContext context, String initialTitle) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      String title = initialTitle;

      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            backgroundColor: const Color(0xFF1E1E1E),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'GoogleSans',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "   Enter Email",
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
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "   Password",
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
                  if (title == "Sign In")
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (_) {},
                          activeColor: Colors.orange,
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
                      Text(
                        title == "Sign In" ? "Don't have an account? " : "Already have an account? ",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            title = title == "Sign In" ? "Sign Up" : "Sign In";
                          });
                        },
                        child: Text(
                          title == "Sign In" ? "Sign Up" : "Sign In",
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
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
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
            ),
          );
        },
      );
    },
  );
}


