List<Pdf> pdfFromJson(dynamic str) =>
    List<Pdf>.from((str).map((x) => Pdf.fromJson(x)));

class Pdf {
    String id;
    String file;
    String idLecons;
    int number;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Pdf({
        required this.id,
        required this.file,
        required this.idLecons,
        required this.number,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Pdf.fromJson(Map<String, dynamic> json) => Pdf(
        id: json["_id"],
        file: json["file"],
        idLecons: json["id_lecons"],
        number: json["number"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "file": file,
        "id_lecons": idLecons,
        "number": number,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
