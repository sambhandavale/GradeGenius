import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

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
            color: const Color.fromARGB(255, 29, 29, 29), // You can change to Colors.transparent if needed
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_icons.length, (index) {
              final isSelected = currentIndex == index;
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      _icons[index],
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        isSelected
                            ? const Color.fromARGB(255, 255, 239, 95)
                            : Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _labels[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
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
