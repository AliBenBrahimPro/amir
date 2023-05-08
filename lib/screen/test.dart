import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:amir/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../Services/user_service.dart';
import '../../../theme.dart';
import '../Services/auth_service.dart';
import '../Services/catalogues_services.dart';
import '../models/catalogues_model.dart';
import '../shared/app_colors.dart';
import '../shared/dimensions/dimensions.dart';
import '../widgets/buttons/action_button.dart';
import '../widgets/inputs/input_field.dart';

class Test extends StatefulWidget {
  const Test({super.key, });

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {

    super.initState();
  }

  bool loading = false;
  bool check = false;

  final _formkey = GlobalKey<FormState>();
  File? _image = null;
  late final _picker = ImagePicker();

  Future getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(
      () {
        if (image != null) {
          _image = File(image.path);
        } else {
          print('No image selected.');
        }
      },
    );
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController iamgecontroller = TextEditingController();
  CataloguesController cataloguesController = CataloguesController();

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
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Center(
                      child: _image == null
                          ? Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Center(
                                  child: SizedBox(
                                      width: 100,
                                      child: InkWell(
                                          onTap: () async {
                                            getImage();
                                            setState(() {
                                              //update UI
                                            });
                                          },
                                          child: Image.asset(
                                              'asset/images/upload.png')))),
                            )
                          : Stack(
                              children: <Widget>[
                                SizedBox(
                                  width: 250.0,
                                  height: 320.0,
                                  child: Image.file(_image!),
                                ),
                                Positioned(
                                  right: 5.0,
                                  child: InkWell(
                                    child: const Icon(
                                      Icons.remove_circle,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                    // This is where the _image value sets to null on tap of the red circle icon
                                    onTap: () {
                                      setState(
                                        () {
                                          _image = null;
                                        },
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                    ),
                    InputField(
                      label: "Nom du catalogue",
                      controller: nameController,
                      textInputType: TextInputType.text,
                      prefixWidget: const Icon(
                        Icons.account_circle_outlined,
                        color: pinkColor,
                      ),
                    ),
                    InputField(
                      label: "année univesitaire",
                      controller: yearController,
                      textInputType: TextInputType.text,
                      prefixWidget: const Icon(
                        Icons.account_circle_outlined,
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
                            label: "Ajouter",
                            buttonColor: greenColor,
                            labelColor: Colors.white,
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                log(_image.toString());
                                Map creds = {
                                  "college_year": yearController.text,
                                  "name_catalogue": nameController.text,
                                  "image": _image,
                                };
                                cataloguesController.createCatalogues(
                                    yearController.text,
                                    nameController.text,
                                    _image);
                              }
                            })
                  ],
                ),
              ))),
    );
  }
}
