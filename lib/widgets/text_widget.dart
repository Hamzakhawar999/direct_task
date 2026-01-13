
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


enum AppFont {
  sans,        // default → Plus Jakarta Sans
  montserrat,
  poppins,}

class TextWidget extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final double? letterSpacing;
  final double? height;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final AppFont font;

  const TextWidget(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.letterSpacing,
    this.height,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.font = AppFont.sans,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle = font == AppFont.montserrat
        ? GoogleFonts.montserrat()
        : font == AppFont.poppins
            ? GoogleFonts.poppins()
            : GoogleFonts.plusJakartaSans();

    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign ?? TextAlign.start,
      style: baseStyle.copyWith(
        fontSize: fontSize ?? 16.sp,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? const Color(0xFF222222),
        height: height,
        letterSpacing: letterSpacing,
        decoration: TextDecoration.none,
      ),
    );
  }
}