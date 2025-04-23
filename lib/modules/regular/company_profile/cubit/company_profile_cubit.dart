import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/utils/end_points.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/values_manager.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/helpers/dio_helper.dart';
import '../../../../widgets/widgets.dart';
import '../../jobs/jobs_cubit.dart';
import '../../jobs/jobs_model.dart';
import '../company_model.dart';
import 'company_profile_states.dart';

class CompanyProfileCubit extends Cubit<CompanyProfileStates>{
  CompanyProfileCubit():super(CompanyProfileInitialState());

  static CompanyProfileCubit get(context) => BlocProvider.of(context); 
  
CompanyProfileModel? companyModel;
   dynamic company;
void getCompanyDetails(int id){
  print('before load');
  emit(CompanyLoadingState());
  DioHelper.getData(
    url: "$COMPANY_PROFILE/$id",
    token: token,
    ).then((value){
      print('company reviews');
      print(value?.data);
      companyModel = CompanyProfileModel.fromJson(value?.data);
      print(companyModel?.status);
      print(companyModel?.message);
      print(companyModel?.data.companyName);
      company = companyModel?.data;
      print(company.companyName);
      //print(company.ratings[0].comment);
      print('company reviews');
      emit(CompanySuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CompanyErrorState(error.toString()));
    });
}


///GET COMPANY JOBS

   JobsModel? jobsModel;
   List<dynamic>? jobs;
   void getCompanyJobs(id)
  {
    emit(CompanyJobsLoadingState());
    DioHelper.getData(
      url: '$GET_JOBS_OF_COMPANY/$id',
      token: token,
    ).then((value) {
      print('company jobs');
      print(value?.data);
      jobsModel = JobsModel.fromJson(value?.data);
      print(jobsModel?.status);
      print(jobsModel?.message);
      print(jobsModel?.data[0].section);
      jobs = jobsModel?.data;
      print('nasser');
      print('nasser');
      print(jobs?.length);
      print(jobs![0]);
      emit(CompanyJobsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CompanyJobsErrorState(error.toString()));
    });
  }

  ///ADD RATING


  void addRating({required id,required rating, required comment})
  {
    emit(AddRatingLoadingState());
    DioHelper.postData(
      url: ADD_RATING,
      token: token,
      data: {
        'company_id' : id,
        'rating' : rating,
        'comment' : comment
      },
    ).then((value) {
      print(value?.data);
      emit(AddRatingSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AddRatingErrorState(error.toString()));
    });
  }




  

String truncateTextToFit(String text, int maxLength, BuildContext context) {
  final String limitedText =
      text.length > maxLength ? text.substring(0, maxLength) : text;
  const TextStyle textStyle = TextStyle(fontSize: 16);
  const double maxWidth = 400;

  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: limitedText, style: textStyle),
    maxLines: 3,
    textDirection: TextDirection.ltr,
  );

  textPainter.layout(maxWidth: maxWidth);
  double buttonWidth = 8; // Assuming 16.0 is the font size

  final double availableWidth = maxWidth - buttonWidth;

  int endIndex = limitedText.length;

  textPainter.text = TextSpan(text: limitedText, style: textStyle);
  textPainter.layout(maxWidth: availableWidth);

  while (textPainter.didExceedMaxLines) {
    endIndex--;
    textPainter.text =
        TextSpan(text: limitedText.substring(0, endIndex), style: textStyle);
    textPainter.layout(maxWidth: availableWidth);
  }

  return limitedText.substring(0, endIndex);
}


void showFullComment(BuildContext context, String writer, String text, String commentWriterProfile) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              radius: AppSize.s28,
              backgroundColor: ColorManager.purple2,
              backgroundImage: const AssetImage(ImageAssets.employeeIc ),
            ),
            Text(writer),
          ],
        ),
        content: SingleChildScrollView(
          child: Text(text),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "See Less",
              style: TextStyle(color: Color.fromARGB(255, 156, 0, 164)),
            ),
          ),
        ],
      );
    },
  );
}

  void showContextMenu(BuildContext context, Offset offset) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromPoints(
          offset,
          offset,
        ),
        Offset.zero & overlay.size,
      ),
      items: [
        const PopupMenuItem<String>(
          value: 'report',
          child: Text('Report'),
        ),
      ],
    ).then((value) {
      if (value == 'report') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reported')),
        );
      }
    });
  }


