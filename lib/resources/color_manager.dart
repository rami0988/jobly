import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'values_manager.dart';


class ColorManager {
  //BASICS
  static Color white = const Color(0xffffffff);
  static Color offWhite = const Color.fromARGB(255, 245, 245, 245);
  static Color black = const Color(0xff000000);


  //PURPLE PALETTE
  static Color purple1 = const Color(0xffd3caf1);
  static Color purple2 = const Color(0xffc9bce7);
  static Color purple3 = const Color(0xffaa96da);
  static const Color purple4 = Color(0xff8b70cd);
  static Color purple5 = const Color(0xff6639A6);
  static Color purple6 = const Color(0xff43256d);
  static const Color purple7 =  Color(0xff36165b);
  static Color purple0 = const Color(0xffe9e8f1);

  //LIGHT MODE
  static Color primary = purple4;
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color grey = HexColor.fromHex("#737477");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color primaryOpacity = purple3;

  //DARK MODE
  static Color darkPrimary = purple6;
  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");


  //STATUS
  static Color error = const Color(0xffe61f34);
  static Color success = const Color(0xff5cb85c);
  static Color pending = const Color(0xffffc14e);


}

extension HexColor on Color{
  static Color fromHex(String hexColorString){
    hexColorString = hexColorString.replaceAll('#', '');
    if(hexColorString.length ==6){
      hexColorString = "FF$hexColorString";
    }
    return Color(int.parse(hexColorString,radix: 16));
  }
}

void showToast({required String? text, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: text!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: AppSize.s16);

////

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = ColorManager.success;
      break;
    case ToastStates.ERROR:
      color = ColorManager.error;
      break;
    case ToastStates.WARNING:
      color = ColorManager.pending;
      break;
  }
  return color;
}
