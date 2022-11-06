import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:team1/screens/on_boarding/on_boarding_screen.dart';
import 'package:team1/shared/styles/colors.dart';
import 'package:team1/shared/styles/styles.dart';

import '../../layout/home_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SplashScreenBody(),
    );
  }
}

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({Key? key}) : super(key: key);


  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? fadingAnimation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    fadingAnimation =
        Tween<double>(begin: 0.2, end: 1).animate(animationController!);

    animationController?.repeat(reverse: true);

    goToNextView();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
        children: [
      Image.asset(splashImage),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeTransition(
            opacity: fadingAnimation!,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TRI',
                  style: GoogleFonts.pacifico(
                    textStyle: const TextStyle(
                      color: defaultColor,
                      fontSize: 45,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  'PSO',
                  style: GoogleFonts.pacifico(
                    textStyle: const TextStyle(
                      color: defaultWhiteColor,
                      fontSize: 45,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    ]);
  }

  void goToNextView() {
    Widget widget;
    Future.delayed(const Duration(seconds: 6), () {
      if (uId != null) {
        widget =  const HomeLayout();
      }else {
        widget = const OnBoard();
      }
      navigateAndFinish(context,widget);
    });
  }
}
