abstract class CompanyProfileStates{}
class CompanyProfileInitialState extends CompanyProfileStates{}
class CompanyLoadingState extends CompanyProfileStates{}
class CompanySuccessState extends CompanyProfileStates{}
class CompanyErrorState extends CompanyProfileStates{
  final String error;
  CompanyErrorState(this.error);
}

class CompanyJobsInitialState extends CompanyProfileStates{}

class CompanyJobsLoadingState extends CompanyProfileStates{}

class CompanyJobsSuccessState extends CompanyProfileStates{}

class CompanyJobsErrorState extends CompanyProfileStates{
  final String error;
  CompanyJobsErrorState(this.error);
}

class AddRatingLoadingState extends CompanyProfileStates{}

class AddRatingSuccessState extends CompanyProfileStates{
}

class AddRatingErrorState extends CompanyProfileStates{
  final String error;
  AddRatingErrorState(this.error);
}