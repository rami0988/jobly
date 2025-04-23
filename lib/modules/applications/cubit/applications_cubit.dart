
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/utils/end_points.dart';

import '../../../utils/constants.dart';
import '../../../utils/helpers/dio_helper.dart';
import '../applications_model.dart';
import 'applications_states.dart';



class ApplicationsCubit extends Cubit<ApplicationsStates>{
  ApplicationsCubit() : super(ApplicationsInitialState());
  static ApplicationsCubit get(context) => BlocProvider.of(context);


  ///GET APPLICATIONS
  MyApplicationsModel? myApplicationsModel;
  List<dynamic>? applications=[];
  void getMyApplications()
  {
  emit(ApplicationsLoadingState());
  DioHelper.getData(
    url: GET_APPLICATIONS,
    token: token,
  ).then((value) {
    print(value?.data);
    myApplicationsModel = MyApplicationsModel.fromJson(value?.data);
    print(myApplicationsModel?.status);
    print(myApplicationsModel?.message);
    print(myApplicationsModel?.data[0].status);
    applications = myApplicationsModel?.data;
    emit(ApplicationsSuccessState());
  }).catchError((error){
    print(error.toString());
    emit(ApplicationsErrorState(error.toString()));
  });
}

  ///CANCEL APPLICATIONS
  void cancelApplication(id)
  {
    emit(CancelApplicationLoadingState());
    DioHelper.postData(
      url: "$CANCEL_APPLICATION/$id",
      token: token,
    ).then((value) {
      print(value?.data);
      emit(CancelApplicationSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CancelApplicationErrorState(error.toString()));
    });
  }




}