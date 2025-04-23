import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/resources/color_manager.dart';
import '../../widgets/widgets.dart';
import 'home_layout_cubit.dart';
import 'home_layout_states.dart';

class HomeLayoutView extends StatelessWidget {
  const HomeLayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            drawer:  myDrawer(context),
            backgroundColor: ColorManager.white,   
            bottomNavigationBar: myNavBar(context),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}


Widget myNavBar(context) {
  return BottomNavigationBar(
      backgroundColor: ColorManager.white, 
      selectedItemColor: ColorManager.purple6, 
      type: BottomNavigationBarType.fixed,
      currentIndex: HomeCubit.get(context).currentIndex,
      onTap: (index) {
        HomeCubit.get(context).changeIndex(index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.work),
          label: 'Jobs',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          label: 'Applications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.question_answer_outlined),
          label: 'Community',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.announcement_outlined),
          label: 'Announcements',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ]);
}
