


import 'package:flutter/material.dart';
import 'package:jobly/modules/core/sign_up/sign_up_employy/signup_employy_view.dart';
import 'package:jobly/resources/color_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/style_manager.dart';
import '../../../utils/helpers/cache_helper.dart';
import '../../../widgets/widgets.dart';
import '../login/login_screen.dart';
import '../sign_up/sign_up_fav/signup_fav_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  
  @override
  State<OnboardingView> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnboardingView> {
      var boardcontroller =PageController();

      List<BoardingModle> boarding =[
        BoardingModle(
             body: AppStrings.body1 ,
             title: AppStrings.title1,
             image: ImageAssets.onboarding1
          ),
        BoardingModle(
             body:AppStrings.body2 ,
             title: AppStrings.title2,
             image: ImageAssets.onboarding2
          ),
        BoardingModle(
             body:AppStrings.body3 ,
             title: AppStrings.title3,
             image: ImageAssets.onboarding3
          )
      ];

      bool islast =false;

      void submit()
      {
        CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
          navigateTo(context, LoginPage());
        });
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: ()
            {
              submit();

            },
           child: Text(AppStrings.skip,style:getBoldStyle(color: ColorManager.purple4,fontSize: FontSize.s20) )
           ),
           
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
              physics:  const BouncingScrollPhysics(),
              controller: boardcontroller,
              onPageChanged: (int index){
                if(index == boarding.length-1){

                  setState(() {
                    islast=true;
                  });
                  
                }else{
                  setState(() {
                    islast =false;
                  });
                }
              },
              itemBuilder:(context,index)=> bulidBoardingItem(boarding[index]),
              itemCount: boarding.length ,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
             Row(children: [
             SmoothPageIndicator(
              controller: boardcontroller, 
              effect:  const ExpandingDotsEffect(
                activeDotColor: ColorManager.purple4,
                dotColor: Colors.grey,
                dotHeight: 10,
                expansionFactor: 4,
                dotWidth: 10,
                spacing: 5.0

              ),
              count: boarding.length,
              ),
             const Spacer(),
              FloatingActionButton(
                backgroundColor: ColorManager.purple4,
                onPressed: 
                ()
                {
                  if(islast)
                  {
                   submit();
                  }
                  boardcontroller.nextPage(
                    duration: const Duration(
                      milliseconds: 1000,
                    ),
                     curve: Curves.fastLinearToSlowEaseIn
                     
                     );

                },
                child: const Icon(Icons.arrow_forward_ios),)
            ],)
          ],
        ),
      )
    );
  }


}