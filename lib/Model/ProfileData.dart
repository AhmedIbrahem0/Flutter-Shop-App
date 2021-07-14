import 'package:shop_app/Model/LoginResponseModel.dart';

class ProfileData{
  late bool status;
  late String message;
  late UserData userData;
  ProfileData.fromJson(Map<String ,dynamic>json){
    status=json["status"];
    message=json["message"];
    userData=UserData.fromJson(json["data"]);


  }
}
