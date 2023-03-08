import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import '../../shared/components/widgets/build_home_items.dart';
import '../../shared/components/widgets/custom_show_toast.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavouritesStates) {
          if (!state.model.status!) {
            showToast(text: state.model.message!, state: ToastStates.error);
          } else {
            showToast(text: state.model.message!, state: ToastStates.success);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context)?.homeModel != null &&
              ShopCubit.get(context)?.categoriesModel != null,
          builder: (context) => BuildHomeItems(
            categoriesModel:  ShopCubit.get(context)?.categoriesModel,
              homeModel: ShopCubit.get(context)?.homeModel,
              ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
  
}
