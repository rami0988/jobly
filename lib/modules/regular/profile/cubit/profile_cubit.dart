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
import '../profile_model.dart';
import 'profile_states.dart';


class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileAboutMeState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;

  void changeColor(int index) {
    selectedIndex = index;
    emit(ProfileChangeState());
  }

  Widget getSelectedWidget(cubit,context,state) {
    switch (selectedIndex) {
      case 0:
        return aboutMe(cubit,context);
      case 1:
        if(cubit.jobs!.isNotEmpty) {
          return jobsBuilder(cubit.jobs, cubit, context, state,"mine");
        } else {
          return const Center(child: Text("No Jobs Added Yet..."));
        }
      case 2:
        return settings(context,cubit,state);
      default:
        return const SizedBox.shrink();
    }
  }

bool isEnglish = false;  // Initial value of the switch
  String language = 'English';         // Initial value of the text widget

  void changeLanguage(bool value) {
      isEnglish = value;
      language = value ? 'Arabic' : 'English'; 
      emit(ChangeLanguageState()); // Update the text value based on the switch state
    
  }


  bool isDark = false;  // Initial value of the switch
  String mode = 'Dark';     
  IconData icon  =  Icons.dark_mode; 
  Color iconColor =const Color.fromARGB(255, 0, 58, 94) ;
  Color iconBackgroundColor =const Color.fromARGB(255, 0, 102, 165) ;// Initial value of the text widget
  // Initial value of the text widget

  void changeMode(bool value) {
      isDark = value;
      mode = value ? 'Light' : 'Dark'; 
      iconColor = value ? const Color.fromARGB(255, 201, 124, 0): const Color.fromARGB(255, 0, 58, 94);
      iconBackgroundColor = value ?const Color.fromARGB(255, 255, 191, 0): const Color.fromARGB(255, 0, 137, 222);
      icon = value ?Icons.light_mode: Icons.dark_mode ;

      emit(ChangeLanguageState()); // Update the text value based on the switch state
    
  }


  dynamic skills="";
  static dynamic videoFile="";
  static dynamic cvFile="";

///get profile data
ProfileModel? profileModel;
   dynamic profile;
void getProfileDetails(){
  print('before load');
  emit(ProfileLoadingState());
  
  DioHelper.getData(
    url: PROFILE,
    token: token,
    ).then((value){
      print('rami');
      print(value?.data);
      profileModel = ProfileModel.fromJson(value?.data);
      print(profileModel?.status);
      print(profileModel?.message);
      print(profileModel?.data?.email);
      profile = profileModel?.data;


      //print("${baseUrl}videos/videos/${profile.employee.video.filename}");
      videoFile=profile.employee.video!=null?"${baseUrl}videos/videos/${profile.employee.video.filename}":null;
      cvFile="${baseUrl}files/CVs/${profile.employee.cv}";
      skills=profile.employee.skills.map((skill) {
        return "\n- ${skill.skill}";
      }).toString();
      skills=skills.substring(1,skills.length - 1);
      emit(ProfileSucsessState());
    }).catchError((error){
      print(error.toString());

      emit(ProfileErrorState(error.toString()));
    });
}



  // function to handle file selection
  File? selectedFile;
  String? fileName;
  String? filePath;
  FormData? data;

  Future<void> selectFile() async {
    emit(UploadFileLoadingState());
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf','jpg','png','mp4','wav'],
    );
    if (result != null) {
      selectedFile = File(result.files.single.path ?? "");
      print(selectedFile?.path);
      fileName = selectedFile!.path.split(r'\').last;
      filePath = selectedFile!.path;
      emit(UploadFileSuccessState());
    } else {
      emit(UploadFileErrorState("No file selected"));
    }
  }



//function to handle sending the selected file
  Future sendFile({
    required filePath,
    required fileName,
  })async{
    emit(SendFileLoadingState());
    FormData data = FormData.fromMap({
      'cv': await MultipartFile.fromFile(filePath,filename: fileName)
    });
    var dio=Dio();
    dio.post(
        "${baseUrl}api/employee/cv/upload",
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        onSendProgress: (int sent,int total){
          print('$sent $total');
        }).then((value) {
      print(value.data);
      emit(SendFileSuccessState());
    }).catchError((error) {
      print(error);
      emit(
        SendFileErrorState(error.toString()),
      );
    });

  }

  Future sendVideo({
    required filePath,
    required fileName,
  })async{
    emit(SendVideoLoadingState());
    FormData data = FormData.fromMap({
      'video': await MultipartFile.fromFile(filePath,filename: fileName)
    });
    var dio=Dio();
    dio.post(
        "${baseUrl}api/employee/upload/video",
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        onSendProgress: (int sent,int total){
          print('$sent $total');
        }).then((value) {
      print(value.data);
      emit(SendVideoSuccessState());
    }).catchError((error) {
      print(error);
      emit(
        SendVideoErrorState(error.toString()),
      );
    });

  }
  

  ///GET MY VACANCIES
  JobsModel? jobsModel;
  List<dynamic>? jobs=[];
  void getMyJobs()
  {
    emit(GetMyJobsLoadingState());
    DioHelper.getData(
      url: GET_MY_JOBS,
      token: token,
    ).then((value) {
      print(value?.data);
      jobsModel = JobsModel.fromJson(value?.data);
      print(jobsModel?.status);
      print(jobsModel?.message);
      print(jobsModel?.data[0].section);
      jobs = jobsModel?.data;
      print(jobsModel?.data[0].description);
      emit(GetMyJobsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetMyJobsErrorState(error.toString()));
    });
  }

  ///DELETE MY VACANCIES

  void deleteMyJob(id)
  {
    emit(DeleteMyJobLoadingState());
    DioHelper.getData(
      url: "$DELETE_JOB/$id",
      token: token,
    ).then((value) {
      print(value?.data);
      emit(DeleteMyJobSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(DeleteMyJobErrorState(error.toString()));
    });
  }

  ///VERIFICATION

  bool verificationStatus=false;
  String verificationMessage="";
  void sendVerification()
  {
    emit(SendVerificationLoadingState());
    DioHelper.postData(
      url: SEND_VERIFICATION,
      token: token,
    ).then((value) {
      print(value?.data);
      verificationStatus=value?.data['status'];
      verificationMessage=value?.data['message'];
      emit(SendVerificationSuccessState(verificationStatus,verificationMessage));
    }).catchError((error){
      print(error.toString());
      emit(SendVerificationErrorState(error.toString()));
    });
  }

  void cancelVerification()
  {
    emit(CancelVerificationLoadingState());
    DioHelper.postData(
      url: CANCEL_VERIFICATION,
      token: token,
    ).then((value) {
      print(value?.data);
      verificationStatus=value?.data['status'];
      verificationMessage=value?.data['message'];
      emit(CancelVerificationSuccessState(verificationStatus,verificationMessage));
    }).catchError((error){
      print(error.toString());
      emit(CancelVerificationErrorState(error.toString()));
    });
  }

}

