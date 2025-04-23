import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/modules/regular/add_job/add_job_view.dart';
import 'package:jobly/modules/regular/profile/cubit/profile_states.dart';
import 'package:jobly/utils/constants.dart';
import '../../../resources/color_manager.dart';
import '../../../widgets/widgets_part2.dart';
import '../../../widgets/widgets.dart';
import 'cubit/profile_cubit.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfileDetails(),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if(state is SendVerificationSuccessState){
            showToast(text: state.message, state: state.status?ToastStates.SUCCESS:ToastStates.ERROR);
          }else if(state is CancelVerificationSuccessState){
            showToast(text: state.message, state: state.status?ToastStates.SUCCESS:ToastStates.ERROR);
          }else if(state is DeleteMyJobSuccessState){
            showToast(text: "Deleted Successfully", state: ToastStates.SUCCESS);
          }
        },
        builder: (context, state) {
          var cubit = ProfileCubit.get(context);
          return Scaffold(
            floatingActionButton: FloatingActionButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddJobView(),
                    ),
                  );
                },
                backgroundColor: ColorManager.purple6,
                child: Icon(Icons.add,color: ColorManager.purple2,)
            ),
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
                    cubit.profile.employee.image!=null?
                    "${baseUrl}images/Employees/${cubit.profile.employee.image.filename}" :
                    null,
                    backgroundImage:
                        "https://live.staticflickr.com/65535/49675583756_a078ac45a9_b.jpg",
                    name: '${cubit.profile.name}',
                    isVerified: cubit.profile.authentication,
                    isProfile: true,
                  ),

                  footer(cubit,context,state),


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
//     _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse("${baseUrl}videos/videos/${ProfileCubit.get(context).profile.employee.video.filename}"));
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

