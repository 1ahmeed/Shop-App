import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'cubit/states.dart';

class ShopRegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  ShopRegisterScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context, state) {
          if(state is ShopRegisterSuccessStates){
            if(state.loginModel!.status! ){
              showToast(
                  text: state.loginModel!.message!,
                  state:ToastStates.success);
              CacheHelper.saveData(key: 'token',
                  value: state.loginModel?.data?.token).then((value){
                 token=state.loginModel!.data!.token!;
                 ShopCubit.get(context)?.getUserData();
                 ShopCubit.get(context)?.getFavourites();

                 navigatorAndFinish(context,const ShopLayout());

              });

            }else{
              showToast(
                  text: state.loginModel!.message!,
                  state:ToastStates.error
              );
            }
          }

        },
        builder:(context, state) {
          return Scaffold(
            body:  Center (
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("REGISTER",
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(
                          "Register now to browse our hot offers",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        defaultTextField(
                            controller: nameController,
                            keyboard: TextInputType.name,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "please enter your name";
                              }
                              return null;
                            },
                            label: "User Name",
                            prefixIcon: Icons.person),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextField(
                            controller: emailController,
                            keyboard: TextInputType.emailAddress,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "please enter your email";
                              }
                              return null;
                            },
                            label: "Email",
                            prefixIcon: Icons.email),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextField(
                            controller: phoneController,
                            keyboard: TextInputType.phone,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "please enter your phone";
                              }
                              return null;
                            },
                            label: "Phone",
                            prefixIcon: Icons.phone),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextField(
                            controller: passwordController,
                            keyboard: TextInputType.visiblePassword,
                            suffixIcon: ShopRegisterCubit.get(context)?.suffix,
                            suffixPressed: () {
                              ShopRegisterCubit.get(context)?.changeVisibility();
                            },
                            isPassword:
                            ShopRegisterCubit.get(context)!.isPassword,
                            onSubmit: (value) {


                            },
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "password is too short";
                              }
                              return null;
                            },
                            label: "Password",
                            prefixIcon: Icons.lock),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition:  state is! ShopRegisterLoadingStates,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context)?.userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,


                                );
                              }
                            },
                            text: "REGISTER",
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } ,

      ),
    );
  }
}
