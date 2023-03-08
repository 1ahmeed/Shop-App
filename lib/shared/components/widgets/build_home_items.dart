import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/widgets/build_categories_items.dart';

import '../../../layout/cubit/cubit.dart';
import '../../../models/categories_model.dart';
import '../../../models/home_models.dart';
import '../../styles/colors.dart';
import 'build_products_items.dart';

class BuildHomeItems extends StatelessWidget {
  BuildHomeItems({Key? key,
     this.categoriesModel,
this.homeModel
   }) ;

  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  @override
  Widget build(BuildContext context) {
    return   SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: homeModel!.data.banners.map((e)=>
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
                        BuildCategoriesItems(dataModel: categoriesModel!.data.data[index]),
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
                homeModel!.data.products.length,
                    (index) =>
                        BuildProductItems(productModel: homeModel!.data.products[index])),
          )
        ],
      ),
    );
  }
}
