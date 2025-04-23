
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/resources/assets_manager.dart';
import 'package:jobly/resources/color_manager.dart';
import 'package:jobly/resources/font_manager.dart';
import 'package:jobly/resources/style_manager.dart';
import 'package:jobly/resources/values_manager.dart';
import '../../widgets/widgets_part2.dart';
import 'cubit/community_cubit.dart';
import 'cubit/community_states.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});
  @override
  Widget build(BuildContext context) {
    var newQuestionController = TextEditingController();
    var newAdviceController = TextEditingController();


    return BlocProvider(
        create: (BuildContext context) => CommunityCubit()..getQuestionsLatest()..getCategories(),
        child: BlocConsumer<CommunityCubit, CommunityStates>(
            listener: (context, state) {
              if (state is AddQuestionSuccessState) {
                if (state.status == true) {
                  showToast(text: 'Question is Sent Successfully.', state: ToastStates.SUCCESS);
                  Navigator.pop(context);
                } else {
                  showToast(text: state.message, state: ToastStates.ERROR);
                }
              }
              if (state is AddAdviceSuccessState) {
                if (state.status == true) {
                  showToast(text: 'Advice is Sent Successfully.', state: ToastStates.SUCCESS);
                  CommunityCubit.get(context).getAdvicesLatest();
                  Navigator.pop(context);
                } else {
                  showToast(text: state.message, state: ToastStates.ERROR);
                }
              }
              if (state is DeleteAdviceSuccessState) {
                CommunityCubit.get(context).getAdvicesLatest();
              }

              if (state is ReportQuestionSuccessState) {
                if (state.status == true) {
                  showToast(text: 'Report is Sent Successfully.', state: ToastStates.SUCCESS);
                  Navigator.pop(context);
                } else {
                  showToast(text: state.message, state: ToastStates.ERROR);
                }
              }
              if (state is ReportAdviceSuccessState) {
                if (state.status == true) {
                  showToast(text: 'Report is Sent Successfully.', state: ToastStates.SUCCESS);
                  Navigator.pop(context);
                } else {
                  showToast(text: state.message, state: ToastStates.ERROR);
                }
              }

            },
            builder: (context, state) {
              var cubit = CommunityCubit.get(context);
              return Scaffold(
                appBar: AppBar(
                  elevation: AppSize.s0,
                  backgroundColor: ColorManager.white,
                  title: Text('Community',style: getMediumStyle(color: ColorManager.darkPrimary).copyWith(fontSize: FontSize.s22),),
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(AppPadding.p14),
                      child: InkWell(
                          onTap:(){
                            cubit.getQuestionsLatest();
                            cubit.dropDownValueCategorySort=null;
                            },
                          child: Image.asset(ImageAssets.trendingIc,width: AppSize.s20,height: AppSize.s16,)),
                    ),
                  ],
                ),
                backgroundColor: ColorManager.offWhite,
                floatingActionButton: FloatingActionButton(
                    backgroundColor: ColorManager.purple6,
                    onPressed: () {
                      if(cubit.currentIndex == 0) {
                        addingDialogWithDropdown(
                            cubit,
                            context,
                            title: "Add Question :",
                            controller: newQuestionController,
                            onPressed:  (){
                              cubit.addQuestion(category: cubit.dropDownValueCategory, question: newQuestionController.text);
                              cubit.dropDownValueCategorySort=null;
                              cubit.getQuestionsLatest();
                              newQuestionController.clear();
                            },
                        );
                      } else {
                        addingDialog(
                            cubit,
                            context,
                            title: "Add Advice :",
                            controller: newAdviceController,
                            onPressed: (){
                              cubit.addAdvice(advice: newAdviceController.text);
                              newAdviceController.clear();
                            }
                        );

                      }
                    },
                    child: Icon(Icons.add,color: ColorManager.purple2,)
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    const SizedBox(height: AppSize.s14,),
                    SizedBox(
                      height: AppSize.s50,
                      width: AppSize.s350,
                      child: ListView.builder(
                        itemCount: 2,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index)=> GestureDetector(
                          onTap: (){
                            cubit.changeTabBar(index);
                            if(cubit.currentIndex==0) {
                              cubit.getQuestionsLatest();
                            } else {
                              cubit.getAdvicesLatest();
                            }
                          },
                          child: animatedTabBarItem(cubit, index, AppSize.s2, AppSize.s165, ColorManager.purple6),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSize.s16,),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            if(cubit.currentIndex==0)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: myDropDownButton(
                                    value: cubit.dropDownValueCategorySort,
                                    hint: 'Choose Category',
                                    function: (newValue) {
                                      cubit.changeCategorySortDropDownButton(newValue!);
                                      cubit.getQuestionsCat(cubit.dropDownValueCategorySort);
                                    },
                                    items: cubit.categoriesItems
                                ),
                              ),
                            cubit.currentIndex==0?
                            cubit.questions!.isNotEmpty?questionsBuilder(cubit.questions, context, cubit, state):const Center(child: Text("No Questions Yet")):
                            advicesBuilder(cubit.advices, context, cubit, state)

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
