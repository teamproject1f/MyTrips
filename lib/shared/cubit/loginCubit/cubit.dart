import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team1/shared/cubit/loginCubit/state.dart';
import '../../components/components.dart';



class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
///START : Login With E-mail & Password
  Future<void> userLogin({
    required String email,
    required String password,
  })async {
    debugPrint('Done');
    emit(LoginLoadingState());
  await  FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
    showToast(
      state: ToastStates.success,
      text: 'Sign in Successful',
    );
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error) {
    showToast(
      state: ToastStates.error,
      text: 'email isn\'t valid',
    );
      emit(LoginErrorState(error.toString()));
    });
  }
///END : Login With E-mail & Password

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