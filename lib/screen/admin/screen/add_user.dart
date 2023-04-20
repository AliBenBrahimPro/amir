import 'package:amir/screen/ColorScheme.dart';
import 'package:amir/shared/app_colors.dart';
import 'package:amir/shared/dimensions/dimensions.dart';
import 'package:amir/widgets/buttons/action_button.dart';
import 'package:amir/widgets/inputs/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../Services/auth_service.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  bool loading = false;
  bool check = false;
  String? role;
  final _formkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: pink,
          ),
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          body: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InputField(
                        label: "Nom",
                        controller: nameController,
                        textInputType: TextInputType.text,
                        prefixWidget: const Icon(
                          Icons.account_circle_outlined,
                          color: pinkColor,
                        ),
                      ),
                    ),
                    InputField(
                      label: "Prénom",
                      controller: lastNameController,
                      textInputType: TextInputType.text,
                      prefixWidget: const Icon(
                        Icons.account_circle_outlined,
                        color: pinkColor,
                      ),
                    ),
                    InputField(
                      label: "Email",
                      controller: emailcontroller,
                      textInputType: TextInputType.emailAddress,
                      prefixWidget: const Icon(
                        Icons.email,
                        color: pinkColor,
                      ),
                    ),
                    InputField(
                      label: "Mot de passe",
                      controller: passController,
                      textInputType: TextInputType.visiblePassword,
                      prefixWidget: const Icon(
                        Icons.lock,
                        color: pinkColor,
                      ),
                    ),
                    InputField(
                      label: "Confirmer la mot de passe",
                      controller: passConfirmController,
                      textInputType: TextInputType.visiblePassword,
                      prefixWidget: const Icon(
                        Icons.lock,
                        color: pinkColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Constants.screenHeight * 0.001,
                          horizontal: Constants.screenWidth * 0.07),
                      child: DropdownButtonFormField<String?>(
                        hint: const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text("Role"),
                        ),
                        decoration: InputDecoration(
                          focusedErrorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          prefix: const Icon(Icons.face, color: pinkColor),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: pinkColor,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(width: 2.0, color: pinkColor),
                          ),
                        ),
                        value: role,
                        items: const [
                          DropdownMenuItem(
                            value: 'eleve',
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Apprenant(e)',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black38),
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'admin',
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Administrateur',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black38),
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'enseigne',
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Ensengeint(e)',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black38),
                              ),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            role = value!;
                          });
                        },
                      ),
                    ),
                    loading
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Constants.screenHeight * 0.01),
                            child: const CircularProgressIndicator(),
                          )
                        : ActionButton(
                            label: "Ajouter",
                            buttonColor: greenColor,
                            labelColor: Colors.white,
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                Map creds = {
                                  "last_name": lastNameController.text,
                                  "first_name": nameController.text,
                                  "email": emailcontroller.text,
                                  "password": passController.text,
                                  "role": role,
                                  "passwordconfirm": passConfirmController.text
                                };
                                Provider.of<Auth>(context, listen: false)
                                    .signUp(creds);
                                Get.toNamed('/gestioncompte');
                              }
                            })
                  ],
                ),
              ))),
    );
  }
}
