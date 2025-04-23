

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants.dart';
import '../../../utils/end_points.dart';
import '../../../utils/helpers/dio_helper.dart';
import '../../regular/search/categories_model.dart';
import '../models/advices_model.dart';
import '../models/questions_model.dart';
import 'community_states.dart';

class CommunityCubit extends Cubit<CommunityStates>{
  CommunityCubit() : super(CommunityInitialState());
  static CommunityCubit get(context) => BlocProvider.of(context);

  List<String> type = [
    "Questions",
    "Advices",
  ];
  ///Toggle between advices and questions
  int currentIndex=0;
  void changeTabBar(int index)
  {
    currentIndex= index;
    emit(ChangeTabBarState());
  }

  ///bringing categories and putting them in a drop down button
  int? dropDownValueCategory;
  int? dropDownValueCategorySort;
  List<DropdownMenuItem<dynamic>> categoriesItems = [];
  void changeCategoryDropDownButton(int newValue)
  {
    dropDownValueCategory = newValue;
    emit(CategoriesChangeState());
  }
  void changeCategorySortDropDownButton(int newValue)
  {
    dropDownValueCategorySort = newValue;
    emit(CategoriesChangeState());
  }

  CategoriesModel? categoriesModel;
  List<dynamic>? categories;
  void getCategories()
  {
    emit(CategoriesLoadingState());
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      print(value?.data);
      categoriesModel = CategoriesModel.fromJson(value?.data);
      print(categoriesModel?.status);
      print(categoriesModel?.message);
      print(categoriesModel?.data[0].category);
      categories = categoriesModel?.data;
      print(categories?[1].id);
      categoriesItems = categories!.map((category) {
        return DropdownMenuItem<dynamic>(
          value: category.id,
          child: Text(category.category),
        );
      }).toList();
      emit(CategoriesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CategoriesErrorState(error.toString()));
    });
  }

  //******************QUESTIONS****************
  ///ADD QUESTION
  bool addStatus=false;
  String addMessage='';
  void addQuestion({required category,required question})
  {
    emit(AddQuestionLoadingState());
    DioHelper.postData(
      url: ADD_QUESTION,
      token: token,
      data: {
        'jops_category_id' : category,
        'content' : question
      },
    ).then((value) {
      print(value?.data);
      addStatus=value?.data["status"];
      addMessage=value?.data["message"];

      emit(AddQuestionSuccessState(addStatus,addMessage));
    }).catchError((error){
      print(error.toString());
      emit(AddQuestionErrorState(error.toString()));
    });
  }


  ///GET QUESTION
  QuestionsModel? questionsModel;
  List<dynamic>? questions=[];
  void getQuestionsLatest()
  {
    emit(GetQuestionsLatestLoadingState());
    DioHelper.getData(
      url: GET_QUESTIONS_LATEST,
      token: token,
    ).then((value) {
      print(value?.data);
      questionsModel = QuestionsModel.fromJson(value?.data);
      print(questionsModel?.status);
      print(questionsModel?.message);
      print(questionsModel?.data[0]);
      questions = questionsModel?.data;
      emit(GetQuestionsLatestSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetQuestionsLatestErrorState(error.toString()));
    });
  }

  void getQuestionsCat(id)
  {
    emit(GetQuestionsCatLoadingState());
    DioHelper.getData(
      url: "$GET_QUESTIONS_CATEGORY/$id",
      token: token,
    ).then((value) {
      print(value?.data);
      questionsModel = QuestionsModel.fromJson(value?.data);
      print(questionsModel?.status);
      print(questionsModel?.message);
      questions = questionsModel?.data;
      emit(GetQuestionsCatSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetQuestionsCatErrorState(error.toString()));
    });
  }


  ///DELETE QUESTION
  void deleteQuestion(id)
  {
    emit(DeleteQuestionLoadingState());
    DioHelper.deleteData(
      url: '${DELETE_QUESTION}/${id}',
      token: token,
    ).then((value) {
      print(value?.data);
      emit(DeleteQuestionSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(DeleteQuestionErrorState(error.toString()));
    });
  }

  ///EDIT QUESTION
  void editQuestion(
      {
        required questionId,
        required  content,
        required  token,
      }
      )
  {
    emit(EditQuestionLoadingState());
    DioHelper.putData(
      token: token,
      url: '${EDIT_QUESTION}/${questionId}',
      data: {
        'content': content,
      },
    ).then((value) {
      print(value?.data);
      emit(EditQuestionSuccessState());
    }).catchError((error) {
      print(" ${error.response.data}");
      emit(EditQuestionErrorState(error.toString()));
    });
  }

  ///REPORT QUESTION
  bool reportStatus=false;
  String reportMessage='';
  void reportQuestion(
      {
        required questionId,
        required  reason,
        required  token,
      }
      )
  {
    emit(ReportQuestionLoadingState());
    DioHelper.postData(
      token: token,
      url: REPORT_QUESTION,
      data: {
        'question_id' : questionId,
        'reason': reason,
      },
    ).then((value) {
      print(value?.data);
      reportStatus=value?.data["status"];
      reportMessage=value?.data["message"];
      emit(ReportQuestionSuccessState(reportStatus,reportMessage));
    }).catchError((error) {
      print(" ${error.response.data}");
      emit(EditQuestionErrorState(error.toString()));
    });
  }

  ///SEND LIKES
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

  //******************ADVICES**************
  ///ADD ADVICE
  // bool addStatus=false;
  // String addMessage='';
  void addAdvice({required advice})
  {
    emit(AddAdviceLoadingState());
    DioHelper.postData(
      url: ADD_ADVICE,
      token: token,
      data: {
        'content' : advice
      },
    ).then((value) {
      print(value?.data);
      addStatus=value?.data["status"];
      addMessage=value?.data["message"];

      emit(AddAdviceSuccessState(addStatus,addMessage));
    }).catchError((error){
      print(error.toString());
      emit(AddAdviceErrorState(error.toString()));
    });
  }


  ///GET ADVICE
  AdvicesModel? advicesModel;
  List<dynamic>? advices;
  void getAdvicesLatest()
  {
    emit(GetAdvicesLoadingState());
    DioHelper.getData(
      url: GET_ADVICES_LATEST,
      token: token,
    ).then((value) {
      print(value?.data);
      advicesModel = AdvicesModel.fromJson(value?.data);
      print(advicesModel?.status);
      print(advicesModel?.message);
      print(advicesModel?.data[0]);
      advices = advicesModel?.data;
      emit(GetAdvicesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetAdvicesErrorState(error.toString()));
    });
  }
  void getAdvicesLiked()
  {
    emit(GetAdvicesLoadingState());
    DioHelper.getData(
      url: GET_ADVICES_LIKED,
      token: token,
    ).then((value) {
      print(value?.data);
      advicesModel = AdvicesModel.fromJson(value?.data);
      print(advicesModel?.status);
      print(advicesModel?.message);
      print(advicesModel?.data[0]);
      advices = questionsModel?.data;
      emit(GetAdvicesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetAdvicesErrorState(error.toString()));
    });
  }


  ///DELETE ADVICE
  void deleteAdvice(id)
  {
    emit(DeleteAdviceLoadingState());
    DioHelper.deleteData(
      url: '$DELETE_ADVICE/$id',
      token: token,
    ).then((value) {
      print(value?.data);
      emit(DeleteAdviceSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(DeleteAdviceErrorState(error.toString()));
    });
  }

  ///EDIT ADVICE
  void editAdvice(
      {
        required adviceId,
        required  content,
        required  token,
      }
      )
  {
    emit(EditAdviceLoadingState());
    DioHelper.putData(
      token: token,
      url: '$EDIT_ADVICE/$adviceId',
      data: {
        'content': content,
      },
    ).then((value) {
      print(value?.data);
      emit(EditAdviceSuccessState());
    }).catchError((error) {
      print(" ${error.response.data}");
      emit(EditAdviceErrorState(error.toString()));
    });
  }

  ///REPORT ADVICE
  // bool reportStatus=false;
  // String reportMessage='';
  void reportAdvice(
      {
        required adviceId,
        required  reason,
        required  token,
      }
      )
  {
    emit(ReportAdviceLoadingState());
    DioHelper.postData(
      token: token,
      url: REPORT_ADVICE,
      data: {
        'advice_id' : adviceId,
        'reason': reason,
      },
    ).then((value) {
      print(value?.data);
      reportStatus=value?.data["status"];
      reportMessage=value?.data["message"];
      emit(ReportAdviceSuccessState(reportStatus,reportMessage));
    }).catchError((error) {
      print(" ${error.response.data}");
      emit(EditAdviceErrorState(error.toString()));
    });
  }

  ///SEND LIKES
  void likeAdvice(id)
  {
    emit(LikeAdviceLoadingState());
    DioHelper.postData(
      url: '$LIKE_ADVICE/$id',
      token: token,
    ).then((value) {
      print(value?.data);
      emit(LikeAdviceSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(LikeAdviceErrorState(error.toString()));
    });
  }


}