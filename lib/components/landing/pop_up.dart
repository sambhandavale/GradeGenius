import 'package:flutter/material.dart';

class InfoPopup extends StatefulWidget {
  const InfoPopup({super.key});

  @override
  State<InfoPopup> createState() => _InfoPopupState();
}

class _InfoPopupState extends State<InfoPopup> {
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 1) {
      setState(() {
        _currentPage++;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 44, 44, 44),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_currentPage == 0) ...[
            const Text(
              "Less Grading, More Teaching – Let AI Handle the Rest!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontFamily: 'GoogleSans',
                height: 1.1,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Our AI automates grading, delivers personalized feedback, and offers actionable insights.",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontFamily: 'GoogleSans',
              ),
            ),
          ] else ...[
            const Text(
              "Sign In or Sign Up",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontFamily: 'GoogleSans',
              ),
            ),
            const SizedBox(height: 20),
            _authOption("Sign In", Colors.black,context),
            const SizedBox(height: 10),
            _authOption("Sign Up", Colors.black,context),
            const SizedBox(height: 10),
            _authOption("Continue as Guest", const Color(0xFFFDEE57),context),
          ],
          const SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: List.generate(2, (index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 5),
                    width: index == _currentPage ? 12 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: index == _currentPage ? Colors.white : Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  );
                }),
              ),
              if(_currentPage == 0)
              GestureDetector(
                onTap: _nextPage,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                  decoration: BoxDecoration(
                    color:  const Color(0xFF76BC7B) ,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Text(
                        _currentPage == 0 ? "Next" : "Done",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        width: 35,
                        height: 35,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

Widget _authOption(String text, Color color, BuildContext context) {
  return GestureDetector(
    onTap: () {
      if (text == "Continue as Guest") {
        Navigator.pop(context);
      } else {
        // for signin and signup
      }
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              color: color == const Color(0xFFFDEE57) ? Colors.black : Colors.white,
              fontSize: 18,
              fontFamily: 'GoogleSans',
            ),
          ),
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow,
              color: Colors.black,
              size: 20,
            ),
          ),
        ],
      ),
    ),
  );
}

}
