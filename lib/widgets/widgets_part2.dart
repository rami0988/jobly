import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:jobly/modules/community/question/question_view.dart';
import 'package:jobly/modules/regular/employee_profile/employee_profile_view.dart';
import 'package:jobly/modules/regular/search/cubit/search_cubit.dart';
import 'package:jobly/resources/assets_manager.dart';
import 'package:jobly/resources/color_manager.dart';
import 'package:jobly/resources/routes_manager.dart';
import 'package:jobly/resources/values_manager.dart';
import 'package:jobly/utils/constants.dart';
import 'package:jobly/utils/helpers/cache_helper.dart';
import 'package:jobly/widgets/widgets.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:url_launcher/url_launcher.dart';
import '../modules/announcements/cubit/announcements_states.dart';
import '../modules/applications/cubit/applications_states.dart';
import '../modules/community/cubit/community_states.dart';
import '../modules/community/question/cubit/question_states.dart';
import '../modules/regular/employee_profile/cubit/employee_profile_cubit.dart';
import '../modules/regular/profile/cubit/profile_cubit.dart';
import '../resources/font_manager.dart';
import '../resources/style_manager.dart';

///Tools
Widget multiSelectionWidget({
  required items,
  required title,
  required icon,
  required buttonText,
  required result
})=>Padding(
  padding: const EdgeInsets.all(AppPadding.p8),
  child:   MultiSelectDialogField(
    items: items,
    dialogWidth: AppSize.s30,
    title: Text(title),
    selectedColor: ColorManager.darkPrimary,
    decoration: BoxDecoration(
      color: null,
      borderRadius:
      const BorderRadius.all(Radius.circular(AppSize.s40)),
      border: Border.all(
        color: ColorManager.primary,
        width: AppSize.s1_5,
      ),
    ),
    buttonIcon: Icon(
      icon,
      color: ColorManager.primary,
    ),
    buttonText: Text(
      buttonText,
      style: TextStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s16,
      ),
    ),
    onConfirm: (chosen) {
      if(result==SearchCubit.selectedCities) {
        SearchCubit.selectedCities = chosen;
      }else if(result==SearchCubit.selectedTypes) {
        SearchCubit.selectedTypes = chosen;
      }else if(result==SearchCubit.selectedCategories) {
        SearchCubit.selectedCategories = chosen;
      } else if(result==SearchCubit.selectedSections) {
        SearchCubit.selectedSections = chosen;
      } else {
        result = chosen;
      }
    },
  ),
);

Widget myDropDownButton({
  required value,
  required hint,
  required function,
  required items,

})=>DropdownButton<dynamic>(
  value: value,
  icon: Icon(
    Icons.keyboard_arrow_down,
    color: ColorManager.purple2,
  ),
  iconSize: 24,
  elevation: 40,
  borderRadius: BorderRadius.circular(40),
  underline: Container(),
  hint: Padding(
    padding: const EdgeInsets.all(6.0),
    child: Text(
      hint,
      style: TextStyle(
          color: ColorManager.primary,
          fontSize: 16),
    ),
  ),
  //  style: ,
  onChanged: function,
  items: items,
);

Widget highlightedContainer(color, radius, text)=>Container(
  padding: const EdgeInsets.symmetric(horizontal: AppSize.s10, vertical: AppSize.s5),
  decoration: BoxDecoration(
    color: color.withOpacity(0.3),
    borderRadius:  BorderRadius.only(
      topRight: Radius.circular(radius),
      bottomLeft: Radius.circular(radius),
    ),
  ),
  child: Text(
    text,
    style: getSemiBoldStyle(color: color,fontSize: FontSize.s14),
  ),
);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged? onSubmit,
  ValueChanged? onChange,
  VoidCallback? suffixPressed,
  FormFieldValidator? validate,
  required String label,
  IconData? prefix,
  IconData? suffix,
  bool isPassword = false,
}) =>
    Padding(
      padding: const EdgeInsets.all(AppPadding.p5),
      child: TextFormField(
          controller: controller,
          keyboardType: type,
          onFieldSubmitted: onSubmit,
          onChanged: onChange,
          validator: validate,
          obscureText: isPassword,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(
              prefix,
              color: ColorManager.purple3,
            ),
            suffixIcon: suffix != null
                ? IconButton(
                    onPressed: suffixPressed,
                    icon: Icon(suffix),
                    color: ColorManager.purple6,
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: ColorManager.lightGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: ColorManager.purple5),
            ),
          )),
    );

Future<void> addingDialog(cubit,context,{required title,required controller,required onPressed}){
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SizedBox(
          width: double.maxFinite,
          child: defaultFormField(
              type: TextInputType.text,
              label: 'type here',
              controller: controller
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: onPressed,
            child: const Text('Confirm'),
          ),
        ],
      );
    },
  );
}
Future<void> addingDialogWithDropdown(cubit,context,{required title,required controller,required onPressed}){
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context,StateSetter setState){
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    width: 300,
                    height: 50,
                    child:myDropDownButton(
                        value: cubit.dropDownValueCategory,
                        hint: 'Choose Category',
                        function: (newValue) {
                          cubit.changeCategoryDropDownButton(newValue!);
                          setState((){});
                        },
                        items: cubit.categoriesItems
                    )
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: defaultFormField(
                      type: TextInputType.text,
                      label: 'type here',
                      controller: controller
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: onPressed,
                child: const Text('Confirm'),
              ),
            ],
          );
        }
      );
    },
  );
}

