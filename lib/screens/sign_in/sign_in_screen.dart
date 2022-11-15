import 'package:TRIPSO/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:TRIPSO/shared/styles/colors.dart';
import '../../shared/animation/fade_animation.dart';
import '../../shared/components/app_bar.dart';
import '../../shared/components/buttons.dart';
import '../../shared/constants/constants.dart';
import '../../shared/components/navigator.dart';
import '../../shared/components/scrollable_form.dart';
import '../../shared/components/show_toast.dart';
import '../../shared/components/sized_box.dart';
import '../../shared/components/text_form_field.dart';
import '../../shared/cubit/SignInCubit/sign_in_cubit.dart';
import '../../shared/cubit/SignInCubit/sign_in_state.dart';
import '../../shared/network/cache_helper.dart';
import '../../shared/styles/styles.dart';
import '../password/forget_password_screen.dart';
import '../sign_up/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
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
              child: FadeAnimation(1.5,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: defaultAppBar(),
                  body: customScrollableForm(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            space(width: 0 ,height: 240),
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
                                  space(width: 0 ,height: 8),
                                  defaultTextFormField(
                                    color: Colors.white30,
                                    context: context,
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Email Address is Required';
                                      }
                                      return null;
                                    },
                                    hint: 'Email Address',
                                    prefix: Icons.alternate_email,
                                  ),
                                  space(width: 0 ,height: 26),
                                  const Text(
                                    'Password',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  space(width: 0 ,height: 8),
                                  defaultTextFormField(
                                    color: Colors.white30,
                                    context: context,
                                    controller: passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Password is Required';
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
                            space(width: 0 ,height: 17),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      navigateTo(
                                          context,  const ForgotPassword());
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
                            space(width: 0 ,height: 104),
                            Center(
                              child: defaultMaterialButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    SignInCubit.get(context).userSignIn(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                    navigateAndFinish(context,
                                        const HomeScreen());
                                  }
                                },
                                text: 'Sign in',
                                color: primaryColor,
                              ),
                            ),
                            space(width: 0 ,height: 28),
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
                          ],
                        ),
                      ),
                    ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
