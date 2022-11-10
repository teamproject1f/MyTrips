import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:TRIPSO/shared/styles/colors.dart';
import '../../shared/components/app_bar.dart';
import '../../shared/components/buttons.dart';
import '../../shared/components/constants.dart';
import '../../shared/components/navigator.dart';
import '../../shared/components/show_toast.dart';
import '../../shared/components/sized_box.dart';
import '../../shared/components/text_form_field.dart';
import '../../shared/cubit/SignInCubit/sign_in_cubit.dart';
import '../../shared/cubit/SignInCubit/sign_in_state.dart';
import '../../shared/network/cache_helper.dart';
import '../../shared/styles/styles.dart';
import '../password/forget_password.dart';
import '../register/register_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
        create: (BuildContext context) => SignInCubit(),
        child:
            BlocConsumer<SignInCubit, SignInStates>(listener: (context, state) {
          if (state is SignInSuccessState) {
            CacheHelper.saveData(value: state.uid, key: 'uId').then((value) {
              uId = state.uid;
            });
          } else if (state is SignInErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.error,
            );
          }
        }, builder: (context, state) {
          return Stack(
            children: [
              Container(
                constraints: const BoxConstraints.expand(),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetPath.signINImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: defaultAppBar(),
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        space(0, 240),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Email Address',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              space(0, 8),
                              defaultTextFormField(
                                color: Colors.white30,
                                context: context,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    'please Enter Your Email Address';
                                  }
                                  return null;
                                },
                                hint: 'Email Address',
                                prefix: Icons.alternate_email,
                              ),
                              space(0, 26),
                              const Text(
                                'Password',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              space(0, 8),
                              defaultTextFormField(
                                color: Colors.white30,
                                context: context,
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    'please Enter Your Password';
                                  }
                                  return null;
                                },
                                prefix: Icons.lock_outline_sharp,
                                suffix: SignInCubit.get(context).suffix,
                                isPassword: SignInCubit.get(context).isPassword,
                                suffixPressed: () {
                                  SignInCubit.get(context).showPassword();
                                },
                                hint: 'Enter Password',
                              ),
                            ],
                          ),
                        ),
                        space(0, 17),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  navigateTo(
                                      context, const RestPasswordScreen());
                                },
                                child: const Text(
                                  'Forgot Password ?',
                                  style: TextStyle(
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        space(0, 104),
                        Center(
                          child: defaultMaterialButton(
                            function: () {
                              SignInCubit.get(context).userSignIn(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            },
                            text: 'Sign in',
                            color: primaryColor,
                          ),
                        ),
                        space(0, 28),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                // navigateAndFinish(context, const RegisterScreen());
                                navigateTo(context, const RegisterScreen());
                              },
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        space(0, 79),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }));
  }
}
