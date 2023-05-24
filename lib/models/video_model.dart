List<Videos> videosFromJson(dynamic str) =>
    List<Videos>.from((str).map((x) => Videos.fromJson(x)));

class Videos {
    String id;
    String url;
    String title;
    String subTitle;
    String time;
    String idLecons;
    String number;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Videos({
        required this.id,
        required this.url,
        required this.title,
        required this.subTitle,
        required this.time,
        required this.idLecons,
        required this.number,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        id: json["_id"],
        url: json["url"],
        title: json["title"],
        subTitle: json["sub_title"],
        time: json["time"].toString(),
        idLecons: json["id_lecons"],
        number: json["number"].toString(),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "url": url,
        "title": title,
        "sub_title": subTitle,
        "time": time,
        "id_lecons": idLecons,
        "number": number,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
