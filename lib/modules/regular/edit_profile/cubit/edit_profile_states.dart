abstract class EditProfileStates{}
class EditProfileInitialState extends EditProfileStates{}
class EditProfileLoadingState extends EditProfileStates{}
class EditProfileSuccessState extends EditProfileStates{}
class EditProfileErrorState extends EditProfileStates{
  final String error;
  EditProfileErrorState(this.error);
}

class EditProfileTypeDropDownState extends EditProfileStates{}
class EditProfileCategoryDropDownState extends EditProfileStates{}
class EditProfileSectionDropDownState extends EditProfileStates{}
class EditProfileWorkStatusDropDownState extends EditProfileStates{}
class EditProfileGraduationDropDownState extends EditProfileStates{}

class CategoriesLoadingState extends EditProfileStates{}
class CategoriesSuccessState extends EditProfileStates{}
class CategoriesErrorState extends EditProfileStates{
  final String error;
  CategoriesErrorState(this.error);
}

class SectionsLoadingState extends EditProfileStates{}
class SectionsSuccessState extends EditProfileStates{}
class SectionsErrorState extends EditProfileStates{
  final String error;
  SectionsErrorState(this.error);
}

class UploadImageLoadingState extends EditProfileStates{}
class UploadImageSuccessState extends EditProfileStates{}
class UploadImageErrorState extends EditProfileStates{
  final String error;
  UploadImageErrorState(this.error);
}

class AddLocationLoadingState extends EditProfileStates{}
class AddLocationSuccessState extends EditProfileStates{
  final bool status;
  final String message;
  AddLocationSuccessState(this.status,this.message);
}
class AddLocationErrorState extends EditProfileStates{
  final String error;
  AddLocationErrorState(this.error);
}

class AddSkillLoadingState extends EditProfileStates{}
class AddSkillSuccessState extends EditProfileStates{
  final bool status;
  final String message;
  AddSkillSuccessState(this.status,this.message);
}
class AddSkillErrorState extends EditProfileStates{
  final String error;
  AddSkillErrorState(this.error);
}

class AddFavouriteLoadingState extends EditProfileStates{}
class AddFavouriteSuccessState extends EditProfileStates{
  final bool status;
  final String message;
  AddFavouriteSuccessState(this.status,this.message);
}
class AddFavouriteErrorState extends EditProfileStates{
  final String error;
  AddFavouriteErrorState(this.error);
}