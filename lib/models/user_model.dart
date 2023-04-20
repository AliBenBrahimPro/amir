List<UsersModel> userFromJson(dynamic str) =>
    List<UsersModel>.from((str).map((x) => UsersModel.fromJson(x)));
class UsersModel {
   String id;
   String lastName;
   String firstName;
   String email;
   String password;
   String role;


  UsersModel(
      {required this.id,
      required this.lastName,
      required this.firstName,
      required this.email,
      required this.password,
      required this.role,
    
      });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
        id: json['_id'],
        lastName: json['last_name'],
        firstName: json['first_name'],
        email: json['email'],
        password: json['password'],
        role: json['role'],
       
        );
  }

  toJson() {
    return {
      'id': id,
      'last_name': lastName,
      'first_name': firstName,
      'email': email,
      'password': password,
      'role': role
    };
  }
}
