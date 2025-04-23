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
import '../../search/sections_model.dart';
import '../add_job_model.dart';
import 'add_job_states.dart';


class AddJobCubit extends Cubit<AddJobStates> {
  AddJobCubit() : super(AddJobInitialState());

  static AddJobCubit get(context) => BlocProvider.of(context);


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

  // drop down buttons changing method
  void changeTypeDropDownButton( newValue)
  {
    dropDownValueType = newValue;
    emit(AddJobTypeDropDownState());
  }
  void changeSectionDropDownButton( newValue)
  {
    dropDownValueSection = newValue;
    emit(AddJobSectionDropDownState());
  }
  void changeCategoryDropDownButton( newValue)
  {
    dropDownValueCategory = newValue;
    emit(AddJobCategoryDropDownState());
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


  ///ADD JOB
  AddJobModel? addJobModel;
  dynamic job;
  Future addJob({
    required description,
    required jobType,
    required requirements,
    required salary,
    required deadline,
    required sectionId,
    required filePath,
    required fileName,
  })async{
    emit(AddJobLoadingState());
    FormData data = FormData.fromMap({
      'description' : description,
      'job_type' : jobType,
      'requirements' : requirements,
      'salary_range' : salary,
      'application_deadline' : deadline,
      'status' : "open",
      'jops_section_id' : sectionId,
      'image': await MultipartFile.fromFile(filePath,filename: fileName)
    });
    var dio=Dio();
    dio.post(
        "${baseUrl}api/$ADD_JOB",
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        onSendProgress: (int sent,int total){
          print('$sent $total');
        }).then((value){
      print('rami');
      print(value.data);
      addJobModel = AddJobModel.fromJson(value.data);
      print(addJobModel?.status);
      print(addJobModel?.message);
      print(addJobModel?.data.image);
      job = addJobModel?.data;
      print("${baseUrl}images/${job.image}");
      print('nasser');
      emit(AddJobSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AddJobErrorState(error.toString()));
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


//
// //function to handle sending the selected file
//   Future sendFile({
//     required filePath,
//     required fileName,
//   })async{
//     emit(SendFileLoadingState());
//     FormData data = FormData.fromMap({
//       'cv': await MultipartFile.fromFile(filePath,filename: fileName)
//     });
//     var dio=Dio();
//     dio.post(
//         "${baseUrl}api/employee/cv/upload",
//         data: data,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//           },
//         ),
//         onSendProgress: (int sent,int total){
//           print('$sent $total');
//         }).then((value) {
//       print(value.data);
//       emit(SendFileSuccessState());
//     }).catchError((error) {
//       print(error);
//       emit(
//         SendFileErrorState(error.toString()),
//       );
//     });
//
//   }


}

