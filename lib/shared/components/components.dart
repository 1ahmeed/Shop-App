import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';


void navigatorTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigatorAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget defaultButton({
  double wide = double.infinity,
  Color background = Colors.deepPurple,
  required VoidCallback function,
  required String text,
  TextStyle? style
}) =>
    Container(
      width: wide,
      color: background,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );

Widget defaultTextButton({
  required void Function()? onPressed,
  required String text,
  TextStyle? style,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: style,
      ),
    );

Widget defaultTextField({
  required TextEditingController controller,
  required TextInputType keyboard,
  required String? Function(String?)? validate,
  void Function(String)? onSubmit,
  void Function(String)? onchange,
  void Function()? onTap,
  required String label,
  bool isClickable = true,
  required IconData? prefixIcon,
  void Function()? suffixPressed,
  IconData? suffixIcon,
  bool isPassword = false,
  Color? colorIcon,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboard,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onchange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        enabledBorder:const OutlineInputBorder(),
        labelText: label,
        prefixIcon: Icon(
          prefixIcon,
          color: colorIcon,
        ),
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: suffixPressed,
        ),
        border: const OutlineInputBorder(),
      ),
    );

void showToast({
        required String text,
 required ToastStates state
})=> Fluttertoast.showToast(
    msg:  text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates {success,error,warning}

 Color? chooseToastColor(ToastStates state){
  Color? color;
  switch(state){
    case ToastStates.success:
    color=Colors.deepPurple.shade600;
    break;

    case ToastStates.error:
      color=Colors.red;
      break;
    case ToastStates.warning:
      color=Colors.amber;
      break;
  }
  return color;
 }

Widget buildProductItems( model,context,{bool isOldPrice=true})=>Padding(
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
            Image(image: NetworkImage(model.image.toString()),
              width: 120,
              height: 120,

            ),
            if(model.discount != 0 && isOldPrice && model.price!= model.oldPrice  )
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
                model.name.toString(),
                style:  TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    model.price.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold,
                        color: defaultColor),

                  ),
                  const SizedBox(width: 5,),
                  if(model.discount != 0 && isOldPrice && model.price!= model.oldPrice  )
                    Text(
                      model.oldPrice.toString(),
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
                        ShopCubit.get(context)!.favourites[model.id]==true ?defaultColor:Colors.grey,
                        child:const Icon(Icons.favorite_border,
                          size: 17,
                          color: Colors.white,
                        )),
                    onPressed: (){

                      ShopCubit.get(context)!. changeFavourites(model.id!);
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
