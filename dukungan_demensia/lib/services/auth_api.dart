import 'dart:convert';
import 'package:dukungan_demensia/models/auth_models.dart';
import 'package:http/http.dart' as http;

class LoginApi{
  final endPointUrl =
      "https://localhost:9999/auth/login";

  Future<LoginResponseBody> postLogin() async {
    final res = await http.get(endPointUrl as Uri);
    print(res.statusCode);

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      LoginResponseBody body = LoginResponseBody.fromJson(json);
      
      return body;
    } else {
      throw ("Error Login");
    }
  }
}

class RegisterApi{
  final endPointUrl =
      "https://localhost:9999/auth/register";

  Future<RegisterResponseBody> postRegister() async {
    final res = await http.get(endPointUrl as Uri);
    print(res.statusCode);

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      RegisterResponseBody body = RegisterResponseBody.fromJson(json);
      
      return body;
    } else {
      throw ("Error Registering");
    }
  }
}
