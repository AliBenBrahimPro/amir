
class UsersModel {
  final String id;
  final String last_name;
  final String first_name;
  final String email;
  final String password;
  final String role;


  UsersModel(
      {required this.id,
      required this.last_name,
      required this.first_name,
      required this.email,
      required this.password,
      required this.role,
    
      });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
        id: json['_id'],
        last_name: json['last_name'],
        first_name: json['first_name'],
        email: json['email'],
        password: json['password'],
        role: json['role'],
       
        );
  }

  toJson() {
    return {
      'id': id,
      'last_name': last_name,
      'first_name': first_name,
      'email': email,
      'password': password,
      'role': role
    };
  }
}
