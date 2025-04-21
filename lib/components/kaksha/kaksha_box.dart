import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradegenius/api/routes/delete/kaksha/delete_kaksha.dart';
import 'package:gradegenius/components/shared/button.dart';

class KakshaBox extends StatelessWidget {
  final String topText;
  final String bottomText;
  final String buttonText;
  final double height;
  final VoidCallback onPressed;
  final Color bgColor;
  final String kakshaId;
  final String kakshaCode;
  final Future<void> Function() getAllKaksha;

  final double? ttFontSize;
  final double? btFontSize;
  final double? ttbtGap;
  final String? role;


  const KakshaBox({
    super.key,
    required this.topText,
    required this.bottomText,
    required this.buttonText,
    this.height = 230,
    required this.onPressed,
    this.bgColor = const Color(0xFFFFEB3B),
    required this.kakshaId,
    required this.kakshaCode,
    required this.getAllKaksha,

    this.ttFontSize = 28,
    this.btFontSize = 44,
    this.ttbtGap = 0,
    this.role = 'teacher',
  });

  Future<void> delKaksha(BuildContext context) async {
    try {
      final res = await deleteKaksha(kakshaId);
      if (res['statusCode'] == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kaksha deleted successfully!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
        await getAllKaksha();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete Kaksha: ${res['message'] ?? 'Unknown error'}'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting Kaksha: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: bgColor,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(topText.isNotEmpty)
                      Text(
                        topText,
                        style: TextStyle(
                          fontSize: ttFontSize,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'GoogleSans',
                          height: 1,
                        ),
                      ),
                      SizedBox(height: ttbtGap,),
                      if(bottomText.isNotEmpty)
                      Text(
                        bottomText,
                        style: TextStyle(
                          fontSize: btFontSize,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'GoogleSans',
                          height: 1
                          // height: 1,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: IconTextButton(
                          text: buttonText,
                          iconPath: 'assets/icons/common/play.svg',
                          onPressed: onPressed,
                          textColor: Colors.white,
                          iconSize: 36,
                          fontSize: 24,
                          backgroundColor: const Color.fromARGB(255, 10, 10, 10),
                          width:'max',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: PopupMenuButton<int>(
                          icon: const Icon(Icons.more_vert,color: Color.fromARGB(255, 255, 255, 255),),
                          color: Colors.black,
                          iconSize: 32,
                          itemBuilder: (context) => [
                            if(role == 'teacher')
                            PopupMenuItem<int>(
                              value: 1,
                              child: Text(
                                "Delete Kaksha",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            PopupMenuItem<int>(
                              value: 2,
                              child: Text(
                                "Copy Code",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                          onSelected: (value) {
                            switch (value) {
                              case 1:
                                delKaksha(context);
                                break;
                              case 2:
                                Clipboard.setData(ClipboardData(text: kakshaCode));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Kaksha code copied to clipboard!'),
                                    backgroundColor: Colors.blue,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                break;

                            }
                          },
                        ),
                      ),
                    
                    ],
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
