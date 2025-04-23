import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:jobly/modules/regular/edit_profile/edit_profile_view.dart';
import 'package:jobly/modules/regular/job_applications/job_applications_view.dart';
import 'package:jobly/modules/regular/job_details/job_details_view.dart';
import 'package:jobly/modules/regular/profile/cubit/profile_cubit.dart';
import 'package:jobly/modules/regular/profile/profile_view.dart';
import 'package:jobly/modules/regular/search/search_view.dart';
import 'package:jobly/resources/color_manager.dart';
import 'package:jobly/utils/constants.dart';
import 'package:jobly/widgets/widgets_part2.dart';
import 'package:url_launcher/url_launcher.dart';
import '../modules/regular/company_profile/company_profile_view.dart';
import '../modules/regular/company_profile/cubit/company_profile_cubit.dart';
import '../modules/regular/employee_profile/cubit/employee_profile_cubit.dart';
import '../modules/regular/jobs/jobs_cubit.dart';
import '../modules/regular/jobs/jobs_states.dart';
import '../resources/assets_manager.dart';
import '../resources/font_manager.dart';
import '../resources/style_manager.dart';
import '../resources/values_manager.dart';

Widget buildJobItem(
    job,
    context,
    cubit,
    type
    ) {
  return InkWell(
    onTap: () {
      if(type=="mine") {
        navigateTo(context, JobApplicationsView(job.vacancyId,));
      }else{
        navigateTo(context, JobDetailsView(id: job.vacancyId,));
      }
    } ,
    child: Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height * 0.15,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorManager.offWhite,
        // color: const Color.fromARGB(255, 249, 249, 249),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              circularImage(context, '${baseUrl}images/${job.publisherPhoto}', MediaQuery.of(context).size.width * 0.05,),
              //company logo
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(job.description),
                    Text(
                      '${job.companyName} - ${job.location?.city??"Undefined"}',
                      style:  TextStyle(
                        color: ColorManager.purple5,),
                    ),
                  ],
                ),
              ),
              if(type=="mine")
              IconButton(onPressed: (){
                cubit.deleteMyJob(job.vacancyId);
                cubit.getMyJobs();
              }, icon: Icon(Icons.remove_circle_outline_sharp,color: ColorManager.error,)),
              Text(
                "#${job.vacancyId}",
                style:  TextStyle(
                  color: ColorManager.purple5,),
              ),
            ],
          ),
          Row(
            children: [
              highlightedText(job.jobType,
                  const Color.fromARGB(255, 201, 231, 255), Colors.blue),
              highlightedText(job.section,
                  const Color.fromARGB(255, 196, 255, 205), Colors.green),
              const Spacer(),
              highlightedText(job.salaryRange,
                  const Color.fromARGB(150, 255, 255, 150), Colors.orangeAccent),

            ],
          ),
        ],
      ),
    ),
  );
}


Widget jobsBuilder(jobs,cubit,context,state,type)=>ConditionalBuilder(
  condition: state is! JobsLoadingState && jobs != null,
  builder: (context) => ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) =>
          buildJobItem(jobs[index], context, cubit,type),
      separatorBuilder: (context, index) => const SizedBox(
        height: 8,
      ),
      itemCount: jobs.length
  ),
  fallback: (context) => const Center(child: CircularProgressIndicator()),
);

//the company widget in the all jobs screen
Widget buildCompanyItem(
    company,
    context,
    cubit
    ) {
  return InkWell(
    onTap: () {
      navigateTo(context, CompanyProfileScreen(company.id));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: AppSize.s40,
              backgroundColor: ColorManager.white,
              backgroundImage: imageSelector(image: company.companyImage,defaultImage: ImageAssets.companyIc),
            ),
            Text(
              company.companyName,
              softWrap: true,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ),
  );
}

//holds the company widgets in it
Widget companiesBuilder(companies,cubit,context,state)=>ConditionalBuilder(
  condition: state is! CompaniesLoadingState && companies != null,
  builder: (context) => Container(
    width: double.infinity,
    height: 130,
    child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            buildCompanyItem(companies[index], context, cubit),
        separatorBuilder: (context, index) => const SizedBox(
          width: 5,
        ),
        itemCount: companies.length
    ),
  ),
  fallback: (context) => const Center(child: CircularProgressIndicator()),
);





