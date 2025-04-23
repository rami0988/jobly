import 'package:bloc/bloc.dart';



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/modules/core/sign_up/sign_up_user/cubit/states.dart';

import '../../../../../utils/constants.dart';
import '../../../../../utils/end_points.dart';
import '../../../../../utils/helpers/cache_helper.dart';
import '../../../../../utils/helpers/dio_helper.dart';
import '../singup_modle.dart';




class SignUpUserCubit extends Cubit<SignupUserStates> {
  SignUpUserCubit() : super(SignupIntStates());

  static SignUpUserCubit get(context) => BlocProvider.of(context);

  String? message="";
  void userSignUp({
    required String email,
    required String password,
    required String name,
  }) {
    CacheHelper.init();
    emit(SignupLoadingStates());
    DioHelper.postData(
      url: SIGHNUPUSER,
      data: {
        'email': email,
        'name':name,
        'password': password,
        'role':"1",
      },
    ).then((value) {
      print("rami");
      
      var dataResponse= UserSignupModle.fromJson(value?.data);
      token = dataResponse.data?.token;
      message = dataResponse.message;
      print(token);
      CacheHelper.saveData(key: 'token', value:token );
      print( CacheHelper.getData(key: 'token'));

      emit(SignupSuccessStates());
    }).catchError((error) {
      emit(SignupErorrStates(error.toString(),message!));
    });
  }
}