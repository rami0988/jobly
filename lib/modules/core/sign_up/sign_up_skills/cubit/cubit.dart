









import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/modules/core/sign_up/sign_up_skills/cubit/states.dart';

import '../../../../../utils/end_points.dart';
import '../../../../../utils/helpers/cache_helper.dart';
import '../../../../../utils/helpers/dio_helper.dart';
import '../../sign_up_address/cubit/states.dart';
import '../sign_up_skills_modle.dart';

class SignUpSkillCubit extends Cubit<SignupSkillStates> {
  SignUpSkillCubit() : super(SignupIntSkillStates());

  static SignUpSkillCubit get(context) => BlocProvider.of(context);

  void SkillSignUp({
    required String skill,

  }) {
    
    
    DioHelper.postData(
      
      url: SIGHNUPSKILL,
      data: {
        'skill': skill,

        
      },
      token: CacheHelper.getData(key: 'token')
    ).then((value) {
      print("rami");
      
      var dataResponse= SkillModle.fromJson(value?.data);

      print(dataResponse.data?.skill);


      emit(SignupSkillSuccessStates());
    }).catchError((error) {
      emit(SignupSkillErorrStates(error.toString()));
    });
  }
}