//onboarding
class BoardingModle {
  final String image;
  final String title;
  final String body;
  BoardingModle({
    required this.body,
    required this.title,
    required this.image,
  });
}

Widget bulidBoardingItem(
  BoardingModle modle,
) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image(image: AssetImage(modle.image))),
        const SizedBox(
          height: 30,
        ),
        Text(
          modle.title,
          style: getBoldStyle(color: Colors.black, fontSize: FontSize.s22),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          modle.body,
          style: getRegularStyle(color: Colors.black, fontSize: FontSize.s14),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );





    

//text from feld

Widget textFieldComponant(
  TextEditingController _passwordController,
  String AppStrings,
  InputBorder? border,
  bool obscureText,
) {
  return TextField(
    controller: _passwordController,
    decoration: InputDecoration(
      labelText: AppStrings,
      border: border,
    ),
    obscureText: obscureText,
  );
}





// //the company widget in the all jobs screen
// Widget companyWidget(
//   context,
//   String imageUrl,
//   String text,
// ) {
//   return InkWell(
//     onTap: () {
//       // Navigate to CompanyProfileScreen and pass data
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           //it shhould lead to the company profile screen
//           builder: (context) => const CoursesScreen(
//               // imageUrl: imageUrl,
//               // companyName: text,
//               ),
//         ),
//       );
//     },
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width * 0.2,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             circularImage(
//               context,
//               imageUrl,
//               MediaQuery.of(context).size.width * 0.07,
//             ),
//             Text(
//               text,
//               softWrap: true,
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }



// //list of jobs
// Widget jobsList(List<Map<String, String>> jobs) {
//   return Expanded(
//     child: ListView.builder(
//       itemCount: jobs.length,
//       itemBuilder: (context, index) {
//         final job = jobs[index];
//         return jobVacancyWidget(
//           context,
//           job['image']!,
//           job['title']!,
//           job['tag']!,
//           job['experience']!,
//           job['type']!,
//           job['salary']!,
//           job['company']!,
//           job['location']!,
//         );
//       },
//     ),
//   );
// }

// Widget companyListTile(context, String imageUrl, String companyName) {
//   return ListTile(
//       onTap: () {
//         navigateTo(
//             context,
//             const CoursesScreen(
//                 //imageUrl: imageUrl, companyName: companyName,
//                 ));
//       },
//       subtitle: const Text('⭐4.2 | 400 Reviews'),
//       title: Text(companyName),
//       leading: circularImage(
//         context,
//         imageUrl,
//         MediaQuery.of(context).size.width * 0.05,
//       ));
// }




Widget customListTile(
  Color backgroundColor,
  Color iconColor,
  IconData icon,
  String title,
  String subtitle,
  bool isSubtitle,
) {
  if (isSubtitle == true) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          highlightedIcon(
            backgroundColor,
            iconColor,
            icon,
            40,
          ),
          // const Color.fromARGB(255, 255, 180, 231),
          // const Color.fromARGB(255, 156, 0, 164),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(subtitle),
            ],
          ),
        ],
      ),
    );
  }
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      children: <Widget>[
        highlightedIcon(
          backgroundColor,
          iconColor,
          icon,
          30,
        ),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}





//reused widgets(mini widgets)
Widget circularImage(context, String imageUrl, double radius) {
  return Card(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(200),
    ),
    elevation: 0,
    child: CircleAvatar(
      backgroundColor: Colors.white,
      radius: radius,
      backgroundImage: NetworkImage(
        imageUrl,
      ),
    ),
  );
}

Widget smallTitle(String title) {
  return Text(
    title,
    style: const TextStyle(fontWeight: FontWeight.bold),
  );
}
// 
Widget highlightedText(String text, Color background, Color textColor) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: textColor,
      ),
    ),
  );
}

Widget numberAndText(context, int number, String text) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.3,
    child: Column(
      children: [
        Text(
          '$number',
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    ),
  );
}
// 
Widget highlightedIcon(Color background, Color iconColor, IconData icon,double size) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(200),
    ),
    child: Icon(
      icon,
      color: iconColor,
      size: size,
      
    ),
  );
}

