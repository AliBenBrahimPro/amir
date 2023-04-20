import 'package:amir/models/user_model.dart';
import 'package:amir/screen/ColorScheme.dart';
import 'package:amir/shared/app_colors.dart';
import 'package:amir/shared/dimensions/dimensions.dart';
import 'package:amir/widgets/buttons/action_button.dart';
import 'package:amir/widgets/inputs/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../Services/auth_service.dart';

class EditUser extends StatefulWidget {
  final UsersModel? user;
  const EditUser({Key? key, required this.user}) : super(key: key);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  bool loading = false;
  bool check = false;
  String? role;
  final _formkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  @override
  void initState() {
    nameController.text = '${widget.user?.firstName}';
    lastNameController.text = '${widget.user?.lastName}';
    emailcontroller.text = '${widget.user?.email}';
    role = '${widget.user?.role}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: pink,
        ),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: Form(
            key: _formkey,
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
                        role = value;
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
                        label: "Modifier",
                        buttonColor: greenColor,
                        labelColor: Colors.white,
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            Map creds =
                                "${widget.user?.email}" == emailcontroller.text
                                    ? {
                                        "last_name": lastNameController.text,
                                        "first_name": nameController.text,
                                        "role": role,
                                      }
                                    : {
                                        "last_name": lastNameController.text,
                                        "first_name": nameController.text,
                                        "email": emailcontroller.text,
                                        "role": role,
                                      };
                            setState(() {
                              Provider.of<Auth>(context, listen: false)
                                  .updateUser(
                                      Provider.of<Auth>(context, listen: false)
                                          .token,
                                      widget.user?.id,
                                      creds);
                              Get.offAndToNamed('/gestioncompte');
                            });
                          }
                        })
              ],
            )));
  }
}
