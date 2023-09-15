List<UsersModel> userFromJson(dynamic str) =>
    List<UsersModel>.from((str).map((x) => UsersModel.fromJson(x)));

class UsersModel {
    String pic;
    bool isAdmin;
    String id;
    String name;
    String email;
    String password;
    int v;
      bool select = false;


    UsersModel({
        required this.pic,
        required this.isAdmin,
        required this.id,
        required this.name,
        required this.email,
        required this.password,
        required this.v,
        this.select = false
    });

    factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        pic: json["pic"],
        isAdmin: json["isAdmin"],
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "pic": pic,
        "isAdmin": isAdmin,
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "__v": v,
    };
}
