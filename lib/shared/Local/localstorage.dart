import 'package:shared_preferences/shared_preferences.dart';
class LocalStorage{

  
  static Future<SharedPreferences> InitLocalStorage()async{

    return await SharedPreferences.getInstance();
  }
  
}
