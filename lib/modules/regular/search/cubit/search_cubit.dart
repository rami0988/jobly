import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/modules/regular/search/categories_model.dart';
import 'package:jobly/utils/end_points.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/helpers/dio_helper.dart';
import '../cities_model.dart';
import '../search_model.dart';
import '../sections_model.dart';
import 'search_states.dart';


class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);


  static List<dynamic> selectedCities=[];
  static List<dynamic> selectedTypes=[];
  static List<dynamic> selectedCategories=[];
  static List<dynamic> selectedSections=[];

  ///SEARCH
  SearchModel? searchModel;
  List<dynamic>? jobs=[];

  void getSearch({required text}) {
    emit(SearchInitialState());
    DioHelper.getData(
      url: SEARCH,
      token: token,
      query:{
        'name':text
      }
    ).then((value) {
      print(value?.data);
      searchModel = SearchModel.fromJson(value?.data);
      print(searchModel?.status);
      print(searchModel?.message);
      print(searchModel?.data[0].section);
      jobs = searchModel?.data;
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState(error.toString()));
    });
  }

  void getFilter() {
    emit(FilterLoadingState());
    DioHelper.getData(
        url: FILTER,
        token: token,
        data : {
          'cities':selectedCities,
          'job_section_ids':selectedSections,
          'job_category_ids':selectedCategories,
          'job_types':selectedTypes,
        }
    ).then((value) {
      print(value?.data);
      searchModel = SearchModel.fromJson(value?.data);
      print(searchModel?.status);
      print(searchModel?.message);
      print(searchModel?.data[0].section);
      jobs = searchModel?.data;
      emit(FilterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(FilterErrorState(error.toString()));
    });
  }

  void getFreelance() {
    emit(FreelanceLoadingState());
    DioHelper.getData(
        url: GET_FREELANCE,
        token: token,
    ).then((value) {
      print(value?.data);
      searchModel = SearchModel.fromJson(value?.data);
      print(searchModel?.status);
      print(searchModel?.message);
      print(searchModel?.data[0].section);
      jobs = searchModel?.data;
      emit(FreelanceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(FreelanceErrorState(error.toString()));
    });
  }

  


  List<MultiSelectItem<dynamic>> typeItems = [
    MultiSelectItem("full_time", "Full Time"),
    MultiSelectItem("part_time", "Part Time"),
    MultiSelectItem("remotely", "Remotely")
  ];

  ///bringing cities and putting them in a multi select dialog
  List<MultiSelectItem<dynamic>> cityItems = [];

  CitiesModel? citiesModel;
  List<dynamic>? cities;
  void getCities()
  {
    emit(CitiesLoadingState());
    DioHelper.getData(
      url: GET_CITIES,
      token: token,
    ).then((value) {
      print(value?.data);
      citiesModel = CitiesModel.fromJson(value?.data);
      print(citiesModel?.status);
      print(citiesModel?.message);
      cities = citiesModel?.data;
      cityItems = cities!.map((city) {
        return MultiSelectItem(city.city, city.city);
      }).toList();

      emit(CitiesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CitiesErrorState(error.toString()));
    });
  }

  ///bringing categories and putting them in a multi select dialog
  List<MultiSelectItem<dynamic>> categoriesItems = [];

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
        return MultiSelectItem(category.id, category.category);
      }).toList();

      emit(CategoriesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CategoriesErrorState(error.toString()));
    });
  }


  ///bringing sections and putting them in a multi select dialog
  List<MultiSelectItem<dynamic>> sectionsItems = [];

  SectionsModel? sectionsModel;
  List<dynamic>? sections;
  void getSections()
  {
    emit(SectionsLoadingState());
    DioHelper.getData(
      url: GET_SECTIONS,
      token: token,
    ).then((value) {
      print(value?.data);
      sectionsModel = SectionsModel.fromJson(value?.data);
      print(sectionsModel?.status);
      print(sectionsModel?.message);
      print(sectionsModel?.data[0].section);
      sections = sectionsModel?.data;
      print(sections?[1].id);
      sectionsItems = sections!.map((section) {
        return MultiSelectItem(section.id, section.section);
      }).toList();

      emit(SectionsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CategoriesErrorState(error.toString()));
    });
  }


}