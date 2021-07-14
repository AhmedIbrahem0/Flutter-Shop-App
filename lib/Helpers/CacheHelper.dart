import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    SharedPreferences ref = await SharedPreferences.getInstance();
    if (value is bool) {
      return ref.setBool(key, value);
    } else if (value is String) {
      return ref.setString(key, value);
    } else if (value is double) {
      return ref.setDouble(key, value);
    } else if (value is int) {
      return ref.setInt(key, value);
    } else {
      return false;
    }
  }

  static Future<dynamic> getData({required String key}) async {
    SharedPreferences ref = await SharedPreferences.getInstance();

    var val = ref.get(key) ?? "null";
    return val;
  }
  static Future<bool> removeValue({required String key})async{
    SharedPreferences ref = await SharedPreferences.getInstance();
   return ref.remove(key);


  }
}
