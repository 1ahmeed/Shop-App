

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterStates>{

  ShopRegisterCubit() : super(ShopRegisterInitialStates());
  static ShopRegisterCubit? get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
}){
    emit(ShopRegisterLoadingStates());
    DioHelper.postData(
        url: REGISTER,
        token: '',
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,


        }).then((value) {
          print(value.data);
         loginModel= ShopLoginModel.fromJson(value.data);
        print(loginModel?.status);
          print(loginModel?.message);
         print(loginModel?.data?.token);
          emit(ShopRegisterSuccessStates(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorStates(error.toString()));
    });

  }

  IconData? suffix= Icons.visibility;
  bool isPassword=true;
  void changeVisibility(){

    isPassword= !isPassword;
    suffix=isPassword? Icons.visibility:Icons.visibility_off_sharp;
      emit(ShopChangeVisibilityStates());

  }
}