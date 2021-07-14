import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Model/CategoryModel.dart';
import 'package:shop_app/cubit/MainShopCubit.dart';

class CategoryScreen extends StatelessWidget {
  static String id = "CategoryScreen";
  @override
  Widget build(BuildContext context) {
    var cubit = MainShopCubit.get(context);
    return BlocConsumer<MainShopCubit, MainShopCubitStates>(
      listener: (context, state) {},
      builder: (context, state) => SafeArea(
        child: Scaffold(
            body: ListView.separated(physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    categoryItem(cubit.categorydata.data.data[index]),
                separatorBuilder: (context, index) => Divider(),
                itemCount: cubit.categorydata.data.data.length)),
      ),
    );
  }
}

Widget categoryItem(CategoryData data) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Image(
          width: 100, height: 100, image: NetworkImage(data.image, scale: 1.0)),
      SizedBox(width: 10,),
      Text(data.name),
      Spacer(),
      IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
    ],
  );
}
