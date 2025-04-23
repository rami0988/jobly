// sign_up_employy_event.dart
abstract class SignUpEmployyEvent {}

class GraduationStatusChanged extends SignUpEmployyEvent {
  final bool isGraduated;

  GraduationStatusChanged({required this.isGraduated});
}

class WorkingStatusChanged extends SignUpEmployyEvent {
  final String workingStatus;

  WorkingStatusChanged({required this.workingStatus});
}

// sign_up_employy_state.dart
abstract class SignUpEmployyState {}

class SignUpEmployyInitial extends SignUpEmployyState {}

class SignUpEmployyLoading extends SignUpEmployyState {}

class SignUpEmployySuccess extends SignUpEmployyState {}

class SignUpEmployyError extends SignUpEmployyState {
  final String error;

  SignUpEmployyError(String string, {required this.error});
}

class GraduationStatusState extends SignUpEmployyState {
  final String graduationStatus;

  GraduationStatusState({required this.graduationStatus});
}

class WorkingStatusState extends SignUpEmployyState {
  final String workingStatus;

  WorkingStatusState({required this.workingStatus});
}

class UploadImageLoadingState extends SignUpEmployyState{}
class UploadImageSuccessState extends SignUpEmployyState{}
class UploadImageErrorState extends SignUpEmployyState{
  final String error;
  UploadImageErrorState(this.error);
}
