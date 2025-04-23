
abstract class JobApplicationsStates{}

class JobApplicationsInitialState extends JobApplicationsStates{}

class JobApplicationsLoadingState extends JobApplicationsStates{}

class JobApplicationsSuccessState extends JobApplicationsStates{}

class JobApplicationsErrorState extends JobApplicationsStates{
  final String error;
  JobApplicationsErrorState(this.error);
}

class AcceptJobApplicationLoadingState extends JobApplicationsStates{}

class AcceptJobApplicationSuccessState extends JobApplicationsStates{}

class AcceptJobApplicationErrorState extends JobApplicationsStates{
  final String error;
  AcceptJobApplicationErrorState(this.error);
}

class RejectJobApplicationLoadingState extends JobApplicationsStates{}

class RejectJobApplicationSuccessState extends JobApplicationsStates{}

class RejectJobApplicationErrorState extends JobApplicationsStates{
  final String error;
  RejectJobApplicationErrorState(this.error);
}


