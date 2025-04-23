import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/modules/core/sign_up/sign_up_skills/cubit/cubit.dart';
import 'package:jobly/modules/core/sign_up/sign_up_skills/cubit/states.dart';

import '../../../../resources/assets_manager.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/font_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/style_manager.dart';
import '../../../../resources/values_manager.dart';
import '../../../../widgets/widgets_part2.dart';
import '../../../home/home_layout_view.dart';
import '../sign_up_fav/signup_fav_view.dart';

class SingupSkill extends StatefulWidget {
  @override
  _SingupSkillState createState() => _SingupSkillState();
}

class _SingupSkillState extends State<SingupSkill> {
  final List<TextEditingController> _skillControllers = [TextEditingController()];

  void _addSkillField() {
    setState(() {
      _skillControllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.purple6,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeLayoutView()),
              );
            },
            child: Text(AppStrings.skip, style: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s20)),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => SignUpSkillCubit(),
        child: BlocListener<SignUpSkillCubit, SignupSkillStates>(
          listener: (context, state) {
            if (state is SignupSkillErorrStates) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Signup Failed: ${state.erorr}'),
                ),
              );
            } else if (state is SignupSkillSuccessStates) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Signup Success'),
                ),
              );
              // Navigate to another screen
               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => SignupFav()));
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
                    const SizedBox(height: AppSize.s100),
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Card(
                            child: Container(
                              width: 300,
                              height: 500,
                              padding: const EdgeInsets.all(16),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Image(image: AssetImage(ImageAssets.purpleLogo)),
                                    const SizedBox(height: AppSize.s16),
                                    const SizedBox(height: AppSize.s32),
                                    ..._skillControllers.map((controller) {
                                      return Column(
                                        children: [
                                          defaultFormField(controller: controller, type: TextInputType.text, label: AppStrings.skill, prefix: Icons.interests),
                                          const SizedBox(height: AppSize.s16),
                                        ],
                                      );
                                    }).toList(),
                                    const SizedBox(height: AppSize.s16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                       ElevatedButton(
                                      onPressed: _addSkillField,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ColorManager.white,
                                      ),
                                      child: Text('Add Skill', style: TextStyle(color: ColorManager.purple6)),
                                    ),
                                    const SizedBox(height: AppSize.s16),
                                    BlocBuilder<SignUpSkillCubit, SignupSkillStates>(
                                      builder: (context, state) {
                                        if (state is SignupSkillLoadingStates) {
                                          return const CircularProgressIndicator();
                                        }
                                        return ElevatedButton(
                                          onPressed: () {
                                            final skills = _skillControllers.map((controller) => controller.text).toList();
                                            skills.forEach((skill) {
                                              BlocProvider.of<SignUpSkillCubit>(context).SkillSignUp(skill: skill);
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: ColorManager.white,
                                          ),
                                          child: Text(AppStrings.next, style: TextStyle(color: ColorManager.purple6)),
                                        );
                                      },
                                    ),
                
                                      ],
                                    )
                
                                  ],
                                ),
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
                                  color: ColorManager.purple6,
                                  width: 5.0,
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
