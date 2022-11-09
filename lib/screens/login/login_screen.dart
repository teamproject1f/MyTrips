import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team1/shared/components/components.dart';
import 'package:team1/shared/styles/colors.dart';
import '../../shared/components/constants.dart';
import '../../shared/cubit/SignInCubit/cubit.dart';
import '../../shared/cubit/SignInCubit/state.dart';
import '../../shared/network/cache_helper.dart';
import '../../shared/styles/styles.dart';
import '../password/forget_Password.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child:
            BlocConsumer<LoginCubit, LoginStates>(listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.saveData(value: state.uid, key: 'uId').then((value) {
              uId = state.uid;
            });
          } else if (state is LoginErrorState) {
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
                                    color: defaultColor,
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
                              LoginCubit.get(context)
                                  .userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            },
                            text: 'Sign in',
                            color: defaultColor,
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
                                  color: defaultColor,
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
