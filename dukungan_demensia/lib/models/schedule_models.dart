class DetilEvent {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? title;
  String? description;
  DateTime? startTime;
  DateTime? endTime;
  String? proofImageUrl;
  DateTime? doneTime;
  String? careRelationId;
  String? ringtoneType;

  DetilEvent({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.description,
    this.startTime,
    this.endTime,
    this.proofImageUrl,
    this.doneTime,
    this.careRelationId,
    this.ringtoneType,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt,
    "updatedAt":updatedAt,
    "title": title,
    "description": description,
    "startTime": startTime,
    "endTime": endTime,
    "proofImageUrl": proofImageUrl,
    "doneTime": doneTime,
    "careRelationId": careRelationId,
    "ringtoneType": ringtoneType,
  };

  factory DetilEvent.fromJson(Map<String, dynamic> json) {
    return DetilEvent(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt'] as String),
      title: json['title'] as String?,
      description: json['description'] as String?,
      startTime: json['startTime'] == null ? null : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null ? null : DateTime.parse(json['endTime'] as String),
      proofImageUrl: json['proofImageUrl'] as String?,
      doneTime: json['doneTime'] == null ? null : DateTime.parse(json['doneTime'] as String),
      careRelationId: json['careRelationId'] as String?,
      ringtoneType: json['ringtoneType'] as String?,
    );
  }
}

class EventResponseBody {
  String? patientId;
  String? careGiverId;
  List<DetilEvent>? events;

  EventResponseBody({
    this.patientId,
    this.careGiverId,
    this.events,
  });

  Map<String, dynamic> toJson() => {
    "patientId": patientId,
    "careGiverId": careGiverId,
    "events":events,
  };

  factory EventResponseBody.fromJson(Map<String, dynamic> json) {
    return EventResponseBody(
      patientId: json['patientId'] as String?,
      careGiverId: json['careGiverId'] as String?,
      events: json['events'] == null ? null : json['events'].map((i) =>
              DetilEvent.fromJson(i)).toList() as List<DetilEvent>,
    );
  }
}

class PostEventResponseBody {
  String? patiendId;
  String? careGiverId;
  DetilEvent? event;

  PostEventResponseBody({
    this.patiendId,
    this.careGiverId,
    this.event,
  });

  Map<String, dynamic> toJson() => {
    "patiendId": patiendId,
    "careGiverId": careGiverId,
    "event":event,
  };

  factory PostEventResponseBody.fromJson(Map<String, dynamic> json) {
    return PostEventResponseBody(
      patiendId: json['patiendId'] as String?,
      careGiverId: json['careGiverId'] as String?,
      event: json['event'] as DetilEvent?,
    );
  }
}

class PostEventRequestBody {
  final String title;
  final String description;
  final String startTime;
  final String ringtoneType;

  PostEventRequestBody({
    required this.title,
    required this.description,
    required this.startTime,
    required this.ringtoneType,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'title': title,
      'description': description,
      'startTime': startTime,
      'ringtoneType': ringtoneType,
    };

    return json;
  }
}