import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:TRIPSO/shared/styles/colors.dart';
import '../../shared/components/buttons.dart';
import '../../shared/components/navigator.dart';
import '../../shared/components/sized_box.dart';
import '../../shared/components/text_form_field.dart';
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
          if (state is ResetPasswordLoadingState) {
            Alert(
              style: AlertStyle(
                animationType: AnimationType.grow,
                animationDuration: const Duration(milliseconds: 1500),
                backgroundColor: secondaryColor,
                isCloseButton: false,
                descStyle: GoogleFonts.roboto(
                  color: Colors.green,
                    fontSize: 24,
                    fontWeight: FontWeight.w700
                ),
              ),
           //   padding: EdgeInsets.zero,
              image: const Image(
                    image: AssetImage(AssetPath.warningImage) ,
                height: 200,
                width: 300,
                fit: BoxFit.cover,

                  ),
              context: context,
              desc: "Check your mail",
              buttons: [

                DialogButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: primaryColor,
                  child: Text(
                    "Done",

                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                )
              ],
            ).show();
          }
          if (state is ResetPasswordSuccessState) {
            //  navigateAndFinish(context, const LoginScreen());
          }
        },
        builder: (context, state) {
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
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        'Please enter your e-mail and we will email you a link to reset your password.',
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                    const Image(image:  AssetImage(AssetPath.resetPasswordImage)),
                    space(0, 10),
                    Center(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 50.0),
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
                          defaultMaterialButton(
                            color: primaryColor,
                            text: 'Reset Password',
                            function: () {
                              if (loginFormKey.currentState!.validate()) {
                                ResetPasswordCubit.get(context).resetPassword(
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
