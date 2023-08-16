

import 'package:flutter/cupertino.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/widgets/custom_navigation_and_finish.dart';

import '../network/local/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value){
    if(value==true){
      navigatorAndFinish(context, ShopLoginScreen());
    }
  });
}
void printFullText(String? text){
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text!).forEach((match) => debugPrint(match.group(0)));

}
 String? token;


