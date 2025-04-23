

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/utils/end_points.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/helpers/dio_helper.dart';
import '../job_details_model.dart';
import 'job_details_states.dart';


class JobDetailsCubit extends Cubit<JobDetailsStates> {
  JobDetailsCubit() : super(JobDetailsInitialState());

  static JobDetailsCubit get(context) => BlocProvider.of(context);




  ///GET JOB DETAILS
  JobDetailsModel? jobModel;
  dynamic job;
  static dynamic detailsJobType="";
  static dynamic detailsJobSalary="";

  void getJobDetails(int id) {
    emit(JobDetailsLoadingState());
    DioHelper.getData(
      url: "$GET_JOB_DETAILS/$id",
      token: token,
    ).then((value) {
      print(value?.data);
      jobModel = JobDetailsModel.fromJson(value?.data);
      print(jobModel?.status);
      print(jobModel?.message);
      print(jobModel?.data.section);
      job = jobModel?.data;
      detailsJobSalary=job.jobType;
      detailsJobType=job.salaryRange;
      emit(JobDetailsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(JobDetailsErrorState(error.toString()));
    });
  }
  void applyToJob(int id){
    emit(JobApplyLoadingState());
    DioHelper.postData(
        url: "$APPLY_TO_JOB/$id",
        token: token,
    ).then((value){
      print(value?.data);
      emit(JobApplySuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(JobApplyErrorState(error.toString()));
    });

  }





}