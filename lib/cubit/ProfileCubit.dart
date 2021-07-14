import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Helpers/DioHelper.dart';
import 'package:shop_app/Model/ProfileData.dart';
import 'package:shop_app/main.dart';
import 'package:toast/toast.dart';
class ProfileCubit extends Cubit<ProfileCubitStates>{
  late ProfileData profileData;
  static ProfileCubit get(context)=>BlocProvider.of(context);
  IconData passIcon=Icons.visibility_off;
  bool isVisible=true;
  ProfileCubit( ) : super(ProfileCubitInit());
  void visibilityChanged(){
    isVisible=!isVisible;
    passIcon=isVisible?Icons.visibility_off:Icons.visibility;
  emit(ProfilePasswordVisibilityChanged());
  }

  updateProfileData(Map<String , dynamic> data,context){
    emit(UpdateProfileDataLoading());
      DioHelper.dio.options.headers={ 
      "lang":"en",
      "Content-Type":"application/json",
      "Authorization":token
    };
    DioHelper.putData(path: "update-profile", data: data).then((value){
      if(value.data["status"]==false){
        emit(UpdateProfileDataError(error: value.data["message"]));
      }else{
        Toast.show(value.data["message"].toString(), context,duration: Toast.LENGTH_LONG);
        emit(UpdateProfileDataSuccess());
        getProfileData();
      }
    }).catchError((error){
      emit(UpdateProfileDataError(error: error.toString()));
    });
  }
    getProfileData(){

      emit(ProfileCubitLoading());
    DioHelper.dio.options.headers={ 
      "lang":"en",
      "Content-Type":"application/json",
      "Authorization":token
    };
DioHelper().get(url: "profile").then((value){
  profileData=ProfileData.fromJson(value.data);

  print(value.data["status"]);
  print(value.data["message"]);
  print(value.data["data"]);
  if(profileData.status==false){
   emit(ProfileCubitError(error: profileData.message.toString()));
  }else{
    
    emit(ProfileCubitSuccess());
  }

}).catchError((error){
  emit(ProfileCubitError(error: error.toString()));
});
    
  }
}
abstract class ProfileCubitStates{}
class ProfileCubitInit extends ProfileCubitStates{}
class ProfileCubitLoading extends ProfileCubitStates{}
class ProfileCubitSuccess extends ProfileCubitStates{}
class ProfileCubitError extends ProfileCubitStates{
  String error;
  ProfileCubitError({required this.error});
}
class ProfilePasswordVisibilityChanged extends ProfileCubitStates{}

class UpdateProfileDataLoading extends ProfileCubitStates{}
class UpdateProfileDataSuccess extends ProfileCubitStates{}
class UpdateProfileDataError extends ProfileCubitStates{
  String error;
  UpdateProfileDataError({required this.error});
}
