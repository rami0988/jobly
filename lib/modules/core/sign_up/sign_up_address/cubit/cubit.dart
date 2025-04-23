






import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/modules/core/sign_up/sign_up_address/cubit/states.dart';

import '../../../../../utils/end_points.dart';
import '../../../../../utils/helpers/cache_helper.dart';
import '../../../../../utils/helpers/dio_helper.dart';
import '../signup_address_modle.dart';

class SignUpAddressCubit extends Cubit<SignupAddressStates> {
  SignUpAddressCubit() : super(SignupIntAddressStates());

  static SignUpAddressCubit get(context) => BlocProvider.of(context);

  void AddressSignUp({
    required String county,
    required String city,
    required String Governorate,
  }) {
    
    
    DioHelper.postData(
      
      url: SIGHNUPADDRESS,
      data: {
        'county': county,
        'city':city,
        'Governorate': Governorate,
        
      },
      token: CacheHelper.getData(key: 'token')
    ).then((value) {
      print("rami");
      
      var dataResponse= SignUpAddressModlee.fromJson(value?.data);

      print(dataResponse.data?.county);


      emit(SignupAddressSuccessStates());
    }).catchError((error) {
      emit(SignupAddressErorrStates(error.toString()));
    });
  }
}