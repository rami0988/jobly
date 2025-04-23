import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/resources/color_manager.dart';
import '../../../widgets/widgets.dart';
import 'jobs_cubit.dart';
import 'jobs_states.dart';

class JobsView extends StatelessWidget {
  const JobsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JobsCubit()..getCompanies()..getJobs(),
      child: BlocConsumer<JobsCubit, JobsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = JobsCubit.get(context);
          return Scaffold(
            appBar: myAppBar(context, "JOBLY", true),
            floatingActionButton: FloatingActionButton(
              backgroundColor: ColorManager.purple6,
              onPressed: () {
                if(cubit.myJobs) {
                  cubit.getAllJobs();
                  cubit.changeJobs();
                } else {
                  cubit.getJobs();
                  cubit.changeJobs();
                }
              },
              child: Icon(Icons.switch_left,color: ColorManager.purple2,)
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  companiesBuilder(cubit.companies, cubit, context, state),
                  jobsBuilder(cubit.jobs, cubit, context, state,"not mine"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
