import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String iconPath;
  final Color backgroundColor;
  final Color textColor;
  final double iconSize;
  final double fontSize;
  final double? width;

  const IconTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.iconPath,
    this.backgroundColor = const Color(0xFF76BC7B),
    this.textColor = Colors.white,
    this.iconSize = 28,
    this.fontSize = 18,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: width == null ? MainAxisSize.min : MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
                fontFamily: 'GoogleSans',
              ),
            ),
            const SizedBox(width: 10),
            SvgPicture.asset(
              iconPath,
              width: iconSize,
              height: iconSize,
            ),
          ],
        ),
      ),
    );
  }
}
