import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/styles/colors.dart';
import '../../shared/components/widgets/custom_button.dart';
import '../../shared/components/widgets/custom_show_toast.dart';
import '../../shared/components/widgets/custom_text_form_field.dart';

class SettingScreen extends StatelessWidget {
  final  formKey = GlobalKey<FormState>();
  final  nameController = TextEditingController();
  final  emailController = TextEditingController();
  final  phoneController = TextEditingController();

  SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context)?.userModel;
       if(model !=null) {
      nameController.text = model.data!.name!;
      emailController.text = model.data!.email!;
      phoneController.text = model.data!.phone!;
    }

        return ConditionalBuilder(
          condition: ShopCubit
              .get(context)
              ?.userModel != null,
          builder: (context) =>
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              color: defaultColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () {
                                signOut(context);
                              },
                              child: const Text('SignOut',
                                style: TextStyle(fontSize: 18,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        controller: nameController,
                        keyboard: TextInputType.name,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Name Must Not Be Empty ';
                          }
                          return null;
                        },
                        label: 'Name',
                        prefixIcon: Icons.person,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        controller: emailController,
                        keyboard: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Email Must Not Be Empty ';
                          }
                          return null;
                        },
                        label: 'EmailAddress',
                        prefixIcon: Icons.email,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        controller: phoneController,
                        keyboard: TextInputType.phone,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Phone Must Not Be Empty ';
                          }
                          return null;
                        },
                        label: 'Phone Number',
                        prefixIcon: Icons.phone,
                      ),
                     const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                          function: () {
                            if(formKey.currentState!.validate())
                            {
                              ShopCubit.get(context)?.updateUserData(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,);
                              showToast(text: 'updated success',
                                  state: ToastStates.success);
                            }

                          },
                          text: 'UPDATE')
                    ],
                  ),
                ),
              ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
