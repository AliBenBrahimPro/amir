
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../widgets/buttons/action_button.dart';
import '../../../widgets/inputs/input_field.dart';
import '../../../shared/app_colors.dart';

//import 'homescreen.dart';

final _formkey = GlobalKey<FormState>();

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  _ForgotPassScreenState createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  TextEditingController emailController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: pinkColor,
            elevation: 0,
            title: Text(
              "Mot de passe oublié ",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                  child: Column(children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: pinkColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(90),
                    ),
                  ),
                  child: Center(
                      child: Container(
                    child: Lottie.asset("asset/lotties/forgot_password.json", height: 150),
                  )),
                ),
                SizedBox(height: 30),
                Form(
                  key: _formkey,
                  child: InputField(
                      label: 'Email',
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      prefixWidget: Icon(Icons.email)),
                ),
                SizedBox(
                  height: 30,
                ),
                loading
                    ? CircularProgressIndicator()
                    : ActionButton(label: "Envoyer", buttonColor: greenColor, labelColor: Colors.white, onPressed: () {}),
              ])))),
    );
  }
}
