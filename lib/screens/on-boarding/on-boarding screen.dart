import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:team1/shared/componnetns/components.dart';
import 'package:team1/shared/styles/colors.dart';
import '../../shared/styles/styles.dart';

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
                  const Spacer(
                    flex: 1,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BE\nREADY',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            overflow: TextOverflow.visible,
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
                                color: Colors.white,
                                fontSize: 36,
                                overflow: TextOverflow.visible,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            'UR',
                            style: GoogleFonts.roboto(
                              textStyle:  TextStyle(
                                color: HexColor('#60D0E6'),
                                fontSize: 36,
                                overflow: TextOverflow.visible,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                        ],
                      ),
                      Text(
                        'NEXT',
                        style: GoogleFonts.roboto(
                          textStyle:  TextStyle(
                            color: HexColor('#60D0E6'),
                            fontSize: 36,
                            overflow: TextOverflow.visible,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        'ADVENTURE',
                        style: GoogleFonts.roboto(
                          textStyle:  const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            overflow: TextOverflow.visible,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                    ],
                  ),

                  space(0, 60),
                  Center(
                    child: Column(
                      children: [
                        defaultMaterialButton(
                            function: (){},
                            text: 'Sign in',
                            color:defaultColor,
                        ),
                        space(0, 20),
                        defaultMaterialButton(
                            function: (){},
                            text: 'Sign up',
                            color:defaultColor.withOpacity(0.30),
                        ),
                        //  space(0, 50),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
