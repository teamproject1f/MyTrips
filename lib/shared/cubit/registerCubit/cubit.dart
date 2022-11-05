import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team1/shared/cubit/registerCubit/state.dart';
import 'package:team1/shared/styles/styles.dart';
import '../../../model/user_model.dart';
import '../../components/components.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

void userRegister({
  required String email,
  required String password,
  required String name,
})async {
  debugPrint('Done');
  emit(RegisterLoadingState());
FirebaseAuth.instance.createUserWithEmailAndPassword(
  email: email,
  password: password,
).then((value)
{
  userCreate(
      email: email,
      name: name,
      uId: value.user!.uid
  );
}).catchError((error)
{
  emit(RegisterErrorState(error.toString()));
});
}

void userCreate({
  required String email,
  required String name,
  required String uId,
})
 async{
  UserModel model = UserModel(
    email: email,
    name: name,
    uId: uId,
    image: profileImage,
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
  }).catchError((error)
  {
    showToast(
      state: ToastStates.error,
      text: 'Sign up Rejected',
    );
    emit(UserCreateErrorState(error));
  });
}

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePassword() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordRegisterState());
  }
}
