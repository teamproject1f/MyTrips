import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:TRIPSO/screens/home/home_screen.dart';
import 'package:TRIPSO/shared/styles/styles.dart';
import '../../shared/components/app_bar.dart';
import '../../shared/components/buttons.dart';
import '../../shared/components/constants.dart';
 import '../../shared/components/navigator.dart';
import '../../shared/components/show_toast.dart';
import '../../shared/components/sized_box.dart';
import '../../shared/components/text_form_field.dart';
import '../../shared/cubit/SignUpCubit/sign_up_cubit.dart';
import '../../shared/cubit/SignUpCubit/sign_up_state.dart';
import '../../shared/network/cache_helper.dart';
import '../../shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var firstnameController = TextEditingController();
    var lastnameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
        create: (BuildContext context) => SignUpCubit(),
        child: BlocConsumer<SignUpCubit, SignUpStates>(
            listener: (context, state) {
          if (state is UserCreateSuccessState) {
            CacheHelper.saveData(value: state.uid, key: 'uId').then((value) {
              uId = state.uid;
              showToast(text: 'Sign up Successful', state: ToastStates.success);
              navigateAndFinish(context, const HomeScreen());
            });
          }
        },
            builder: (context, state) {
          return Stack(
            children: [
              Container(
                constraints: const BoxConstraints.expand(),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:  AssetImage(AssetPath.signUPImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: defaultAppBar(),
                  body: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 30, bottom: 50, right: 20, left: 20),
                                child: const Text(
                                  'Create Account',
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              space(0, 32),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'First Name',
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
                                      controller: firstnameController,
                                      keyboardType: TextInputType.name,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'First Name is Required';
                                        }
                                        return null;
                                      },
                                      prefix: Icons.edit_outlined,
                                      hint: 'First Name',
                                    ),
                                    space(0, 20),
                                    const Text(
                                      'Last Name',
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
                                      controller: lastnameController,
                                      keyboardType: TextInputType.name,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Last Name is Required';
                                        }
                                        return null;
                                      },
                                      prefix: Icons.edit_outlined,
                                      hint: 'Last Name',
                                    ),
                                    space(0, 20),
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
                                        String pattern =
                                            "r^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]";
                                        RegExp regExp = RegExp(pattern);
                                        if (value!.isEmpty) {
                                          return 'Email is Required';
                                        } else if (regExp.hasMatch(value)) {
                                          return 'Please a valid Email';
                                        } else {
                                          return null;
                                        }
                                      },
                                      prefix: Icons.alternate_email,
                                      hint: 'Email Address',
                                    ),
                                    space(0, 20),
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
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      validate: (String? value) {
                                        String pattern =
                                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                                        RegExp regExp = RegExp(pattern);
                                        if (value!.isEmpty) {
                                          return "Password is Required";
                                        } else if (!regExp.hasMatch(value)) {
                                          return 'Example  Tripso123!\n'
                                              'Minimum 1 Upper case\n'
                                              'Minimum 1 lowercase\n'
                                              'Minimum 1 Numeric Number\n'
                                              'Minimum 1 Special Character\n'
                                              'Common Allow Character ( ! @ # & * ~ ) \n';
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
                                  ],
                                ),
                              ),
                              space(0, 70),
                              defaultMaterialButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    SignUpCubit.get(context).userSignUp(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      firstName: firstnameController.text,
                                      lastName: lastnameController.text,
                                    );
                                  }
                                },
                                text: 'Sign up',
                                color: primaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }));
  }
}
