import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/widgets/widgets.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/end_points.dart';
import '../../../../utils/helpers/dio_helper.dart';
import '../../../../widgets/widgets_part2.dart';
import '../../jobs/jobs_model.dart';
import '../../profile/profile_model.dart';
import 'employee_profile_states.dart';



class EmployeeProfileCubit extends Cubit<EmployeeProfileStates> {
  EmployeeProfileCubit() : super(EmployeeProfileAboutMeState());

  static EmployeeProfileCubit get(context) => BlocProvider.of(context);




  dynamic skills="";
  static dynamic videoFile="";
  static dynamic cvFile="";

  ///get profile data
  ProfileModel? profileModel;
  dynamic profile;
  void getEmployeeProfileDetails(id){
    print('before load');
    emit(EmployeeProfileLoadingState());

    DioHelper.getData(
      url: "$EMPLOYEE_PROFILE/$id",
      token: token,
    ).then((value){
      print('rami');
      print(value?.data);
      profileModel = ProfileModel.fromJson(value?.data);
      print(profileModel?.status);
      print(profileModel?.message);
      print(profileModel?.data?.email);
      profile = profileModel?.data;
      print("${baseUrl}videos/videos/${profile.employee.video.filename}");
      videoFile="${baseUrl}videos/videos/${profile.employee.video.filename}";
      cvFile="${baseUrl}files/CVs/${profile.employee.cv}";
      skills=profile.employee.skills.map((skill) {
        return "\n- ${skill.skill}";
      }).toString();
      skills=skills.substring(1,skills.length - 1);
      print('nasser');
      emit(EmployeeProfileSuccessState());
    }).catchError((error){
      print(error.toString());

      emit(EmployeeProfileErrorState(error.toString()));
    });
  }



}

