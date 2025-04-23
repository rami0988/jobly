import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/modules/regular/job_details/cubit/job_details_cubit.dart';
import 'package:jobly/modules/regular/job_details/cubit/job_details_states.dart';
import 'package:jobly/resources/values_manager.dart';
import 'package:jobly/utils/constants.dart';

import '../../../resources/color_manager.dart';
import '../../../widgets/widgets.dart';


class JobDetailsView extends StatelessWidget {
  final int id;


  const JobDetailsView({
    super.key,
    required this.id
  });

  @override
  Widget build(BuildContext context) {


    return BlocProvider(
        create: (context)=>JobDetailsCubit()..getJobDetails(id),
        child: BlocConsumer<JobDetailsCubit,JobDetailsStates>(
            listener: (context,state){
              if(state is JobApplySuccessState) {
                showToast(text: "Applied Successfully", state: ToastStates.SUCCESS);
                
              }
            },
            builder: (context,state){
              var cubit = JobDetailsCubit.get(context);

              return Scaffold(
                appBar: myAppBar(context, 'Job Details', false),
                backgroundColor: ColorManager.white,
                body: ConditionalBuilder(
                    condition: state is! JobDetailsLoadingState && cubit.job!=null,
                    builder: (context)=>SingleChildScrollView(
                  child: Column(
                    children: [
                      //image
                      circularImage(
                          context, "${baseUrl}images${cubit.job.publisherPhoto}", MediaQuery.of(context).size.width * 0.2),
                      //role
                      Text(
                          cubit.job.description
                      ),
                      //company
                      Text(
                        cubit.job.companyName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      //location
                      Padding(
                        padding: const EdgeInsets.all(AppPadding.p18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children:[
                                  customListTile(ColorManager.purple2, ColorManager.purple6, Icons.work, "Type", cubit.job.jobType??"Undefined Type", true),
                                  const SizedBox(width: 40,),
                                  customListTile(ColorManager.purple2, ColorManager.purple6, Icons.attach_money, "Salary", cubit.job.salaryRange??"Undefined Salary", true),
                                ]
                            ),
                          ),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children:[
                                  customListTile(ColorManager.purple2, ColorManager.purple6, Icons.location_on_rounded, "Location", cubit.job.location==null?"Undefined ":cubit.job.location.city, true),
                                  const SizedBox(width: 40,),
                                  customListTile(ColorManager.purple2, ColorManager.purple6, Icons.calendar_month_rounded, "Deadline", cubit.job.applicationDeadline, true),
                                ]
                            ),
                          ),

                        ],),
                      ),


                      //job description
                      jobDescription(context, "Category", cubit.job.category),
                      jobDescription(context, "Section", cubit.job.section),
                      jobDescription(context, "Requirements",cubit.job.requirements),
                      //company info
                      companyListTile(context,1, "${baseUrl}images${cubit.job.publisherPhoto}", cubit.job.companyName),
                      //apply button
                      myButton(
                        context,
                        'Apply',
                            () {cubit.applyToJob(id);},
                        ColorManager.white,
                        ColorManager.purple5,
                        double.infinity,
                      ),
                    ],
                  ),
                ),
                    fallback: (context) => const Center(child: CircularProgressIndicator()),
                ),
              );
            },
        ),
    );
  }
}
