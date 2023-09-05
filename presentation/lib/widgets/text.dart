import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final FontWeight fontWeight;
  final bool isTextUpperCase;
  final TextAlign textAlign;
  final double fontSize;
  final Color color;
  final String text;
  final String fontFamily;
  final TextOverflow textOverflow;
  final int? maxLines;
  final double? height;
  final double? letterSpacing;

  const TextWidget(
      {Key? key,
      required this.text,
      this.textAlign = TextAlign.start,
      this.fontSize = 14,
      this.color = Colors.black,
      this.isTextUpperCase = false,
      this.fontWeight = FontWeight.normal,
      this.fontFamily = 'Roboto',
      this.textOverflow = TextOverflow.clip,
      this.maxLines = 2,
      this.height,
      this.letterSpacing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      isTextUpperCase ? text.toUpperCase() : text,
      textAlign: textAlign,
      overflow: textOverflow,
      maxLines: maxLines,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          height: height,
          letterSpacing: letterSpacing),
    );
  }
}
