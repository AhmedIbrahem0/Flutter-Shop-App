import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Helpers/CacheHelper.dart';
import 'package:shop_app/Model/LoginResponseModel.dart';
import 'package:shop_app/Helpers/DioHelper.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Screens/ShopLayout.dart';
class LogInCubit extends Cubit<LoginStates>
{
  LogInCubit(): super(LogIninit());
  static LogInCubit get(context){
    return BlocProvider.of(context);
  }
  String token="";

  void signIn({ 
    required context,
    required String email,required String password}){
  emit(LogInLoading());
      DioHelper.postData(
    path:"login", 
    data:{"email": email,
	"password": password}, 
  ).then((value) {
    LoginResponse response= LoginResponse.fromJson(value.data);
    if(response.status==false){
      return emit(LogInError(response.message));
    }
    token=response.data.token;
    CacheHelper.saveData(key: "token", value:response.data.token);
    Navigator.pushReplacementNamed(context,ShopLayoutScreen.id);
     emit(LogInSuccess());
  }).catchError((error){
    emit(LogInError(error.toString()));
  });
 }
  bool isVisible =false;
  IconData passIcon= Icons.visibility_off;
  void  visabilityChanged(){
    isVisible=!isVisible;
    passIcon=isVisible? Icons.visibility_off:Icons.visibility;

    emit(PasswordVisibilityChanged());
  }

}
















// log In States //
abstract class LoginStates{}
class LogIninit extends LoginStates{}
class LogInLoading extends LoginStates{}
class LogInSuccess extends LoginStates{}
class PasswordVisibilityChanged extends LoginStates{}

class LogInError extends LoginStates{
  String error;
  LogInError(this.error);
}


