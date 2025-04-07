import 'package:flutter/material.dart';
import 'package:gradegenius/components/shared/custom_bottom_nav.dart';
import 'package:gradegenius/components/shared/ppt_app_bar.dart';
import 'package:gradegenius/utils/constants.dart';
import 'package:iconsax/iconsax.dart'; // Ensure this import is present

class PresentationPage extends StatefulWidget {
  const PresentationPage({super.key});

  @override
  State<PresentationPage> createState() => _PresentationPageState();
}

class _PresentationPageState extends State<PresentationPage> {
  int selectedTab = 1;
  bool isNotesSelected = false;

  final TextEditingController linkController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  void toggleTab(bool notes) {
    setState(() {
      isNotesSelected = notes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.darkThemeBg,
      appBar: const PPTAppBar(),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: selectedTab,
        onItemSelected: (index) {
          setState(() {
            selectedTab = index;
            // Add your navigation logic if needed
          });
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// Toggle Buttons
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => toggleTab(false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: isNotesSelected
                            ? const Color(0xFF2B2B2B)
                            : const Color(0xFF3C3C3C),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Text(
                        'Presentation',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily: 'GoogleSans',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => toggleTab(true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: isNotesSelected
                            ? const Color(0xFFFFC727)
                            : const Color(0xFF2B2B2B),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Text(
                        'Notes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isNotesSelected
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily: 'GoogleSans',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            /// Reference Link
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF2B2B2B),
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextField(
                controller: linkController,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'GoogleSans',
                ),
                decoration: const InputDecoration.collapsed(
                  hintText: 'Add reference link',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'GoogleSans',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// Paste your content
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF141414),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Iconsax.copy,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: contentController,
                      maxLines: 10,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'GoogleSans',
                      ),
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Paste your content here',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'GoogleSans',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            /// Generate Button
            GestureDetector(
              onTap: () {
                // Add generate logic here
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF8E9FE7),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Generate',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'GoogleSans',
                      ),
                    ),
                    SizedBox(width: 12),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 16,
                      child: Icon(
                        Iconsax.play,
                        color: Color(0xFF8E9FE7),
                        size: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}