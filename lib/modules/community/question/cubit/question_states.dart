
abstract class QuestionStates{}

class QuestionInitialState extends QuestionStates{}

class QuestionLoadingState extends QuestionStates{}

class QuestionSuccessState extends QuestionStates{}

class QuestionErrorState extends QuestionStates{
  final String error;
  QuestionErrorState(this.error);
}

class GetAnswerInitialState extends QuestionStates{}

class GetAnswerLoadingState extends QuestionStates{}

class GetAnswerSuccessState extends QuestionStates{}

class GetAnswerErrorState extends QuestionStates{
  final String error;
  GetAnswerErrorState(this.error);
}

class AddAnswerInitialState extends QuestionStates{}

class AddAnswerLoadingState extends QuestionStates{}

class AddAnswerSuccessState extends QuestionStates{
  final bool addStatus;
  final String addMessage;
  AddAnswerSuccessState(this.addStatus,this.addMessage);
}

class AddAnswerErrorState extends QuestionStates{
  final String error;
  AddAnswerErrorState(this.error);
}


class DeleteAnswerInitialState extends QuestionStates{}

class DeleteAnswerLoadingState extends QuestionStates{}

class DeleteAnswerSuccessState extends QuestionStates{
  final bool deleteStatus;
  final String deleteMessage;
  DeleteAnswerSuccessState(this.deleteStatus,this.deleteMessage);
}

class DeleteAnswerErrorState extends QuestionStates{
  final String error;
  DeleteAnswerErrorState(this.error);
}

class EditAnswerInitialState extends QuestionStates{}

class EditAnswerLoadingState extends QuestionStates{}

class EditAnswerSuccessState extends QuestionStates{
  final bool editStatus;
  final String editMessage;
  EditAnswerSuccessState(this.editStatus,this.editMessage);
}

class EditAnswerErrorState extends QuestionStates{
  final String error;
  EditAnswerErrorState(this.error);
}

class ReportAnswerInitialState extends QuestionStates{}

class ReportAnswerLoadingState extends QuestionStates{}

class ReportAnswerSuccessState extends QuestionStates{
  final bool reportStatus;
  final String reportMessage;
  ReportAnswerSuccessState(this.reportStatus,this.reportMessage);
}

class ReportAnswerErrorState extends QuestionStates{
  final String error;
  ReportAnswerErrorState(this.error);
}

///LIKE
class LikeLoadingState extends QuestionStates{}

class LikeSuccessState extends QuestionStates{}

class LikeErrorState extends QuestionStates{
  final String error;
  LikeErrorState(this.error);
}

class ChangeIsLikedState extends QuestionStates{}