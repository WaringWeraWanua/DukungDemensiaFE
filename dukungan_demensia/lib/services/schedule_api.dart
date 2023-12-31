import 'dart:convert';
import 'package:dukungan_demensia/models/schedule_models.dart';
import 'package:http/http.dart' as http;
import 'package:dukungan_demensia/components/globals.dart' as globals;

class ScheduleAPI{
  Future<List<DetilEvent>> getEvent() async {
    final res = await http.get(Uri.parse("https://dd-server.malikrafsan.tech/event"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + globals.token,
      });
    Map<String, dynamic> json = jsonDecode(res.body);
    if (res.statusCode == 200) {
      //EventResponseBody body = EventResponseBody.fromJson(json['data']);
      // List<DetilEvent> bodyevent = List<DetilEvent>.fromJson(json['data']);
      List<dynamic> body = json['data']['events'];
      List<DetilEvent> events = body.map((dynamic item) => DetilEvent.fromJson(item)).toList();
      return events;
    } else {
      print('Error Login: ${res.statusCode}');
      print('Error Body: ${res.body}');
      return [];
    }
  }
}

class PostScheduleAPI{
  Future<PostEventResponseBody> postSchedule(PostEventRequestBody requestBody) async {
    final res = await http.post(Uri.parse("https://dd-server.malikrafsan.tech/event"),
        body: jsonEncode(requestBody.toJson()),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + globals.token,
        });

    Map<String, dynamic> json = jsonDecode(res.body);
    if (res.statusCode == 200) {
      PostEventResponseBody body = PostEventResponseBody.fromJson(json['data']);
      return body;
    } else {
      print('Error Registering: ${res.statusCode}');
      print('Error Body: ${res.body}');
      throw ("Error Registering : ${json['message']}");
    }
  }
}

