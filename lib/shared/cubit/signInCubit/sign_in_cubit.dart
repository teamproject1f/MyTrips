import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:TRIPSO/shared/cubit/SignInCubit/sign_in_state.dart';
import '../../components/show_toast.dart';



class SignInCubit extends Cubit<SignInStates> {
  SignInCubit() : super(SignInInitialState());

  static SignInCubit get(context) => BlocProvider.of(context);
///START : SignIn With E-mail & Password
  Future<void> userSignIn({
    required String email,
    required String password,
  })async {
    debugPrint('Done');
    emit(SignInLoadingState());
  await  FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
    showToast(
      state: ToastStates.success,
      text: 'Sign in Successful',
    );
      emit(SignInSuccessState(value.user!.uid));
    }).catchError((error) {
    showToast(
      state: ToastStates.error,
      text: 'Sign in Failed',
    );
      emit(SignInErrorState(error.toString()));
    });
  }
///END : SignIn With E-mail & Password

///START : Show Password
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void showPassword() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShowPasswordState());
  }
///END : Show Password
}