///COMMUNITY
Widget animatedTabBarItem(cubit, index, height, width, color,) => AnimatedContainer(
      duration: const Duration(milliseconds: DurationConstant.d100),
      margin: const EdgeInsets.all(AppMargin.m5),
      width: AppSize.s165,
      height: AppSize.s2,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: const Offset(2, 20),
              blurRadius: AppSize.s50,
              spreadRadius: AppSize.s10,
            ),
          ],
          borderRadius: BorderRadius.circular(AppSize.s20),
          border: Border.all(color: ColorManager.white, width: AppSize.s1_5),
          color: cubit.currentIndex == index ? color : ColorManager.white),
      child: Center(
        child: Text(
          cubit.type[index],
          style: TextStyle(
              color: cubit.currentIndex == index
                  ? ColorManager.white
                  : ColorManager.darkPrimary),
        ),
      ),
    );

Widget buildAnswerItem(answer,question, context, cubit, state,) => Card(
      color: ColorManager.purple0,
      shadowColor: ColorManager.purple0,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(AppSize.s28),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: AppSize.s18,
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.m20),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p14),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  EmployeeProfileScreen(answer.userId),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: AppSize.s20,
                    backgroundColor: ColorManager.white,
                    backgroundImage: imageSelector(image: answer.image,defaultImage: ImageAssets.employeeIc),
                  ),
                ),
                const SizedBox(
                  width: AppSize.s14,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${answer.name}',
                            style: const TextStyle(height: AppSize.s1_5),
                          ),
                          const SizedBox(
                            width: AppSize.s8,
                          ),
                          answer.isAuth ?
                               const Icon(
                                  Icons.verified,
                                  color: Colors.lightBlue,
                                  size: AppSize.s16,
                                )
                              : const SizedBox(
                                  width: AppSize.s1_5,
                                ),
                        ],
                      ),
                      Text(
                          '${answer.time}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(height: AppSize.s1_5)),
                    ],
                  ),
                ),
                answer.isMine==true?
                InkWell(
                  onTap: (){
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(''),
                          content: SizedBox(
                              width: 40,
                              height: 80,
                              child: Column(
                                children: [
                                  const SizedBox(height: 10,),
                                  InkWell(
                                      onTap:(){
                                        var editedAnswerController = TextEditingController(text: '${answer.content}');
                                        addingDialog(
                                          cubit,
                                          context,
                                          title: 'Edit Answer',
                                          controller: editedAnswerController,
                                          onPressed: () {
                                            cubit.editAnswer(
                                                answerId : answer.id,
                                                content : editedAnswerController.text,
                                                token : token
                                            );
                                            cubit.getAnswers(question.id);
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      },
                                      child: Text('Edit Answer',style: TextStyle(color: ColorManager.pending),)),
                                  const SizedBox(height: 20,),
                                  InkWell(
                                      onTap:(){
                                        showDialog<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Are You Sure'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('Delete'),
                                                  onPressed: () {
                                                    cubit.deleteAnswer(answer.id);
                                                    cubit.getAnswers(question.id);
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text('Cancel'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Text('Delete Answer',style: TextStyle(color: ColorManager.error))),
                                ],
                              )
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: Image.asset(
                        ImageAssets.dotsIc
                    ),
                  ),
                ):
                InkWell(
                  onTap: (){
                    var reportController = TextEditingController();
                    addingDialog(
                        cubit,
                        context,
                        title: 'Report Reason :',
                        controller: reportController,
                        onPressed: (){
                          cubit.reportAnswer(
                              token:token,
                              answerId:answer.id,
                              reason:reportController.text
                          );
                          reportController.clear();
                        }
                    );
                  },
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: Image.asset(
                        ImageAssets.reportIc
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            Text(
              '${answer.content}',
              style: getSemiBoldStyle(color: ColorManager.black),
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            SizedBox(
              height: AppSize.s30,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if(answer.isLiked==false) {
                          print(answer.id);
                          cubit.likeAnswer(answer.id);
                          answer.likesCount = answer.likesCount + 1;
                          answer.isLiked = !answer.isLiked;
                        }else
                        {
                          print(answer.id);
                          cubit.likeAnswer(answer.id);
                          answer.likesCount = answer.likesCount - 1;
                          answer.isLiked = !answer.isLiked;
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            ImageAssets.upArrowIc,
                            width: AppSize.s14,
                            height: AppSize.s14,
                            color: ColorManager.purple5,
                          ),
                          const SizedBox(
                            width: AppSize.s4,
                          ),
                          Text(
                            '${answer.likesCount} Votes',
                            style: getSemiBoldStyle(color: ColorManager.purple6)
                                .copyWith(fontSize: FontSize.s14),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget answersBuilder(answers,question, context, cubit, state) => ConditionalBuilder(
  condition: state is! GetAnswerLoadingState && answers != null,
  builder: (context) => ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) =>
          buildAnswerItem(answers[index],question, context, cubit, state),
      separatorBuilder: (context, index) => const SizedBox(
        height: AppSize.s8,
      ),
      itemCount: answers.length),
  fallback: (context) => const Center(child: CircularProgressIndicator()),
);

Widget buildAdviceItem(advice, context, cubit, state,) => Card(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(AppSize.s28), // Change the radius here
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: AppSize.s18,
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.m20),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p14),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  EmployeeProfileScreen(advice.userId),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: AppSize.s20,
                    backgroundColor: ColorManager.white,
                    backgroundImage: imageSelector(image: advice.image,defaultImage: ImageAssets.employeeIc),
                  ),
                ),
                const SizedBox(
                  width: AppSize.s14,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${advice.name}',
                            style: const TextStyle(height: AppSize.s1_5),
                          ),
                          const SizedBox(
                            width: AppSize.s8,
                          ),
                          advice.isAuth
                              ? const Icon(
                                  Icons.verified,
                                  color: Colors.lightBlue,
                                  size: AppSize.s16,
                                )
                              : const SizedBox(
                                  width: AppSize.s1_5,
                                ),
                        ],
                      ),
                      Text(
                          '${advice.time}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(height: AppSize.s1_5)),
                    ],
                  ),
                ),
                advice.isMine == true?
                InkWell(
                  onTap: (){
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(''),
                          content: SizedBox(
                              width: 40,
                              height: 80,
                              child: Column(
                                children: [
                                  const SizedBox(height: 10,),
                                  InkWell(
                                      onTap:(){
                                        var editedAdviceController = TextEditingController(text: '${advice.content}');
                                        addingDialog(
                                          cubit,
                                          context,
                                          title: 'Edit Advice',
                                          controller: editedAdviceController,
                                          onPressed: () {
                                            cubit.editAdvice(
                                                adviceId : advice.id,
                                                content : editedAdviceController.text,
                                                token : token
                                            );
                                            cubit.getAdvicesLatest();
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      },
                                      child: Text('Edit Advice',style: TextStyle(color: ColorManager.pending),)),
                                  const SizedBox(height: 20,),
                                  InkWell(
                                      onTap:(){
                                        showDialog<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Are You Sure'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('Delete'),
                                                  onPressed: () {
                                                    cubit.deleteAdvice(advice.id);
                                                    cubit.getAdvicesLatest();
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text('Cancel'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Text('Delete Advice',style: TextStyle(color: ColorManager.error))),
                                ],
                              )
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: Image.asset(
                        ImageAssets.dotsIc
                    ),
                  ),
                ):
                InkWell(
                  onTap: (){
                    var reportController = TextEditingController();
                    addingDialog(
                        cubit,
                        context,
                        title: 'Report Reason :',
                        controller: reportController,
                        onPressed: (){
                          cubit.reportAdvice(
                              token:token,
                              adviceId:advice.id,
                              reason:reportController.text
                          );
                          reportController.clear();
                        }
                    );
                  },
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: Image.asset(
                        ImageAssets.reportIc
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            Text(
              '${advice.content}',
              style: getSemiBoldStyle(color: ColorManager.black),
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            SizedBox(
              height: AppSize.s30,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if(advice.isLiked==false) {
                          print(advice.id);
                          cubit.likeAdvice(advice.id);
                          advice.likesCount = advice.likesCount + 1;
                          advice.isLiked = !advice.isLiked;
                        }else
                        {
                          print(advice.id);
                          cubit.likeAdvice(advice.id);
                          advice.likesCount = advice.likesCount - 1;
                          advice.isLiked = !advice.isLiked;
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            ImageAssets.upArrowIc,
                            width: AppSize.s14,
                            height: AppSize.s14,
                            color: ColorManager.purple5,
                          ),
                          const SizedBox(
                            width: AppSize.s4,
                          ),
                          Text(
                            '${advice.likesCount} Votes',
                            style: getSemiBoldStyle(color: ColorManager.purple6)
                                .copyWith(fontSize: FontSize.s14),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget advicesBuilder(advices, context, cubit, state) => ConditionalBuilder(
  condition: state is! GetAdvicesLoadingState && advices != null,
  builder: (context) => ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) =>
          buildAdviceItem(advices[index], context, cubit, state),
      separatorBuilder: (context, index) => const SizedBox(
        height: AppSize.s8,
      ),
      itemCount: advices.length),
  fallback: (context) => const Center(child: CircularProgressIndicator()),
);

Widget buildQuestionItem(question, context, cubit, state,) => InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuestionView(question),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppSize.s28), // Change the radius here
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: AppSize.s18,
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.m20),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p14),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EmployeeProfileScreen(1),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: AppSize.s20,
                      backgroundColor: ColorManager.white,
                      backgroundImage: imageSelector(image: question.image,defaultImage: ImageAssets.employeeIc),
                    ),
                  ),
                  const SizedBox(
                    width: AppSize.s14,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${question.name}',
                              style: const TextStyle(height: AppSize.s1_5),
                            ),
                            const SizedBox(
                              width: AppSize.s8,
                            ),
                            question.isAuth ?
                            const Icon(
                                    Icons.verified,
                                    color: Colors.lightBlue,
                                    size: AppSize.s16,
                                  ) :
                            const SizedBox(width: AppSize.s1_5,),
                          ],
                        ),
                        Text(
                            '${question.time}',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(height: AppSize.s1_5)),
                      ],
                    ),
                  ),
                  question.isMine==true?
                  InkWell(
                    onTap: (){
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(''),
                            content: SizedBox(
                                width: 40,
                                height: 80,
                                child: Column(
                                  children: [
                                    SizedBox(height: 10,),
                                    InkWell(
                                        onTap:(){
                                          var editedQuestionController = TextEditingController(text: '${question.content}');
                                          addingDialog(
                                            cubit,
                                            context,
                                            title: 'Edit Question',
                                            controller: editedQuestionController,
                                            onPressed: () {
                                              cubit.editQuestion(
                                                  questionId : question.id,
                                                  content : editedQuestionController.text,
                                                  token : token
                                              );
                                              cubit.getQuestionsLatest();
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            },
                                          );
                                        },
                                        child: Text('Edit Question',style: TextStyle(color: ColorManager.pending),)),
                                    const SizedBox(height: 20,),
                                    InkWell(
                                        onTap:(){
                                          showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Are You Sure'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('Delete'),
                                                    onPressed: () {
                                                      cubit.deleteQuestion(question.id);
                                                      cubit.getQuestionsLatest();
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text('Cancel'),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Text('Delete Question',style: TextStyle(color: ColorManager.error))),
                                  ],
                                )
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                          ImageAssets.dotsIc
                      ),
                    ),
                  ):
                  InkWell(
                    onTap: (){
                      var reportController = TextEditingController();
                      addingDialog(
                          cubit,
                          context,
                          title: 'Report Reason :',
                          controller: reportController,
                          onPressed: (){
                            cubit.reportQuestion(
                                token:token,
                                questionId:question.id,
                                reason:reportController.text
                            );
                            reportController.clear();
                          }
                      );
                    },
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                          ImageAssets.reportIc
                      ),
                    ),
                  ),

                ],
              ),
              const SizedBox(
                height: AppSize.s10,
              ),
              Text(
                '${question.content}',
                style: getSemiBoldStyle(color: ColorManager.black),
              ),
              const SizedBox(
                height: AppSize.s10,
              ),
              SizedBox(
                height: AppSize.s30,
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if(question.isLiked==false) {
                            print(question.id);
                            cubit.likeQuestion(question.id);
                            question.likesCount = question.likesCount + 1;
                            question.isLiked = !question.isLiked;
                          }else
                          {
                            print(question.id);
                            cubit.likeQuestion(question.id);
                            question.likesCount = question.likesCount - 1;
                            question.isLiked = !question.isLiked;
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              ImageAssets.upArrowIc,
                              width: AppSize.s16,
                              height: AppSize.s16,
                              color: ColorManager.purple5,
                            ),
                            const SizedBox(
                              width: AppSize.s4,
                            ),
                            Text(
                              '${question.likesCount} Votes',
                              style: getBoldStyle(color: ColorManager.purple6)
                                  .copyWith(fontSize: FontSize.s14),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              ImageAssets.answersIc,
                              width: AppSize.s20,
                              height: AppSize.s20,
                              color: ColorManager.purple5,
                            ),
                            const SizedBox(
                              width: AppSize.s5,
                            ),
                            Text(
                              '${question.answersCount} Answers',
                              style: getBoldStyle(color: ColorManager.purple6)
                                  .copyWith(fontSize: FontSize.s14),
                            )
                          ],
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

