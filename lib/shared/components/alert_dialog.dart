import 'package:flutter/material.dart';

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