import 'package:flutter/material.dart';
import 'package:team1/shared/styles/styles.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var firstnameController = TextEditingController();
    var lastnameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Stack(
      children: [
        Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: signUPImage,
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
                  IconButton(

                    onPressed: () {
                      pop(context);
                    },
                    icon: Icon(Icons.arrow_back,size: 25,color: Colors.white,),

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
                        padding: const EdgeInsets.symmetric(horizontal: 50),
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
                                  'please Enter Your First Name';
                                }
                              },
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
                                  'please Enter Your Last Name';
                                }
                              },
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
                                if (value!.isEmpty) {
                                  'please Enter Your Email Address';
                                }
                              },
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
                              keyboardType: TextInputType.visiblePassword,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  'please Enter Your Password';
                                }
                              },
                              hint: 'Password',
                            ),
                          ],
                        ),
                      ),
                      space(0, 70),
                      defaultMaterialButton(
                        function: () {
                          // navigateAndFinish(context, const HomeLayout());
                        },
                        text: 'Sign up',
                        color: defaultColor,
                      ),
                      space(0, 70)
                    ],
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
