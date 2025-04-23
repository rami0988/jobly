
abstract class AnnouncementsStates{}

class AnnouncementsInitialState extends AnnouncementsStates{}

class AnnouncementsLoadingState extends AnnouncementsStates{}

class AnnouncementsSuccessState extends AnnouncementsStates{}

class AnnouncementsErrorState extends AnnouncementsStates{
  final String error;
  AnnouncementsErrorState(this.error);
}



