import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/utils/constants.dart';
import '../../../widgets/widgets_part2.dart';
import '../../../widgets/widgets.dart';
import 'cubit/employee_profile_cubit.dart';
import 'cubit/employee_profile_states.dart';


class EmployeeProfileScreen extends StatelessWidget {
  const EmployeeProfileScreen(this.id,{super.key});
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeProfileCubit()..getEmployeeProfileDetails(id),
      child: BlocConsumer<EmployeeProfileCubit, EmployeeProfileStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = EmployeeProfileCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child:
              cubit.profile == null ?
              const Center(child: CircularProgressIndicator()):
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SafeArea(child: SizedBox()),
                  CompanyProfileHeader(
                    context: context,
                    profileImage:
                    "${baseUrl}images/Employees/${cubit.profile.employee.image.filename}",
                    backgroundImage:
                    "https://live.staticflickr.com/65535/49675583756_a078ac45a9_b.jpg",
                    name: '${cubit.profile.name}',
                    isVerified: cubit.profile.authentication,
                    isProfile: true,
                    isEmployee: true,
                  ),
                  pointsAndPosts(cubit,context),
                  aboutMe(cubit,context),


                ],
              ),
            ),
          );
        },
      ),
    );
  }
}













// class NetworkMediaWidget extends StatefulWidget {
//   @override
//   NetworkMediaWidgetState createState() => NetworkMediaWidgetState();
// }

//
// class NetworkMediaWidget extends StatefulWidget {
//   @override
//   _NetworkMediaWidgetState createState() => _NetworkMediaWidgetState();
// }
//
// class _NetworkMediaWidgetState extends State<NetworkMediaWidget> {
//   VideoPlayerController? _videoPlayerController;
//   ChewieController? _chewieController;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeVideoPlayer();
//   }
//
//   Future<void> _initializeVideoPlayer() async {
//     // Replace with your video URL
//
//     _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse("${baseUrl}videos/videos/${EmployeeProfileCubit.get(context).profile.employee.video.filename}"));
//
//     await _videoPlayerController!.initialize();
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController!,
//       aspectRatio: _videoPlayerController!.value.aspectRatio,
//       autoPlay: false,
//       looping: false,
//     );
//
//     setState(() {});
//   }
//
//   @override
//   void dispose() {
//     _videoPlayerController?.dispose();
//     _chewieController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _videoPlayerController != null && _videoPlayerController!.value.isInitialized
//         ? Chewie(
//       controller: _chewieController!,
//     )
//         : Center(
//       child: CircularProgressIndicator(),
//     );
//   }
// }
//

