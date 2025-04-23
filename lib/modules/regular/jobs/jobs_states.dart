abstract class JobsStates{}

class JobsInitialState extends JobsStates{}

class JobsLoadingState extends JobsStates{}

class JobsSuccessState extends JobsStates{}

class JobsErrorState extends JobsStates{
  final String error;
  JobsErrorState(this.error);
}
class CompaniesLoadingState extends JobsStates{}

class CompaniesSuccessState extends JobsStates{}

class CompaniesErrorState extends JobsStates{
  final String error;
  CompaniesErrorState(this.error);
}
class ChangeJobsState extends JobsStates{}

class ForYouJobsState extends JobsStates{}
class AllJobsState extends JobsStates{}
