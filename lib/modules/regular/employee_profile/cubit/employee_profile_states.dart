abstract class EmployeeProfileStates{}
class EmployeeProfileAboutMeState extends EmployeeProfileStates{}


//PROFILE

class EmployeeProfileLoadingState extends EmployeeProfileStates{}
class EmployeeProfileSuccessState extends EmployeeProfileStates{}
class EmployeeProfileErrorState extends EmployeeProfileStates
{
  final String error;
  EmployeeProfileErrorState(this.error);
}


