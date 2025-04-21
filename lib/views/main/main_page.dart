import 'package:flutter/material.dart';
import 'package:gradegenius/components/shared/bottom_nav.dart';
import 'package:gradegenius/models/users.dart';
import 'package:gradegenius/providers/authProvider.dart';
import 'package:gradegenius/utils/constants.dart';
import 'package:gradegenius/views/main/all_kaksha.dart';
import 'package:gradegenius/views/main/quiz.dart';
import 'package:gradegenius/views/main/landing_page.dart';
import 'package:gradegenius/views/main/presentation.dart';
import 'package:gradegenius/views/static/page_404.dart';
import 'package:provider/provider.dart';

class HomeController extends StatefulWidget {
  const HomeController({super.key});

  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  User? _user;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _user = authProvider.user;
  }

  List<Widget> get _pages => [
    LandingPage(
      popup: false,
      goToAllKaksha: () {
        setState(() {
          _selectedIndex = 2;
        });
      },
      goToPPT: () {
        setState(() {
          _selectedIndex = 1;
        });
      },
      role: _user!.role,
    ),
    PresentationPage(),
    AllKaksha(role: _user!.role,),
    QuizGeneratorPage(),
    Page404(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
