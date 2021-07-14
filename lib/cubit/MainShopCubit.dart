import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Helpers/DioHelper.dart';
import 'package:shop_app/Model/CategoryModel.dart';
import 'package:shop_app/Model/FavouritesModel.dart';
import 'package:shop_app/Model/HomeData.dart';
import 'package:shop_app/Screens/CategoryScreen.dart';
import 'package:shop_app/Screens/FavScreen.dart';
import 'package:shop_app/Screens/ProductScreen.dart';
import 'package:shop_app/Screens/SettingScreen.dart';
import 'package:shop_app/main.dart';

class MainShopCubit extends Cubit<MainShopCubitStates> {
  late Map<int, bool> favourites = {};
  MainShopCubit() : super(ShopCubitInit());
  static MainShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomNavList = [
    ProductScreen(),
    CategoryScreen(),
    FavScreen(),
    SettingsScreen()
  ];
  void currentIndexChanged(int newindex) {
    currentIndex = newindex;
    emit(BottomNavIndexChanged());
  }

  favToggle(int id) {
    emit(GetFavDataLoading());
    favourites.update(id, (value) => !value);
    emit(FavToggledChanged());
    DioHelper.dio.options.headers = {
      "lang": "en",
      "Content-Type": "application/json",
      "Authorization": token
    };
    DioHelper.postData(path: "favorites", data: {"product_id": id})
        .then((value) {
      if (value.data["status"] == false) {
        favourites.update(id, (value) => !value);
        return emit(FavToggledError(error: value.data["message"]));
      } else {
        getFavData();
      }
      emit(FavToggledSucces());
    }).catchError((error) {
      favourites.update(id, (value) => !value);
      // favouriteList.removeWhere((element) => element.id == id);
      emit(FavToggledError(error: error));
    });
  }

  late HomeResponse homeData;
  void getHomeData() {
    emit(HomeDataLoading());

    getCategoryData();
    DioHelper.dio.options.headers = {
      "lang": "en",
      "Content-Type": "application/json",
      "Authorization": token
    };
    DioHelper()
        .get(
      url: "home",
    )
        .then((value) {
      homeData = HomeResponse.fromJson(value.data);
      if (homeData.status == false) {
        return emit(HomeDataError(error: "Something Went Wrong !"));
      }
      homeData.data.products.forEach((element) {
        favourites.addAll({element.id: element.isFav});
      });
      getFavData() ;

      emit(HomeDataSuccess());
    }).catchError((error) {
      emit(HomeDataError(error: error.toString()));
    });
  }

  late GetFavData favData;

  void getFavData() {
    emit(GetFavDataLoading());
    DioHelper.dio.options.headers = {
      "lang": "en",
      "Content-Type": "application/json",
      "Authorization": token
    };
    DioHelper().get(url: "favorites").then((value) {
      favData = GetFavData.fromJson(value.data);
      if (value.data["status"] == false) {
        emit(GetFavDataError(error: value.data["message"]));
      } else {
        emit(GetFavDataSuccess());
      }
    }).catchError((error) {
      emit(GetFavDataError(error: error.toString()));
    });
  }

  late CategoryModel categorydata;
  void getCategoryData() {
    DioHelper.dio.options.headers = {"lang": "en"};
    DioHelper().get(url: "categories").then((val) {
      categorydata = CategoryModel.fromJson(val.data);
    }).catchError((error) {
      emit(CategoryDataError(error: error.t.toString()));
    });
  }
}

abstract class MainShopCubitStates {}

class HomeDataLoading extends MainShopCubitStates {}

class HomeDataSuccess extends MainShopCubitStates {}

class HomeDataError extends MainShopCubitStates {
  String error;
  HomeDataError({required this.error});
}

class CategoryDataSuccess extends MainShopCubitStates {}

class CategoryDataLoading extends MainShopCubitStates {}

class CategoryDataError extends MainShopCubitStates {
  String error;
  CategoryDataError({required this.error});
}

class BottomNavIndexChanged extends MainShopCubitStates {}

class ShopCubitInit extends MainShopCubitStates {}

/// Favourtie ///
class GetFavDataLoading extends MainShopCubitStates {}

class GetFavDataSuccess extends MainShopCubitStates {}

class GetFavDataError extends MainShopCubitStates {
  String error;
  GetFavDataError({required this.error});
}

class FavToggledSucces extends MainShopCubitStates {}

class FavToggledChanged extends MainShopCubitStates {}

class FavToggledError extends MainShopCubitStates {
  String error;
  FavToggledError({required this.error});
}
