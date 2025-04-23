
abstract class CommunityStates{}

class CommunityInitialState extends CommunityStates{}

class CommunityLoadingState extends CommunityStates{}

class CommunitySuccessState extends CommunityStates{}

class CommunityErrorState extends CommunityStates{
  final String error;
  CommunityErrorState(this.error);
}
class ChangeTabBarState extends CommunityStates{}

///DROP DOWN BUTTON
class CategoriesInitialState extends CommunityStates{}

class CategoriesLoadingState extends CommunityStates{}

class CategoriesSuccessState extends CommunityStates{}

class CategoriesErrorState extends CommunityStates{
  final String error;
  CategoriesErrorState(this.error);
}

class CategoriesChangeState extends CommunityStates{}

///********QUESTIONS**********
///GET
class GetQuestionsLatestInitialState extends CommunityStates{}

class GetQuestionsLatestLoadingState extends CommunityStates{}

class GetQuestionsLatestSuccessState extends CommunityStates{}

class GetQuestionsLatestErrorState extends CommunityStates{
  final String error;
  GetQuestionsLatestErrorState(this.error);
}

class GetQuestionsCatInitialState extends CommunityStates{}

class GetQuestionsCatLoadingState extends CommunityStates{}

class GetQuestionsCatSuccessState extends CommunityStates{}

class GetQuestionsCatErrorState extends CommunityStates{
  final String error;
  GetQuestionsCatErrorState(this.error);
}
///ADD
class AddQuestionInitialState extends CommunityStates{}

class AddQuestionLoadingState extends CommunityStates{}

class AddQuestionSuccessState extends CommunityStates{
  final bool status;
  final String message;
  AddQuestionSuccessState(this.status,this.message);
}

class AddQuestionErrorState extends CommunityStates{
  final String error;
  AddQuestionErrorState(this.error);
}
///DELETE
class DeleteQuestionInitialState extends CommunityStates{}

class DeleteQuestionLoadingState extends CommunityStates{}

class DeleteQuestionSuccessState extends CommunityStates{}

class DeleteQuestionErrorState extends CommunityStates{
  final String error;
  DeleteQuestionErrorState(this.error);
}
///EDIT
class EditQuestionInitialState extends CommunityStates{}

class EditQuestionLoadingState extends CommunityStates{}

class EditQuestionSuccessState extends CommunityStates{}

class EditQuestionErrorState extends CommunityStates{
  final String error;
  EditQuestionErrorState(this.error);
}
///REPORT
class ReportQuestionInitialState extends CommunityStates{}

class ReportQuestionLoadingState extends CommunityStates{}

class ReportQuestionSuccessState extends CommunityStates{
  final bool status;
  final String message;
  ReportQuestionSuccessState(this.status,this.message);
}

class ReportQuestionErrorState extends CommunityStates{
  final String error;
  ReportQuestionErrorState(this.error);
}
///LIKE
class LikeLoadingState extends CommunityStates{}

class LikeSuccessState extends CommunityStates{}

class LikeErrorState extends CommunityStates{
  final String error;
  LikeErrorState(this.error);
}


///********ADVICES**********
///GET
class GetAdvicesInitialState extends CommunityStates{}

class GetAdvicesLoadingState extends CommunityStates{}

class GetAdvicesSuccessState extends CommunityStates{}

class GetAdvicesErrorState extends CommunityStates{
  final String error;
  GetAdvicesErrorState(this.error);
}
///ADD
class AddAdviceInitialState extends CommunityStates{}

class AddAdviceLoadingState extends CommunityStates{}

class AddAdviceSuccessState extends CommunityStates{
  final bool status;
  final String message;
  AddAdviceSuccessState(this.status,this.message);
}

class AddAdviceErrorState extends CommunityStates{
  final String error;
  AddAdviceErrorState(this.error);
}
///DELETE
class DeleteAdviceInitialState extends CommunityStates{}

class DeleteAdviceLoadingState extends CommunityStates{}

class DeleteAdviceSuccessState extends CommunityStates{}

class DeleteAdviceErrorState extends CommunityStates{
  final String error;
  DeleteAdviceErrorState(this.error);
}
///EDIT
class EditAdviceInitialState extends CommunityStates{}

class EditAdviceLoadingState extends CommunityStates{}

class EditAdviceSuccessState extends CommunityStates{}

class EditAdviceErrorState extends CommunityStates{
  final String error;
  EditAdviceErrorState(this.error);
}
///REPORT
class ReportAdviceInitialState extends CommunityStates{}

class ReportAdviceLoadingState extends CommunityStates{}

class ReportAdviceSuccessState extends CommunityStates{
  final bool status;
  final String message;
  ReportAdviceSuccessState(this.status,this.message);
}

class ReportAdviceErrorState extends CommunityStates{
  final String error;
  ReportAdviceErrorState(this.error);
}


///LIKE
class LikeAdviceLoadingState extends CommunityStates{}

class LikeAdviceSuccessState extends CommunityStates{}

class LikeAdviceErrorState extends CommunityStates{
  final String error;
  LikeAdviceErrorState(this.error);
}
