import 'package:flutter/material.dart';

import '../../../layout/cubit/cubit.dart';
import '../../../models/home_models.dart';
import '../../styles/colors.dart';

class BuildProductItems  extends StatelessWidget {
  BuildProductItems({Key? key,
  this.productModel
  }) ;
  ProductModel? productModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage(
                productModel!.image.toString(),
              ),
              width: double.infinity,
              height: 200,
            ),
            if (productModel!.discount != 0)
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
                "${productModel!.name} ",
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    "${productModel!.price.round()}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: defaultColor),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if (productModel!.discount != 0)
                    Text(
                      "${productModel!.oldPrice.round()}",
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
                        ShopCubit.get(context)!.favourites[productModel!.id]!
                            ? defaultColor
                            : Colors.grey,
                        child: const Icon(
                          Icons.favorite_border,
                          size: 17,
                          color: Colors.white,
                        )),
                    onPressed: () {
                      ShopCubit.get(context)!.changeFavourites(productModel!.id);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
