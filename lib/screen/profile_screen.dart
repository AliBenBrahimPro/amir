import 'package:amir/screen/ColorScheme.dart';
import 'package:amir/shared/app_colors.dart';
import 'package:amir/shared/dimensions/dimensions.dart';
import 'package:amir/widgets/buttons/action_button.dart';
import 'package:amir/widgets/inputs/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../Services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool loading = false;
  bool check = false;
  String? role = '';
  String? token;
  String? id;
  final _formkey = GlobalKey<FormState>();
  final _storage = const FlutterSecureStorage();

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passConfirmController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    roleController.text = Provider.of<Auth>(context, listen: false).user!.role;
    emailcontroller.text =
        Provider.of<Auth>(context, listen: false).user!.email;
    lastNameController.text =
        Provider.of<Auth>(context, listen: false).user!.lastName;
    nameController.text =
        Provider.of<Auth>(context, listen: false).user!.firstName;
    token = await _storage.read(key: 'token');
    id = await _storage.read(key: 'id');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Form(
              key: _formkey,
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 20),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: pink,
                        radius: 30,
                        child: Text(
                          nameController.text[0].toUpperCase(),
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
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
                    label: "Role",
                    controller: roleController,
                    enabled: false,
                    textInputType: TextInputType.emailAddress,
                    prefixWidget: const Icon(
                      Icons.face,
                      color: pinkColor,
                    ),
                  ),
                  loading
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Constants.screenHeight * 0.01),
                          child: Container(
                              child: const CircularProgressIndicator()),
                        )
                      : ActionButton(
                          label: "Modifier",
                          buttonColor: greenColor,
                          labelColor: Colors.white,
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              Map creds = {
                                "last_name": lastNameController.text,
                                "first_name": nameController.text,
                                "email": emailcontroller.text,
                              };
                              if (emailcontroller.text.trim().toLowerCase() ==
                                  Provider.of<Auth>(context, listen: false)
                                      .user!
                                      .email.trim().toLowerCase()) {
                                creds.remove('email');
                              }
                              Provider.of<Auth>(context, listen: false)
                                  .updateUser(token, id, creds);
                            }
                          })
                ],
              ))),
    );
  }
}
