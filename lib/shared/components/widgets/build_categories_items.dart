import 'package:flutter/material.dart';

import '../../../models/categories_model.dart';

class BuildCategoriesItems extends  StatelessWidget {
  const BuildCategoriesItems({super.key,
   this.dataModel
   }) ;
  final  DataModel? dataModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage(dataModel!.image),
          fit: BoxFit.cover,
          width: 100,
          height: 100,
        ),
        Container(
          color: Colors.black.withOpacity(.8),
          width: 100,
          height: 20,
          child: Text(
            dataModel!.name,
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
}
