import 'dart:io';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Helpers/CacheHelper.dart';
import 'package:shop_app/Screens/LogInScreen.dart';
import 'package:shop_app/cubit/LogInCubit.dart';
import 'package:shop_app/cubit/MainShopCubit.dart';

class ShopLayoutScreen extends StatelessWidget {
  static String id = "ShopLayoutScreen";

  @override
  Widget build(BuildContext context) {
          
    
    return BlocConsumer<MainShopCubit, MainShopCubitStates>(
      listener: (context, state) {
           
      },
      builder: (context, state)  {
    //       print( MainShopCubit.get(context).homeData.data.products.length.toString() + "Product length 00000000000000" );
    // print( MainShopCubit.get(context).categorydata.data.data.length.toString() + "cat length 000000000000000000" );
          return Scaffold(
        bottomNavigationBar: bottomNavBar(MainShopCubit.get(context)),
        body: ConditionalBuilder(

          /// ايرور فى ال state 
          condition: !(state is HomeDataLoading)  ,
          builder: (context) =>  MainShopCubit.get(context).bottomNavList[MainShopCubit.get(context).currentIndex],
          fallback: (context) =>Center(child:CircularProgressIndicator()),
        )
    );
  }  );
  }

  BottomNavigationBar bottomNavBar(MainShopCubit cubit) {
    return BottomNavigationBar(
        backgroundColor: Colors.grey[300],
        currentIndex: cubit.currentIndex,
        selectedItemColor: Colors.blueAccent,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(size: 32),
        elevation: 20,
        iconSize: 25,
        onTap: (newIndex) {
          cubit.currentIndexChanged(newIndex);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Category",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outlined),
            label: "Favourites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          )
        ]);
  }
}

//    print(LogInCubit.get(context).token);
//   LogInCubit.get(context).token="";
//   print(LogInCubit.get(context).token);
//  var val= await CacheHelper.removeValue(key: "token")
//  .then((value) {

//  });

//   print("logged out done "+val.toString());
//   Navigator.pushReplacementNamed(context,LogInScreen.id);
