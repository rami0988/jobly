import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/modules/core/sign_up/sign_up_employy/cubit/states.dart';
import 'package:jobly/utils/constants.dart';
import 'package:jobly/utils/end_points.dart';
import '../signup_modle_employy.dart';


class SignUpEmployyCubit extends Cubit<SignUpEmployyState> {
  SignUpEmployyCubit() : super(SignUpEmployyInitial());

  static SignUpEmployyCubit get(context) => BlocProvider.of(context);

  String? graduationStatus;
  String? workingStatus;


  void changeGraduationStatus(bool isGraduated) {
    graduationStatus = isGraduated ? 'graduated' : 'Not graduated';
    emit(GraduationStatusState(graduationStatus: graduationStatus!));
  }

  void changeWorkingStatus(String status) {
    workingStatus = status;
    emit(WorkingStatusState(workingStatus: workingStatus!));
  }

  ///Edit Profile
  SignUpEmployyModlee? signUpEmployyModlee;
  dynamic signup;

  Future signUpEmployee({
    dateOfBirth,
    resume,
    experience,
    education,
    portfolio,
    phoneNumber,
    workStatus,
    graduationStatus,
    filePath,
    fileName
  }) async {
    emit(SignUpEmployyLoading());
    Map<String, dynamic> formDataMap = {
      'date_of_birth': dateOfBirth,
      'resume': resume,
      'experience': experience,
      'education': education,
      'portfolio': portfolio,
      'phone_number': phoneNumber,
      'work_status': workStatus,
      'graduation_status': graduationStatus,
    };
    if (filePath != null) {
      formDataMap['photo'] =
      await MultipartFile.fromFile(filePath, filename: fileName);
    }
    FormData data = FormData.fromMap(formDataMap);
    var dio = Dio();
    dio.post(
        "${baseUrl}api/$SIGHNUPEMPLOYY",
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        }).then((value) {
      print(value.data);
      // editProfileModel = EditProfileModel.fromJson(value.data);
      // print(editProfileModel?.status);
      // print(editProfileModel?.message);
      // print(editProfileModel?.data.image);
      // editedProfile = editProfileModel?.data;
      // print("${baseUrl}images/${editedProfile.image}");
      emit(SignUpEmployySuccess());
    }).catchError((error) {
      print(error.toString());
      emit(SignUpEmployyError(error.toString(), error: error.toString()));
    });
  }


  // function to handle file selection
  File? selectedFile;
  String? fileName;
  String? filePath;
  FormData? data;

  Future<void> selectFile() async {
    emit(UploadImageLoadingState());
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );
    if (result != null) {
      selectedFile = File(result.files.single.path ?? "");
      print(selectedFile?.path);
      fileName = selectedFile!
          .path
          .split(r'\')
          .last;
      filePath = selectedFile!.path;
      emit(UploadImageSuccessState());
    } else {
      emit(UploadImageErrorState("No file selected"));
    }
  }
}