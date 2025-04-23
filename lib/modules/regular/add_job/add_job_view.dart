import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/modules/regular/add_job/cubit/add_job_cubit.dart';
import 'package:jobly/modules/regular/add_job/cubit/add_job_states.dart';
import 'package:jobly/resources/color_manager.dart';
import 'package:jobly/resources/values_manager.dart';
import 'package:jobly/widgets/widgets_part2.dart';
import 'package:jobly/widgets/widgets.dart';

class AddJobView extends StatelessWidget {
  const AddJobView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var descriptionController = TextEditingController();
    var requirementsController = TextEditingController();
    var salaryController = TextEditingController();
    var deadlineController = TextEditingController();

    return BlocProvider(
        create: (context) => AddJobCubit()..getCategories(),
        child: BlocConsumer<AddJobCubit,AddJobStates>(
            listener:(context,state){
              if(state is AddJobSuccessState){
                showToast(text: "Job Added Successfully", state: ToastStates.SUCCESS);
              }
            },
            builder: (context,state){
              var cubit = AddJobCubit.get(context);
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Add Job"),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.all(AppPadding.p14),
                    child: Column(
                      children: [
                        const Text("Description"),
                        defaultFormField(controller: descriptionController, type: TextInputType.text, label: "Description"),
                        const Text("Requirements"),
                        defaultFormField(controller: requirementsController, type: TextInputType.text, label: "Requirements"),
                        const Text("Salary"),
                        defaultFormField(controller: salaryController, type: TextInputType.text, label: "Salary"),
                        const Text("Application Deadline"),
                        defaultFormField(controller: deadlineController, type: TextInputType.text, label: "Application Deadline"),
                        const Text("Category"),
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
                        const Text("Section"),
                        myDropDownButton(
                            value: cubit.dropDownValueSection,
                            hint: 'Choose Section',
                            function: (newValue) {
                              cubit.changeSectionDropDownButton(newValue!);
                            },
                            items: cubit.menuItemsSection
                        ),
                        const Text("Job Type"),
                        myDropDownButton(
                            value: cubit.dropDownValueType,
                            hint: 'Choose Job Type',
                            function: (newValue) {
                              cubit.changeTypeDropDownButton(newValue!);
                            },
                            items: cubit.menuItemsType
                        ),
                        const Text("Image"),
                        TextButton(onPressed: (){
                          cubit.selectFile();
                        }, child: Text("Upload Image")),
                        if (cubit.selectedFile != null)
                          Center(child: Text(cubit.fileName!)), // show the selected file path, if there is one
                        SizedBox(height: 20,),
                        myButton(
                          context,
                          'Add Job',
                              (){
                            cubit.addJob(
                                description: descriptionController.text,
                                jobType: cubit.dropDownValueType,
                                requirements: requirementsController.text,
                                salary: salaryController.text,
                                deadline: deadlineController.text,
                                sectionId: cubit.dropDownValueSection,
                                filePath: cubit.filePath,
                                fileName: cubit.fileName
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
