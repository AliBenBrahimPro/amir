import 'dart:io';
import 'package:amir/Services/auth_service.dart';
import 'package:amir/shared/app_colors.dart';
import 'package:amir/shared/dimensions/dimensions.dart';
import 'package:amir/widgets/buttons/action_button.dart';
import 'package:amir/widgets/inputs/input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../widgets/square_tile.dart';
import '../Sign_up/signup.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignInScreen> {
  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    emailController.text = "sousouch@gmail.com";
    passwordController.text = "12345678";
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<bool> avoidReturnButton() async {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text("vous etes sur de sortir ?"),
            actions: [Negative(context), Positive()],
          );
        });
    return true;
  }

  Widget Positive() {
    return Container(
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: TextButton(
          onPressed: () {
            exit(0);
          },
          child: const Text(
            " Oui",
            style: TextStyle(
              color: Color(0xffEAEDEF),
            ),
          )),
    );
  } // fermeture de l'application

  Widget Negative(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pop(context); // fermeture de dialog
        },
        child: Text(" Non"));
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: avoidReturnButton,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Form(
                key: _formkey,
                child: SizedBox(
                  height: Constants.screenHeight,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
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
                        padding:
                            EdgeInsets.only(top: Constants.screenHeight * 0.1),
                        child: InputField(
                          label: "Email",
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          prefixWidget: Icon(
                            Icons.email,
                            color: pinkColor,
                          ),
                        ),
                      ),
                      InputField(
                        label: "Mot de passe",
                        controller: passwordController,
                        textInputType: TextInputType.visiblePassword,
                        prefixWidget: Icon(
                          Icons.lock,
                          color: pinkColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Constants.screenWidth * 0.07,
                            vertical: Constants.screenHeight * 0.01),
                        child: Container(
                          width: Constants.screenWidth,
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () => Get.toNamed("/reset_password"),
                            child: Text(
                              "mot de passe oublié?",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      isLoading
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Constants.screenHeight * 0.01),
                              child: CircularProgressIndicator(),
                            )
                          : ActionButton(
                              label: "Connecter",
                              buttonColor: greenColor,
                              labelColor: Colors.white,
                              onPressed: () {
                                Map creds = {
                                  'email': emailController.text,
                                  'password': passwordController.text
                                };
                                if (_formkey.currentState!.validate()) {
                                  Provider.of<Auth>(context, listen: false)
                                      .login(creds);
                                  // Get.toNamed("/homepage");
                                }
                              }),
                      const SizedBox(height: 20),

                      // or continue with
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                'où se connecter avec',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // google + apple sign in buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          // google button
                          SquareTile(imagePath: 'asset/images/facebook.png'),

                          SizedBox(width: 25),

                          // apple button
                          SquareTile(imagePath: 'asset/images/google.png'),
                          SizedBox(width: 25),

                          SquareTile(imagePath: 'asset/images/linkedin.png')
                        ],
                      ),

                      const SizedBox(height: 20),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextButton(
                                child: Text("Besoin d'un nouveau compte?",
                                    style: TextStyle(
                                        color: pinkColor,
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic)),
                                onPressed: () {
                                  Get.to(SignupScreen());
                                },
                              ))
                            ],
                          )),
                    ]),
                  ),
                ))),
      ),
    );
  }
}
