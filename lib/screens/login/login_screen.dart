
import 'package:flutter/material.dart';
import 'package:team1/shared/components/components.dart';
import 'package:team1/shared/styles/colors.dart';
import '../../shared/styles/styles.dart';
import '../password/forget_Password.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Stack(
      children: [
        Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: signINImage,
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: defaultAppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    space(0, 180),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: const Text('Email Address',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                      space(0, 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: defaultTextFormField(
                        color: Colors.white30,
                        context: context,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validate: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            'please Enter Your Email Address';
                          }
                        },
                        hint: 'Email Address',
                      ),
                    ),
                    space(0, 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: const Text('Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                    ),
                    space(0, 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: defaultTextFormField(
                        color: Colors.white30,
                        context: context,
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        validate: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            'please Enter Your Password';
                          }
                        },
                        hint: 'Enter Password',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: ()
                              {
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => const RestPasswordScreen())
                               );
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
                    space(0, 100),
                    Center(
                      child: defaultMaterialButton(
                        function: ()
                        {
                       //   navigateAndFinish(context, const HomeLayout());
                        },
                        text: 'Sign in',
                        color:defaultColor,
                      ),
                    ),
                    space(0, 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        TextButton(

                          onPressed: ()
                          {
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
