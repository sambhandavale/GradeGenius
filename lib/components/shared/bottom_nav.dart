import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavExample extends StatefulWidget {
  const CustomBottomNavExample({super.key});

  @override
  State<CustomBottomNavExample> createState() => _CustomBottomNavExampleState();
}

class _CustomBottomNavExampleState extends State<CustomBottomNavExample> {
  int _selectedIndex = 0;

  final List<String> _icons = [
    'assets/icons/nav/home.svg',
    'assets/icons/nav/ppt.svg',
    'assets/icons/nav/kaksha.svg',
    'assets/icons/nav/quiz.svg',
    'assets/icons/nav/profile.svg',
  ];

  final List<String> _labels = [
    "Home",
    "PPT",
    "Kaksha",
    "Quiz",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 29, 29, 29),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_icons.length, (index) {
              final isSelected = _selectedIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      _icons[index],
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _labels[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

}
