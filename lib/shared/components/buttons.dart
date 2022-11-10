import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget defaultMaterialButton({
  required Function() function,
  required String text,
  double width = 290,
  double height = 43.0,
  double radius = 10.0,
  bool isUpperCase = false,
  Color? color,
  Function? onTap,
}) => Container(
  width: width,
  height: height,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(
      radius,
    ),
    color: color,
  ),
  child: MaterialButton(

    clipBehavior : Clip.antiAliasWithSaveLayer,
    height: 22,
    minWidth: 59,
    onPressed: function,
    // color: color,
    child: FittedBox(
      child: Text(
        textAlign : TextAlign.center,
        isUpperCase ? text.toUpperCase() : text,
        style: GoogleFonts.roboto(
          fontSize: 19,
          color: const Color(0xffFFFFFF),
          fontWeight: FontWeight.w500,

        ),
      ),
    ),
  ),
);
