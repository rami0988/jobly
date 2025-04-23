
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/resources/color_manager.dart';
import 'package:jobly/resources/font_manager.dart';
import 'package:jobly/resources/style_manager.dart';
import 'package:jobly/resources/values_manager.dart';

import '../../widgets/widgets_part2.dart';
import 'cubit/applications_cubit.dart';
import 'cubit/applications_states.dart';



class ApplicationsView extends StatelessWidget {
  const ApplicationsView({super.key});
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (BuildContext context) => ApplicationsCubit()..getMyApplications(),
        child: BlocConsumer<ApplicationsCubit, ApplicationsStates>(
            listener: (context, state) {
              if(state is CancelApplicationSuccessState) {
                showToast(text: "Application Canceled Successfully", state: ToastStates.SUCCESS);
              }
            },
            builder: (context, state) {
              var cubit = ApplicationsCubit.get(context);
              return Scaffold(
                appBar: AppBar(
                  elevation: AppSize.s0,
                  backgroundColor: ColorManager.white,
                  title: Text('Applications',style: getMediumStyle(color: ColorManager.darkPrimary).copyWith(fontSize: FontSize.s22),),
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
                            cubit.applications!.isNotEmpty?applicationsBuilder(cubit.applications, context, cubit, state):const Center(child: Text("No Applications Yet...")),
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
