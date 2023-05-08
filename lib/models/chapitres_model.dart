List<Chapitres> chapitresFromJson(dynamic str) =>
    List<Chapitres>.from((str).map((x) => Chapitres.fromJson(x)));

class Chapitres {
    Chapitres({
        required this.id,
        required this.number,
        required this.title,
        required this.contenu,
        required this.idCour,
        required this.createdAt,
        required this.updatedAt,
    });

    String id;
    int number;
    String title;
    String contenu;
    String idCour;
    DateTime createdAt;
    DateTime updatedAt;

    factory Chapitres.fromJson(Map<String, dynamic> json) => Chapitres(
        id: json["_id"],
        number: json["number"],
        title: json["title"],
        contenu: json["contenu"],
        idCour: json["id_cour"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "number": number,
        "title": title,
        "contenu": contenu,
        "id_cour": idCour,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
