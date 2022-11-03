import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:team1/shared/styles/colors.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/restPasswordCubit/rest_password_cubit.dart';
import '../../shared/cubit/restPasswordCubit/rest_password_state.dart';
import '../../shared/styles/styles.dart';

class RestPasswordScreen extends StatelessWidget {
  const RestPasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var loginFormKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordStates>(
        listener: (context, state) {
          if (state is ResetPasswordSuccessState) {
            //  navigateAndFinish(context, const LoginScreen());
          }
        },
        builder: (context, state) {
          //  var cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.dark,
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark),
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  emailController.clear();
                  pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              titleSpacing: 1,
              title: Text(
                'Reset Password',
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            body: Form(
              key: loginFormKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20,top: 20),
                      child: Text(
                        'Enter the E-mail address\nassociated with your account',
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),

                    const Image(image: resetPasswordImage),
                    space(0, 10),
                    Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50.0),
                            child: defaultTextFormField(
                              color: const Color(0xff938E8E).withOpacity(0.3),
                              context: context,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              prefix: Icons.alternate_email,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Your E-mail';
                                }
                                return null;
                              },
                              hint: 'E-mail Address',
                            ),
                          ),
                          space(0, 60),
                          state is ResetPasswordLoadingState
                              ? Container(
                              width: 290,
                              height: 43,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: defaultColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Check Your Mail',
                                    style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red,
                                    ),
                                  ),
                                  space(10, 0),
                                  const Icon(Icons.warning),
                                ],
                              ),
                                )
                              : defaultMaterialButton(
                                  color: defaultColor,
                                  text: 'Reset Password',
                                  function: () {
                                    if (loginFormKey.currentState!.validate()) {
                                      ResetPasswordCubit.get(context)
                                          .resetPassword(
                                        email: emailController.text,
                                      );
                                    }
                                  },
                                ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
