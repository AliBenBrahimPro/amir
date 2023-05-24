List<Domaines> domainesFromJson(dynamic str) =>
    List<Domaines>.from((str).map((x) => Domaines.fromJson(x)));

class Domaines {
    Domaines({
        required this.id,
        required this.nameDomain,
        required this.certificate,
        required this.image,
        required this.icon,
        required this.createdAt,
        required this.updatedAt,
    });

    String id;
    String nameDomain;
    String certificate;
    String image;
    String icon;
    DateTime createdAt;
    DateTime updatedAt;

    factory Domaines.fromJson(Map<String, dynamic> json) => Domaines(
        id: json["_id"],
        nameDomain: json["name_domain"],
        certificate: json["certificate"],
        image: json["image"],
        icon: json["icon"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name_domain": nameDomain,
        "certificate": certificate,
        "image": image,
        "icon": icon,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}