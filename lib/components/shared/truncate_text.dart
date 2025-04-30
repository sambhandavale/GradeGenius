import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String title;
  final int maxLength;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;
  final String fontFamily;
  final double lineHeight;

  const ExpandableText({
    super.key,
    required this.title,
    this.maxLength = 20,
    this.fontSize = 24,
    this.fontColor = Colors.black,
    this.fontWeight = FontWeight.w400,
    this.fontFamily = 'GoogleSans',
    this.lineHeight = 1,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final shouldTruncate = widget.title.length > widget.maxLength;
    final displayText = shouldTruncate && !isExpanded
        ? '${widget.title.substring(0, widget.maxLength)}...'
        : widget.title;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayText,
          style: TextStyle(
            fontSize: widget.fontSize,
            color: widget.fontColor,
            fontWeight: widget.fontWeight,
            fontFamily: widget.fontFamily,
            height: widget.lineHeight,
          ),
        ),
        if (shouldTruncate)
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                isExpanded ? 'less' : 'more',
                style: TextStyle(
                  fontSize: widget.fontSize * 0.66,
                  color: const Color.fromARGB(255, 24, 24, 24),
                  fontWeight: widget.fontWeight,
                  fontFamily: widget.fontFamily,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
