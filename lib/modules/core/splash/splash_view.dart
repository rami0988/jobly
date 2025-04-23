import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jobly/modules/home/home_layout_view.dart';


import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/constants_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../utils/constants.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}


class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  _startDelay(){
    _timer=Timer(const Duration(seconds: AppConstants.splashDelay),_goNext);
  }
  _goNext() {
   // Navigator.pushReplacementNamed(context, Routes.homeRoute);
    if (onBoardingSkipped != null) {
      if (token != null) {
        Navigator.pushReplacementNamed(context, Routes.homeRoute);
      }
      else {
        Navigator.pushReplacementNamed(context, Routes.loginRoute);
      }
    } else {
      Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
    }


  }
  @override
  void initState() {
    super.initState();
    _startDelay();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorManager.purple4, // Darker purple
              ColorManager.purple7, // Lighter purple (adjust as needed)
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: const Center(
          child: Image(image: AssetImage(ImageAssets.whiteLogo)),
        ),
      ),
    );
  }

  @override
  void dispose(){
    _timer?.cancel();
    super.dispose();
  }
}