final List<Job> companyJobs = [

  Job(
    image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png",
    title: "Product Manager",
    tag: "#1923",
    time: "2 days ago",
    role: "Manager",
    level: "Senior Level",
    experience: "5-7 years",
    type: "Permanent",
    salary: "\$150,000",
    company: "Google",
    location: "Mountain View, CA"
  ),
  
  Job(
    image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png",
    title: "Product Manager",
    tag: "#1923",
    time: "2 days ago",
    role: "Manager",
    level: "Senior Level",
    experience: "5-7 years",
    type: "Permanent",
    salary: "\$150,000",
    company: "Google",
    location: "Mountain View, CA"
  ),
  Job(
    image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png",
    title: "Product Manager",
    tag: "#1923",
    time: "2 days ago",
    role: "Manager",
    level: "Senior Level",
    experience: "5-7 years",
    type: "Permanent",
    salary: "\$150,000",
    company: "Google",
    location: "Mountain View, CA"
  ),
  
  Job(
    image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png",
    title: "Product Manager",
    tag: "#1923",
    time: "2 days ago",
    role: "Manager",
    level: "Senior Level",
    experience: "5-7 years",
    type: "Permanent",
    salary: "\$150,000",
    company: "Google",
    location: "Mountain View, CA"
  ),Job(
    image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png",
    title: "Product Manager",
    tag: "#1923",
    time: "2 days ago",
    role: "Manager",
    level: "Senior Level",
    experience: "5-7 years",
    type: "Permanent",
    salary: "\$150,000",
    company: "Google",
    location: "Mountain View, CA"
  ),
  
  Job(
    image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png",
    title: "Product Manager",
    tag: "#1923",
    time: "2 days ago",
    role: "Manager",
    level: "Senior Level",
    experience: "5-7 years",
    type: "Permanent",
    salary: "\$150,000",
    company: "Google",
    location: "Mountain View, CA"
  ),
  
];

//data
List<Comment> dummyComments = [
  const Comment(
      commentId: 1,
      commentWriter: 'Nigga',
      commentText: "Great place to work, fantastic perks, but can be very demanding.",
      commentWriterProfile:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbgk0yfCOe55931lf6q0osfhGRU-fnH8Im1g&s"),
  const Comment(
    commentId: 2,
    commentWriter: 'Lisa simpson',
    commentText: "I've enjoyed my time at Google. The company offers amazing benefits, and the work environment is collaborative and innovative. The projects are interesting and challenging, and there's a strong emphasis on professional development. However, the high expectations and fast-paced environment can be stressful at times.",
    commentWriterProfile:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvijrjZvRcdjlErXJcK3hcJrt_WsN-kFY84A&s',
          ),
  const Comment(
    commentId: 3,
    commentWriter: 'Random Hacker',
    commentText: '''Working at Google has been a transformative experience. The company is renowned for its innovative culture and commitment to making the world’s information universally accessible and useful. From day one, I was impressed by the level of talent and passion that my colleagues bring to their work. The perks and benefits are second to none – from free meals and gym access to generous parental leave and health benefits, Google truly cares about the well-being of its employees.
The projects I’ve worked on have been both challenging and rewarding. Google encourages its employees to think big and tackle complex problems, and there’s a sense of pride in contributing to products that have a global impact. The resources available for professional development are outstanding, with numerous opportunities for learning and growth, including internal courses, conferences, and mentorship programs.

That said, the job is not without its challenges. The work can be intense, with high expectations and tight deadlines. The company’s size and fast pace can sometimes make it difficult to navigate and prioritize tasks. Additionally, while Google promotes a healthy work-life balance, the reality is that many employees find themselves working long hours to meet the demands of their roles.

Overall, Google is an incredible place to work if you are passionate about technology and innovation and are willing to put in the effort to excel in a highly competitive environment. The opportunities for impact and personal growth are immense, and the collaborative and inclusive culture makes it a unique and fulfilling place to build a career.''',
    commentWriterProfile:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZ0FpBg5Myb9CQ-bQpFou9BY9JXoRG6208_Q&s",
  ),
];

}

//class
class Comment {
  final int commentId;
  final String commentWriter;
  final String commentText;
  final String commentWriterProfile;

  const Comment({
    required this.commentId,
    required this.commentWriter,
    required this.commentText,
    required this.commentWriterProfile,
  });
}
