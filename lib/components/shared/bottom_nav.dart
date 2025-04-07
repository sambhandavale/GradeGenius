import 'package:flutter/material.dart';
import 'package:gradegenius/utils/constants.dart';
import 'package:gradegenius/components/shared/bottom_nav.dart'; // Update this path if needed

class PPTPage extends StatefulWidget {
  const PPTPage({super.key});

  @override
  State<PPTPage> createState() => _PPTPageState();
}

class _PPTPageState extends State<PPTPage> {
  int selectedTab = 0;

  void _onNavItemTapped(int index) {
    if (index == 1) return; // Already on PPT page
    // Example navigation logic
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/presentation');
        break;
      case 2:
        Navigator.pushNamed(context, '/kaksha');
        break;
      case 3:
        Navigator.pushNamed(context, '/quiz');
        break;
      case 4:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.darkThemeBg,
      bottomNavigationBar: BottomNav(
        currentIndex: 1,
        onItemSelected: _onNavItemTapped,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Add PPT / Notes",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'GoogleSans',
                ),
              ),
              const SizedBox(height: 20),

              // Tabs
              Row(
                children: [
                  _buildTabButton(0, "Presentation"),
                  const SizedBox(width: 12),
                  _buildTabButton(1, "Notes"),
                ],
              ),
              const SizedBox(height: 30),

              // Reference Link Input
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Add reference link',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Paste Content Area
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const TextField(
                    maxLines: null,
                    expands: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Paste your content here',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.content_paste, color: Colors.white54),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(int index, String label) {
    final isSelected = index == selectedTab;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFFB83C) : Colors.grey[800],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
