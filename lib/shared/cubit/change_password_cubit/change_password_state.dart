abstract class ChangePasswordStates {}

class ChangePasswordInitialState extends ChangePasswordStates {}

class ChangeUserPasswordLoadingState extends ChangePasswordStates {}

class ChangeUserPasswordSuccessState extends ChangePasswordStates {}

class ChangeUserPasswordErrorState extends ChangePasswordStates {
  final String error ;
  ChangeUserPasswordErrorState(this.error);
}
