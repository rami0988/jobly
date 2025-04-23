import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/utils/bloc_observer.dart';
import 'package:jobly/utils/constants.dart';
import 'package:jobly/utils/helpers/cache_helper.dart';
import 'package:jobly/utils/helpers/dio_helper.dart';


import 'app/app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  token = CacheHelper.getData(key: 'token');
  onBoardingSkipped = CacheHelper.getData(key: 'onBoarding');
  runApp(MyApp());
}

