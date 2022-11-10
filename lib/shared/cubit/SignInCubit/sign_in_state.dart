abstract class SignInStates{}

class SignInInitialState extends SignInStates{}

class SignInLoadingState extends SignInStates{}

class SignInSuccessState extends SignInStates
{
  final String uid;
  SignInSuccessState(this.uid);
}

class SignInErrorState extends SignInStates{

  final String error;

  SignInErrorState(this.error);
}

class ShowPasswordState extends SignInStates{}

// get user Reload states
class SignInReloadLoadingState extends SignInStates {}
class SignInReloadSuccessState extends SignInStates {}
class SignInReloadErrorState extends SignInStates {
  final String? errorString ;
  SignInReloadErrorState(this.errorString);
}

