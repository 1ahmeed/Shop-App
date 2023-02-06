import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_models.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';
///product

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
          builder: (context) => buildProductsData(
              ShopCubit.get(context)?.homeModel,
              ShopCubit.get(context)?.categoriesModel,
              context),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildProductsData(
          HomeModel? model, CategoriesModel? categoriesModel, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model!.data.banners.map((e)=>
                  Image(
                      image:
                      NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,)
                    ).toList(),
                options: CarouselOptions(
                    height: 250,
                    initialPage: 0,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 3),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal)),
            if (ShopCubit.get(context)?.homeModel?.data.banners == null)
              Container(
                width: double.infinity,
                height: 250,
                color: Colors.white,
              ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "CATEGORIES",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: defaultColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoriesItem(categoriesModel.data.data[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                      itemCount: categoriesModel!.data.data.length,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "PRODUCTS",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: defaultColor),
                  ),
                ],
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.6,
              children: List.generate(
                  model.data.products.length,
                  (index) =>
                      buildProductsItem(model.data.products[index], context)),
            )
          ],
        ),
      );

  Widget buildProductsItem(ProductModel model, context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(
                  model.image.toString(),
                ),
                width: double.infinity,
                height: 200,
              ),
              if (model.discount != 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: const Text(
                    "DISCOUNT",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model.name} ",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      "${model.price.round()}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: defaultColor),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        "${model.oldPrice.round()}",
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    IconButton(
                      icon: CircleAvatar(
                          radius: 17,
                          backgroundColor:
                              ShopCubit.get(context)!.favourites[model.id]!
                                  ? defaultColor
                                  : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 17,
                            color: Colors.white,
                          )),
                      onPressed: () {
                        ShopCubit.get(context)!.changeFavourites(model.id);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );

  Widget buildCategoriesItem(DataModel model) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image),
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          ),
          Container(
            color: Colors.black.withOpacity(.8),
            width: 100,
            height: 20,
            child: Text(
              model.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
}