Widget seeAll(context, String text, Widget page) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            navigateTo(context, page);
          },
          child: const Text('See All'),
        ),
      ],
    ),
  );
}

Widget dividerVertical(BuildContext context) {
  return SizedBox(
    height: 80,
    child: VerticalDivider(
      width: MediaQuery.of(context).size.width * 0.2,
      thickness: 2,
      indent: 5,
      endIndent: 5,
      color: Theme.of(context).colorScheme.secondary,
    ),
  );
}

Widget jobDescription(context, String title, String description) {
  return Column(
    children: [
      ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
      ),
    ],
  );
}
//functions
void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

//buttons
Widget myButton(
  BuildContext context,
  String buttonText,
  VoidCallback onPressed,
  Color textColor,
  Color backgroundColor,
  double width,
) {
  return MaterialButton(
    splashColor: Colors.transparent,
    onPressed: onPressed,
    child: Container(
      width: width,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor,
      ),
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: TextStyle(color: textColor),
      ),
    ),
  );
}
// 
Widget squareButton(
  context,
  List<String> items,
  Function(String) onSelected,
) {
  return Positioned(
    bottom: 5,
    right: 5,
    child: FloatingActionButton(
      onPressed: () {},
      child: PopupMenuButton<String>(
        offset: const Offset(0, -100),
        onSelected: onSelected,
        itemBuilder: (BuildContext context) {
          return items.map((String item) {
            return PopupMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList();
        },
      ),
    ),
  );
}

Widget backButtonrounded(BuildContext context) {
  return InkWell(
            onTap: () {
          Navigator.pop(context);
        },
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: highlightedIcon(Colors.transparent, Theme.of(context).primaryColor,  Icons.arrow_back,25),
    ),
  );
}
// 

//lists
//holds the company widgets in it
// Widget companyHolder(context) {
//   return SizedBox(
//     height: MediaQuery.of(context).size.height * 0.13,
//     child: ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: companyData.length,
//       itemBuilder: (context, index) {
//         final company = companyData[index];
//         return companyWidget(
//           context,
//           company['image']!,
//           company['text']!,
//         );
//       },
//     ),
//   );
// }
//job vacancy widget
Widget jobsVertical(List<Job> jobs) {
  return Expanded(
    child: ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return jobVacancyWidget(context, job);
      },
    ),
  );
}
//job vacancy widget
Widget jobsHorizontal(BuildContext context, List<Job> jobs) {
  return Column(
    children: [
      SizedBox(
        width: 400,
        height: MediaQuery.of(context).size.height * 0.15,
        child: PageView.builder(
          controller: PageController(viewportFraction: 1),
          itemCount: jobs.length,
          itemBuilder: (BuildContext context, int index) {
            final job = jobs[index];
            return jobVacancyWidget(context, job);
          },
        ),
      ),
    ],
  );
}
//
Widget buildGridView(
    List items,
    Widget Function(Color, Color, IconData, String, String, bool) gridItemBuilder) {
  return SizedBox(
    height: 140,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 0,
          childAspectRatio: 2.5,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          var item = items[index];
          return gridItemBuilder(
            const Color.fromARGB(
                255, 255, 180, 231), // Example background color
            const Color.fromARGB(255, 156, 0, 164), // Example icon color
            item['icon'], // Assuming 'icon' is IconData
            item['title'],
            item['subtitle'] ?? '', // Optional subtitle, default empty string
            item['isSubtitle'] ??
                false, // Optional isSubtitle flag, default false
          );
        },
      ),
    ),
  );
}
//
Widget reviews(BuildContext context, String image) {
  return Column(
    children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        child: PageView.builder(
          // physics: ,
          controller: PageController(viewportFraction: 1),
          itemCount: CompanyProfileCubit.get(context).dummyComments.length,
          itemBuilder: (BuildContext context, int index) {
            return CommentItem(
              commentId: CompanyProfileCubit.get(context)
                  .dummyComments[index]
                  .commentId,
              commentWriter: CompanyProfileCubit.get(context)
                  .dummyComments[index]
                  .commentWriter,
              commentText: CompanyProfileCubit.get(context)
                  .dummyComments[index]
                  .commentText,
              commentWriterProfile: CompanyProfileCubit.get(context)
                  .dummyComments[index]
                  .commentWriterProfile,
            );
          },
        ),
      ),
      const Padding(padding: EdgeInsets.all(10)),
    ],
  );
}
// 


