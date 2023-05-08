List<Lecons> leconsFromJson(dynamic str) =>
    List<Lecons>.from((str).map((x) => Lecons.fromJson(x)));

class Lecons {
    Lecons({
        required this.id,
        required this.name,
        required this.description,
        required this.idChapitre,
        required this.number,
        required this.createdAt,
        required this.updatedAt,
    });

    String id;
    String name;
    String description;
    String idChapitre;
    int number;
    DateTime createdAt;
    DateTime updatedAt;

    factory Lecons.fromJson(Map<String, dynamic> json) => Lecons(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        idChapitre: json["id_chapitre"],
        number: json["number"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "id_chapitre": idChapitre,
        "number": number,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
