import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import '../../shared/components/widgets/build_favourites_item.dart';


class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition:State is !ShopLoadingGetFavouritesStates ,
          builder:(context) => ListView.separated(
            itemBuilder:(context, index) =>BuildFavouritesItem(
              favouritesProduct: ShopCubit.get(context)!.favouritesModel!.data!.data![index].product!,
            ),
            separatorBuilder: (context, index) => const SizedBox(width: 10,),
            itemCount:ShopCubit.get(context)!.favouritesModel!.data!.data!.length,),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      } ,
    );
  }

}

