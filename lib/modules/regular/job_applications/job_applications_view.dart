
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/modules/regular/job_applications/cubit/job_applications_cubit.dart';
import 'package:jobly/resources/color_manager.dart';
import 'package:jobly/resources/font_manager.dart';
import 'package:jobly/resources/style_manager.dart';
import 'package:jobly/resources/values_manager.dart';

import '../../../widgets/widgets_part2.dart';
import 'cubit/job_applications_states.dart';



class JobApplicationsView extends StatelessWidget {
  const JobApplicationsView(this.id,{super.key});
  final int id;
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (BuildContext context) => JobApplicationsCubit()..getMyJobApplications(id),
        child: BlocConsumer<JobApplicationsCubit, JobApplicationsStates>(
            listener: (context, state) {
              if(state is AcceptJobApplicationSuccessState) {
                showToast(text: "Application Accepted Successfully", state: ToastStates.SUCCESS);
              }else if(state is RejectJobApplicationSuccessState) {
                showToast(text: "Application Rejected Successfully", state: ToastStates.SUCCESS);
              }
            },
            builder: (context, state) {
              var cubit = JobApplicationsCubit.get(context);
              return Scaffold(
                appBar: AppBar(
                  elevation: AppSize.s0,
                  backgroundColor: ColorManager.white,
                  title: Text('Job Applications',style: getMediumStyle(color: ColorManager.darkPrimary).copyWith(fontSize: FontSize.s22),),
                ),
                backgroundColor: ColorManager.offWhite,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    const SizedBox(height: AppSize.s14,),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            cubit.jobApplications!.isNotEmpty?applicationsOthersBuilder(cubit.jobApplications, context, cubit, state):const Center(child:  Text("No Applications Yet..")),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
        ));

  }}
