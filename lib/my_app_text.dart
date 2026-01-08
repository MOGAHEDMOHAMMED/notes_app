import 'package:flutter/material.dart';
import 'package:my_flutter_project/my_app_colors.dart';

class MyAppText {
  static Text heading1(String data){
    return Text(data,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: MyAppColors.clrNegativeAppColor),textDirection: TextDirection.rtl,);
  }
  static Text heading2(String data){
    return Text(data,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: MyAppColors.clrNegativeAppColor),textDirection: TextDirection.rtl,);
  }
  static Text heading3(String data){
    return Text(data,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: MyAppColors.clrNegativeAppColor),textDirection: TextDirection.rtl,);
  }
  static Text defualtText(String data){
    return Text(data,style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: MyAppColors.clrNegativeAppColor),textDirection: TextDirection.rtl,);
  }
}