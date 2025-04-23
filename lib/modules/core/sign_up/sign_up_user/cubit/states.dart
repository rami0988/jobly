abstract class SignupUserStates{}


class SignupIntStates extends SignupUserStates{}

class SignupLoadingStates extends SignupUserStates{}

class SignupSuccessStates extends SignupUserStates{}

class SignupErorrStates extends SignupUserStates
{
  final String message;
  final String erorr;

  SignupErorrStates(this.erorr,this.message);
}