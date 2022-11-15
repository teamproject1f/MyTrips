import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/animation/fade_animation.dart';
import '../../shared/components/buttons.dart';
import '../../shared/components/navigator.dart';
import '../../shared/components/sized_box.dart';
import '../../shared/components/text_form_field.dart';
import '../../shared/cubit/SignUpCubit/sign_up_cubit.dart';
import '../../shared/cubit/SignUpCubit/sign_up_state.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/styles.dart';
import 'auth.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  var passController = TextEditingController();
  var confirmPassController = TextEditingController();
  var updateFormKey = GlobalKey<FormState>();

  Future<void> _submit(String newPassword) async {
    await AuthServices().changePassword(newPassword);
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
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
                    passController.clear();
                    confirmPassController.clear();
                    pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                titleSpacing: 1,
                title: Text(
                  'New Password',
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
                key: updateFormKey,
                child: CustomScrollView(slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        space(width: 0, height: 50),
                        FittedBox(
                          child: Text(
                            'Create New Password?',
                            style: GoogleFonts.roboto(
                                color: primaryColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        space(width: 0, height: 10),
                        FittedBox(
                          child: Text(
                            'Your new password must be different\n'
                            '         from previous used password',
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ),
                        const FadeAnimation(
                          1.0,
                          child: Image(
                              height: 300,
                              image: AssetImage(AssetPath.changePasswordImage)),
                        ),
                        space(width: 0, height: 60),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Column(
                            children: [
                              defaultTextFormField(
                                color: const Color(0xff938E8E).withOpacity(0.3),
                                context: context,
                                controller: passController,
                                keyboardType: TextInputType.visiblePassword,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password is Required';
                                  }
                                  return null;
                                },
                                prefix: Icons.lock_outline_sharp,
                                suffix: SignUpCubit.get(context).suffix,
                                isPassword: SignUpCubit.get(context).isPassword,
                                suffixPressed: () {
                                  SignUpCubit.get(context).showPassword();
                                },
                                hint: 'Password',
                              ),
                              space(width: 0, height: 30),
                              defaultTextFormField(
                                color: const Color(0xff938E8E).withOpacity(0.3),
                                context: context,
                                controller: confirmPassController,
                                keyboardType: TextInputType.visiblePassword,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Confirm New Password is Required';
                                  }
                                  return null;
                                },
                                prefix: Icons.lock_outline_sharp,
                                suffix: SignUpCubit.get(context).suffix,
                                isPassword: SignUpCubit.get(context).isPassword,
                                suffixPressed: () {
                                  SignUpCubit.get(context).showPassword();
                                },
                                hint: 'Confirm New Password',
                              )
                            ],
                          ),
                        ),
                        space(width: 0, height: 50),
                        isLoading
                            ? const CircularProgressIndicator()
                            : defaultButton(
                                color: primaryColor,
                                widget: Text(
                                  'Reset Password',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    fontSize: 19,
                                    color: const Color(0xffFFFFFF),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                function: () {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  passController.text ==
                                          confirmPassController.text
                                      ? _submit(passController.text)
                                      : debugPrint("failed");
                                  setState(() {
                                    isLoading = false;
                                  });
                                  pop(context);
                                },
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
