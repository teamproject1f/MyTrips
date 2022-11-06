import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:team1/screens/splash/splash_screen.dart';
import 'package:team1/shared/bloc_observer.dart';
import 'package:team1/shared/components/constants.dart';
import 'shared/network/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();

  uId = CacheHelper.getData(key: 'uId');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
