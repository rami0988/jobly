import 'package:flutter/material.dart';
import 'package:jobly/modules/announcements/announcement_view.dart';
import 'package:jobly/modules/community/community_view.dart';
import 'package:jobly/modules/core/login/login_screen.dart';
import 'package:jobly/modules/core/onboarding/onboarding_view.dart';
import 'package:jobly/modules/core/sign_up/sign_up_employy/signup_employy_view.dart';
import 'package:jobly/modules/home/home_layout_view.dart';
import 'package:jobly/resources/strings_manager.dart';
import '../modules/applications/applications_view.dart';
import '../modules/core/splash/splash_view.dart';


class Routes{
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String communityRoute = "/community";
  static const String questionRoute = "/question";
  static const String announcementsRoute = "/announcements";
  static const String applicationsRoute = "/applications";
  static const String homeRoute = "/home";


}
class RouteGenerator{
  static Route<dynamic> getRoute(RouteSettings routeSettings){
    switch (routeSettings.name){
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_)=>const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_)=> const OnboardingView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_)=> const LoginPage());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_)=>  SingupEmployy());
      case Routes.communityRoute:
       return MaterialPageRoute(builder: (_)=> const CommunityView());
      case Routes.announcementsRoute:
        return MaterialPageRoute(builder: (_)=> const AnnouncementsView());
      case Routes.applicationsRoute:
        return MaterialPageRoute(builder: (_)=> const ApplicationsView());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_)=> const HomeLayoutView());        
      default:
        return unDefinedRoute();
    }
  }
  static Route<dynamic> unDefinedRoute(){
    return MaterialPageRoute(builder: (_)=>
    Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.noRouteFound),
      ),
      body: const Center(child: Text(AppStrings.noRouteFound)),
    )
    );
  }
}