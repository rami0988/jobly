import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/end_points.dart';
import '../../../../utils/helpers/dio_helper.dart';
import '../../search/categories_model.dart';
import '../../search/sections_by_category_model.dart';
import '../edit_profile_model.dart';
import 'edit_profile_states.dart';



class EditProfileCubit extends Cubit<EditProfileStates> {
  EditProfileCubit() : super(EditProfileInitialState());

  static EditProfileCubit get(context) => BlocProvider.of(context);


  String? dropDownValueType;
  List<DropdownMenuItem> menuItemsType = [
    const DropdownMenuItem<dynamic>(
      value: "remotely",
      child: Text("Remotely"),
    ),
    const DropdownMenuItem<dynamic>(
      value: "part_time",
      child: Text("Part Time"),
    ),
    const DropdownMenuItem<dynamic>(
      value: "full_time",
      child: Text("Full Time"),
    )
  ];
  String? dropDownValueCategory;
  List<DropdownMenuItem> menuItemsCategory = [];
  String? dropDownValueSection;
  List<DropdownMenuItem> menuItemsSection = [];
  String? dropDownValueWorkStatus;
  List<DropdownMenuItem> menuItemsWorkStatus = [
    const DropdownMenuItem<dynamic>(
      value: "working",
      child: Text("Working"),
    ),
    const DropdownMenuItem<dynamic>(
      value: "not working",
      child: Text("Not Working"),
    ),
    const DropdownMenuItem<dynamic>(
      value: "student",
      child: Text("Student"),
    )
  ];
  String? dropDownValueGraduation;
  List<DropdownMenuItem> menuItemsGraduation = [
    const DropdownMenuItem<dynamic>(
      value: "graduated",
      child: Text("Graduated"),
    ),
    const DropdownMenuItem<dynamic>(
      value: "Not graduated",
      child: Text("Not Graduated"),
    ),
  ];

  // drop down buttons changing method
  void changeTypeDropDownButton( newValue)
  {
    dropDownValueType = newValue;
    emit(EditProfileTypeDropDownState());
  }
  void changeSectionDropDownButton( newValue)
  {
    dropDownValueSection = newValue;
    emit(EditProfileSectionDropDownState());
  }
  void changeCategoryDropDownButton( newValue)
  {
    dropDownValueCategory = newValue;
    emit(EditProfileCategoryDropDownState());
  }
  void changeWorkStatusDropDownButton( newValue)
  {
    dropDownValueWorkStatus = newValue;
    emit(EditProfileWorkStatusDropDownState());
  }
  void changeGraduationDropDownButton( newValue)
  {
    dropDownValueGraduation = newValue;
    emit(EditProfileGraduationDropDownState());
  }

  ///bringing sections and putting them in a dropdown button
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
      menuItemsCategory = categories!.map((category) {
        return DropdownMenuItem<dynamic>(
          value: '${category.id}',
          child: Text('${category.category}'),
        );

      }).toList();

      emit(CategoriesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CategoriesErrorState(error.toString()));
    });
  }
  ///bringing sections and putting them in a dropdown button
  SectionsByCategoryModel? sectionsModel;
  List<dynamic>? sections;
  void getSections(id)
  {
    emit(SectionsLoadingState());
    DioHelper.getData(
      url: "$GET_SECTIONS_FOR_CATEGORY/$id",
      token: token,
    ).then((value) {
      print(value?.data);
      sectionsModel = SectionsByCategoryModel.fromJson(value?.data);
      print(sectionsModel?.status);
      print(sectionsModel?.message);
      print(sectionsModel?.data[0].section);
      sections = sectionsModel?.data;
      print(sections?[1].id);
      menuItemsSection = sections!.map((section) {
        return DropdownMenuItem<dynamic>(
          value: '${section.id}',
          child: Text('${section.section}'),
        );

      }).toList();


      emit(SectionsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CategoriesErrorState(error.toString()));
    });
  }


  ///Edit Profile
  EditProfileModel? editProfileModel;
  dynamic editedProfile;
  Future editProfile({
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
  })async{
    emit(EditProfileLoadingState());
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
      formDataMap['photo'] = await MultipartFile.fromFile(filePath, filename: fileName);
    }
    FormData data = FormData.fromMap(formDataMap);
    var dio=Dio();
    dio.post(
        "${baseUrl}api/$EDIT_PROFILE",
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        onSendProgress: (int sent,int total){
          print('$sent $total');
        }).then((value){
      print(value.data);
      // editProfileModel = EditProfileModel.fromJson(value.data);
      // print(editProfileModel?.status);
      // print(editProfileModel?.message);
      // print(editProfileModel?.data.image);
      // editedProfile = editProfileModel?.data;
      // print("${baseUrl}images/${editedProfile.image}");
      emit(EditProfileSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(EditProfileErrorState(error.toString()));
    });
  }

  ///LOCATION
  bool locationStatus=false;
  String locationMessage='';
  void addLocation({required country,required city,required governorate})
  {
    emit(AddLocationLoadingState());
    DioHelper.postData(
      url: ADD_LOCATION,
      token: token,
      data: {
        'county' : country,
        'city' : city,
        'Governorate' : governorate
      },
    ).then((value) {
      print(value?.data);
      locationStatus=value?.data["status"];
      locationMessage=value?.data["message"];

      emit(AddLocationSuccessState(locationStatus,locationMessage));
    }).catchError((error){
      print(error.toString());
      emit(AddLocationErrorState(error.toString()));
    });
  }

  ///SKILL
  bool skillStatus=false;
  String skillMessage='';
  void addSkill({required skill})
  {
    emit(AddSkillLoadingState());
    DioHelper.postData(
      url: ADD_SKILL,
      token: token,
      data: {
        'skill' : skill,
      },
    ).then((value) {
      print(value?.data);
      skillStatus=value?.data["status"];
      skillMessage=value?.data["message"];

      emit(AddSkillSuccessState(skillStatus,skillMessage));
    }).catchError((error){
      print(error.toString());
      emit(AddSkillErrorState(error.toString()));
    });
  }

  ///FAVOURITE
  bool favouriteStatus=false;
  String favouriteMessage='';
  void addFavourite({required section})
  {
    emit(AddFavouriteLoadingState());
    DioHelper.postData(
      url: ADD_FAVOURITE,
      token: token,
      data: {
        'job_section_id' : section,

      },
    ).then((value) {
      print(value?.data);
      favouriteStatus=value?.data["status"];
      favouriteMessage=value?.data["message"];

      emit(AddFavouriteSuccessState(favouriteStatus,favouriteMessage));
    }).catchError((error){
      print(error.toString());
      emit(AddFavouriteErrorState(error.toString()));
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
      allowedExtensions: ['jpg','png'],
    );
    if (result != null) {
      selectedFile = File(result.files.single.path ?? "");
      print(selectedFile?.path);
      fileName = selectedFile!.path.split(r'\').last;
      filePath = selectedFile!.path;
      emit(UploadImageSuccessState());
    } else {
      emit(UploadImageErrorState("No file selected"));
    }
  }


}

