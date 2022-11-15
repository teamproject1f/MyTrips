import 'package:TRIPSO/screens/password/update_password_screen.dart';
import 'package:TRIPSO/shared/components/buttons.dart';
import 'package:TRIPSO/shared/components/sized_box.dart';
import 'package:TRIPSO/shared/components/text_form_field.dart';
import 'package:TRIPSO/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../shared/animation/fade_animation.dart';
import '../../shared/components/navigator.dart';
import '../../shared/cubit/restPasswordCubit/rest_password_cubit.dart';
import '../../shared/cubit/restPasswordCubit/rest_password_state.dart';
import '../../shared/styles/styles.dart';

enum AuthMode { forgot, verify }

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword>  createState() => _ForgotPasswordState();

}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool submitValid = false;
  AuthMode _authMode = AuthMode.forgot;
  var otpController = TextEditingController();
  var emailController = TextEditingController();
  var forgetFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void verify() {
    EmailAuth.validate(
        receiverMail: emailController.value.text,
        userOTP: otpController.value.text);
  }

  void sendOtp() async {
    EmailAuth.sessionName = "Company Name";
    bool result =
        await EmailAuth.sendOtp(receiverMail: emailController.value.text);
    if (result) {
      setState(() {
        submitValid = true;
      });
    }
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.forgot) {
      setState(() {
        _authMode = AuthMode.verify;
      });
    } else {
      setState(() {
        _authMode = AuthMode.forgot;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordStates>(
          listener: (context, state) {},
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
                actions: [
                  if (_authMode == AuthMode.verify)
                    TextButton(
                      onPressed: sendOtp,
                      child: Text(
                        'Resend Code',
                        style: GoogleFonts.roboto(
                          fontSize: 17,
                          letterSpacing: 1,
                          shadows: [
                            const Shadow(
                                color: Colors.black, offset: Offset(0, -5))
                          ],
                          color: Colors.transparent,
                          decoration: TextDecoration.underline,
                          decorationColor: primaryColor,
                          decorationThickness: 2,
                          decorationStyle: TextDecorationStyle.dashed,
                        ),
                      ),
                    ),
                ],
              ),
              body: Form(
                key: forgetFormKey,
                child: CustomScrollView(slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        space(width: 0, height: 50),
                        FittedBox(
                          child: Text(
                            _authMode == AuthMode.forgot
                                ? 'Forgot Your Password?'
                                : 'Verify Your Email',
                            style: GoogleFonts.roboto(
                                color: primaryColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        space(width: 0, height: 10),
                        FittedBox(
                          child: Text(
                            _authMode == AuthMode.forgot
                                ? 'Enter the Email address associated with'
                                : 'Please enter the 6 digit code sent to',
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            _authMode == AuthMode.forgot
                                ? 'your account'
                                : emailController.text,
                            style: GoogleFonts.roboto(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        const FadeAnimation(
                          1.0,
                          child: Image(

                              image: AssetImage(AssetPath.resetPasswordImage)),
                        ),
                        space(width: 0, height: 10),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 50.0),
                            child: _authMode == AuthMode.forgot
                                ? defaultTextFormField(
                                    color: const Color(0xff938E8E)
                                        .withOpacity(0.3),
                                    context: context,
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    prefix: Icons.alternate_email,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Email is Required';
                                      }
                                      return null;
                                    },
                                    hint: 'E-mail Address',
                                  )
                                : (submitValid)
                                    ? PinCodeTextField(
                              appContext: context,
                              pastedTextStyle: TextStyle(
                                color: const Color(0xff938E8E)
                                    .withOpacity(0.5),
                                fontWeight: FontWeight.bold,
                              ),
                              length: 6,
                              obscureText: true,
                              obscuringCharacter: '*',
                              obscuringWidget: const FlutterLogo(
                                size: 24,
                              ),
                              blinkWhenObscuring: true,
                              animationType: AnimationType.fade,
                              validator: (value) {
                                if (value!.length < 6) {
                                  return 'Digit Code is Required';
                                }
                                return null;
                              },
                              pinTheme: PinTheme(
                                activeColor: secondaryColor,
                                selectedColor: primaryColor,
                                inactiveColor: Colors.grey,
                                disabledColor: Colors.yellow,
                                activeFillColor: secondaryColor,
                                selectedFillColor: secondaryColor,
                                inactiveFillColor: secondaryColor,
                                errorBorderColor: Colors.redAccent,
                                shape: PinCodeFieldShape.circle,
                                borderRadius:
                                BorderRadius.circular(5),
                                fieldHeight: 50,
                                fieldWidth: 40,
                              ),
                              cursorColor: Colors.black,
                              animationDuration:
                              const Duration(milliseconds: 300),
                              enableActiveFill: true,
                              // errorAnimationController: errorController,
                              controller: otpController,
                              keyboardType: TextInputType.number,
                              boxShadows: const [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  color: Colors.black12,
                                  blurRadius: 10,
                                )
                              ],
                              onCompleted: (v) {
                                debugPrint("Completed");
                              },
                              // onTap: () {
                              //   print("Pressed");
                              // },
                              onChanged: (value) {
                                debugPrint(value);
                              },
                              beforeTextPaste: (text) {
                                debugPrint("Allowing to paste $text");
                                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                return true;
                              },
                            )
                                    : PinCodeTextField(
                                        appContext: context,
                                        pastedTextStyle: TextStyle(
                                          color: const Color(0xff938E8E)
                                              .withOpacity(0.5),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        length: 6,
                                        obscureText: true,
                                        obscuringCharacter: '*',
                                        obscuringWidget: const FlutterLogo(
                                          size: 24,
                                        ),
                                        blinkWhenObscuring: true,
                                        animationType: AnimationType.fade,
                                        validator: (value) {
                                          if (value!.length < 6) {
                                            return 'Digit Code is Required';
                                          }
                                          return null;
                                        },
                                        pinTheme: PinTheme(
                                          activeColor: secondaryColor,
                                          selectedColor: primaryColor,
                                          inactiveColor: Colors.grey,
                                          disabledColor: Colors.yellow,
                                          activeFillColor: secondaryColor,
                                          selectedFillColor: secondaryColor,
                                          inactiveFillColor: secondaryColor,
                                          errorBorderColor: Colors.redAccent,
                                          shape: PinCodeFieldShape.circle,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          fieldHeight: 50,
                                          fieldWidth: 40,
                                        ),
                                        cursorColor: Colors.black,
                                        animationDuration:
                                            const Duration(milliseconds: 300),
                                        enableActiveFill: true,
                                        // errorAnimationController: errorController,
                                        controller: otpController,
                                        keyboardType: TextInputType.number,
                                        boxShadows: const [
                                          BoxShadow(
                                            offset: Offset(0, 1),
                                            color: Colors.black12,
                                            blurRadius: 10,
                                          )
                                        ],
                                        onCompleted: (v) {
                                          debugPrint("Completed");
                                        },
                                        onChanged: (value) {
                                          debugPrint(value);
                                        },
                                        beforeTextPaste: (text) {
                                          debugPrint("Allowing to paste $text");
                                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                          return true;
                                        },
                                      ),
                        ),
                        space(width: 0, height: 50),
                        defaultButton(
                          function: () {
                            if (forgetFormKey.currentState!.validate()) {
                              ResetPasswordCubit.get(context).resetPassword(
                                email: emailController.text,
                              );
                              if (_authMode == AuthMode.forgot) {
                                sendOtp();
                                _switchAuthMode();
                              } else {
                                verify();
                                otpController.clear();
                                pop(context);
                                navigateTo(context, const UpdatePassword());
                              }
                            }
                          },
                          widget: Text(
                            _authMode == AuthMode.forgot
                                ? 'Verify Email'
                                : 'Confirm',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 19,
                              color: const Color(0xffFFFFFF),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          color: primaryColor,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            );
          }),
    );
  }
}
