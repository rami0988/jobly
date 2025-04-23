abstract class SignupAddressStates{}


class SignupIntAddressStates extends SignupAddressStates{}

class SignupAddressLoadingStates extends SignupAddressStates{}

class SignupAddressSuccessStates extends SignupAddressStates{}

class SignupAddressErorrStates extends SignupAddressStates
{
  final String erorr;

  SignupAddressErorrStates(this.erorr);
}