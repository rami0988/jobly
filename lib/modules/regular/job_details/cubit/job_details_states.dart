abstract class JobDetailsStates{}

class JobDetailsInitialState extends JobDetailsStates{}

class JobDetailsLoadingState extends JobDetailsStates{}

class JobDetailsSuccessState extends JobDetailsStates{}

class JobDetailsErrorState extends JobDetailsStates{
  final String error;
  JobDetailsErrorState(this.error);
}

class JobApplyLoadingState extends JobDetailsStates{}

class JobApplySuccessState extends JobDetailsStates{}

class JobApplyErrorState extends JobDetailsStates{
  final String error;
  JobApplyErrorState(this.error);
}
