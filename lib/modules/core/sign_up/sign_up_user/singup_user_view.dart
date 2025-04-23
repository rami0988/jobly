


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/modules/core/sign_up/sign_up_user/cubit/cubit.dart';
import 'package:jobly/modules/core/sign_up/sign_up_user/cubit/states.dart';
import 'package:jobly/resources/strings_manager.dart';

import '../../../../resources/assets_manager.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/values_manager.dart';
import '../../../../widgets/widgets_part2.dart';
import '../sign_up_employy/signup_employy_view.dart';

class SingupUser extends StatelessWidget {
  final TextEditingController _emailNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: BlocProvider(
        create: (context) => SignUpUserCubit(),
        child: BlocListener<SignUpUserCubit, SignupUserStates>(
          listener: (context, state) {
            if (state is SignupErorrStates) {
              showToast(text: "Register Failed : Password must be 8 at least", state: ToastStates.ERROR);
            } else if (state is SignupSuccessStates) {
                 SnackBar(
                  content: Text('Register success'),
                );
              // Navigate to another screen
             Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => SingupEmployy()));
            }
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: AppSize.s100,),
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [

                          Card(   
                            child: Container(
                            width: 300, // العرض
                            height: 500, // الطول
                            padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                      
                                const Image(image: AssetImage(ImageAssets.purpleLogo)),
                                const SizedBox(height: AppSize.s16),
    
                                  const SizedBox(height: AppSize.s32),
                              
                                  defaultFormField(controller: _nameController, type:TextInputType.text, label: AppStrings.name,prefix: Icons.person),
                                  const SizedBox(height: AppSize.s16),
                                  defaultFormField(controller: _emailNumberController, type:TextInputType.emailAddress, label: AppStrings.emaill,prefix: Icons.email),
                                  const SizedBox(height: AppSize.s16),
                                  defaultFormField(controller: _passwordController, type:TextInputType.text, label: AppStrings.password,isPassword: true,prefix: Icons.password),
                                  const SizedBox(height: AppSize.s16),
                                 const  SizedBox(height: 16),
                                  BlocBuilder<SignUpUserCubit, SignupUserStates>(
                                    builder: (context, state) {
                                      if (state is SignupLoadingStates) {
                                        return const CircularProgressIndicator();
                                      }
                              
                                      return ElevatedButton(
                                        onPressed: () {
                                          final email = _emailNumberController.text;
                                          final password = _passwordController.text;
                                          final name = _nameController.text;
                                          BlocProvider.of<SignUpUserCubit>(context).userSignUp(email: email, password: password,name: name);
                                        },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: ColorManager.white, // Set the button's background color to white
                                          )      ,
                                        child:  Text(AppStrings.next,style: TextStyle(color:ColorManager.purple6,),),
                                      );
                                    },
                                  ),

                                ],
                              ),
                            ),
                          ),
                     Positioned(
                          top: -40,
                          left: 120,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ColorManager.purple6, // لون البوردير الشفاف
                                width: 5.0, // عرض البوردير
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 35,
                              backgroundColor: ColorManager.white,
                              child: Icon(
                                Icons.person,
                                size: 40,
                                color: ColorManager.purple6,
                              ),
                            ),
                          ),
                        ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
