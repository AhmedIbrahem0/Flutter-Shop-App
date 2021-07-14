import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Model/FavouritesModel.dart';
import 'package:shop_app/Model/HomeData.dart';
import 'package:shop_app/cubit/MainShopCubit.dart';

class FavScreen extends StatelessWidget {
  static String id = "FavScreen";
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainShopCubit, MainShopCubitStates>(
      listener: (context, state) {
        if(state is GetFavDataError){
          print(state.error);
        }
      },
      builder: (context, state) => ConditionalBuilder(
        fallback: (context)=>Center(child: CircularProgressIndicator(),),
        condition: (state is GetFavDataSuccess ||state is HomeDataLoading || state is BottomNavIndexChanged )
        ,builder: (context )=>
         MainShopCubit.get(context)
              .favData.favModel.favouriteList.length==0?Center(child: Text("You have no Favourites ! "),)
       : Scaffold(
            body: SafeArea(
                child: ListView(
      
          children: MainShopCubit.get(context)
              .favData.favModel.favouriteList
              .map(
                (element) => favWidget(element, context),
              )
              .toList(),
              physics: BouncingScrollPhysics(),
        )
        )),
      ),
    );
  }

  Widget favWidget(FavProduct product, context) {
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment:AlignmentDirectional.bottomStart,
                children: [
                  Image(
                  width: 120,
                  height: 100,
                  image: NetworkImage(product.image),
                  
                ),
                if (product.discount > 0)
                Container(alignment: Alignment.center,
                  color: Colors.red,
                  width: 55,
                  height: 20,
                  child: Text(
                    "Discount",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )
                ]
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(product.price.toString() +" LE",
                        style: TextStyle(fontSize: 15, color: Colors.blue)),
                 if(product.discount>0)
                 Text(
                   product.oldPrice.toString() +" LE",
                   style: TextStyle(
                     decoration:  TextDecoration.lineThrough,
                     fontSize: 12
                   ),
                 )
                  ],
                ),
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    MainShopCubit.get(context).favToggle(product.productId);
                  },
                  icon: MainShopCubit.get(context).favourites[product.productId] == true
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(Icons.favorite_border_outlined))
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
