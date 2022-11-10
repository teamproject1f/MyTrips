import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../styles/colors.dart';

Future<bool?> alertDialog({
  required context,
  required Color color,
  required String image,
  required String title,
  required String text,
}){
  return Alert(
    style: AlertStyle(
      animationType: AnimationType.grow,
      animationDuration: const Duration(milliseconds: 1500),
      backgroundColor: secondaryColor,
      isCloseButton: false,
      descStyle: GoogleFonts.roboto(
          color: color,
          fontSize: 24,
          fontWeight: FontWeight.w700),
    ),
    //   padding: EdgeInsets.zero,
    image:   Image(
      image: AssetImage(image),
      height: 200,
      width: 300,
      fit: BoxFit.cover,
    ),
    context: context,
    desc: title,
    buttons: [
      DialogButton(
        onPressed: () {
          Navigator.pop(context);
        },
        color: primaryColor,
        child: Text(
          text,
          style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700),
        ),
      )
    ],
  ).show();
}