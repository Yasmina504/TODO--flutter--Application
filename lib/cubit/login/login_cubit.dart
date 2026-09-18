import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repo/auth_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());

  final AuthRepo _authRepo = AuthRepo();

  var username = TextEditingController();
  var password = TextEditingController();
  bool isPasswordSecure = true;

  void changePassSecure() {
    isPasswordSecure = !isPasswordSecure;
    emit(LoginPassVisibilityChanged());
  }

  Future<void> login() async {
    if (username.text.trim().isEmpty) {
      emit(LoginErrorState('Please enter your username'));
      return;
    }
    if (password.text.trim().isEmpty) {
      emit(LoginErrorState('Please enter your password'));
      return;
    }

    emit(LoginLoadingState());

    final result = await _authRepo.login(
      username: username.text.trim(),
      password: password.text,
    );

    if (result['success'] == true) {
      emit(LoginSuccessState(result['user'].username));
    } else {
      emit(LoginErrorState(result['message']));
    }
  }

  @override
  Future<void> close() {
    username.dispose();
    password.dispose();
    return super.close();
  }
}