Widget questionsBuilder(questions, context, cubit, state) => ConditionalBuilder(
  condition: state is! CommunityLoadingState && questions != null,
  builder: (context) => ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) =>
          buildQuestionItem(questions[index], context, cubit, state),
      separatorBuilder: (context, index) => const SizedBox(
        height: AppSize.s8,
      ),
      itemCount: questions.length),
  fallback: (context) => const Center(child: CircularProgressIndicator()),
);

Widget buildDetailedQuestionItem(question, context, cubit, state,) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  EmployeeProfileScreen(question.userId),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: AppSize.s20,
                  backgroundColor: ColorManager.purple4,
                  backgroundImage: imageSelector(image: question.image,defaultImage: ImageAssets.employeeIc),
                ),
              ),
              const SizedBox(
                width: AppSize.s14,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${question.name}',
                          style: const TextStyle(height: AppSize.s1_5),
                        ),
                        const SizedBox(
                          width: AppSize.s8,
                        ),
                        question.isAuth==true ?
                             const Icon(
                                Icons.verified,
                                color: Colors.lightBlue,
                                size: AppSize.s16,
                              )
                            : const SizedBox(
                                width: AppSize.s1_5,
                              ),
                      ],
                    ),
                    Text(
                        '${question.time}',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(height: AppSize.s1_5)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppSize.s16,
          ),
          Text(
            question.content,
            style: getMediumStyle(color: ColorManager.black)
                .copyWith(fontSize: FontSize.s17),
          ),
          const SizedBox(
            height: AppSize.s16,
          ),
          SizedBox(
            height: AppSize.s30,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if(question.isLiked==false) {
                        print(question.id);
                        cubit.likeQuestion(question.id);
                        question.likesCount = question.likesCount + 1;
                        question.isLiked = !question.isLiked;
                      }else
                      {
                        print(question.id);
                        cubit.likeQuestion(question.id);
                        question.likesCount = question.likesCount - 1;
                        question.isLiked = !question.isLiked;
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageAssets.upArrowIc,
                          width: AppSize.s16,
                          height: AppSize.s16,
                          color: ColorManager.purple5,
                        ),
                        const SizedBox(
                          width: AppSize.s4,
                        ),
                        Text(
                          '${question.likesCount} Votes',
                          style: getBoldStyle(color: ColorManager.purple6)
                              .copyWith(fontSize: FontSize.s14),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageAssets.answersIc,
                          width: AppSize.s20,
                          height: AppSize.s20,
                          color: ColorManager.purple5,
                        ),
                        const SizedBox(
                          width: AppSize.s5,
                        ),
                        Text(
                          '${question.answersCount} Answers',
                          style: getBoldStyle(color: ColorManager.purple6)
                              .copyWith(fontSize: FontSize.s14),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );


///ANNOUNCEMENT
Widget buildAnnouncementItem(announcement, context, cubit, state) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: AppMargin.m20),
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorManager.white,
            border: Border.all(color: ColorManager.purple4, width: AppSize.s2),
            borderRadius: BorderRadius.circular(AppSize.s20),
            boxShadow: [
              BoxShadow(
                color: ColorManager.purple2,
                offset: const Offset(2, 2),
                blurRadius: AppSize.s5,
                spreadRadius: AppSize.s2,
              ),
            ],
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(
            padding: const EdgeInsets.all(AppSize.s14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: AppSize.s20,
                      backgroundColor: ColorManager.white,
                      backgroundImage: imageSelector(image: announcement.companyPhoto,defaultImage: ImageAssets.purpleLogo),
                    ),
                    const SizedBox(width: AppSize.s14),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            '${announcement.companyName}',
                            style: const TextStyle(height: AppSize.s1_5),
                          ),
                          const SizedBox(width: AppSize.s8),
                          announcement.isAuth?
                          const Icon(Icons.verified, color: Colors.lightBlue, size: AppSize.s16):
                          const SizedBox(width: AppSize.s8),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.s10),
                Text(
                  '${announcement.title}',
                  style: getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_month_outlined, color: ColorManager.purple5),
                              const SizedBox(width: AppSize.s5),
                               Text('${announcement.duration}'),
                            ],
                          ),
                          const SizedBox(height: AppSize.s8),
                          Row(
                            children: [
                              Icon(Icons.access_time, color: ColorManager.purple5),
                              const SizedBox(width: AppSize.s5),
                               Text('${announcement.days}',),
                            ],
                          ),
                          const SizedBox(height: AppSize.s8),
                          Row(
                            children: [
                              Icon(Icons.person_outline, color: ColorManager.purple5),
                              const SizedBox(width: AppSize.s5),
                               Expanded(child: Text('${announcement.companyEmail}', overflow: TextOverflow.ellipsis,))
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSize.s10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${announcement.startDate}',),
                          const SizedBox(height: AppSize.s14),
                          Text("From ${announcement.time}"),
                          const SizedBox(height: AppSize.s16),
                          Text('created ${announcement.createdAt}',overflow: TextOverflow.ellipsis,),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    Icon(Icons.attach_money, color: ColorManager.pending),
                    const SizedBox(width: AppSize.s5),
                     Text("Price : ${announcement.price} SYP"),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: AppSize.s0,
          right: AppSize.s0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s10, vertical: AppSize.s5),
            decoration: BoxDecoration(
              color: ColorManager.purple4,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(AppSize.s20),
                bottomLeft: Radius.circular(AppSize.s20),
              ),
            ),
            child: Text(
              announcement.type=="course"?"Course":"Internship",
              style: getSemiBoldStyle(color: ColorManager.white,fontSize: FontSize.s14),
            ),
          ),
        ),
      ],
    ),
  );
}
Widget announcementsBuilder(announcements, context, cubit, state) => ConditionalBuilder(
  condition: state is! AnnouncementsLoadingState && announcements != null,
  builder: (context) => ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) =>
          buildAnnouncementItem(announcements[index], context, cubit, state),
      separatorBuilder: (context, index) => const SizedBox(
        height: AppSize.s20,
      ),
      itemCount: announcements.length),
  fallback: (context) => const Center(child: CircularProgressIndicator()),
);
///APPLICATIONS
Widget buildOthersApplicationItem(application, context, cubit, state) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: AppMargin.m20),
    child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p10,horizontal: AppPadding.p10),
            height: AppSize.s80,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s20),
              color: ColorManager.white,
              boxShadow: [
                BoxShadow(
                  color: ColorManager.grey.withOpacity(0.5),
                  offset: const Offset(2, 2),
                  blurRadius: AppSize.s5,
                  spreadRadius: AppSize.s2,
                ),
              ],
            ),

            child: Row(
              children: [
                Container(
                  width: AppSize.s60,
                  height: AppSize.s60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ColorManager.purple4,
                      width: AppSize.s2,
                    ),
                  ),
                  child: InkWell(
                    onTap: (){
                      navigateTo(context, EmployeeProfileScreen(application.userId));
                    },
                    child: CircleAvatar(
                        radius: AppSize.s350,
                        backgroundColor: ColorManager.purple4,
                        backgroundImage: imageSelector(image: application.image,defaultImage: ImageAssets.purpleLogo)
                    ),
                  ),
                ),
                const SizedBox(width: AppSize.s16,),
                Text(application.name,style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                const Spacer(),
                InkWell(
                  onTap: (){
                    cubit.acceptApplication(application.id);
                    cubit.getMyJobApplications(application.id);
                  },
                  child: Icon(Icons.check_outlined,color: ColorManager.success,),
                ),
                const SizedBox(width: AppSize.s16,),
                InkWell(
                  onTap: (){
                    cubit.rejectApplication(application.id);
                    cubit.getMyJobApplications(application.id);
                  },
                  child: Icon(Icons.close,color: ColorManager.error,),
                ),

              ],
            ),
          ),
          Positioned(
            bottom: AppSize.s0,
            right: AppSize.s0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.s10, vertical: AppSize.s0),
              decoration: BoxDecoration(
                color: ColorManager.grey.withOpacity(0.2),
                borderRadius:  const BorderRadius.only(
                  bottomRight: Radius.circular(AppSize.s20),
                  topLeft: Radius.circular(AppSize.s20),
                ),
              ),
              child: Text(
                "sent ${application.applicationDate}",
                style: getRegularStyle(color: ColorManager.grey,fontSize: FontSize.s12),
              ),
            ),
          ),

        ]
    ),
  );
}
Widget buildApplicationItem(application, context, cubit, state) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: AppMargin.m20),
    child: Stack(
      children: [
        Container(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p10,horizontal: AppPadding.p10),
        height: AppSize.s80,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s20),
          color: ColorManager.white,
          boxShadow: [
            BoxShadow(
              color: ColorManager.grey.withOpacity(0.5),
              offset: const Offset(2, 2),
              blurRadius: AppSize.s5,
              spreadRadius: AppSize.s2,
            ),
          ],
        ),

        child: Row(
          children: [
            Container(
              width: AppSize.s60,
              height: AppSize.s60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: ColorManager.purple4,
                  width: AppSize.s2,
                ),
              ),
              child: CircleAvatar(
                radius: AppSize.s350,
                backgroundColor: ColorManager.purple4,
                backgroundImage: imageSelector(image: application.publisherPhoto,defaultImage: ImageAssets.employeeIc)
              ),
            ),
            const SizedBox(width: AppSize.s16,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(application.jobTitle,style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                const Spacer(),
                Text(application.publisherName,style: getMediumStyle(color: ColorManager.grey),),
                const Spacer(),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,size: AppSize.s16,color: ColorManager.grey,),
                    Text(application.location?.city??"No Location",style: getMediumStyle(color: ColorManager.grey),),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
        Positioned(
          top: AppSize.s0,
          right: AppSize.s0,
          child: highlightedContainer(statusColor(application.status), AppSize.s20, application.status),
        ),
        Positioned(
          bottom: AppSize.s0,
          right: AppSize.s0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s10, vertical: AppSize.s0),
            decoration: BoxDecoration(
              color: ColorManager.grey.withOpacity(0.2),
              borderRadius:  const BorderRadius.only(
                bottomRight: Radius.circular(AppSize.s20),
                topLeft: Radius.circular(AppSize.s20),
              ),
            ),
            child: Text(
              "sent ${application.date}",
              style: getRegularStyle(color: ColorManager.grey,fontSize: FontSize.s12),
            ),
          ),
        ),
        Positioned(
          left: AppSize.s0,
          top: AppSize.s0,
          child: InkWell(
              onTap: (){
                showDialog<void>(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: const Text('Are you sure you want to cancel this job application ? '),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Delete'),
                            onPressed: () {
                              cubit.cancelApplication(application.id);
                              cubit.getMyApplications();
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    }
                );
                },
              child: Icon(
                Icons.remove_circle,
                color: ColorManager.error,
                size: AppSize.s18,
              ),

          ),
        ),
      ]
    ),
  );
}





