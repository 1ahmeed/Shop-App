import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';


class ShopSearchCubit extends Cubit<SearchStates> {
  ShopSearchCubit() : super(ShopSearchInitialState());

  static ShopSearchCubit? get(context) => BlocProvider.of(context);
  late SearchModel searchModel;
  void getSearch(String text){
    emit(ShopSearchLoadingState());
    DioHelper.postData(
        url: search,
        token: token,
        data: {
          'text':text
        }).then((value) {
      searchModel=SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessState());
    }).catchError((error){
      emit(ShopSearchErrorState(error));
    });
  }

}
