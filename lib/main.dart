import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:team1/screens/on_boarding/on_boarding_screen.dart';
import 'package:team1/screens/splash/splash_screen.dart';
import 'package:team1/shared/bloc_observer.dart';
import 'package:team1/shared/components/constants.dart';

import 'layout/home_layout.dart';
import 'shared/network/cache_helper.dart';

void main()async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();

  Widget widget;
  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget =  const HomeLayout();
  } else {
    widget = const OnBoard();
  }
  runApp( MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {

  final  Widget startWidget;
  const MyApp({super.key,required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }

}


