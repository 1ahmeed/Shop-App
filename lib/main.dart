import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/onboarding_screen/onboarding_screen.dart';
import 'package:shop_app/shared/block_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();Widget? widget;
  token = CacheHelper.getData(key: "token");
  bool? onBoarding = CacheHelper.getData(key: "onBoarding");
  print(token);
  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else {
      widget = ShopLoginScreen();
    }
  }else{
    widget= OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;

  MyApp({this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
          create: (context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavourites()..getUserData(),

      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
