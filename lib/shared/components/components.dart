
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:team1/shared/network/cache_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
    );

PreferredSizeWidget defaultAppBar ()=> AppBar(
  systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light
  ),
  backgroundColor: Colors.transparent,
  elevation: 0,
);

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
  Function? suffixPressed,  TextStyle? style,}) {
  return TextFormField(
    focusNode: focusNode,
      textAlignVertical: TextAlignVertical.center,
      style: GoogleFonts.roboto(
        fontStyle: FontStyle.normal,
        color:  Colors.black,
        fontSize: 17,
        fontWeight: FontWeight.w400,
        height: 0.9
      ),
      cursorHeight: 25,
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
      color: Colors.grey,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
            color:  Colors.grey,
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
        errorBorder: const OutlineInputBorder(
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
      ),
    );
}



void showToast({
  required String text,
  required ToastStates state,}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 10,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );
}

// enum  كذا اختيار من حاجة
enum ToastStates { success, error, waring }
Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;

    case ToastStates.error:
      color = Colors.red;
      break;

    case ToastStates.waring:
      color = Colors.amber;
      break;
  }
  return color;
}

void navigateTo(context, widget) {
  Navigator.push(
      context,
      Routing().createRoute(widget));
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
      context,
      Routing().createRoute(widget), (route) {
    return false;
  });
}

class Routing{
  Route createRoute(widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>  widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.1, 0.0);
        const end = Offset.zero;
        const curve = Curves.bounceIn;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
            position: animation.drive(tween),
            child: child
        );
      },
    );
  }
}


void logOut(context) {
  CacheHelper.removeData(
    key: 'uId',
  ).then((value) {
    if (value) {
     // navigateAndFinish(context,  const LoginScreen());
    }
  });
}

void pop(context) {
  Navigator.pop(context);
}


// Widget imagePreview(){
//   return FullScreenWidget(
//     child: Center(
//       child: Image.network(
//         "$image",
//         fit: BoxFit.cover,
//         width: double.infinity,
//         alignment: AlignmentDirectional.topCenter,
//       ),
//     ),
//   );
// }


Widget baseAlertDialog({
  required context,
  String? title,
  String? content,
  String? outlinedButtonText,
  String? elevatedButtonText,
  IconData? elevatedButtonIcon,
}){
  return AlertDialog(
    backgroundColor:Colors.red,
    title: Text('$title',style: const TextStyle(color: Colors.red),),
    titlePadding: const EdgeInsetsDirectional.only(start:13,top: 15 ),
    content: Text('$content',style: const TextStyle(color: Colors.grey,),),
    elevation: 8,
    contentPadding: const EdgeInsets.all(15),
    actions: [
      OutlinedButton(
          onPressed: (){
            Navigator.of(context).pop(false);
          },
          child: Text('$outlinedButtonText')
      ),
      SizedBox(
        width: 115,
        child: ElevatedButton(
          style:ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.blueAccent)) ,
          onPressed: (){
            Navigator.of(context).pop(true);
          },
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(elevatedButtonIcon),
              const SizedBox(width: 5,),
              Text('$elevatedButtonText',style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    ],

  );
}

Widget searchBar({
  required context,
  bool readOnly = true,
  double height = 40,
  double width = double.infinity,

}){
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    height: height,
    width: width,
    child: TextFormField(
      readOnly: readOnly,
      style: const TextStyle(color: Colors.grey),
      // onTap: () => navigateTo(context, SearchScreen()),
      decoration: InputDecoration(
        border: OutlineInputBorder( borderRadius: BorderRadius.circular(15)),
        filled: true,
        // fillColor: SocialCubit.get(context).unreadMessage,
        disabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(15)),
        hintText: 'LocaleKeys.search.tr()',
        hintStyle: const TextStyle(fontSize: 15,color: Colors.grey),
        prefixIcon: const Icon(Icons.search,color: Colors.grey,),
      ),
    ),
  );
}

Widget space(double width, double height) {
  return SizedBox(
    width: width,
    height: height,
  );
}


String daysBetween(DateTime postDate){
  if  ((DateTime.now().difference(postDate).inHours / 24).round() == 0)
  {
    if(DateTime.now().difference(postDate).inHours == 0 ) {
      if(DateTime.now().difference(postDate).inMinutes == 0) {
        return 'now';
      }
      else {
        return '${DateTime.now().difference(postDate).inMinutes.toString()} minutes';
      }
    }
    else {
      return '${DateTime.now().difference(postDate).inHours.toString()} hours';
    }
  } else {
    return (' ${(DateTime.now().difference(postDate).inHours / 24).round().toString()} days');
  }


}
String getDate () {
  DateTime dateTime =  DateTime.now();
  String date =  DateFormat.yMMMd().format(dateTime);
  return date;
}
String getNowDateTime (Timestamp dateTime) {
  String date =DateFormat.yMd().format(dateTime.toDate()).toString();
  String time = DateFormat.Hm().format(dateTime.toDate()).toString();
  List<String> nowSeparated = [date,time];
  String nowJoined = nowSeparated.join(' at ');
  return nowJoined;
}
String time = DateTime.now().toString().split(' ').elementAt(1);

class SizeConfig {
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    orientation = MediaQuery.of(context).orientation;

    defaultSize = orientation == Orientation.landscape
        ? screenHeight! * .024
        : screenWidth! * .024;

    debugPrint('this is the default size $defaultSize');
    debugPrint('this is the screenHeight  $screenHeight');
    debugPrint('this is the screenWidth $screenWidth');
  }


}
