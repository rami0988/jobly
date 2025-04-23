abstract class AddJobStates{}
class AddJobInitialState extends AddJobStates{}
class AddJobLoadingState extends AddJobStates{}
class AddJobSuccessState extends AddJobStates{}
class AddJobErrorState extends AddJobStates{
  final String error;
  AddJobErrorState(this.error);
}

class AddJobTypeDropDownState extends AddJobStates{}
class AddJobCategoryDropDownState extends AddJobStates{}
class AddJobSectionDropDownState extends AddJobStates{}

class CategoriesLoadingState extends AddJobStates{}
class CategoriesSuccessState extends AddJobStates{}
class CategoriesErrorState extends AddJobStates{
  final String error;
  CategoriesErrorState(this.error);
}

class SectionsLoadingState extends AddJobStates{}
class SectionsSuccessState extends AddJobStates{}
class SectionsErrorState extends AddJobStates{
  final String error;
  SectionsErrorState(this.error);
}

class UploadImageLoadingState extends AddJobStates{}
class UploadImageSuccessState extends AddJobStates{}
class UploadImageErrorState extends AddJobStates{
  final String error;
  UploadImageErrorState(this.error);
}