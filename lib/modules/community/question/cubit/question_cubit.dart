
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/end_points.dart';
import '../../../../utils/helpers/dio_helper.dart';
import '../../models/answers_model.dart';
import 'question_states.dart';



class QuestionCubit extends Cubit<QuestionStates>{
  QuestionCubit() : super(QuestionInitialState());
  static QuestionCubit get(context) => BlocProvider.of(context);


  ///ADD ANSWER
  bool addStatus=false;
  String addMessage='';
  void addAnswer({required questionId,required content})
  {
    emit(AddAnswerLoadingState());
    DioHelper.postData(
      url: '${ADD_ANSWER}/$questionId',
      token: token,
      data: {
        'content' : content
      },
    ).then((value) {
      print(value?.data);
      addStatus=value?.data["status"];
      addMessage=value?.data["message"];

      emit(AddAnswerSuccessState(addStatus,addMessage));
    }).catchError((error){
      print(error.toString());
      emit(AddAnswerErrorState(error.toString()));
    });
  }


  ///GET ANSWER
  AnswersModel? answersModel;
  List<dynamic>? answers=[];
  void getAnswers(questionId)
  {
    emit(GetAnswerLoadingState());
    DioHelper.getData(
      url: '$GET_ANSWERS/$questionId',
      token: token,
    ).then((value) {
      print(value?.data);
      answersModel = AnswersModel.fromJson(value?.data);
      print(answersModel?.status);
      print(answersModel?.message);
      print(answersModel?.data[0]);
      answers = answersModel?.data;
      emit(GetAnswerSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetAnswerErrorState(error.toString()));
    });
  }


  ///DELETE ANSWER
  bool deleteStatus=false;
  String deleteMessage='';
  void deleteAnswer(answerId)
  {
    emit(DeleteAnswerLoadingState());
    DioHelper.deleteData(
      url: '$DELETE_ANSWER/$answerId',
      token: token,
    ).then((value) {
      print(value?.data);
      deleteStatus=value?.data["status"];
      deleteMessage=value?.data["message"];
      emit(DeleteAnswerSuccessState(deleteStatus,deleteMessage));
    }).catchError((error){
      print(error.toString());
      emit(DeleteAnswerErrorState(error.toString()));
    });
  }

  ///EDIT ANSWER
  bool editStatus=false;
  String editMessage='';
  void editAnswer(
      {
        required answerId,
        required  content,
        required  token,
      }
      )
  {
    emit(EditAnswerLoadingState());
    DioHelper.putData(
      token: token,
      url: '$EDIT_ANSWER/$answerId',
      data: {
        'content': content,
      },
    ).then((value) {
      print(value?.data);
      editStatus=value?.data["status"];
      editMessage=value?.data["message"];
      emit(EditAnswerSuccessState(editStatus,editMessage));
    }).catchError((error) {
      print(" ${error.response.data}");
      emit(EditAnswerErrorState(error.toString()));
    });
  }

  ///REPORT ANSWER
  bool reportStatus=false;
  String reportMessage='';
  void reportAnswer(
      {
        required answerId,
        required  reason,
        required  token,
      }
      )
  {
    emit(ReportAnswerLoadingState());
    DioHelper.postData(
      token: token,
      url: REPORT_ANSWER,
      data: {
        'answer_id' : answerId,
        'reason': reason,
      },
    ).then((value) {
      print(value?.data);
      reportStatus=value?.data["status"];
      reportMessage=value?.data["message"];
      emit(ReportAnswerSuccessState(reportStatus,reportMessage));
    }).catchError((error) {
      print(" ${error.response.data}");
      emit(EditAnswerErrorState(error.toString()));
    });
  }

  ///SEND LIKES
  void likeAnswer(id)
  {
    emit(LikeLoadingState());
    DioHelper.postData(
      url: '$LIKE_ANSWER/$id',
      token: token,
    ).then((value) {
      print(value?.data);
      emit(LikeSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(LikeErrorState(error.toString()));
    });
  }
  void likeQuestion(id)
  {
    emit(LikeLoadingState());
    DioHelper.postData(
      url: '$LIKE_QUESTION/$id',
      token: token,
    ).then((value) {
      print(value?.data);
      emit(LikeSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(LikeErrorState(error.toString()));
    });
  }

}