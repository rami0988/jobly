import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/modules/announcements/announcement_view.dart';
import 'package:jobly/modules/applications/applications_view.dart';
import 'package:jobly/modules/regular/jobs/jobs_view.dart';
import 'package:jobly/modules/regular/profile/profile_view.dart';
import '../community/community_view.dart';
import 'home_layout_states.dart';

class HomeCubit extends Cubit<HomeLayoutStates> {
  HomeCubit() : super(HomeLayoutInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const JobsView(),
    const ApplicationsView(),
    const CommunityView(),
    const AnnouncementsView(),
    const ProfileScreen(),
  ];

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(HomeLayoutChangeTabState());
  }
}





