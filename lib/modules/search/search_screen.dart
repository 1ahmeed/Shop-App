import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import '../../shared/components/widgets/build_search_items.dart';
import '../../shared/components/widgets/custom_text_form_field.dart';

class SearchScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var searchController=TextEditingController();

  SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit,SearchStates>(
        listener: (context,state){
        },
        builder: (context,state){
          return  Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                        controller: searchController,
                        keyboard:  TextInputType.text,
                        validate: (v) {
                          if (v!.isEmpty) {
                            return 'Search Can\'t be Empty';
                          }
                          return null;
                        },
                        label: 'Search',
                       prefixIcon: Icons.search,
                        onchange: (value){
                          if(formKey.currentState!.validate())
                          {
                            ShopSearchCubit.get(context)?.getSearch(searchController.text);
                          }

                        },

                      onSubmit:(value){
                          if(formKey.currentState!.validate())
                          {
                            ShopSearchCubit.get(context)?.getSearch(searchController.text);
                          }
                        }
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if(state is ShopSearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 20,
                    ),
                    if(state is ShopSearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            physics:const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => BuildSearchItem(
                              searchProduct:ShopSearchCubit.get(context)?.searchModel.data!.data[index],
                                isOldPrice: false ),
                            separatorBuilder: (context, index) =>const SizedBox(height: 20,),
                            itemCount: ShopSearchCubit.get(context)!.searchModel.data!.data.length),
                      ),
                  ],
                ),
              ),
            ),
          )  ;
        },
      ),
    );

  }
}


