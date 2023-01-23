import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favourites_model.dart';
import 'package:shop_app/models/favourites_model.dart';
import 'package:shop_app/models/home_models.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/favourites/favourites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/setting_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';


class ShopCubit extends Cubit<ShopStates> {

  ShopCubit() : super(ShopInitialStates());

  static ShopCubit? get(context) => BlocProvider.of(context);

  List<String> title = [
    "Salah",
    "Favourites",
    "Setting"
  ];

  int currentIndex = 0;
 List<Widget>? screens = [
   const ProductsScreen(),
   const FavouritesScreen(),
   SettingScreen(),

 ];

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(ShopBottomNavBarStates());
  }

  HomeModel? homeModel;
  Map<int,bool>favourites= {};
  void getHomeData(){
    emit(ShopLoadingHomeDataStates());
    DioHelper.getData(
        url: HOME,
      token: token,
    ).then((value) {
      homeModel= HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favourites.addAll({element.id:element.favorites});
        emit(ShopSuccessHomeDataStates());
      });

    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataStates(error.toString()));
    });

  }

  CategoriesModel? categoriesModel;
  void getCategoriesData(){
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel= CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesStates(error.toString()));
    });

  }

//change icon of favourite

  ChangeFavouritesModel? changeFavouritesModel;
  void changeFavourites(int productId){
    favourites[productId]=!favourites[productId]!;
    emit(ShopChangeFavouritesStates());
    DioHelper.postData(
        url: FAVOURITES,
        data: {
          "product_id":productId
        },
         token: token,

    ).then((value) {
      changeFavouritesModel= ChangeFavouritesModel.fromJson(value.data);
      if(!changeFavouritesModel!.status!){
        favourites[productId]=!favourites[productId]!;
      }else{
        getFavourites();
      }
      emit(ShopSuccessChangeFavouritesStates(changeFavouritesModel!));
    }).catchError((error){
      print(error.toString());
      favourites[productId]=!favourites[productId]!;
      emit(ShopErrorChangeFavouritesStates(error));
    });

  }
//add or not to favScreen
  FavouritesModel? favouritesModel;
  void getFavourites(){
    emit(ShopLoadingGetFavouritesStates());
    DioHelper.getData(
      url: FAVOURITES,
      token: token,
    ).then((value) {
      favouritesModel= FavouritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavouritesStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavouritesStates(error));
    });

  }

  ShopLoginModel? userModel;
  void getUserData(){
    emit(ShopLoadingUserDataStates());
    DioHelper.getData(
      url: PROFILE,
      token: token ,
    ).then((value) {
      userModel= ShopLoginModel.fromJson(value.data);
      printFullText(userModel!.data!.name);
      emit(ShopSuccessUserDataStates(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUserDataStates(error));
    });

  }

  void updateUserData({
    required String name,
    required String phone,
    required String email,

  }){
    emit(ShopLoadingUpdateUserStates());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
        data: {
          'name':name,
          'phone':phone,
          'email':email
        }).then((value) {

      userModel=ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserStates(userModel!));
      print('update is ok');
    }).
    catchError((error)
    {
      emit(ShopErrorUpdateUserStates(error));
      print(error.toString());
    });
  }


}