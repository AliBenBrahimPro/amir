import 'package:flutter/material.dart';

import '../theme/color.dart';

class ProfilePage extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String role;

  ProfilePage(
      {Key? key,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.role});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes informations'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: pink,
                      radius: 30,
                      child: Text(
                        firstName[0].toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    firstName + " " + lastName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text(
                  'Prenom',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(firstName),
              ),
              ListTile(
                title: Text(
                  'Nom',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(lastName),
              ),
              ListTile(
                title: Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(email),
              ),
              ListTile(
                title: Text(
                  'Role',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(role),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
