import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/utils/end_points.dart';
import '../../../utils/constants.dart';
import '../../../utils/helpers/dio_helper.dart';
import '../model/announcements_model.dart';
import 'announcements_states.dart';


class AnnouncementsCubit extends Cubit<AnnouncementsStates>{
  AnnouncementsCubit() : super(AnnouncementsInitialState());
  static AnnouncementsCubit get(context) => BlocProvider.of(context);

  ///GET ANNOUNCEMENTS
  AnnouncementsModel? announcementsModel;
  List<dynamic>? announcements;
  void getAnnouncements()
  {
    emit(AnnouncementsLoadingState());
    DioHelper.getData(
      url: GET_ANNOUNCEMENTS,
      token: token,
    ).then((value) {
      print(value?.data);
      announcementsModel = AnnouncementsModel.fromJson(value?.data);
      print(announcementsModel?.status);
      print(announcementsModel?.message);
      print(announcementsModel?.data[0]);
      announcements = announcementsModel?.data;
      emit(AnnouncementsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AnnouncementsErrorState(error.toString()));
    });
  }

}