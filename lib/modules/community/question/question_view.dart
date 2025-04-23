
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobly/resources/assets_manager.dart';
import 'package:jobly/resources/color_manager.dart';
import 'package:jobly/resources/font_manager.dart';
import 'package:jobly/resources/style_manager.dart';
import 'package:jobly/resources/values_manager.dart';

import '../../../widgets/widgets_part2.dart';
import 'cubit/question_cubit.dart';
import 'cubit/question_states.dart';



class QuestionView extends StatelessWidget {
  const QuestionView(this.question, {super.key});
  final question;
  @override
  Widget build(BuildContext context) {
    var answerController = TextEditingController();

    return BlocProvider(
        create: (BuildContext context) => QuestionCubit()..getAnswers(question.id),
        child: BlocConsumer<QuestionCubit, QuestionStates>(
            listener: (context, state) {
              if (state is AddAnswerSuccessState) {
                if (state.addStatus == true) {
                  showToast(text: 'Answer is Sent.', state: ToastStates.SUCCESS);
                  Navigator.pop(context);
                } else {
                  showToast(text: state.addMessage, state: ToastStates.ERROR);
                }
              }
              if (state is ReportAnswerSuccessState) {
                if (state.reportStatus == true) {
                  showToast(text: 'Report is Sent.', state: ToastStates.SUCCESS);
                  Navigator.pop(context);
                } else {
                  showToast(text: state.reportMessage, state: ToastStates.ERROR);
                }
              }
              if (state is DeleteAnswerSuccessState) {
                if (state.deleteStatus == true) {
                  showToast(text: 'Answer is Deleted.', state: ToastStates.SUCCESS);
                  Navigator.pop(context);
                } else {
                  showToast(text: state.deleteMessage, state: ToastStates.ERROR);
                }
              }
              if (state is EditAnswerSuccessState) {
                if (state.editStatus == true) {
                  showToast(text: 'Answer is edited.', state: ToastStates.SUCCESS);

                } else {
                  showToast(text: state.editMessage, state: ToastStates.ERROR);
                }
              }
            },
            builder: (context, state) {
              var cubit = QuestionCubit.get(context);
              return Scaffold(
                appBar: AppBar(
                  elevation: AppSize.s0,
                  backgroundColor: ColorManager.white,
                  title: Text('Question',style: getMediumStyle(color: ColorManager.darkPrimary).copyWith(fontSize: FontSize.s22),),
                ),
                backgroundColor: ColorManager.offWhite,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    const SizedBox(height: AppSize.s14,),
                    buildDetailedQuestionItem(question, context, cubit, state),
                    //const SizedBox(height: AppSize.s16,),
                    Padding(
                      padding: const EdgeInsets.all( 20.0),
                      child: defaultFormField(
                          controller: answerController,
                          type: TextInputType.text,
                          label: "Add Answer",
                          suffix: Icons.add,
                          suffixPressed: (){
                            cubit.addAnswer(questionId: question.id, content: answerController.text);
                            question.answersCount++;
                            cubit.getAnswers(question.id);
                          },
                          prefix: Icons.mode_comment_rounded
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                      child: Row(
                        children: [
                          Image.asset(ImageAssets.trendingIc,width: AppSize.s20,height: AppSize.s20,),
                          Text("Top Answers:",style: getSemiBoldStyle(color: ColorManager.grey).copyWith(fontSize: FontSize.s18),),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSize.s5,),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            cubit.answers!.isNotEmpty?answersBuilder(cubit.answers,question, context, cubit, state):const Text("No Answers Yet...")

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
