import 'dart:convert';
import 'package:dukungan_demensia/models/schedule_models.dart';
import 'package:http/http.dart' as http;

class ScheduleAPI{
  Future<EventResponseBody> getEvent() async {
    final res = await http.post(Uri.parse("https://dd-server.malikrafsan.tech/event"),
        headers: {
          "Content-Type": "application/json"
      });
    Map<String, dynamic> json = jsonDecode(res.body);
    if (res.statusCode == 200) {
      EventResponseBody body = EventResponseBody.fromJson(json['data']);
      print(body.careGiverId);
      return body;
    } else {
      print('Error Login: ${res.statusCode}');
      print('Error Body: ${res.body}');
      throw ("Error Login : ${json['message']}");
    }
  }
}

