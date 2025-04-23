import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/values_manager.dart';
import '../../../utils/constants.dart';
import '../../../widgets/widgets_part2.dart';
import '../../../widgets/widgets.dart';
import 'cubit/company_profile_cubit.dart';
import 'cubit/company_profile_states.dart';

class CompanyProfileScreen extends StatelessWidget {
  const CompanyProfileScreen(this.id,{super.key,});
  final int id;

  @override
  Widget build(BuildContext context) {
    var ratingController = TextEditingController();
    var reviewController = TextEditingController();
    return BlocProvider(
      create: (context) => CompanyProfileCubit()..getCompanyDetails(id)..getCompanyJobs(id),
      child: BlocConsumer<CompanyProfileCubit, CompanyProfileStates>(
        listener: (context, state) {
          if(state is AddRatingSuccessState){
            showToast(text: "Rating Added Successfully...", state: ToastStates.SUCCESS);
          }
        },
        builder: (context, state) {
          var cubit = CompanyProfileCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.white,
            body: SingleChildScrollView(
              child: cubit.company == null ?
              const Center(child: CircularProgressIndicator()):
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SafeArea(child: SizedBox()),
                  CompanyProfileHeader(
                    context: context,
                    profileImage: "${baseUrl}images/${cubit.company.commercialRecord}",
                    backgroundImage:
                    'https://www.planetizen.com/files/images/shutterstock_192086159.jpg',
                    name: cubit.company.companyName,
                    isVerified: 0,
                    isProfile: false,
                    avg: cubit.company.avg,
                  ),

                  jobDescription(
                    context,
                    'About Us:',
                    '''${cubit.company.companyDescription}''',
                  ),
                  jobDescription(
                    context,
                    'Email:',
                    '''${cubit.company.contactEmail}''',
                  ),
                  jobDescription(
                    context,
                    'phone number:',
                    '''${cubit.company.contactPhone}''',
                  ),
                  jobDescription(
                    context,
                    'Industry:',
                    '''${cubit.company.industry}''',
                  ),
                  jobDescription(
                    context,
                    'Established at:',
                    '''${cubit.company.dateOfEstablishment}''',
                  ),
                  jobDescription(
                    context,
                    'Visit Our Website:',
                    '''${cubit.company.companyWebsite}''',
                  ),
                  jobDescription(context, 'Location:', '''
 - Country : ${cubit.company.address.county}
 - City : ${cubit.company.address.city}
 - Governorate : ${cubit.company.address.governorate}
'''),
                  if(cubit.jobs!= null)   // reviews2(context, imageUrl),
                  jobsBuilder(cubit.jobs, cubit, context, state,"not mine"),
                    reviewsbuilder(
                    context,
                    cubit,
                    cubit.company.ratings,
                  ),
                  //jobsHorizontal2(context,cubit,cubit.jobs,),
                  myButton(
                    context,
                    'Add a Review',
                        () {
                           showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Add Rating and Review:"),
                                content: SizedBox(
                                  height:120,
                                  child: Column(
                                    children: [
                                      defaultFormField(
                                          type: TextInputType.text,
                                          label: 'type rating',
                                          controller: ratingController
                                      ),
                                      defaultFormField(
                                          type: TextInputType.text,
                                          label: 'type review',
                                          controller: reviewController
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: (){
                                      cubit.addRating(
                                          id: cubit.company.id,
                                          rating: ratingController.text,
                                          comment: reviewController.text
                                      );
                                      cubit.getCompanyDetails(id);
                                      Navigator.pop(context);

                                    },
                                    child: const Text('Confirm'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                    Colors.white,
                    Theme.of(context).primaryColor,
                    double.infinity,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  //   return BlocProvider(
  //     create: (context) => CompanyProfileCubit()..getCompanyInfo(1),
  //     child: BlocConsumer<CompanyProfileCubit, CompanyProfileStates>(
  //       listener: (context, state) {},
  //       builder: (context, state) {
  //         var cubit = CompanyProfileCubit.get(context);
  //         return Scaffold(
  //           backgroundColor: ColorManager.white,
  //           body: SingleChildScrollView(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 const SafeArea(child: SizedBox()),
  //                 //image/logo/name/back button
  //                 companyProfileHeader(
  //                   context,
  //                   cubit.company,
  //                   cubit,
  //                   'https://www.planetizen.com/files/images/shutterstock_192086159.jpg',
  //                   false,
  //                 ),
  //                 jobDescription(context, 'About Us:',cubit,cubit.company),
  //                     // '''Google is a global technology leader focused on improving the ways people connect with information. Founded in 1998 by Larry Page and Sergey Brin, Google specializes in internet-related services and products, including search engines, online advertising technologies, cloud computing, software, and hardware. Known for its innovative approach and commitment to organizing the world’s information, Google continues to be a pioneer in the tech industry.'''),
  //                  seeAll(context, 'jobs from $companyName',
  //                      const EditProfileScreen()),
  //                 // jobsHorizontal(
  //                 //     context, CompanyProfileCubit.get(context).companyJobs),
  //                 // seeAll(context, 'What do people have to say about us ?',
  //                 //     const EditProfileScreen()),
  //                 // reviews(context, imageUrl),
  //                 // myButton(context, 'Add a Review', () {}, ColorManager.white,
  //                 //     Theme.of(context).primaryColor, double.infinity)
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}

Widget reviewsbuilder(BuildContext context, cubit, reviews) {
  return Column(
    children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        child: PageView.builder(
          physics: const BouncingScrollPhysics(),
          controller: PageController(viewportFraction: 1),
          itemCount: reviews.length,
          itemBuilder: (BuildContext context, int index) {
            return buildCommentItem(reviews[index], context, cubit);
          },
        ),
      ),
    ],
  );
}

//
Widget buildCommentItem(
  review,
  context,
  cubit,
) {
  return GestureDetector(
    onLongPressStart: (details) => CompanyProfileCubit.get(context)
        .showContextMenu(context, details.globalPosition),
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: AppSize.s16,
                backgroundColor: ColorManager.purple2,
                backgroundImage: const AssetImage(ImageAssets.employeeIc ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width * 0.85,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 249, 249, 249),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    seeMoreText(
                        context,
                        review.comment,
                        review.rating,
                        'https://www.planetizen.com/files/images/shutterstock_192086159.jpg',
                        70),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 35,
          bottom: 60,
          child: Text(
            '⭐${review.rating}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

// //
// Widget jobsHorizontal2(BuildContext context, cubit, jobs) {
//   return SizedBox(
//     width: 400,
//     height: MediaQuery.of(context).size.height * 0.15,
//     child: PageView.builder(
//       controller: PageController(viewportFraction: 1),
//       itemCount: jobs.length,
//       itemBuilder: (BuildContext context, int index) {
//         return buildJobItem(jobs[index], context, cubit);
//       },
//     ),
//   );
// }
