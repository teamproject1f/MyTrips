
import 'package:flutter/material.dart';
import 'package:team1/shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/styles.dart';
import 'package:google_fonts/google_fonts.dart';


class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: onBoardImage,
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            appBar: defaultAppBar(),
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 1),
                  welcomeText(),
                  space(0, 60),
                  button(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget button ()=> Center(
    child: Column(
      children: [

        defaultMaterialButton(
          function: ()
          {
            // navigateTo(context, widget);
          },
          text: 'Sign in',
          color:defaultColor,
        ),
        space(0, 26),

        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: defaultMaterialButton(
            function: (){},
            text: 'Sign up',
            color:defaultColor.withOpacity(0.30),
          ),
        ),
        //  space(0, 50),
      ],
    ),
  );

  Widget welcomeText()=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'BE\nREADY',
        style: GoogleFonts.roboto(
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 40,
            height: 1.3,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Row(
        children:
        [
          Text(
            'TO',
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                height: 1.3,
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Text(
            'UR',
            style: GoogleFonts.roboto(
              textStyle:  const TextStyle(
                height: 1.3,
                color: Color(0xff60D0E6),
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),


        ],
      ),
      Text(
        'NEXT',
        style: GoogleFonts.roboto(
          textStyle:  const TextStyle(
            height: 1.3,
            color:Color(0xff60D0E6),
            fontSize: 40,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Text(
        'ADVENTURE',
        style: GoogleFonts.roboto(
          textStyle:  const TextStyle(
            height: 1.3,
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  ) ;
}
