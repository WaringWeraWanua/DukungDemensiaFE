import 'dart:convert';
import 'package:dukungan_demensia/models/proof_image_models.dart';
import 'package:http/http.dart' as http;
import 'package:dukungan_demensia/components/globals.dart' as globals;

class ProofImage{
  Future<bool> postProofImage(ImageRequestBody requestBody, String id) async {
    final res = await http.patch(Uri.parse("https://dd-server.malikrafsan.tech/event/$id/proofImageUrl"),
        body: jsonEncode(requestBody),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + globals.token,
      });
    print(res);
    print(res.body);
    if (res.statusCode == 200) {
      return true;
    } else {
      print('Error Login: ${res.statusCode}');
      print('Error Body: ${res.body}');
      throw ("Error Unggah :");
    }
  }
}

class AcceptProofImage{
  Future<bool> acceptProofImage(AcceptProofImageBody requestBody, String id) async {
    final res = await http.post(Uri.parse("https://dd-server.malikrafsan.tech/event/$id/done"),
        // body: jsonEncode(requestBody),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + globals.token,
      });
    print("bip");
    if (res.statusCode == 200) {
      return true;
    } else {
      print('Error Login: ${res.statusCode}');
      print('Error Body: ${res.body}');
      throw ("Error accept");
    }
  }
}