import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Helpers/CacheHelper.dart';
import 'package:shop_app/Helpers/DioHelper.dart';
import 'package:shop_app/Model/LoginResponseModel.dart';

import '../main.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  late LoginResponse registerData;
  RegisterCubit() : super(RegisterInit());
 static RegisterCubit get(context)=>BlocProvider.of(context);
  bool isVisable=true;
  IconData visibilityIcon= Icons.visibility_off;
   void changeRegisterVisibility(){
    isVisable=!isVisable;
    visibilityIcon=isVisable? Icons.visibility_off:Icons.visibility;
    print(isVisable);
    emit(RegisterVisibilityChanged());
  }

  registerRequest(String name,String email,String password,String phone, ){
    emit(RegisterLoading());
      
    DioHelper.postData(path: "register", data:{ 
      "name":name,
      "phone":phone,
      "email":email,
      "password":password,
      
    }).then((response){
      if(response.data["status"]==false){
            return emit(RegisterError(response.data["message"]));
      }
        registerData=LoginResponse.fromJson(response.data);
        CacheHelper.saveData(key: "token", value: registerData.data.token);
        print(token);
         emit(RegisterSuccess());
    }).catchError((error){
      emit(RegisterError(error.toString()));
    });
  }
}

// Registeration States
abstract class RegisterStates {}

class RegisterInit extends RegisterStates {}

class RegisterLoading extends RegisterStates {}

class RegisterSuccess extends RegisterStates {}

class RegisterError extends RegisterStates {
  String error;
  RegisterError(this.error);
}
class RegisterVisibilityChanged extends RegisterStates {}
