import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/resources/color_manager.dart';
import 'package:jobly/resources/values_manager.dart';
import 'package:jobly/utils/constants.dart';
import 'package:jobly/widgets/widgets_part2.dart';
import 'package:jobly/widgets/widgets.dart';

import '../../../resources/assets_manager.dart';
import 'cubit/edit_profile_cubit.dart';
import 'cubit/edit_profile_states.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView(this.profile,{Key? key}) : super(key: key);
  final profile;


  @override
  Widget build(BuildContext context) {
    var ageController = TextEditingController(text: profile.employee.dateOfBirth ?? "");
    var phoneNumberController = TextEditingController(text: profile.employee.phoneNumber ?? "");
    var experienceController = TextEditingController(text: profile.employee.experience ??"");
    var skillController = TextEditingController();
    var educationController = TextEditingController(text: profile.employee.education ?? "");
    var resumeController = TextEditingController(text: profile.employee.resume ?? "");
    var portfolioController = TextEditingController(text: profile.employee.portfolio ?? "");
    var countryController = TextEditingController(text: profile.address!=null?profile.address.county:"");
    var cityController = TextEditingController(text: profile.address!=null?profile.address.city:"");
    var governorateController = TextEditingController(text: profile.address!=null?profile.address.governorate:"");

    return BlocProvider(
      create: (context) => EditProfileCubit()..getCategories(),
      child: BlocConsumer<EditProfileCubit,EditProfileStates>(
        listener:(context,state){
          if(state is EditProfileSuccessState){
            showToast(text: "Edited Successfully", state: ToastStates.SUCCESS);
          }else if(state is AddSkillSuccessState){
            showToast(text: "Skill Added Successfully", state: ToastStates.SUCCESS);
          }else if(state is AddLocationSuccessState){
            showToast(text: "Location Added Successfully", state: ToastStates.SUCCESS);
          }else if(state is AddFavouriteSuccessState){
            showToast(text: "Favourite Added Successfully", state: ToastStates.SUCCESS);
          }
        },
        builder: (context,state){
          var cubit = EditProfileCubit.get(context);
          cubit.dropDownValueWorkStatus=profile.employee.workStatus;
          cubit.dropDownValueGraduation=profile.employee.graduationStatus;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Edit Profile"),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsetsDirectional.all(AppPadding.p14),
                child: Column(
                  children: [
                    const Text("Image"),
                    Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width * 0.4,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child:profile.employee.image!=null
                              ? Image.network(
                            "${baseUrl}images/Employees/${profile.employee.image.filename}",
                            fit: BoxFit.cover,
                          )
                              :Image.asset(ImageAssets.employeeIc),

                        ),
                      ),
                    ),
                    TextButton(onPressed: (){
                      cubit.selectFile();
                    }, child: const Text("Change Image")),
                    if (cubit.selectedFile != null)
                      Center(child: Text(cubit.fileName!)), // show the selected file path, if there is one
                    const SizedBox(height: 20,),
                    const Text("Age"),
                    defaultFormField(controller: ageController, type: TextInputType.text, label: "YYYY-MM-DD"),
                    const Text("Phone Number"),
                    defaultFormField(controller: phoneNumberController, type: TextInputType.text, label: "Phone Number"),
                    const Text("Experience"),
                    defaultFormField(controller: experienceController, type: TextInputType.text, label: "Experience"),
                    const Text("Education"),
                    defaultFormField(controller: educationController, type: TextInputType.text, label: "Education"),
                    const Text("Resume"),
                    defaultFormField(controller: resumeController, type: TextInputType.text, label: "Resume"),
                    const Text("Portfolio"),
                    defaultFormField(controller: portfolioController, type: TextInputType.text, label: "Portfolio"),
                    const Text("Work Status"),
                    myDropDownButton(
                        value: cubit.dropDownValueWorkStatus,
                        hint: 'Choose Work Status',
                        function: (newValue) {
                          cubit.changeWorkStatusDropDownButton(newValue!);
                        },
                        items: cubit.menuItemsWorkStatus
                    ),
                    const Text("Graduation Status"),
                    myDropDownButton(
                        value: cubit.dropDownValueGraduation,
                        hint: 'Choose Graduation Status',
                        function: (newValue) {
                          cubit.changeGraduationDropDownButton(newValue!);
                        },
                        items: cubit.menuItemsGraduation
                    ),

                    myButton(
                      context,
                      'Confirm',
                          (){
                        cubit.editProfile(
                            dateOfBirth: ageController.text,
                            resume: resumeController.text,
                            education: educationController.text,
                            experience: experienceController.text,
                            portfolio: portfolioController.text,
                            phoneNumber: phoneNumberController.text,
                            workStatus: cubit.dropDownValueWorkStatus,
                            graduationStatus: cubit.dropDownValueGraduation,
                            fileName: cubit.fileName,
                            filePath: cubit.filePath
                        );
                      },
                      ColorManager.white,
                      ColorManager.purple5,
                      double.infinity,
                    ),
                    const Text("Skills"),
                    defaultFormField(controller: skillController, type: TextInputType.text, label: "Add a Skill..."),
                    myButton(
                      context,
                      'ADD SKILL',
                          (){
                        cubit.addSkill(skill: skillController.text);
                      },
                      ColorManager.white,
                      ColorManager.purple5,
                      double.infinity,
                    ),
                    const Text("Favourite Section"),
                    myDropDownButton(
                        value: cubit.dropDownValueCategory,
                        hint: 'Choose Category',
                        function: (newValue) {
                          cubit.dropDownValueSection=null;
                          cubit.changeCategoryDropDownButton(newValue!);
                          cubit.getSections(newValue);
                        },
                        items: cubit.menuItemsCategory
                    ),
                    myDropDownButton(
                        value: cubit.dropDownValueSection,
                        hint: 'Choose Section',
                        function: (newValue) {
                          cubit.changeSectionDropDownButton(newValue!);
                        },
                        items: cubit.menuItemsSection
                    ),
                    myButton(
                      context,
                      'Add Favourite',
                          (){
                        cubit.addFavourite(section: cubit.dropDownValueSection);

                      },
                      ColorManager.white,
                      ColorManager.purple5,
                      double.infinity,
                    ),
                    const Text("Location"),
                    defaultFormField(controller: countryController, type: TextInputType.text, label: "Country"),
                    defaultFormField(controller: cityController, type: TextInputType.text, label: "City"),
                    defaultFormField(controller: governorateController, type: TextInputType.text, label: "Governorate"),
                    myButton(
                      context,
                      'ADD LOCATION',
                          (){
                        cubit.addLocation(
                            country: countryController.text,
                            city: cityController.text,
                            governorate: governorateController.text
                        );

                      },
                      ColorManager.white,
                      ColorManager.purple5,
                      double.infinity,
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
