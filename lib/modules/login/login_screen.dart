import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../shared/components/widgets/custom_button.dart';
import '../../shared/components/widgets/custom_navigation_.dart';
import '../../shared/components/widgets/custom_navigation_and_finish.dart';
import '../../shared/components/widgets/custom_show_toast.dart';
import '../../shared/components/widgets/custom_text_button.dart';
import '../../shared/components/widgets/custom_text_form_field.dart';


class ShopLoginScreen extends StatelessWidget {

 final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  ShopLoginScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) {
            if(state is ShopLoginSuccessStates){
              if(state.loginModel!.status! ){
                showToast(
                    text: state.loginModel!.message!,
                    state:ToastStates.success);

               CacheHelper.saveData(key: 'token',
                   value: state.loginModel?.data?.token
               ).then((value){
                 token=state.loginModel!.data!.token!;
                ShopCubit.get(context)?.getUserData();
                ShopCubit.get(context)?.getFavourites();
                 navigatorAndFinish(context, const ShopLayout());
                   });

              }else{
               showToast(
                   text: state.loginModel!.message!,
                   state:ToastStates.error
               );
              }
            }

          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("LOGIN",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                  )),
                          Text(
                            "login now to browse our hot offers",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomTextFormField(
                              controller: emailController,
                              keyboard: TextInputType.emailAddress,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "please enter your email address";
                                }
                                else if (!value.contains("@") || !value.contains(".")) {
                                  return " email must have '@' and '.'";
                                }else{
                                  return null;
                                }

                              },
                              label: "Email Address",
                              prefixIcon: Icons.email_outlined),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              controller: passwordController,
                              keyboard: TextInputType.visiblePassword,
                              suffixIcon: ShopLoginCubit.get(context)?.suffix,
                              suffixPressed: () {
                                ShopLoginCubit.get(context)?.changeVisibility();
                              },
                              isPassword:
                                  ShopLoginCubit.get(context)!.isPassword,
                              onSubmit: (value) {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context)?.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return "password is too short";
                                }
                                if (value.length < 6) {
                                  return ' password must have more than 6 nums';
                                }
                                return null;

                              },
                              label: "Password",
                              prefixIcon: Icons.lock),
                          const SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopLoginLoadingStates,
                            builder: (context) => CustomButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context)?.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: "LOGIN",
                            ),
                            fallback: (context) =>
                                const Center(child: CircularProgressIndicator()),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              CustomTextButton(
                                onPressed: () {
                                  navigatorTo(context, ShopRegisterScreen());
                                },
                                text: "Register",
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
