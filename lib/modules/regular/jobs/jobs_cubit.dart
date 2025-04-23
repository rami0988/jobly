import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/constants.dart';
import '../../../utils/end_points.dart';
import '../../../utils/helpers/dio_helper.dart';
import 'company_model.dart';
import 'jobs_model.dart';
import 'jobs_states.dart';

class JobsCubit extends Cubit<JobsStates> {
  JobsCubit() : super(JobsInitialState());

  static JobsCubit get(context) => BlocProvider.of(context);



  //Toggling between all jobs and my Jobs
  bool myJobs=true;
  void changeJobs(){
    myJobs = !myJobs;
    emit(ChangeJobsState());
  }

  ///GET JOBS
   JobsModel? jobsModel;
   List<dynamic>? jobs;
   void getJobs()
  {
    emit(JobsLoadingState());
    DioHelper.getData(
      url: GET_FAV_JOBS,
      token: token,
    ).then((value) {
      print(value?.data);
      jobsModel = JobsModel.fromJson(value?.data);
      print(jobsModel?.status);
      print(jobsModel?.message);
      print(jobsModel?.data[0].section);
      jobs = jobsModel?.data;
      emit(JobsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(JobsErrorState(error.toString()));
    });
  }

  ///GET All JOBS
  JobsModel? allJobsModel;
  void getAllJobs()
  {
    emit(JobsLoadingState());
    DioHelper.getData(
      url: GET_COMPANIES_JOBS,
      token: token,
    ).then((value) {
      print(value?.data);
      allJobsModel = JobsModel.fromJson(value?.data);
      print(jobsModel?.status);
      print(jobsModel?.message);
      print(jobsModel?.data[0].section);
      jobs = allJobsModel?.data;
      emit(JobsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(JobsErrorState(error.toString()));
    });
  }

  ///GET COMPANIES
  CompanyModel? companyModel;
  List<dynamic>? companies;
  void getCompanies()
  {
    emit(CompaniesLoadingState());
    DioHelper.getData(
      url: GET_COMPANIES,
      token: token,
    ).then((value) {
      print(value?.data);
      companyModel = CompanyModel.fromJson(value?.data);
      print(companyModel?.status);
      print(companyModel?.message);
      print(companyModel?.data[0].companyName);
      companies = companyModel?.data;
      emit(CompaniesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CompaniesErrorState(error.toString()));
    });
  }















// List<Job> getCurrentList() {
//     if (currentList == 'For You') {
//       return yourJobs;
//     } else {
//       return allJobs;
//     }
//   }

  //map function
  // List<Map<String, String>> getCurrentList() {
  //   if (currentList == 'For You') {
  //     return yourJobs;
  //   } else {
  //     return allJobs;
  //   }
  // }

  // String currentList = 'For You';
  //
  // void changeIndex(String? value) {
  //   currentList = value ?? 'For You';
  //   if (currentList == 'For You') {
  //     emit(ForYouJobsState());
  //   } else {
  //     emit(AllJobsState());
  //   }
  // }

// final List<Job> yourJobs = [
//
//   Job(
//     image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png",
//     title: "Product Manager",
//     tag: "#1923",
//     time: "2 days ago",
//     role: "Manager",
//     level: "Senior Level",
//     experience: "5-7 years",
//     type: "Permanent",
//     salary: "\$150,000",
//     company: "Google",
//     location: "Mountain View, CA"
//   ),
//
//   Job(
//     image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png",
//     title: "Product Manager",
//     tag: "#1923",
//     time: "2 days ago",
//     role: "Manager",
//     level: "Senior Level",
//     experience: "5-7 years",
//     type: "Permanent",
//     salary: "\$150,000",
//     company: "Google",
//     location: "Mountain View, CA"
//   ),
//   Job(
//     image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png",
//     title: "Product Manager",
//     tag: "#1923",
//     time: "2 days ago",
//     role: "Manager",
//     level: "Senior Level",
//     experience: "5-7 years",
//     type: "Permanent",
//     salary: "\$150,000",
//     company: "Google",
//     location: "Mountain View, CA"
//   ),
//
//   Job(
//     image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png",
//     title: "Product Manager",
//     tag: "#1923",
//     time: "2 days ago",
//     role: "Manager",
//     level: "Senior Level",
//     experience: "5-7 years",
//     type: "Permanent",
//     salary: "\$150,000",
//     company: "Google",
//     location: "Mountain View, CA"
//   ),
//   Job(
//     image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png",
//     title: "Product Manager",
//     tag: "#1923",
//     time: "2 days ago",
//     role: "Manager",
//     level: "Senior Level",
//     experience: "5-7 years",
//     type: "Permanent",
//     salary: "\$150,000",
//     company: "Google",
//     location: "Mountain View, CA"
//   ),
//
//   Job(
//     image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png",
//     title: "Product Manager",
//     tag: "#1923",
//     time: "2 days ago",
//     role: "Manager",
//     level: "Senior Level",
//     experience: "5-7 years",
//     type: "Permanent",
//     salary: "\$150,000",
//     company: "Google",
//     location: "Mountain View, CA"
//   ),
//
// ];

//object list
// Create a list of Job objects
// final List<Job> allJobs = [
//   Job(
//     image: "https://static.wixstatic.com/media/d2252d_4c1a1bda6a774bd68f789c0770fd16e5~mv2.png",
//     title: "Software Engineer",
//     tag: "#1921",
//     time: "1 day ago",
//     role: "Developer",
//     level: "Mid Level",
//     experience: "3-5 years",
//     type: "Permanent",
//     salary: "\$120,000",
//     company: "Amazon",
//     location: "Seattle, WA"
//   ),
//   Job(
//     image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png",
//     title: "Product Manager",
//     tag: "#1923",
//     time: "2 days ago",
//     role: "Manager",
//     level: "Senior Level",
//     experience: "5-7 years",
//     type: "Permanent",
//     salary: "\$150,000",
//     company: "Google",
//     location: "Mountain View, CA"
//   ),
//   Job(
//     image: "https://play-lh.googleusercontent.com/DIQzLQuHuupEoCe8TfpUdrsYDicq2cSE_WTsrZ-Ys6ppLHKdc7m5dbyqmQqiJi0JfQ",
//     title: "Chef",
//     tag: "#1900",
//     time: "3 days ago",
//     role: "Cook",
//     level: "Entry Level",
//     experience: "1-2 years",
//     type: "Temporary",
//     salary: "\$40,000",
//     company: "Burger King",
//     location: "New York, NY"
//   ),
//   Job(
//     image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-oTCfJdO8zwDoyHB7j5tktdQq31w6t31GsA&s",
//     title: "Designer",
//     tag: "#1933",
//     time: "4 days ago",
//     role: "Designer",
//     level: "Mid Level",
//     experience: "3-5 years",
//     type: "Permanent",
//     salary: "\$70,000",
//     company: "LEGO",
//     location: "Billund, Denmark"
//   ),
//   Job(
//     image: "https://static.wixstatic.com/media/d2252d_4c1a1bda6a774bd68f789c0770fd16e5~mv2.png",
//     title: "Software Engineer",
//     tag: "#1921",
//     time: "1 day ago",
//     role: "Developer",
//     level: "Mid Level",
//     experience: "3-5 years",
//     type: "Permanent",
//     salary: "\$120,000",
//     company: "Amazon",
//     location: "Seattle, WA"
//   ),
//   Job(
//     image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png",
//     title: "Product Manager",
//     tag: "#1923",
//     time: "2 days ago",
//     role: "Manager",
//     level: "Senior Level",
//     experience: "5-7 years",
//     type: "Permanent",
//     salary: "\$150,000",
//     company: "Google",
//     location: "Mountain View, CA"
//   ),
//   Job(
//     image: "https://play-lh.googleusercontent.com/DIQzLQuHuupEoCe8TfpUdrsYDicq2cSE_WTsrZ-Ys6ppLHKdc7m5dbyqmQqiJi0JfQ",
//     title: "Chef",
//     tag: "#1900",
//     time: "3 days ago",
//     role: "Cook",
//     level: "Entry Level",
//     experience: "1-2 years",
//     type: "Temporary",
//     salary: "\$40,000",
//     company: "Burger King",
//     location: "New York, NY"
//   ),
//   Job(
//     image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-oTCfJdO8zwDoyHB7j5tktdQq31w6t31GsA&s",
//     title: "Designer",
//     tag: "#1933",
//     time: "4 days ago",
//     role: "Designer",
//     level: "Mid Level",
//     experience: "3-5 years",
//     type: "Permanent",
//     salary: "\$70,000",
//     company: "LEGO",
//     location: "Billund, Denmark"
//   ),
// ];

//maplist
//   final List<Map<String, String>> allJobs = [
//     {
//       "image":
//           "https://static.wixstatic.com/media/d2252d_4c1a1bda6a774bd68f789c0770fd16e5~mv2.png",
//       "title": "Software Engineer",
//       "tag": "#1921",
//       "time": "1 day ago",
//       "role": "Developer",
//       "level": "Mid Level",
//       "experience": "3-5 years",
//       "type": "Permanent",
//       "salary": "\$120,000",
//       "company": "Amazon",
//       "location": "Seattle, WA"
//     },
//     {
//       "image":
//           "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png",
//       "title": "Product Manager",
//       "tag": "#1923",
//       "time": "2 days ago",
//       "role": "Manager",
//       "level": "Senior Level",
//       "experience": "5-7 years",
//       "type": "Permanent",
//       "salary": "\$150,000",
//       "company": "Google",
//       "location": "Mountain View, CA"
//     },
//     {
//       "image":
//           "https://play-lh.googleusercontent.com/DIQzLQuHuupEoCe8TfpUdrsYDicq2cSE_WTsrZ-Ys6ppLHKdc7m5dbyqmQqiJi0JfQ",
//       "title": "Chef",
//       "tag": "#1900",
//       "time": "3 days ago",
//       "role": "Cook",
//       "level": "Entry Level",
//       "experience": "1-2 years",
//       "type": "Temporary",
//       "salary": "\$40,000",
//       "company": "Burger King",
//       "location": "New York, NY"
//     },
//     {
//       "image":
//           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-oTCfJdO8zwDoyHB7j5tktdQq31w6t31GsA&s",
//       "title": "Designer",
//       "tag": "#1933",
//       "time": "4 days ago",
//       "role": "Designer",
//       "level": "Mid Level",
//       "experience": "3-5 years",
//       "type": "Permanent",
//       "salary": "\$70,000",
//       "company": "LEGO",
//       "location": "Billund, Denmark"
//     },
//     {
//       "image":
//           "https://static.wixstatic.com/media/d2252d_4c1a1bda6a774bd68f789c0770fd16e5~mv2.png",
//       "title": "Software Engineer",
//       "tag": "#1921",
//       "time": "1 day ago",
//       "role": "Developer",
//       "level": "Mid Level",
//       "experience": "3-5 years",
//       "type": "Permanent",
//       "salary": "\$120,000",
//       "company": "Amazon",
//       "location": "Seattle, WA"
//     },
//     {
//       "image":
//           "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png",
//       "title": "Product Manager",
//       "tag": "#1923",
//       "time": "2 days ago",
//       "role": "Manager",
//       "level": "Senior Level",
//       "experience": "5-7 years",
//       "type": "Permanent",
//       "salary": "\$150,000",
//       "company": "Google",
//       "location": "Mountain View, CA"
//     },
//     {
//       "image":
//           "https://play-lh.googleusercontent.com/DIQzLQuHuupEoCe8TfpUdrsYDicq2cSE_WTsrZ-Ys6ppLHKdc7m5dbyqmQqiJi0JfQ",
//       "title": "Chef",
//       "tag": "#1900",
//       "time": "3 days ago",
//       "role": "Cook",
//       "level": "Entry Level",
//       "experience": "1-2 years",
//       "type": "Temporary",
//       "salary": "\$40,000",
//       "company": "Burger King",
//       "location": "New York, NY"
//     },
//     {
//       "image":
//           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-oTCfJdO8zwDoyHB7j5tktdQq31w6t31GsA&s",
//       "title": "Designer",
//       "tag": "#1933",
//       "time": "4 days ago",
//       "role": "Designer",
//       "level": "Mid Level",
//       "experience": "3-5 years",
//       "type": "Permanent",
//       "salary": "\$70,000",
//       "company": "LEGO",
//       "location": "Billund, Denmark"
//     }
//   ];
}

// Define a Job class
class Job {
  final String image;
  final String title;
  final String tag;
  final String time;
  final String role;
  final String level;
  final String experience;
  final String type;
  final String salary;
  final String company;
  final String location;

  Job({
    required this.image,
    required this.title,
    required this.tag,
    required this.time,
    required this.role,
    required this.level,
    required this.experience,
    required this.type,
    required this.salary,
    required this.company,
    required this.location,
  });
}





//json try
/*
Yes, there are better approaches that can enhance the maintainability, scalability, and readability of your code when dealing with data from an API. Here are a couple of recommendations:

### 1. Using JSON Serialization and Deserialization

This approach involves converting JSON data directly into Dart objects and vice versa. It leverages the `json_serializable` package to automate the generation of code for serializing and deserializing JSON data.

**Steps:**
1. Define a model class with JSON serialization annotations.
2. Use the `json_serializable` package to generate the necessary serialization code.
3. Parse the API response directly into Dart objects.

**Example:**

1. **Add dependencies to `pubspec.yaml`:**
   ```yaml
   dependencies:
     json_annotation: ^4.0.1

   dev_dependencies:
     build_runner: ^2.0.6
     json_serializable: ^4.1.0
   ```

2. **Define the model class:**

   ```dart
   import 'package:json_annotation/json_annotation.dart';

   part 'job.g.dart';

   @JsonSerializable()
   class Job {
     final String image;
     final String title;
     final String tag;
     final String time;
     final String role;
     final String level;
     final String experience;
     final String type;
     final String salary;
     final String company;
     final String location;

     Job({
       required this.image,
       required this.title,
       required this.tag,
       required this.time,
       required this.role,
       required this.level,
       required this.experience,
       required this.type,
       required this.salary,
       required this.company,
       required this.location,
     });

     factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);
     Map<String, dynamic> toJson() => _$JobToJson(this);
   }
   ```

3. **Generate serialization code:**
   Run the build_runner command to generate the JSON serialization code:
   ```bash
   flutter pub run build_runner build
   ```

4. **Parse API response:**
   ```dart
   import 'dart:convert';
   import 'job.dart';

   Future<List<Job>> fetchJobs() async {
     final response = await http.get(Uri.parse('https://api.example.com/jobs'));

     if (response.statusCode == 200) {
       List<dynamic> jobsJson = json.decode(response.body);
       return jobsJson.map((json) => Job.fromJson(json)).toList();
     } else {
       throw Exception('Failed to load jobs');
     }
   }
   
   ```

### 2. Using a State Management Solution

Integrate a state management solution such as `Provider`, `Riverpod`, or `Bloc` to manage the state of your application and handle data fetching, parsing, and UI updates in a more organized manner.

**Example with `Provider`:**

1. **Add dependencies to `pubspec.yaml`:**
   ```yaml
   dependencies:
     provider: ^6.0.0
     json_annotation: ^4.0.1

   dev_dependencies:
     build_runner: ^2.0.6
     json_serializable: ^4.1.0
   ```

2. **Define the model class:** (same as above)

3. **Create a service class to fetch data:**
   ```dart
   import 'dart:convert';
   import 'package:http/http.dart' as http;
   import 'job.dart';

   class JobService {
     Future<List<Job>> fetchJobs() async {
       final response = await http.get(Uri.parse('https://api.example.com/jobs'));

       if (response.statusCode == 200) {
         List<dynamic> jobsJson = json.decode(response.body);
         return jobsJson.map((json) => Job.fromJson(json)).toList();
       } else {
         throw Exception('Failed to load jobs');
       }
     }
   }
   ```

4. **Create a `ChangeNotifier` to manage state:**
   ```dart
   import 'package:flutter/foundation.dart';
   import 'job.dart';
   import 'job_service.dart';

   class JobProvider with ChangeNotifier {
     List<Job> _jobs = [];
     bool _isLoading = false;

     List<Job> get jobs => _jobs;
     bool get isLoading => _isLoading;

     final JobService jobService;

     JobProvider({required this.jobService});

     Future<void> fetchJobs() async {
       _isLoading = true;
       notifyListeners();

       try {
         _jobs = await jobService.fetchJobs();
       } catch (e) {
         // handle error
       } finally {
         _isLoading = false;
         notifyListeners();
       }
     }
   }
   ```

5. **Provide the state to the widget tree:**
   ```dart
   import 'package:flutter/material.dart';
   import 'package:provider/provider.dart';
   import 'job_provider.dart';
   import 'job_service.dart';

   void main() {
     runApp(
       ChangeNotifierProvider(
         create: (context) => JobProvider(jobService: JobService()),
         child: MyApp(),
       ),
     );
   }

   class MyApp extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return MaterialApp(
         home: JobListScreen(),
       );
     }
   }
   ```

6. **Use the provider in the UI:**
   ```dart
   import 'package:flutter/material.dart';
   import 'package:provider/provider.dart';
   import 'job_provider.dart';

   class JobListScreen extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       final jobProvider = Provider.of<JobProvider>(context);

       return Scaffold(
         appBar: AppBar(title: Text('Jobs')),
         body: jobProvider.isLoading
             ? Center(child: CircularProgressIndicator())
             : ListView.builder(
                 itemCount: jobProvider.jobs.length,
                 itemBuilder: (context, index) {
                   final job = jobProvider.jobs[index];
                   return ListTile(
                     title: Text(job.title),
                     subtitle: Text('${job.company} - ${job.location}'),
                   );
                 },
               ),
         floatingActionButton: FloatingActionButton(
           onPressed: jobProvider.fetchJobs,
           child: Icon(Icons.refresh),
         ),
       );
     }
   }
   ```

### Benefits of These Approaches:

1. **JSON Serialization and Deserialization:**
   - Provides a clear and structured way to handle API responses.
   - Reduces boilerplate code by generating serialization code automatically.
   - Ensures type safety and enhances code readability.

2. **State Management Solution:**
   - Organizes state management, making it easier to handle data fetching, error handling, and UI updates.
   - Promotes a clean architecture by separating concerns (e.g., business logic, state management, and UI).
   - Enhances testability and maintainability of the codebase.

By leveraging these techniques, you can create a more robust, maintainable, and scalable solution for your API-driven application.
*/
