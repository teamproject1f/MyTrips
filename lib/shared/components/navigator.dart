import 'package:flutter/material.dart';


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

void pop(context) {
  Navigator.pop(context);
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


