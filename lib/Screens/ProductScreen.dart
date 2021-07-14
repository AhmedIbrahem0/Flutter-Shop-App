import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Model/CategoryModel.dart';
import 'package:shop_app/Model/HomeData.dart';
import 'package:shop_app/cubit/MainShopCubit.dart';
import 'package:toast/toast.dart';

class ProductScreen extends StatelessWidget {
  static String id = "ProductScreen";
  @override
  Widget build(BuildContext context) {
    var cubit = MainShopCubit.get(context);
    return BlocConsumer<MainShopCubit, MainShopCubitStates>(
      listener: (context, state) {
        if(state is FavToggledError){
          Toast.show(state.error,context,duration: Toast.LENGTH_LONG,backgroundColor: Colors.red);
        }
      },
      builder: (context, state) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCarouselSlider(cubit: cubit),
                SizedBox(
                  height: 10,
                ),
                Text(
                  " Categories",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemCount: cubit.categorydata.data.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return categorySlider(
                          cubit.categorydata.data.data[index]);
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 20),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  " New products",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                Divider(
                  color: Colors.black,
                ),
                Container(
                    color: Colors.grey[400],
                    child: GridView.count(
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      childAspectRatio: 1 / 1.4,
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      children: cubit.homeData.data.products.map((item) {
                        return customGridItem(item, context);
                      }).toList(),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget categorySlider(CategoryData data) {
    return Container(
      width: 120,
      height: 120,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            width: double.infinity,
            height: 100,
            image: NetworkImage(data.image),
          ),
          Container(
              width: double.infinity,
              color: Colors.black.withOpacity(0.5),
              child: Text(data.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  )))
        ],
      ),
    );
  }
}

Widget customGridItem(Product product, BuildContext context) {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.all(5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                height: double.infinity,
                width: double.infinity,
                image: NetworkImage(
                  product.image,
                ),
              ),
              if (product.discount > 0)
                Container(
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
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          product.name,
          maxLines: 2,
          style: TextStyle(fontSize: 15),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Text(
              product.price.toString() + " LE",
              style: TextStyle(fontSize: 15, color: Colors.blue),
            ),
            SizedBox(
              width: 10,
            ),
            if (product.discount > 0)
              Text(
                product.oldPrice.toString(),
                style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    fontSize: 15,
                    color: Colors.grey),
              ),
            Spacer(),
            IconButton(
                onPressed: () {
                  MainShopCubit.get(context).favToggle(product.id);
                },
                icon: MainShopCubit.get(context).favourites[product.id] ?? false
                    ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.favorite_border,
                      ))
          ],
        )
      ],
    ),
  );
}

class CustomCarouselSlider extends StatelessWidget {
  final MainShopCubit cubit;

  const CustomCarouselSlider({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: cubit.homeData.data.banners.map((item) {
          return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image(
                  image: NetworkImage(
                    item.image,
                  ),
                )),
          );
        }).toList(),
        options: CarouselOptions(
            disableCenter: false,
            viewportFraction: 1.0,
            autoPlayCurve: Curves.linear,
            autoPlay: true,
            height: MediaQuery.of(context).size.height * 0.3));
  }
}
