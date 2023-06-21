import 'dart:convert';
import 'package:dukungan_demensia/models/auth_models.dart';
import 'package:http/http.dart' as http;

class LoginApi{
  final endPointUrl =
      "https://localhost:9999/auth/login";

  Future<LoginResponseBody> getArticle() async {
    final endPointUrl = Uri.parse("https://newsapi.org/v2/everything?q=dementia&apiKey=75360416e97b4a95bc489e98eb323e5f");
    final res = await http.get(endPointUrl);
    print(res.statusCode);

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      LoginResponseBody body = LoginResponseBody.fromJson(json);
      
      return body;
    } else {
      throw ("Can't get the Articles");
    }
  }
}