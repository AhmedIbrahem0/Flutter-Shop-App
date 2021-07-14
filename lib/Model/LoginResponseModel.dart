class LoginResponse {
 late bool status;
 late String message;
 late UserData data;
  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    if(json["data"].toString()!="null"){
    data =UserData.fromJson(json["data"]);
}
  }
}

class UserData {
  late final int id;
  late final String token;
  late final String phone;
  late final String email;
  late final String name;
  late final String image;

  // UserData(
  //     {required this.id,
  //     required this.image,
  //     required this.token,
  //     required this.phone,
  //     required this.email,
  //     required this.name});
  UserData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    email=json["email"];
    name = json["name"];
    phone = json["phone"];
    token = json["token"];
    image = json["image"];
  }
}
