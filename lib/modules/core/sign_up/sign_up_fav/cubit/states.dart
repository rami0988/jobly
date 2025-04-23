abstract class SignupFavStates{}


class SignupIntFavStates extends SignupFavStates{}

class SignupFavLoadingStates extends SignupFavStates{}

class SignupFavSuccessStates extends SignupFavStates{}

class SignupFavErorrStates extends SignupFavStates
{
  final String erorr;

  SignupFavErorrStates(this.erorr);
}