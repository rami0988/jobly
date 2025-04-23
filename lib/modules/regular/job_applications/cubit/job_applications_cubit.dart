
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/utils/end_points.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/helpers/dio_helper.dart';
import '../job_applications_model.dart';
import 'job_applications_states.dart';



class JobApplicationsCubit extends Cubit<JobApplicationsStates>{
  JobApplicationsCubit() : super(JobApplicationsInitialState());
  static JobApplicationsCubit get(context) => BlocProvider.of(context);


  ///GET MY JOB APPLICATIONS
  JobApplicationsModel? jobApplicationsModel;
  List<dynamic>? jobApplications=[];
  void getMyJobApplications(id)
  {
    emit(JobApplicationsLoadingState());
    DioHelper.getData(
      url: "$GET_MY_JOB_APPLICATIONS/$id",
      token: token,
    ).then((value) {
      print(value?.data);
      jobApplicationsModel = JobApplicationsModel.fromJson(value?.data);
      print(jobApplicationsModel?.status);
      print(jobApplicationsModel?.message);
      print(jobApplicationsModel?.data[0].image);
      jobApplications = jobApplicationsModel?.data;
      emit(JobApplicationsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(JobApplicationsErrorState(error.toString()));
    });
  }

  ///ACCEPT APPLICATIONS
  void acceptApplication(id)
  {
    emit(AcceptJobApplicationLoadingState());
    DioHelper.postData(
      url: "$ACCEPT_APPLICATION/$id",
      token: token,
    ).then((value) {
      print(value?.data);
      emit(AcceptJobApplicationSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AcceptJobApplicationErrorState(error.toString()));
    });
  }

  ///REJECT APPLICATIONS
  void rejectApplication(id)
  {
    emit(RejectJobApplicationLoadingState());
    DioHelper.postData(
      url: "$REJECT_APPLICATION/$id",
      token: token,
    ).then((value) {
      print(value?.data);
      emit(RejectJobApplicationSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(RejectJobApplicationErrorState(error.toString()));
    });
  }



}