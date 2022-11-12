import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget defaultTextFormField({
  FocusNode? focusNode,
  Color? color,
  required BuildContext context,
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String? Function(String?) validate,
  required String? hint,
  onTap,
  onChanged,
  Function(String)? onFieldSubmitted,
  bool isPassword = false,
  bool isClickable = true,
  InputDecoration? decoration,
  IconData? suffix,
  IconData? prefix,
  Function? suffixPressed,
  TextStyle? style,
}) {
  return TextFormField(
    focusNode: focusNode,
    textAlignVertical: TextAlignVertical.center,
    style: GoogleFonts.roboto(
      fontStyle: FontStyle.normal,
      color:  Colors.white,
      fontSize: 17,
      fontWeight: FontWeight.w400,
    ),
    maxLines: 1,
    minLines: 1,
    controller: controller,
    validator: validate,
    enabled: isClickable,
    onTap: onTap,
    onFieldSubmitted: onFieldSubmitted,
    onChanged: onChanged,
    obscureText: isPassword,
    keyboardType: keyboardType,
    autofocus: false,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.zero,
      fillColor: color,
      filled: true,
      prefixIcon: Icon(
        prefix,
        color: Colors.white,
      ),
      suffixIcon: suffix != null
          ? IconButton(
        onPressed: () {
          suffixPressed!();
        },
        icon: Icon(
          suffix,
          color:  Colors.white,
        ),
      ) : null,
      focusedBorder:  const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        borderSide: BorderSide(
          color:  Colors.white,
        ),
      ),
      hintText: hint,
      hintStyle:  TextStyle(
        color:  Colors.white.withOpacity(0.8),
        height: 1,
      ),
      enabledBorder:  const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        borderSide: BorderSide(
          color:  Colors.white,
        ),
      ),
      errorBorder:  const OutlineInputBorder(

        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder:  const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      errorStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16
      ),
    ),
  );
}
