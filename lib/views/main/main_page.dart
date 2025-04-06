import 'package:flutter/material.dart';
import 'package:gradegenius/components/shared/bottom_nav.dart';
import 'package:gradegenius/utils/constants.dart';
import 'package:gradegenius/views/main/all_kaksha.dart';
import 'package:gradegenius/views/main/landing_page.dart';
import 'package:gradegenius/views/static/page_404.dart';

class HomeController extends StatefulWidget {
  const HomeController({super.key});

  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  List<Widget> get _pages => [
    LandingPage(
      popup: false,
      goToAllKaksha: () {
        setState(() {
          _selectedIndex = 2;
        });
      },
    ),
    Page404(),
    AllKaksha(),
    Page404(),
    Page404(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
      _pageController.jumpToPage(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.darkThemeBg,
      body: Stack(
        children: [
          _pages[_selectedIndex],
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: CustomBottomNav(
                  currentIndex: _selectedIndex,
                  onItemSelected: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
