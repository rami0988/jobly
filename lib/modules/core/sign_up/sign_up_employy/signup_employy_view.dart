
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/modules/core/sign_up/sign_up_employy/cubit/cubit.dart';
import 'package:jobly/modules/core/sign_up/sign_up_employy/cubit/states.dart';

import '../../../../resources/assets_manager.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/font_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/values_manager.dart';
import '../../../../widgets/widgets_part2.dart';
import '../sign_up_address/signup_address_view.dart';

class SingupEmployy extends StatefulWidget {
  @override
  _SingupEmployyState createState() => _SingupEmployyState();
}

class _SingupEmployyState extends State<SingupEmployy> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _resumeController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _portfolioController = TextEditingController();
  final TextEditingController _phone_numberController = TextEditingController();
  final List<String> workingStatusOptions = ['working', 'student', 'not working'];

   //File? _image;


  // Future<void> pickImage(ImageSource source) async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: source);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //       _imageName = pickedFile.name; // Get the name of the picked file
  //     });
  //     // TODO: Handle image file (_image) as needed (uploading, displaying, etc.)
  //   }
  // }





// Future<void> pickImage(ImageSource camera) async {
//   final picker = ImagePicker();
//   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//   if (pickedFile != null) {
//     // This is the correct way to get the file path as a String
//      _filePath = pickedFile.path;
//       _imageName= pickedFile.name;
//     // Now you can call your userSignUp method with the correct file path
//
//   } else {
//     print('No image selected.');
//   }
// }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: BlocProvider(
        create: (context) => SignUpEmployyCubit(),
        child: BlocListener<SignUpEmployyCubit, SignUpEmployyState>(
          listener: (context, state) {
            if (state is SignUpEmployyError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('SIGNUP Failed: ${state.error}'),
                ),
              );
            } else if (state is SignUpEmployySuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('SIGNUP Success'),
                ),
              );
              // Navigate to another screen
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => SingupAddress()));
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
                physics: const BouncingScrollPhysics(),
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
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Image(image: AssetImage(ImageAssets.purpleLogo)),
                                    const SizedBox(height: AppSize.s16),
                                    const SizedBox(height: AppSize.s32),
                                    defaultFormField(
                                      controller: _ageController,
                                      type: TextInputType.number,
                                      label: AppStrings.age,
                                      prefix: Icons.format_list_numbered_outlined,
                                    ),
                                    const SizedBox(height: AppSize.s16),
                                    defaultFormField(
                                      controller: _resumeController,
                                      type: TextInputType.emailAddress,
                                      label: AppStrings.lastname,
                                      prefix: Icons.person,
                                    ),
                                    const SizedBox(height: AppSize.s16),
                                    defaultFormField(
                                      controller: _experienceController,
                                      type: TextInputType.text,
                                      label: AppStrings.experience,
                                      prefix: Icons.work_history_sharp,
                                    ),
                                    const SizedBox(height: AppSize.s16),
                                    defaultFormField(
                                      controller: _educationController,
                                      type: TextInputType.text,
                                      label: AppStrings.education,
                                      prefix: Icons.cast_for_education,
                                    ),
                                    const SizedBox(height: AppSize.s16),
                                    defaultFormField(
                                      controller: _portfolioController,
                                      type: TextInputType.text,
                                      label: AppStrings.portfolio,
                                      prefix: Icons.description,
                                    ),
                                    const SizedBox(height: AppSize.s16),
                                    defaultFormField(
                                      controller: _phone_numberController,
                                      type: TextInputType.number,
                                      label: AppStrings.phone_number,
                                      prefix: Icons.phone,
                                    ),
                                    const SizedBox(height: AppSize.s16),
                                    BlocBuilder<SignUpEmployyCubit, SignUpEmployyState>(
                                      builder: (context, state) {
                                        String workingStatus = 'working';
                                        if (state is WorkingStatusState) {
                                          workingStatus = state.workingStatus;
                                        }
                                        return Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: ColorManager.purple2,
                                                borderRadius: BorderRadius.circular(30.0),
                                              ),
                                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                                              child: DropdownButton<String>(
                                                dropdownColor: ColorManager.purple3,
                                                iconEnabledColor: ColorManager.white,
                                                value: workingStatus,
                                                onChanged: (String? newValue) {
                                                  if (newValue != null) {
                                                    context.read<SignUpEmployyCubit>().changeWorkingStatus(newValue);
                                                  }
                                                },
                                                items: workingStatusOptions
                                                    .map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    const SizedBox(height: AppSize.s16),
                                    BlocBuilder<SignUpEmployyCubit, SignUpEmployyState>(
                                      builder: (context, state) {
                                        String graduationStatus = 'Not Graduated';
                                        if (state is GraduationStatusState) {
                                          graduationStatus = state.graduationStatus;
                                        }
                                        return Row(
                                          children: [
                                            Switch(
                                              value: graduationStatus == 'Graduated',
                                              activeColor: ColorManager.purple4,
                                              inactiveThumbColor: ColorManager.purple6,
                                              inactiveTrackColor: ColorManager.purple2,
                                              onChanged: (value) {
                                                context.read<SignUpEmployyCubit>().changeGraduationStatus(value);
                                              },
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              graduationStatus,
                                              style: TextStyle(fontSize: FontSize.s12),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    const SizedBox(height: AppSize.s16),
                                    // BlocProvider.of<SignUpEmployyCubit>(context).filePath != null
                                    //     ? Column(
                                    //         children: [
                                    //           const SizedBox(height: 8),
                                    //           Text(
                                    //             BlocProvider.of<SignUpEmployyCubit>(context).fileName!,
                                    //             style: TextStyle(fontSize: FontSize.s12, color: Colors.black),
                                    //           ),
                                    //         ],
                                    //       )
                                    //     : Container(),
                                    BlocBuilder<SignUpEmployyCubit, SignUpEmployyState>(
                                      builder: (context, state){
                                        var cubit = SignUpEmployyCubit.get(context);
                                        return ElevatedButton(
                                          onPressed: () {
                                            BlocProvider.of<SignUpEmployyCubit>(context).selectFile();
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: ColorManager.purple2
                                          ),
                                          child: Text(AppStrings.PickImage,style: TextStyle(color: ColorManager.black),),
                                        );
                                      }),

                                    const SizedBox(height: AppSize.s16),
                                    BlocBuilder<SignUpEmployyCubit, SignUpEmployyState>(
                                      builder: (context, state) {
                                        var cubit=SignUpEmployyCubit.get(context);
                                        if (state is SignUpEmployyLoading) {
                                          return const CircularProgressIndicator();
                                        }

                                        return ElevatedButton(
                                          onPressed: () {
                                            cubit.signUpEmployee(
                                                dateOfBirth: _ageController.text,
                                                resume: _resumeController.text,
                                                education: _educationController.text,
                                                experience: _experienceController.text,
                                                portfolio: _portfolioController.text,
                                                phoneNumber: _phone_numberController.text,
                                                workStatus: cubit.workingStatus,
                                                graduationStatus: cubit.graduationStatus,
                                                fileName: cubit.fileName,
                                                filePath: cubit.filePath
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: ColorManager.white,
                                          ),
                                          child: Text(
                                            AppStrings.next,
                                            style: TextStyle(color: ColorManager.purple6),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: AppSize.s16),
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

  // void _showImagePicker(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext bc) {
  //       return SafeArea(
  //         child: Wrap(
  //           children: <Widget>[
  //             ListTile(
  //               leading: Icon(Icons.photo_library),
  //               title: Text('Photo Library'),
  //               onTap: () {
  //                 pickImage(ImageSource.gallery);
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //             ListTile(
  //               leading: Icon(Icons.photo_camera),
  //               title: Text('Camera'),
  //               onTap: () {
  //                 pickImage(ImageSource.camera);
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
