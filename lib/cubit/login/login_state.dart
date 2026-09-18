abstract class LoginState {}

class LoginInitState extends LoginState {}

class LoginPassVisibilityChanged extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String username;
  LoginSuccessState(this.username);
}

class LoginErrorState extends LoginState {
  final String errorMsg;
  LoginErrorState(this.errorMsg);
}