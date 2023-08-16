import 'package:flutter/material.dart';

import '../../../layout/cubit/cubit.dart';
import '../../../models/favourites_model.dart';
import '../../styles/colors.dart';

class BuildFavouritesItem extends StatelessWidget {
   const BuildFavouritesItem({super.key,
   this.isOldPrice=true,
this.favouritesProduct
   });
   final Product? favouritesProduct;
   final bool? isOldPrice;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: double.infinity,
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(image: NetworkImage(favouritesProduct!.image.toString()),
                  width: 120,
                  height: 120,

                ),
                if(favouritesProduct!.discount != 0 && isOldPrice! && favouritesProduct!.price!= favouritesProduct!.oldPrice  )
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.red,
                    child: const Text("DISCOUNT",
                      style: TextStyle(color: Colors.white,
                          fontSize: 14
                      ),),
                  )
              ],
            ),
            const SizedBox(width:5 ,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    favouritesProduct!.name.toString(),
                    style:  const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        favouritesProduct!.price.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold,
                            color: defaultColor),

                      ),
                      const SizedBox(width: 5,),
                      if(favouritesProduct!.discount != 0 && isOldPrice! && favouritesProduct!.price!= favouritesProduct!.oldPrice  )
                        Text(
                          favouritesProduct!.oldPrice.toString(),
                          style:const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                        icon:  CircleAvatar(
                            radius: 17,
                            backgroundColor:
                            ShopCubit.get(context)!.favourites[favouritesProduct!.id]==true ?defaultColor:Colors.grey,
                            child:const Icon(Icons.favorite_border,
                              size: 17,
                              color: Colors.white,
                            )),
                        onPressed: (){

                          ShopCubit.get(context)!. changeFavourites(favouritesProduct!.id!);
                        },
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
