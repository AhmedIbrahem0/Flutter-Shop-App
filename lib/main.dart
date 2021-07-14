// @dart=2.9
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Helpers/CacheHelper.dart';
import 'package:shop_app/Helpers/DioHelper.dart';
import 'package:shop_app/Screens/CategoryScreen.dart';
import 'package:shop_app/Screens/FavScreen.dart';
import 'package:shop_app/Screens/LogInScreen.dart';
import 'package:shop_app/Screens/OnBoarding.dart';
import 'package:shop_app/Screens/ProductScreen.dart';
import 'package:shop_app/Screens/RegisterScreen.dart';
import 'package:shop_app/Screens/SettingScreen.dart';
import 'package:shop_app/Screens/ShopLayout.dart';
import 'package:shop_app/cubit/BlocObserver.dart';
import 'package:shop_app/cubit/LogInCubit.dart';
import 'package:shop_app/cubit/MainShopCubit.dart';
import 'package:shop_app/cubit/ProfileCubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  String widget;
  token = await CacheHelper.getData(key: "token");
  print(token);

  var onBoarding = await CacheHelper.getData(key: "OnBoarding");

  widget = onBoarding == true
      ? token == "null"
          ? LogInScreen.id
          : ShopLayoutScreen.id
      : OnBoardingPage.id;
  runApp(Home(widget));
}

class Home extends StatelessWidget {
  String widget;
  Home(this.widget);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LogInCubit>(create: (context) => LogInCubit()),
        BlocProvider<MainShopCubit>(
            create: (context) => MainShopCubit()..getHomeData())
,       BlocProvider<ProfileCubit>(create: (context) =>ProfileCubit()..getProfileData()),

      ],
      
      child: MaterialApp(
        theme:
            ThemeData(textTheme: TextTheme(bodyText1: TextStyle(fontSize: 35))),
        debugShowCheckedModeBanner: false,
        initialRoute: widget,
        routes: {
          ShopLayoutScreen.id: (context) => ShopLayoutScreen(),
          OnBoardingPage.id: (context) => OnBoardingPage(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          LogInScreen.id: (context) => LogInScreen(),
          ProductScreen.id: (context) => ProductScreen(),
          FavScreen.id: (context) => FavScreen(),
          SettingsScreen.id: (context) => SettingsScreen(),
          CategoryScreen.id: (context) => CategoryScreen(),
        },
      ),
    );
  }
}

String token = "";