//tiles
Widget settingsTileSwitch(
  BuildContext context,
  cubit,
  IconData icon,
  String title,
  String status,
  Color background,
  Color iconColor,
  bool isSwitch,
  bool isSwitchOn,
  Function(bool)? switchFunction, // Parameter for switch function
) {
  return Container(
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: ListTile(
      tileColor: Colors.white,
      leading: highlightedIcon(background, iconColor, icon,30),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          smallTitle(title),
          Text(status),
        ],
      ),
      trailing: isSwitch
          ? Switch(
              onChanged: switchFunction,
              value: isSwitchOn,
            )
          : InkWell(
              onTap: (){
                title!="Edit Profile"?
                showUploadCvDialog(context, cubit):
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileView(cubit.profile),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 245, 245, 245),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded, // Right arrow icon
                  color: Colors.black, // Icon color
                ),
              ),
            ),
    ),
  );
}

Widget settingsVideoTileSwitch(
    BuildContext context,
    cubit,
    IconData icon,
    String title,
    String status,
    Color background,
    Color iconColor,
    bool isSwitch,
    bool isSwitchOn,
    Function(bool)? switchFunction, // Parameter for switch function
    ) {
  return Container(
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: ListTile(
      tileColor: Colors.white,
      leading: highlightedIcon(background, iconColor, icon,30),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          smallTitle(title),
          Text(status),
        ],
      ),
      trailing: isSwitch
          ? Switch(
        onChanged: switchFunction,
        value: isSwitchOn,
      )
          : InkWell(
        onTap: (){
          showUploadVideoDialog(context, cubit);
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 245, 245, 245),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.arrow_forward_ios_rounded, // Right arrow icon
            color: Colors.black, // Icon color
          ),
        ),
      ),
    ),
  );
}

Widget companyListTile(context,int id, String imageUrl, String companyName) {
  return ListTile(

      subtitle: const Text('⭐4.2 | 400 Reviews'),
      title: Text(companyName),
      leading: circularImage(
        context,
        imageUrl,
        MediaQuery.of(context).size.width * 0.05,
      ));
}





//needs modification
Widget titleAndDescription(context) {
  return Column(
    children: [
      //job description
      smallTitle('Job description'),
      //'Roles and Responsibilities:'
      jobDescription(
        context,
        'Roles and Responsibilities:',
        '''
● Code Review: Perform code reviews to ensure high code quality and adherence to best practices.
● Problem Solving: Identify, troubleshoot, and resolve complex issues and bugs.
● Documentation: Create and maintain technical documentation for systems and processes. 
● Testing: Implement and maintain robust testing strategies to ensure the reliability and performance of applications.''',
      ),
      //Perks and Benefits:
      jobDescription(
        context,
        'Perks and Benefits:',
        '''
● Stock Options: Potential to own part of Amazon through stock grants.
● Health Insurance: Comprehensive medical, dental, and vision insurance plans.
● Retirement Plans: 401(k) plan with company match.
● Paid Time Off: Generous paid vacation, sick leave, and parental leave.
● Employee Discounts: Discounts on Amazon products and services.''',
      ),
      //Role
      jobDescription(context, 'Role', '● Senior Software Engineer'),
      //Industry Type:
      jobDescription(context, 'Industry Type:', '''● E-commerce
● Technology'''),
      //Department
      jobDescription(context, 'Department:', '● Engineering'),
      //Employment Type
      jobDescription(context, 'Employment Type::', '● Full-time'),
      //Role Category
      jobDescription(context, 'Role Category:', '● Software Development'),
      //Education
      jobDescription(context, 'Education :',
          '''Education :
          ● Bachelor's Degree in Computer Science, Engineering, or a related field (Master's or Ph.D. preferred).
● Certifications in relevant technologies or methodologies (e.g., AWS Certification, Agile Certification) are a plus.'''),
    ],
  );
}



