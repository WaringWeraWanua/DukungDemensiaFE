import 'dart:convert';
import 'package:dukungan_demensia/models/auth_models.dart';
import 'package:http/http.dart' as http;
import 'package:dukungan_demensia/components/globals.dart' as globals;

class LoginApi{
  Future<LoginResponseBody> postLogin(LoginRequestBody requestBody) async {
    final res = await http.post(Uri.parse("https://dd-server.malikrafsan.tech/auth/login"),
        body: jsonEncode(requestBody),
        headers: {
          "Content-Type": "application/json"
      });
    Map<String, dynamic> json = jsonDecode(res.body);
    if (res.statusCode == 200) {
      LoginResponseBody body = LoginResponseBody.fromJson(json['data']);
      return body;
    } else {
      print('Error Login: ${res.statusCode}');
      print('Error Body: ${res.body}');
      throw ("Error Login : ${json['message']}");
    }
  }
}

class PairApi{
  Future<RegisterResponseBody> getPairPhoneNumber() async {
    final res = await http.get(Uri.parse("https://dd-server.malikrafsan.tech/user/pair"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + globals.token,
      });
    Map<String, dynamic> json = jsonDecode(res.body);
    if (res.statusCode == 200) {
      RegisterResponseBody body = RegisterResponseBody.fromJson(json['data']);
      return body;
    } else {
      throw ("Error Getting Pair Phone Number");
    }
  }
}

class RegisterApi{
  Future<RegisterResponseBody> postRegister(RegisterRequestBody requestBody) async {
    final res = await http.post(Uri.parse("https://dd-server.malikrafsan.tech/auth/register"),
        body: jsonEncode(requestBody.toJson()),
        headers: {"Content-Type": "application/json"});

    Map<String, dynamic> json = jsonDecode(res.body);
    if (res.statusCode == 200) {
      RegisterResponseBody body = RegisterResponseBody.fromJson(json['data']);
      return body;
    } else {
      print('Error Registering: ${res.statusCode}');
      print('Error Body: ${res.body}');
      throw ("Error Registering : ${json['message']}");
    }
  }
}
