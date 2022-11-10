import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:TRIPSO/shared/cubit/SignUpCubit/signUp_state.dart';
import 'package:TRIPSO/shared/styles/styles.dart';
import '../../../model/user_model.dart';
import '../../components/components.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  void userSignUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    debugPrint('Done');
    emit(SignUpLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
          email: email,
          firstName: firstName,
          lastName: lastName,
          uId: value.user!.uid);
    }).catchError((error) {
      emit(SignUpErrorState(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String firstName,
    required String lastName,
    required String uId,
  }) async {
    UserModel model = UserModel(
      email: email,
      firstName: firstName,
      lastName: lastName,
      uId: uId,
      image: AssetPath.profileImage,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      showToast(
        state: ToastStates.success,
        text: 'Sign up Successful',
      );
      emit(UserCreateSuccessState(uId));
    }).catchError((error) {
      showToast(
        state: ToastStates.error,
        text: 'Sign up Rejected',
      );
      emit(UserCreateErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void showPassword() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordSignUpState());
  }
}