//the company widget in the all jobs screen
Widget companyWidget(
  context,
  int id,
  String imageUrl,
  String text,
) {
  return InkWell(
    onTap: () {
      // Navigate to CompanyProfileScreen and pass data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CompanyProfileScreen(id),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            circularImage(
              context,
              imageUrl,
              MediaQuery.of(context).size.width * 0.07,
            ),
            Text(
              text,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
// uses object
Widget jobVacancyWidget(
  context,
  Job job,
) {
  return InkWell(
    onTap: () => {},
    child: Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height * 0.15,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 249, 249, 249),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(200),
                ),
                elevation: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: MediaQuery.of(context).size.width * 0.05,
                  backgroundImage: NetworkImage(job.image),
                ),
              ),
              //company logo
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(job.title),
                    Text(
                      '${job.company} - ${job.location}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 115, 1, 115)),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    job.tag,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 115, 1, 115)),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              highlightedText(job.type,
                  const Color.fromARGB(255, 201, 231, 255), Colors.blue),
              highlightedText(job.experience,
                  const Color.fromARGB(255, 196, 255, 205), Colors.green),
              const Expanded(child: SizedBox()),
              Text(job.salary),
            ],
          ),
        ],
      ),
    ),
  );
}
//all jobs/for you jobs filter button

PreferredSizeWidget myAppBar(context, String title, bool searchVisible) {
  return AppBar(
    elevation: 0,
    shadowColor: Colors.transparent,
    foregroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    //forceMaterialTransparency: true,
    iconTheme: const IconThemeData(
      color: Color.fromARGB(255, 164, 78, 179), // Change the color to red
    ),
    actions: [
      if (searchVisible)
        IconButton(
          icon: const Icon(Icons.search,
              color: Color.fromARGB(255, 164, 78, 179)),
          onPressed: () {
            navigateTo(context, SearchView());
          },
        ),
    ],
    backgroundColor: Colors.white,
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Color.fromARGB(255, 164, 78, 179)),
    ),
  );
}

Widget myDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 115, 1, 115),
          ),
          child: Text(
            'Menu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Profile'),
          onTap: () {
            navigateTo(context, const ProfileScreen());
            // Handle the home tap
            //  Navigator.push(context, MaterialPageRoute(builder: (context) =>  const ProfileScreen()));
            // Navigator.of(context).pop(); // Close the drawer
          },
        ),
        const Divider(
          indent: 10,
          endIndent: 10,
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {
            // Handle the company list tap
            Navigator.of(context).pop(); // Close the drawer
          },
        ),
        const Divider(
          indent: 10,
          endIndent: 10,
        ),
        ListTile(
          leading: const Icon(Icons.assignment),
          title: const Text('job applications'),
          onTap: () {
            // Handle the company list tap
            Navigator.of(context).pop(); // Close the drawer
          },
        ),
      ],
    ),
  );
}

class CompanyProfileHeader extends StatelessWidget {
  final BuildContext context;
  final String? profileImage;
  final String backgroundImage;
  final String name;
  final int isVerified;
  final bool isProfile;
  final bool isEmployee;
  final String avg;

  const CompanyProfileHeader({
    super.key,
    required this.context,
    required this.profileImage,
    required this.backgroundImage,
    required this.name,
    required this.isVerified,
    this.isProfile = true,
    this.isEmployee=false,
    this.avg="0.0"
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        SizedBox(
          height: isProfile
              ? MediaQuery.of(context).size.height * 0.5
              : MediaQuery.of(context).size.height * 0.45,
          child: Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              ImageAssets.employeeBG,
              fit: BoxFit.cover,
              width: double.infinity,
              height: isProfile
                  ? MediaQuery.of(context).size.height * 0.35
                  : MediaQuery.of(context).size.height * 0.4,
            ),
          ),
        ),
        // Optional Rounded Border
        if (!isProfile)
          Positioned(
            bottom: 30,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
            ),
          ),

        // Profile or Company Image
        isProfile
            ? Positioned(
                left: MediaQuery.of(context).size.width * 0.3,
                bottom: 0,
                top: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width * 0.4,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: profileImage!=null
                              ? Image.network(
                            profileImage!,
                            fit: BoxFit.cover,
                          )
                              :Image.asset(ImageAssets.employeeIc),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                        isVerified==1?
                        const Icon(Icons.verified_rounded,color: Colors.lightBlue,):
                        const SizedBox()
                      ],
                    ),
                  ],
                ),
              )
            : Positioned(
                bottom: -4,
                left: 10,
                child: circularImage(context, profileImage!, 50),
              ),

        // Optional Back Button
        isProfile ? const Text('') : backButtonrounded(context),
        // Company Name for Company Header
        if (!isProfile)
          Positioned(
            left: MediaQuery.of(context).size.width * 0.4,
            bottom: 10,
            child: Row(
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        isProfile
            ? Positioned(
                bottom: 45,
                right: MediaQuery.of(context).size.width * 0.25,
                child: InkWell(
                  onTap: () {
                    launchUrl(
                      isEmployee?
                      Uri.parse('${EmployeeProfileCubit.videoFile}'):
                      Uri.parse('${ProfileCubit.videoFile}'),
                      mode: LaunchMode.platformDefault
                  );
                    },
                    child: highlightedIcon(Theme.of(context).primaryColor,
                        Colors.white, Icons.play_arrow_rounded,30)))
            : const Text(''),
        if (!isProfile)
          const Positioned(
            bottom: 70,
            left: 5,
            child: Icon(Icons.star_rate_rounded,color: Colors.yellow,size: 55,),
          ),
        if (!isProfile)
          Positioned(
            bottom: 87,
            left: 22,
            child: Text(avg,style: TextStyle(color: ColorManager.black,fontSize: 14,fontWeight: FontWeight.bold),),
          ),

      ],
    );
  }
}

