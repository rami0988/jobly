abstract class ProfileStates{
  const ProfileStates();
    @override
  List<Object> get props => [];
}
class ProfileAboutMeState extends ProfileStates{}
class ProfilePostsState extends ProfileStates{}
class ProfileInfoState extends ProfileStates{}

class ProfileChangeState extends ProfileStates{}
class DarkThemeState extends ProfileStates{}
class LightThemeState extends ProfileStates{}

class ChangeLanguageState extends ProfileStates{}

//File
class UploadFileLoadingState extends ProfileStates{}
class UploadFileSuccessState extends ProfileStates{}
class UploadFileErrorState extends ProfileStates
{
  final String error;
  UploadFileErrorState(this.error);
}
class SendFileLoadingState extends ProfileStates{}
class SendFileSuccessState extends ProfileStates{}
class SendFileErrorState extends ProfileStates
{
  final String error;
  SendFileErrorState(this.error);
}
class SendVideoLoadingState extends ProfileStates{}
class SendVideoSuccessState extends ProfileStates{}
class SendVideoErrorState extends ProfileStates
{
  final String error;
  SendVideoErrorState(this.error);
}


//PROFILE

class ProfileLoadingState extends ProfileStates{}



class ProfileSucsessState extends ProfileStates{}



class ProfileErrorState extends ProfileStates
{
  final String error;

  ProfileErrorState(this.error);
}

class SendVerificationLoadingState extends ProfileStates{}
class SendVerificationSuccessState extends ProfileStates{
  final bool status;
  final String message;
  SendVerificationSuccessState(this.status,this.message);
}
class SendVerificationErrorState extends ProfileStates
{
  final String error;
  SendVerificationErrorState(this.error);
}

class CancelVerificationLoadingState extends ProfileStates{}
class CancelVerificationSuccessState extends ProfileStates{
  final bool status;
  final String message;
  CancelVerificationSuccessState(this.status,this.message);
}
class CancelVerificationErrorState extends ProfileStates
{
  final String error;
  CancelVerificationErrorState(this.error);
}

//JOBS

class GetMyJobsLoadingState extends ProfileStates{}
class GetMyJobsSuccessState extends ProfileStates{}
class GetMyJobsErrorState extends ProfileStates
{
  final String error;
  GetMyJobsErrorState(this.error);
}


class DeleteMyJobLoadingState extends ProfileStates{}
class DeleteMyJobSuccessState extends ProfileStates{}
class DeleteMyJobErrorState extends ProfileStates
{
  final String error;
  DeleteMyJobErrorState(this.error);
}
