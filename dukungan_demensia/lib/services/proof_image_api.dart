import 'dart:convert';
import 'package:dukungan_demensia/models/proof_image_models.dart';
import 'package:http/http.dart' as http;

class LoginApi{
  Future<ImageResponseBody> postLogin(ImageRequestBody requestBody, String id) async {
    final res = await http.post(Uri.parse("https://dd-server.malikrafsan.tech/event/$id/proofImageUrl"),
        body: jsonEncode(requestBody),
        headers: {
          "Content-Type": "application/json"
      });
    Map<String, dynamic> json = jsonDecode(res.body);
    if (res.statusCode == 200) {
      ImageResponseBody body = ImageResponseBody.fromJson(json['data']);
      print(body);
      return body;
    } else {
      print('Error Login: ${res.statusCode}');
      print('Error Body: ${res.body}');
      throw ("Error Login : ${json['message']}");
    }
  }
}