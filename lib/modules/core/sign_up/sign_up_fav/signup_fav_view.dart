import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/modules/core/sign_up/sign_up_fav/cubit/cubit.dart';
import 'package:jobly/modules/core/sign_up/sign_up_fav/cubit/states.dart';
import 'package:jobly/modules/core/sign_up/sign_up_fav/signup_getcat_modle.dart';
import 'package:jobly/modules/core/sign_up/sign_up_fav/signup_getsubcat_modle.dart';

import '../../../../resources/assets_manager.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/font_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/style_manager.dart';
import '../../../../resources/values_manager.dart';
import '../../../home/home_layout_view.dart';

class SignupFav extends StatefulWidget {
  @override
  _SignupFavState createState() => _SignupFavState();
}

class _SignupFavState extends State<SignupFav> {
  MyData? selectedIdfav; // Add a variable to store the selected value
  JopsSection? selectedSubOption; // Variable to store the selected sub-option

  String id="";

  final List<String> idfavOptions = [
    'Option 1',
    'Option 2',
    'Option 3',
  ];




  final Map<String, List<String>> subOptions = {
    'Option 1': ['SubOption 1.1', 'SubOption 1.2'],
    'Option 2': ['SubOption 2.1', 'SubOption 2.2'],
    'Option 3': ['SubOption 3.1', 'SubOption 3.2'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.purple6,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeLayoutView()),
              );
            },
            child: Text(
              AppStrings.skip,
              style: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s20),
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => SignUpFavCubit()..getCat(),
        child: BlocConsumer<SignUpFavCubit, SignupFavStates>(
          listener: (context, state) {
            if (state is SignupFavErorrStates) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Signup Failed: ${state.erorr}'),
                ),
              );
            } else if (state is SignupFavSuccessStates) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Signup Success'),
                ),
              );
              // Navigate to another screen
               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomeLayoutView()));
            }
          },
          
          builder: (BuildContext context, SignupFavStates state) {
            var cubit =SignUpFavCubit.get(context);
            return    Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorManager.purple4, // Darker purple
                  ColorManager.purple7, // Lighter purple (adjust as needed)
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: AppSize.s100),
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Card(
                            child: Container(
                              width: 300, // width
                              height: 500, // height
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Image(image: AssetImage(ImageAssets.purpleLogo)),
                                  const SizedBox(height: AppSize.s16),
                                  DropdownButton<MyData>(
                                    value: selectedIdfav,
                                    hint: Text('Select an option'),
                                    onChanged: (MyData? newValue) {
                                      
                                      setState(() {
                                        selectedIdfav = newValue;
                                        print(selectedIdfav?.id!);
                                        selectedSubOption = null; // Reset the sub-option when a new option is selected
                                        cubit.getSubCat(selectedIdfav?.id!);
                                      });
                                      

                                    },
                                    items: cubit.cat.map<DropdownMenuItem<MyData>>((value) {
                                      return DropdownMenuItem<MyData>(
                                        value: value,
                                        child: Text(value.category!),
                                      );
                                    }).toList(),
                                  ),
                                  if (selectedIdfav != null) ...[
                                    const SizedBox(height: 16),
                                    DropdownButton<JopsSection>(
                                      value: selectedSubOption,
                                      hint: Text('Select a sub-option'),
                                      onChanged: (JopsSection? newValue) {
                                        
                                        setState(() {
                                          selectedSubOption = newValue;
                                          print(selectedSubOption!.id!);

                                          id=selectedSubOption!.id!.toString();

                                        });
                                      },
                                      items: cubit.sub_cat!.map<DropdownMenuItem<JopsSection>>((value) {
                                        return DropdownMenuItem<JopsSection>(
                                          value: value,
                                          child: Text(value.section!),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                  const SizedBox(height: 16),
                                  BlocBuilder<SignUpFavCubit, SignupFavStates>(
                                    builder: (context, state) {
                                      if (state is SignupFavLoadingStates) {
                                        return const CircularProgressIndicator();
                                      }

                                      return ElevatedButton(
                                        onPressed: () {
                                          cubit.FavSignUp(favid: id);
                              
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: ColorManager.white, // Set the button's background color to white
                                        ),
                                        child: Text(
                                          AppStrings.next,
                                          style: TextStyle(
                                            color: ColorManager.purple6,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: -40,
                            left: 120,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ColorManager.purple6, // Transparent border color
                                  width: 5.0, // Border width
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 35,
                                backgroundColor: ColorManager.white,
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: ColorManager.purple6,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
            },
          
        ),
      ),
    );
  }
}
