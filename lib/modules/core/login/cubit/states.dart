import '../login_model.dart';

abstract class LoginStates{}


class LoginIntStates extends LoginStates{}

class LoginLoadingStates extends LoginStates{}

class LoginSuccessStates extends LoginStates{
  final LoginModel loginModel;
  LoginSuccessStates(this.loginModel);
}

class LoginErrorStates extends LoginStates
{
  final String error;

  LoginErrorStates(this.error);
}