Widget applicationsOthersBuilder(applications, context, cubit, state) => ConditionalBuilder(
  condition: state is! ApplicationsLoadingState && applications != null,
  builder: (context) => ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) =>
          buildOthersApplicationItem(applications[index], context, cubit, state),
      separatorBuilder: (context, index) => const SizedBox(
        height: AppSize.s8,
      ),
      itemCount: applications.length),
  fallback: (context) => const Center(child: CircularProgressIndicator()),
);
Widget applicationsBuilder(applications, context, cubit, state) => ConditionalBuilder(
  condition: state is! ApplicationsLoadingState && applications != null,
  builder: (context) => ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) =>
          buildApplicationItem(applications[index], context, cubit, state),
      separatorBuilder: (context, index) => const SizedBox(
        height: AppSize.s8,
      ),
      itemCount: applications.length),
  fallback: (context) => const Center(child: CircularProgressIndicator()),
);
Color statusColor(status){
  if(status=="pending") {
    return ColorManager.pending;
  } else if(status=="Accepted") {
    return ColorManager.success;
  } else if(status=="Rejected") {
    return ColorManager.error;
  }else {
    return ColorManager.grey;
  }
}
ImageProvider<Object> imageSelector({required image,required defaultImage}){
  if(image==null) {
    return AssetImage(defaultImage);
  } else {
    return NetworkImage("${baseUrl}images/$image");
  }
}
///FILTER
Widget filterOptions(cubit,context)=>AlertDialog(
  title: const Text('Filter Options:'),
  content: SingleChildScrollView(
    child: Column(
      children: [
        multiSelectionWidget(
            items: cubit.typeItems,
            title: "Job Types",
            icon: Icons.access_time,
            buttonText: "Choose Types",
            result: SearchCubit.selectedTypes
        ),
        multiSelectionWidget(
            items: cubit.cityItems,
            title: "Cities",
            icon: Icons.location_on_outlined,
            buttonText: "Choose Cities",
            result: SearchCubit.selectedCities
        ),
        multiSelectionWidget(
            items: cubit.categoriesItems,
            title: "Categories",
            icon: Icons.category_outlined,
            buttonText: "Choose Category",
            result: SearchCubit.selectedCategories
        ),
        multiSelectionWidget(
            items: cubit.sectionsItems,
            title: "Sections",
            icon: Icons.domain,
            buttonText: "Choose Sections",
            result: SearchCubit.selectedSections
        ),
        TextButton(onPressed: (){cubit.getFreelance();Navigator.of(context).pop();}, child: const Text("Get Freelance Jobs"))
      ],
    ),
  ),
  actions: <Widget>[
    TextButton(
      child: const Text('Apply'),
      onPressed: () {
        cubit.getFilter();
        Navigator.of(context).pop();
      },
    ),
  ],
);
///PROFILE
Widget pointsAndPosts(cubit,context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      //favourite
      numberAndText(context, cubit.profile.points, 'Points'),
      //divider
      dividerVertical(context),
      //planning to read
      numberAndText(context, cubit.profile.advices.length, 'Contributions')
    ],
  );
}
Widget buildTextButton(cubit,context, String text, int index) {
  return GestureDetector(
    onTap: () {
      if(index==1) {
        cubit.getMyJobs();
      }
      cubit.changeColor(index);
      },
    child: Container(
      width: MediaQuery.of(context).size.width * 0.3,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: cubit.selectedIndex == index
            ? Theme.of(context).primaryColor
            : ColorManager.white,
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: ColorManager.purple4, width: 2),
      ),
      child: Text(
        textAlign: TextAlign.center,
        text,
        style: TextStyle(
          color: cubit.selectedIndex == index
              ? ColorManager.white
              : Colors.black,
        ),
      ),
    ),
  );
}
Widget infoRow(cubit,context,state) =>Padding(
  padding: const EdgeInsets.symmetric(vertical: 20),
  child: Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildTextButton(cubit, context, 'About Me', 0),

          buildTextButton(cubit, context, 'My Jobs', 1),

          buildTextButton(cubit, context, 'Settings', 2),
        ],
      ),
      const SizedBox(height: 20),
      cubit.getSelectedWidget(cubit,context,state),
    ],
  ),
);
Widget footer(cubit,context,state) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: ColorManager.offWhite,
        // color: Color.fromARGB(255, 245, 245, 245),
        // borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          //points and posts
          pointsAndPosts(cubit,context),
          infoRow(cubit,context,state),

        ],
      ),
    ),
  );
}
Widget aboutMe(cubit,context) {
  return Column(
    children: [
      //about me
      jobDescription(context, '',
          '''${cubit.profile.employee.resume}'''),

      //exp
      jobDescription(
        context,
        '● Work Experience:',''' ${cubit.profile.employee.experience}''',
      ),
      //Education
      jobDescription(
          context,
          '●Education:', '''● ${cubit.profile.employee.education}'''),
      //skills
      jobDescription(context,
          '●Skills:', '''${cubit.skills}'''),
      TextButton(
        onPressed: () {
          launchUrl(
            cubit is ProfileCubit ?
              Uri.parse('${ProfileCubit.cvFile}'):
              Uri.parse('${EmployeeProfileCubit.cvFile}'),
              mode: LaunchMode.externalApplication
          );
        },
        child:  Text(
                  'Check CV',
                  style: getSemiBoldStyle(color: ColorManager.darkPrimary,fontSize: FontSize.s16),
              ),
      ),

//contact
      jobDescription(context, 'Contact Information:', '''
● Name:
    ${cubit.profile.name}

● Email:
    ${cubit.profile.email}

● Phone:
    ${cubit.profile.employee.phoneNumber}

● Location:
    - Country : ${cubit.profile.address !=null? cubit.profile.address.county:""}
    - City : ${cubit.profile.address!=null?cubit.profile.address.city:""}
    - Governorate : ${cubit.profile.address!=null?cubit.profile.address.governorate:""}
'''),




      //NetworkMediaWidget(),
    ],
  );
}
Widget settings(context,cubit,state) {
  return Column(
    children: [
      //language
      settingsTileSwitch(
        context,
        cubit,
        Icons.language_outlined,
        'Language',
        cubit.language,
        const Color.fromARGB(255, 100, 126, 255),
        const Color.fromARGB(255, 30, 4, 126),
        true,
        cubit.isEnglish,
        cubit.changeLanguage,
      ),
      //darkmode
      settingsTileSwitch(
        context,
        cubit,
        cubit.icon,
        'Mode',
        cubit.mode,
        cubit.iconBackgroundColor,
        cubit.iconColor,
        true,
        cubit.isDark,
        cubit.changeMode,
      ),
      Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          tileColor: Colors.white,
          leading: highlightedIcon(Colors.blue, Colors.indigo, Icons.verified_user_rounded,30),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              smallTitle("Verification"),
              const Text("Send Request"),
            ],
          ),
          trailing:  InkWell(
            onTap: (){
              cubit.sendVerification();

            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 245, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.send_rounded, // Right arrow icon
                color: Colors.black, // Icon color
              ),
            ),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          tileColor: Colors.white,
          leading: highlightedIcon(Colors.orange, Colors.deepOrange, Icons.verified_user_rounded,30),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              smallTitle("Verification"),
              const Text("Cancel Request"),
            ],
          ),
          trailing:  InkWell(
            onTap: (){
              cubit.cancelVerification();

            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 245, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.cancel_outlined, // Right arrow icon
                color: Colors.black, // Icon color
              ),
            ),
          ),
        ),
      ),
      //edit profile
      settingsTileSwitch(
        context,
        cubit,
        Icons.edit,
        "Edit Profile",
        '',
        Colors.amberAccent,
        Colors.deepOrangeAccent,
        false,
        false,
            (value) {},
      ),
      //add video
      settingsVideoTileSwitch(
        context,
        cubit,
        Icons.video_settings_rounded,
        'Add Video',
        '',
        const Color.fromARGB(255, 255, 100, 100),
        const Color.fromARGB(255, 255, 255, 255),
        false,
        false,
            (value) {},
      ),

      //add cv
      settingsTileSwitch(
        context,
        cubit,
        Icons.picture_as_pdf_outlined,
        'Add CV',
        '',
        const Color.fromARGB(255, 255, 100, 100),
        const Color.fromARGB(255, 255, 255, 255),
        false,
        false,
            (value) {},
      ),
      Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          tileColor: Colors.white,
          leading: highlightedIcon(ColorManager.purple2, ColorManager.purple5, Icons.logout_rounded,30),
          title: smallTitle("Log Out"),
          trailing:  InkWell(
            onTap: (){
              CacheHelper.removeData(key: "token");
              Navigator.of(context).pushNamedAndRemoveUntil(Routes.loginRoute, (Route<dynamic> route) => false);
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
      ),
      const SizedBox(
        height: 30,
      )
    ],
  );
}
Future<void> showUploadCvDialog(BuildContext context,cubit) {
  return showDialog<void>(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text('Upload CV'),
          content:  const Text("Select your CV file..."),
          actions: <Widget>[
            TextButton(
              child: const Text('Select PDF'),
              onPressed: ()  {
                cubit.selectFile();
                print(cubit.fileName);
              },
            ),
            TextButton(
                child:const Text ('Upload'),
                onPressed: () {
                  cubit.sendFile(
                    filePath: cubit.filePath,
                    fileName: cubit.fileName,
                  );

                })

          ],
        );
      }
  );
}
Future<void> showUploadVideoDialog(BuildContext context,cubit) {
  return showDialog<void>(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text('Upload Personal Video'),
          content:  const Text("Select your video file..."),
          actions: <Widget>[
            TextButton(
              child: const Text('Select video'),
              onPressed: ()  {
                cubit.selectFile();
                print(cubit.fileName);
              },
            ),
            TextButton(
                child:const Text ('Upload'),
                onPressed: () {
                  cubit.sendVideo(
                    filePath: cubit.filePath,
                    fileName: cubit.fileName,
                  );
                })

          ],
        );
      }
  );
}
