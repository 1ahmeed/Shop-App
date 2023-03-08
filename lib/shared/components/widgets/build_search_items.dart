import 'package:flutter/material.dart';
import 'package:shop_app/models/search_model.dart';

import '../../../layout/cubit/cubit.dart';
import '../../styles/colors.dart';

class BuildSearchItem extends  StatelessWidget {
   BuildSearchItem({Key? key,
   this.searchProduct,
     this.isOldPrice,
   });

  Product? searchProduct;
  bool? isOldPrice=true;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(image: NetworkImage(searchProduct!.image.toString()),
                  width: 120,
                  height: 120,

                ),
                if(searchProduct!.discount != 0 && isOldPrice! && searchProduct!.price!= searchProduct!.oldPrice  )
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
                    searchProduct!.name.toString(),
                    style:  TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        searchProduct!.price.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold,
                            color: defaultColor),

                      ),
                      const SizedBox(width: 5,),
                      if(searchProduct!.discount != 0 && isOldPrice! && searchProduct!.price!= searchProduct!.oldPrice  )
                        Text(
                          searchProduct!.oldPrice.toString(),
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
                            ShopCubit.get(context)!.favourites[searchProduct!.id]==true ?defaultColor:Colors.grey,
                            child:const Icon(Icons.favorite_border,
                              size: 17,
                              color: Colors.white,
                            )),
                        onPressed: (){

                          ShopCubit.get(context)!. changeFavourites(searchProduct!.id!);
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
