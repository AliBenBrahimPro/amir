
List<Catalogues> cataloguesFromJson(dynamic str) =>
    List<Catalogues>.from((str).map((x) => Catalogues.fromJson(x)));

class Catalogues {
    Catalogues({
        required this.id,
        required this.nameCatalogue,
        required this.collegeYear,
        required this.image,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    String id;
    String nameCatalogue;
    String collegeYear;
    String image;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Catalogues.fromJson(Map<String, dynamic> json) => Catalogues(
        id: json["_id"],
        nameCatalogue: json["name_catalogue"],
        collegeYear: json["college_year"],
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );
    

    Map<String, dynamic> toJson(map) => {
        "_id": id,
        "name_catalogue": nameCatalogue,
        "college_year": collegeYear,
        "image": image,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}