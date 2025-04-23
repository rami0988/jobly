
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/modules/core/sign_up/sign_up_fav/cubit/states.dart';
import 'package:jobly/utils/constants.dart';

import '../../../../../utils/end_points.dart';
import '../../../../../utils/helpers/cache_helper.dart';
import '../../../../../utils/helpers/dio_helper.dart';
import '../signup_fav_modle.dart';
import '../signup_getcat_modle.dart';
import '../signup_getsubcat_modle.dart';


class SignUpFavCubit extends Cubit<SignupFavStates> {
  SignUpFavCubit() : super(SignupIntFavStates());

  static SignUpFavCubit get(context) => BlocProvider.of(context);

  void FavSignUp({
    required String favid,
  }) {
    DioHelper.postData(
      
      url: SIGHNUPADDFAV,
      data: {
        'job_section_id': favid,    
      },
      token: token
    ).then((value) {
      print("rami");
      
      var dataResponse= AddFav.fromJson(value?.data);

      print(dataResponse.data?.jopsSectionId);


      emit(SignupFavSuccessStates());
    }).catchError((error) {
      emit(SignupFavErorrStates(error.toString()));
    });
  }



List<MyData> cat = [];


void getCat() {
  emit(SignupFavLoadingStates());

  if (cat.isEmpty) {
    DioHelper.getData(
      url: SIGHNUPGETCAT,
      token: token,
    ).then((value) {
      print(value);
      // print(type)
      // cat = value?.data['data'];
    
      cat=GetCat.fromJson(value?.data).data!;
      // print(cat)
      var dataResponse = GetCat.fromJson(value?.data);
    print('rami');

      print(cat);
      
      emit(SignupFavSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SignupFavErorrStates(error.toString()));
    });
  } else {
    emit(SignupFavSuccessStates());
  }
}





 List<JopsSection> sub_cat=[];
 List<SubData> data=[];
  void getSubCat(var id){
    emit(SignupFavLoadingStates());
    print("h");
    
      print('m');
      DioHelper.getData(
      url:'$SIGHNUPGETSUBCAT$id',
      token: token,
      ).then((value) {
        print('s');
        data=SubCatModle.fromJson(value?.data).data!;
        sub_cat=data[0].jopsSection!;
        print(sub_cat);
              var dataResponse= SubCatModle.fromJson(value?.data);
              
              emit(SignupFavSuccessStates());
      })
      .catchError((error)
              {
                print(error.toString());
                emit(SignupFavErorrStates(error.toString()));
                });

  }




}