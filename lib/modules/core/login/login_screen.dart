import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/modules/core/login/cubit/cubit.dart';
import 'package:jobly/modules/core/login/cubit/states.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';
import '../../../utils/constants.dart';
import '../../../utils/helpers/cache_helper.dart';
import '../../../widgets/widgets_part2.dart';
import '../../home/home_layout_view.dart';
import '../sign_up/sign_up_user/singup_user_view.dart';



class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    return Scaffold(
     
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocListener<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginErrorStates) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Login Failed: ${state.error}'),
                ),
              );
            } else if (state is LoginSuccessStates) {
              CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value) {
                token= state.loginModel.data?.token;
              });
                 const SnackBar(
                  content: Text('Login success'),
                );

              // Navigate to another screen
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeLayoutView()));
            }
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration:  const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorManager.purple4,
                  ColorManager.purple7,
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

                                  defaultFormField(controller: _emailController, type:TextInputType.emailAddress, label: AppStrings.emaill,prefix: Icons.email),
                                  const SizedBox(height: AppSize.s16),
                                  defaultFormField(controller: _passwordController, type:TextInputType.text, label: AppStrings.password,isPassword: true,prefix: Icons.lock,),
                                  const SizedBox(height: AppSize.s16),
                                 const  SizedBox(height: 16),
                                  BlocBuilder<LoginCubit, LoginStates>(
                                    builder: (context, state) {
                                      var cubit=LoginCubit.get(context);
                                      if (state is LoginLoadingStates) {
                                        return const CircularProgressIndicator();
                                      }

                                      return MaterialButton(
                                        onPressed: () {
                                          cubit.userLogin(email: _emailController.text, password: _passwordController.text);
                                        },
                                        child:  Container(
                                          width: 100,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: ColorManager.primary,
                                          ),
                                          child: Text(
                                            AppStrings.signIn,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: ColorManager.white),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  const Divider(),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => SingupUser()));

                                      // Handle register
                                    },
                                    child:  Text(AppStrings.account,style: TextStyle(color: ColorManager.purple6,),),
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
