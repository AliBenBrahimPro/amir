List<Cours> coursFromJson(dynamic str) =>
    List<Cours>.from((str).map((x) => Cours.fromJson(x)));

class Cours {
    Cours({
        required this.id,
        required this.nameCour,
        required this.descriptionCour,
        required this.idDomaine,
        required this.image,
        required this.createdAt,
        required this.updatedAt,
    });

    String id;
    String nameCour;
    String descriptionCour;
    String idDomaine;
    String image;
    DateTime createdAt;
    DateTime updatedAt;

    factory Cours.fromJson(Map<String, dynamic> json) => Cours(
        id: json["_id"],
        nameCour: json["name_cour"],
        descriptionCour: json["description_cour"],
        idDomaine: json["id_domaine"],
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name_cour": nameCour,
        "description_cour": descriptionCour,
        "id_domaine": idDomaine,
        "image": image,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
