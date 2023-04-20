import 'package:amir/screen/ColorScheme.dart';
import 'package:amir/shared/app_colors.dart';
import 'package:amir/shared/dimensions/dimensions.dart';
import 'package:amir/widgets/buttons/action_button.dart';
import 'package:amir/widgets/inputs/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../Services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
            backgroundColor: pinkColor,
            elevation: 0,
            title: const Text("Creér un compte"),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: const BoxDecoration(
                          color: pinkColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(90),
                          ),
                        ),
                        child: Center(
                            child: Container(
                          child: Lottie.asset("asset/lotties/login.json",
                              height: 150),
                        )),
                      ),
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
                      
                      loading
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Constants.screenHeight * 0.01),
                              child: const CircularProgressIndicator(),
                            )
                          : ActionButton(
                              label: "S\'inscrire",
                              buttonColor: greenColor,
                              labelColor: Colors.white,
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  Map creds = {
                                    "last_name": lastNameController.text,
                                    "first_name": nameController.text,
                                    "email": emailcontroller.text,
                                    "password": passController.text,
                                    "role": "eleve",
                                    "passwordconfirm":
                                        passConfirmController.text
                                  };
                                  Provider.of<Auth>(context, listen: false)
                                      .signUp(creds);
                                  Get.offAllNamed('/login');

                                }
                              })
                    ],
                  )))),
    );
  }
}
