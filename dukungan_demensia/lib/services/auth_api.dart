import 'dart:convert';
import 'package:dukungan_demensia/models/auth_models.dart';
import 'package:http/http.dart' as http;

class LoginApi{
  Future<LoginResponseBody> postLogin(LoginRequestBody requestBody) async {
    final res = await http.post(Uri.parse("http://192.168.1.10:9999/auth/login"),
        body: jsonEncode(requestBody),
        headers: {
          "Content-Type": "application/json"
      });

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      LoginResponseBody body = LoginResponseBody.fromJson(json['data']);
      print(body.token);
      return body;
    } else {
      print('Error Login: ${res.statusCode}');
      print('Error Body: ${res.body}');
      throw ("Error Login");
    }
  }
}

class RegisterApi{
  Future<RegisterResponseBody> postRegister(RegisterRequestBody requestBody) async {
    final res = await http.post(Uri.parse("http://192.168.1.10:9999/auth/register"),
        body: jsonEncode(requestBody.toJson()),
        headers: {"Content-Type": "application/json"});
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      RegisterResponseBody body = RegisterResponseBody.fromJson(json['data']);
      return body;
    } else {
      print('Error Registering: ${res.statusCode}');
      print('Error Body: ${res.body}');
      throw ("Error Registering");
    }
  }
}
