abstract class SignupSkillStates{}


class SignupIntSkillStates extends SignupSkillStates{}

class SignupSkillLoadingStates extends SignupSkillStates{}

class SignupSkillSuccessStates extends SignupSkillStates{}

class SignupSkillErorrStates extends SignupSkillStates
{
  final String erorr;

  SignupSkillErorrStates(this.erorr);
}