class CommentItem extends StatelessWidget {
  final int commentId;
  final String commentWriter;
  final String commentText;
  final String commentWriterProfile;

  const CommentItem({
    super.key,
    required this.commentId,
    required this.commentWriter,
    required this.commentText,
    required this.commentWriterProfile,
  });

  @override
  Widget build(BuildContext context) {
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
                GestureDetector(
                  onTap: () {},
                  child: circularImage(
                    context,
                    commentWriterProfile,
                    MediaQuery.of(context).size.width * 0.05,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 249, 249, 249),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        commentWriter,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // ReadMoreText(
                      //  commentText,
                      //   trimMode: TrimMode.Line,
                      //   trimLines: 2,
                      //   colorClickableText: Colors.pink,
                      //   trimCollapsedText: 'Show more',
                      //   trimExpandedText: 'Show less',
                      //   moreStyle: TextStyle(
                      //       fontSize: 14, fontWeight: FontWeight.bold),
                      // )
                      seeMoreText(context, commentText, commentWriter,
                          commentWriterProfile, 99),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            bottom: -13,
            child: IconButton(
              splashColor: Colors.transparent,
              splashRadius: 1,
              onPressed: () {},
              icon: Icon(
                Icons.thumb_up_alt_rounded,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          const Positioned(
            right: 50,
            bottom: -5,
            child: Text(
              '28',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
//
Widget seeMoreText(
  BuildContext context,
  String text,
  String commentWriter,
  String commentWriterProfile,
  int maxLength,
) {
  final String truncatedText = CompanyProfileCubit.get(context)
      .truncateTextToFit(text, maxLength, context);
  return SizedBox(
    width: 400,
    child: RichText(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: truncatedText,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          if (text.length >= maxLength)
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () => CompanyProfileCubit.get(context)
                    .showFullComment(
                        context, commentWriter, text, commentWriterProfile),
                child: const Text(
                  'See More',
                  style: TextStyle(
                    color: Color.fromARGB(255, 156, 0, 164),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
// Dummy company JSON Data
final List<Map<String, String>> companyData = [
  {
    "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfF0wZy7mQfdYr7u_rBgFUpF1-XYBJ6Alr5w&s",
    "text": "Syriatel"
  },
  {
    "image":
        "https://static.wixstatic.com/media/d2252d_4c1a1bda6a774bd68f789c0770fd16e5~mv2.png",
    "text": "Amazon"
  },
  {
    "image":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png",
    "text": "Google"
  },
  {
    "image":
        "https://play-lh.googleusercontent.com/DIQzLQuHuupEoCe8TfpUdrsYDicq2cSE_WTsrZ-Ys6ppLHKdc7m5dbyqmQqiJi0JfQ",
    "text": "Burger King"
  },
  {
    "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-oTCfJdO8zwDoyHB7j5tktdQq31w6t31GsA&s",
    "text": "Lego"
  }
];
