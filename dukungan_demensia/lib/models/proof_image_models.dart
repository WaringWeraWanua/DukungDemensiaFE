

class ImageRequestBody {
  final String imageUrl;

  const ImageRequestBody({
    required this.imageUrl, 
  });

  Map<String, dynamic> toJson() => {
    'imageUrl': imageUrl,
  };
}

class DetilEventSingle {
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

  DetilEventSingle({
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

  factory DetilEventSingle.fromJson(Map<String, dynamic> json) {
    return DetilEventSingle(
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

class ImageResponseBody {
  String? patiendId;
  String? careGiverId;
  DetilEventSingle? event;

  ImageResponseBody({
    this.patiendId,
    this.careGiverId,
    this.event,
  });

  Map<String, dynamic> toJson() => {
    "patiendId": patiendId,
    "careGiverId": careGiverId,
    "event":event,
  };

  factory ImageResponseBody.fromJson(Map<String, dynamic> json) {
    return ImageResponseBody(
      patiendId: json['patiendId'] as String?,
      careGiverId: json['careGiverId'] as String?,
      event: json['event'] == null ? null : json['event'] as DetilEventSingle,
    );
  }
}