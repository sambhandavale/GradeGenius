import 'package:flutter/material.dart';
import 'package:gradegenius/components/shared/button.dart';

class CreateCardFeature extends StatelessWidget {
  final String imagePath;
  final String topText;
  final String bottomText;
  final String buttonText;
  final double height;
  final VoidCallback onPressed;
  final Color bgColor;

  final double? imageTop;
  final double? imageBottom;
  final double? imageLeft;
  final double? imageRight;
  final double imageWidth;
  final double imageHeight;
  final bool wantImg;

  final double? ttFontSize;
  final double? btFontSize;
  final double? ttbtGap;

  const CreateCardFeature({
    super.key,
    required this.imagePath,
    required this.topText,
    required this.bottomText,
    required this.buttonText,
    this.height = 230,
    required this.onPressed,
    this.bgColor = const Color(0xFFFFEB3B),
    this.imageTop = -50,
    this.imageBottom,
    this.imageLeft = 100,
    this.imageRight,
    this.imageWidth = 400,
    this.imageHeight = 400,
    this.wantImg = true,
    this.ttFontSize = 28,
    this.btFontSize = 44,
    this.ttbtGap = 0,
  });

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
            if (wantImg)
              Positioned(
                top: imageTop,
                bottom: imageBottom,
                left: imageLeft,
                right: imageRight,
                child: Image.asset(
                  imagePath,
                  width: imageWidth,
                  height: imageHeight,
                  fit: BoxFit.contain,
                ),
              ),
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
                      // Container(
                      //   padding: const EdgeInsets.symmetric(vertical: 6),
                      //   decoration: BoxDecoration(
                      //     color: Colors.black,
                      //     borderRadius: BorderRadius.circular(40),
                      //   ),
                      //   child: IconButton(
                      //     icon: const Icon(Icons.more_vert),
                      //     color: Colors.white,
                      //     iconSize: 32,
                      //     onPressed: () {
                      //       // Your action here
                      //     },
                      //   ),
                      // ),
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
